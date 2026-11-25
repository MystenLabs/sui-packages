module 0x4c62677c4946cc0c2c6d33faad4bc4c293011728947343aa7f34b5b0065be51f::audio_transcoder {
    struct AUDIO_TRANSCODER has drop {
        dummy_field: bool,
    }

    struct AudioTranscoder has drop {
        dummy_field: bool,
    }

    struct TranscodePayload has copy, drop {
        recording_id: address,
        master_blob_id: u256,
        source_pcm_digest: vector<u8>,
        quilt_blob_id: u256,
        sealed_dek: vector<u8>,
        preview_start_sample: u64,
        preview_end_sample: u64,
        preview_blob_id: u256,
    }

    struct TranscodeVerifiedEvent has copy, drop {
        pk: vector<u8>,
        policy_version: u64,
        verified_at_ms: u64,
        recording_id: 0x2::object::ID,
        master_blob_id: u256,
        data: 0xadefbe1aeb900807ed03144bddd80dc6478030c28ede3b2990f8e792606f317a::data::WalrusBlob,
        preview: 0x7a83dd22131cad38ded582a5cb5527e1ab95eec3c748e934585d6da4f61da563::recording_transcode::RecordingPreview,
    }

    fun init(arg0: AUDIO_TRANSCODER, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x7914545ac251592310fd47fb3a70cdc2b30c233ca0e38b15b5494f30bb0df0ce::enclave::new<AUDIO_TRANSCODER>(arg0, arg1);
        0x7914545ac251592310fd47fb3a70cdc2b30c233ca0e38b15b5494f30bb0df0ce::enclave::share<AUDIO_TRANSCODER>(v0);
        0x2::transfer::public_transfer<0x7914545ac251592310fd47fb3a70cdc2b30c233ca0e38b15b5494f30bb0df0ce::enclave::EnclavePolicyAdminCap<AUDIO_TRANSCODER>>(v1, 0x2::tx_context::sender(arg1));
    }

    public fun request_transcode<T0>(arg0: &mut 0xd958fc04212d0be5c92fd89964e6d2fa1065be489b19eaf7668f77ca46c6dba::recording::Recording<T0>, arg1: &0xd958fc04212d0be5c92fd89964e6d2fa1065be489b19eaf7668f77ca46c6dba::recording::RecordingAdminCap<T0>, arg2: &0x7914545ac251592310fd47fb3a70cdc2b30c233ca0e38b15b5494f30bb0df0ce::enclave::EnclavePolicy<AUDIO_TRANSCODER>, arg3: u256, arg4: u64, arg5: u64) {
        assert!(arg4 < arg5 && arg5 <= 0x857344a4593c4b42b4512c230dbbda14c70abb09c4767d6e6228aebffcd6ed65::audio_format_pcm::samples_per_channel(0x4eec45b7624d50d65da8d4e68674ea03497e2f22351d1f6075f2844a41078468::audio::format<0x11f24c8cd2aa5dd42580c6799922a6197b2ef6a93cff2f64b6bb8f86ffdc47e4::audio_verifier::AudioVerifier, 0x857344a4593c4b42b4512c230dbbda14c70abb09c4767d6e6228aebffcd6ed65::audio_format_pcm::Pcm, 0x78fc72a89343f4237448a79c4b1fcc158cfd612bb4a9813847ad2d5760cf5f3d::audio_channel_layout::ChannelLayout>(0x139e6ee3f98645506a5e8a5f6258922b46eb97d645ecb371bce1b3082707145e::recording_master::master<T0, 0x11f24c8cd2aa5dd42580c6799922a6197b2ef6a93cff2f64b6bb8f86ffdc47e4::audio_verifier::AudioVerifier, 0x857344a4593c4b42b4512c230dbbda14c70abb09c4767d6e6228aebffcd6ed65::audio_format_pcm::Pcm, 0x78fc72a89343f4237448a79c4b1fcc158cfd612bb4a9813847ad2d5760cf5f3d::audio_channel_layout::ChannelLayout>(arg0, arg3))), 0);
        0xe0262111397c8bfbef7ec8b785e249ce6b4eaf03c63cc4caf11b99fb38ebc0ec::recording_master_access::grant<T0, AUDIO_TRANSCODER>(arg0, arg1, arg2, arg3, transcode_terms(arg4, arg5));
    }

    public fun transcode_terms(arg0: u64, arg1: u64) : vector<u8> {
        let v0 = 0x1::bcs::to_bytes<u64>(&arg0);
        0x1::vector::append<u8>(&mut v0, 0x1::bcs::to_bytes<u64>(&arg1));
        v0
    }

    public fun verify_transcode<T0>(arg0: &0x7914545ac251592310fd47fb3a70cdc2b30c233ca0e38b15b5494f30bb0df0ce::enclave::EnclavePolicy<AUDIO_TRANSCODER>, arg1: &mut 0xd958fc04212d0be5c92fd89964e6d2fa1065be489b19eaf7668f77ca46c6dba::recording::Recording<T0>, arg2: &0xd958fc04212d0be5c92fd89964e6d2fa1065be489b19eaf7668f77ca46c6dba::recording::RecordingAdminCap<T0>, arg3: address, arg4: u256, arg5: vector<u8>, arg6: u256, arg7: vector<u8>, arg8: u64, arg9: u64, arg10: u256, arg11: vector<u8>, arg12: u64, arg13: vector<u8>) : 0x7a83dd22131cad38ded582a5cb5527e1ab95eec3c748e934585d6da4f61da563::recording_transcode::RecordingTranscode<AudioTranscoder> {
        let v0 = TranscodePayload{
            recording_id         : arg3,
            master_blob_id       : arg4,
            source_pcm_digest    : arg5,
            quilt_blob_id        : arg6,
            sealed_dek           : arg7,
            preview_start_sample : arg8,
            preview_end_sample   : arg9,
            preview_blob_id      : arg10,
        };
        0x7914545ac251592310fd47fb3a70cdc2b30c233ca0e38b15b5494f30bb0df0ce::enclave::verify_signature<AUDIO_TRANSCODER, TranscodePayload>(arg0, arg11, 0, arg12, v0, &arg13);
        let v1 = 0x2::object::id<0xd958fc04212d0be5c92fd89964e6d2fa1065be489b19eaf7668f77ca46c6dba::recording::Recording<T0>>(arg1);
        assert!(arg3 == 0x2::object::id_to_address(&v1), 1);
        assert!(0x857344a4593c4b42b4512c230dbbda14c70abb09c4767d6e6228aebffcd6ed65::audio_format_pcm::digest(0x4eec45b7624d50d65da8d4e68674ea03497e2f22351d1f6075f2844a41078468::audio::format<0x11f24c8cd2aa5dd42580c6799922a6197b2ef6a93cff2f64b6bb8f86ffdc47e4::audio_verifier::AudioVerifier, 0x857344a4593c4b42b4512c230dbbda14c70abb09c4767d6e6228aebffcd6ed65::audio_format_pcm::Pcm, 0x78fc72a89343f4237448a79c4b1fcc158cfd612bb4a9813847ad2d5760cf5f3d::audio_channel_layout::ChannelLayout>(0x139e6ee3f98645506a5e8a5f6258922b46eb97d645ecb371bce1b3082707145e::recording_master::master<T0, 0x11f24c8cd2aa5dd42580c6799922a6197b2ef6a93cff2f64b6bb8f86ffdc47e4::audio_verifier::AudioVerifier, 0x857344a4593c4b42b4512c230dbbda14c70abb09c4767d6e6228aebffcd6ed65::audio_format_pcm::Pcm, 0x78fc72a89343f4237448a79c4b1fcc158cfd612bb4a9813847ad2d5760cf5f3d::audio_channel_layout::ChannelLayout>(arg1, arg4))) == &arg5, 2);
        let v2 = 0xe0262111397c8bfbef7ec8b785e249ce6b4eaf03c63cc4caf11b99fb38ebc0ec::recording_master_access::consume<T0, AUDIO_TRANSCODER>(arg1, arg2, arg4);
        let v3 = transcode_terms(arg8, arg9);
        assert!(0xe0262111397c8bfbef7ec8b785e249ce6b4eaf03c63cc4caf11b99fb38ebc0ec::recording_master_access::terms(&v2) == &v3, 3);
        let v4 = 0xadefbe1aeb900807ed03144bddd80dc6478030c28ede3b2990f8e792606f317a::data::new_blob(arg6, 0xadefbe1aeb900807ed03144bddd80dc6478030c28ede3b2990f8e792606f317a::confidentiality::new_encrypted(arg7));
        let v5 = 0x7a83dd22131cad38ded582a5cb5527e1ab95eec3c748e934585d6da4f61da563::recording_transcode::new_preview(arg8, arg9, 0xadefbe1aeb900807ed03144bddd80dc6478030c28ede3b2990f8e792606f317a::data::new_blob(arg10, 0xadefbe1aeb900807ed03144bddd80dc6478030c28ede3b2990f8e792606f317a::confidentiality::new_unencrypted()));
        let v6 = TranscodeVerifiedEvent{
            pk             : arg11,
            policy_version : 0x7914545ac251592310fd47fb3a70cdc2b30c233ca0e38b15b5494f30bb0df0ce::enclave::version<AUDIO_TRANSCODER>(arg0),
            verified_at_ms : arg12,
            recording_id   : 0x2::object::id<0xd958fc04212d0be5c92fd89964e6d2fa1065be489b19eaf7668f77ca46c6dba::recording::Recording<T0>>(arg1),
            master_blob_id : arg4,
            data           : v4,
            preview        : v5,
        };
        0x2::event::emit<TranscodeVerifiedEvent>(v6);
        let v7 = AudioTranscoder{dummy_field: false};
        0x7a83dd22131cad38ded582a5cb5527e1ab95eec3c748e934585d6da4f61da563::recording_transcode::new<AudioTranscoder>(v7, v4, v5)
    }

    // decompiled from Move bytecode v7
}

