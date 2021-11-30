//
//  SampleHandler.swift
//  BroacastUploader
//
//  Created by 申潤五 on 2021/11/10.
//

import HaishinKit
import ReplayKit
import VideoToolbox

open class SampleHandler: RPBroadcastSampleHandler {
    private lazy var rtmpConnection: RTMPConnection = {
        let conneciton = RTMPConnection()
        conneciton.addEventListener(.rtmpStatus, selector: #selector(rtmpStatusEvent), observer: self)
        conneciton.addEventListener(.ioError, selector: #selector(rtmpErrorHandler), observer: self)
        return conneciton
    }()

    private lazy var rtmpStream: RTMPStream = {
        RTMPStream(connection: rtmpConnection)
    }()

    private var isMirophoneOn = false

    deinit {
        rtmpConnection.removeEventListener(.ioError, selector: #selector(rtmpErrorHandler), observer: self)
        rtmpConnection.removeEventListener(.rtmpStatus, selector: #selector(rtmpStatusEvent), observer: self)
    }

    override open func broadcastStarted(withSetupInfo setupInfo: [String: NSObject]?) {
        //TODO: 這兒應該由原 APP 取得一些相關資訊，如伺服器位置等，但這事要建立 appGroup 操作不只是一點麻煩，暫時不作
        rtmpConnection.connect(Preference.defaultInstance.uri!, arguments: nil)
    }

    open override func broadcastFinished() {
        //TODO: 這兒應該回到原APP，但這事要建立 appGroup 操作不只是一點麻煩，暫時不作
        
        print("Finished")
    }
    
    
    
    override open func processSampleBuffer(_ sampleBuffer: CMSampleBuffer, with sampleBufferType: RPSampleBufferType) {
        switch sampleBufferType {
        case .video:
            if let description = CMSampleBufferGetFormatDescription(sampleBuffer) {
                let dimensions = CMVideoFormatDescriptionGetDimensions(description)
                rtmpStream.videoSettings = [
                    .width: dimensions.width,
                    .height: dimensions.height ,
                    .profileLevel: kVTProfileLevel_H264_Baseline_AutoLevel
                ]
            }
            rtmpStream.appendSampleBuffer(sampleBuffer, withType: .video)
        case .audioMic:
            isMirophoneOn = true
            if CMSampleBufferDataIsReady(sampleBuffer) {
                rtmpStream.appendSampleBuffer(sampleBuffer, withType: .audio)
            }
        case .audioApp:
            if !isMirophoneOn && CMSampleBufferDataIsReady(sampleBuffer) {
                rtmpStream.appendSampleBuffer(sampleBuffer, withType: .audio)
            }
        @unknown default:
            break
        }
    }

    @objc
    private func rtmpErrorHandler(_ notification: Notification) {
        rtmpConnection.connect(Preference.defaultInstance.uri!)
    }

    @objc
    private func rtmpStatusEvent(_ status: Notification) {
        let e = Event.from(status)

        guard
            let data: ASObject = e.data as? ASObject,
            let code: String = data["code"] as? String else {
            return
        }
        switch code {
        case RTMPConnection.Code.connectSuccess.rawValue:
            rtmpStream.publish(Preference.defaultInstance.streamKey!)
        default:
            break
        }
    }
}
struct Preference {
    static var defaultInstance = Preference()
    var uri: String? = "rtmp://a.rtmp.youtube.com/live2"
    var streamKey: String? = "d30a-5uxg-63zp-7595-fh2r"
}
