module 0xc547a01e2fcd7b126e94d6fa67172ea074e452a0534e31d52dbd0e7907bde35f::audio_verifier {
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
    }

    struct AudioVerifiedEvent has copy, drop {
        pk: vector<u8>,
        policy_version: u64,
        verified_at_ms: u64,
        audio_id: 0x2::object::ID,
    }

    fun init(arg0: AUDIO_VERIFIER, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0xc8906ad5bebb9c50e786a3246791cdd2e95c304596574a68647c2d48de69afe8::enclave::new<AUDIO_VERIFIER>(arg0, arg1);
        0xc8906ad5bebb9c50e786a3246791cdd2e95c304596574a68647c2d48de69afe8::enclave::share<AUDIO_VERIFIER>(v0);
        0x2::transfer::public_transfer<0xc8906ad5bebb9c50e786a3246791cdd2e95c304596574a68647c2d48de69afe8::enclave::EnclavePolicyAdminCap<AUDIO_VERIFIER>>(v1, 0x2::tx_context::sender(arg1));
    }

    public fun verify_audio(arg0: &mut 0x5dafcccd44bc253b50bf35b23086e0495264956662fd96fb87b8068eef8eeaeb::audio::AudioRegistry, arg1: &0xc8906ad5bebb9c50e786a3246791cdd2e95c304596574a68647c2d48de69afe8::enclave::EnclavePolicy<AUDIO_VERIFIER>, arg2: vector<u8>, arg3: u8, arg4: u8, arg5: u32, arg6: u64, arg7: vector<u8>, arg8: u64, arg9: vector<u8>) : 0x5dafcccd44bc253b50bf35b23086e0495264956662fd96fb87b8068eef8eeaeb::audio::Audio<AudioVerifier> {
        let v0 = AudioPayload{
            channels            : arg3,
            bit_depth           : arg4,
            sample_rate_hz      : arg5,
            samples_per_channel : arg6,
            pcm_digest          : arg7,
        };
        0xc8906ad5bebb9c50e786a3246791cdd2e95c304596574a68647c2d48de69afe8::enclave::verify_signature<AUDIO_VERIFIER, AudioPayload>(arg1, arg2, 0, arg8, v0, &arg9);
        let v1 = AudioVerifier{dummy_field: false};
        let v2 = 0x5dafcccd44bc253b50bf35b23086e0495264956662fd96fb87b8068eef8eeaeb::audio::new<AudioVerifier>(arg0, v1, arg3, arg4, arg5, arg6, arg7);
        let v3 = AudioVerifiedEvent{
            pk             : arg2,
            policy_version : 0xc8906ad5bebb9c50e786a3246791cdd2e95c304596574a68647c2d48de69afe8::enclave::version<AUDIO_VERIFIER>(arg1),
            verified_at_ms : arg8,
            audio_id       : 0x2::object::id<0x5dafcccd44bc253b50bf35b23086e0495264956662fd96fb87b8068eef8eeaeb::audio::Audio<AudioVerifier>>(&v2),
        };
        0x2::event::emit<AudioVerifiedEvent>(v3);
        v2
    }

    // decompiled from Move bytecode v7
}

