module 0x11f24c8cd2aa5dd42580c6799922a6197b2ef6a93cff2f64b6bb8f86ffdc47e4::audio_verifier {
    struct AUDIO_VERIFIER has drop {
        dummy_field: bool,
    }

    struct AudioVerifier has drop {
        dummy_field: bool,
    }

    struct AudioPayload has copy, drop {
        channels: u8,
        bit_depth: u8,
        sample_rate_hz: u32,
        samples_per_channel: u64,
        pcm_digest: vector<u8>,
        channel_layout: vector<u8>,
        blob_id: u256,
        sealed_dek: vector<u8>,
    }

    struct AudioVerifiedEvent has copy, drop {
        pk: vector<u8>,
        policy_version: u64,
        verified_at_ms: u64,
        format: 0x857344a4593c4b42b4512c230dbbda14c70abb09c4767d6e6228aebffcd6ed65::audio_format_pcm::Pcm,
        layout: 0x78fc72a89343f4237448a79c4b1fcc158cfd612bb4a9813847ad2d5760cf5f3d::audio_channel_layout::ChannelLayout,
        data: 0xadefbe1aeb900807ed03144bddd80dc6478030c28ede3b2990f8e792606f317a::data::WalrusBlob,
    }

    fun init(arg0: AUDIO_VERIFIER, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x7914545ac251592310fd47fb3a70cdc2b30c233ca0e38b15b5494f30bb0df0ce::enclave::new<AUDIO_VERIFIER>(arg0, arg1);
        0x7914545ac251592310fd47fb3a70cdc2b30c233ca0e38b15b5494f30bb0df0ce::enclave::share<AUDIO_VERIFIER>(v0);
        0x2::transfer::public_transfer<0x7914545ac251592310fd47fb3a70cdc2b30c233ca0e38b15b5494f30bb0df0ce::enclave::EnclavePolicyAdminCap<AUDIO_VERIFIER>>(v1, 0x2::tx_context::sender(arg1));
    }

    public fun verify_audio(arg0: &0x7914545ac251592310fd47fb3a70cdc2b30c233ca0e38b15b5494f30bb0df0ce::enclave::EnclavePolicy<AUDIO_VERIFIER>, arg1: u8, arg2: u8, arg3: u32, arg4: u64, arg5: vector<u8>, arg6: vector<u8>, arg7: u256, arg8: vector<u8>, arg9: vector<u8>, arg10: u64, arg11: vector<u8>) : 0x4eec45b7624d50d65da8d4e68674ea03497e2f22351d1f6075f2844a41078468::audio::Audio<AudioVerifier, 0x857344a4593c4b42b4512c230dbbda14c70abb09c4767d6e6228aebffcd6ed65::audio_format_pcm::Pcm, 0x78fc72a89343f4237448a79c4b1fcc158cfd612bb4a9813847ad2d5760cf5f3d::audio_channel_layout::ChannelLayout> {
        let v0 = AudioPayload{
            channels            : arg1,
            bit_depth           : arg2,
            sample_rate_hz      : arg3,
            samples_per_channel : arg4,
            pcm_digest          : arg5,
            channel_layout      : arg6,
            blob_id             : arg7,
            sealed_dek          : arg8,
        };
        0x7914545ac251592310fd47fb3a70cdc2b30c233ca0e38b15b5494f30bb0df0ce::enclave::verify_signature<AUDIO_VERIFIER, AudioPayload>(arg0, arg9, 0, arg10, v0, &arg11);
        let v1 = 0x857344a4593c4b42b4512c230dbbda14c70abb09c4767d6e6228aebffcd6ed65::audio_format_pcm::new(arg1, arg2, arg3, arg4, arg5);
        assert!(0x1::vector::length<u8>(&arg6) == (arg1 as u64), 0);
        let v2 = 0x78fc72a89343f4237448a79c4b1fcc158cfd612bb4a9813847ad2d5760cf5f3d::audio_channel_layout::new(arg6);
        let v3 = 0xadefbe1aeb900807ed03144bddd80dc6478030c28ede3b2990f8e792606f317a::data::new_blob(arg7, 0xadefbe1aeb900807ed03144bddd80dc6478030c28ede3b2990f8e792606f317a::confidentiality::new_encrypted(arg8));
        let v4 = AudioVerifiedEvent{
            pk             : arg9,
            policy_version : 0x7914545ac251592310fd47fb3a70cdc2b30c233ca0e38b15b5494f30bb0df0ce::enclave::version<AUDIO_VERIFIER>(arg0),
            verified_at_ms : arg10,
            format         : v1,
            layout         : v2,
            data           : v3,
        };
        0x2::event::emit<AudioVerifiedEvent>(v4);
        let v5 = AudioVerifier{dummy_field: false};
        0x4eec45b7624d50d65da8d4e68674ea03497e2f22351d1f6075f2844a41078468::audio::new<AudioVerifier, 0x857344a4593c4b42b4512c230dbbda14c70abb09c4767d6e6228aebffcd6ed65::audio_format_pcm::Pcm, 0x78fc72a89343f4237448a79c4b1fcc158cfd612bb4a9813847ad2d5760cf5f3d::audio_channel_layout::ChannelLayout>(v5, v1, v2, v3)
    }

    // decompiled from Move bytecode v7
}

