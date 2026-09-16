module 0x73a989640258bd5d82e0ae23bcb6f874fae65c78aecc1781b9a702801a043d7e::audio {
    struct Audio has copy, drop, store {
        format: 0x1::string::String,
        channels: u8,
        bit_depth: u8,
        sample_rate_hz: u32,
        samples: u64,
        pcm_digest: vector<u8>,
        blob_id: u256,
    }

    public fun bit_depth(arg0: &Audio) : u8 {
        arg0.bit_depth
    }

    public fun blob_id(arg0: &Audio) : u256 {
        arg0.blob_id
    }

    public fun channels(arg0: &Audio) : u8 {
        arg0.channels
    }

    public fun duration_ms(arg0: &Audio) : u64 {
        0x1::u64::mul_div(arg0.samples, 1000, (arg0.sample_rate_hz as u64))
    }

    public fun format(arg0: &Audio) : &0x1::string::String {
        &arg0.format
    }

    public fun new(arg0: 0x1::string::String, arg1: u8, arg2: u8, arg3: u32, arg4: u64, arg5: vector<u8>, arg6: u256) : Audio {
        let v0 = 0x1::string::as_bytes(&arg0);
        assert!(!0x1::vector::is_empty<u8>(v0), 26);
        assert!(0x1::vector::length<u8>(v0) <= 16, 27);
        let v1 = 0;
        let v2;
        while (v1 < 0x1::vector::length<u8>(v0)) {
            let v3 = 0x1::vector::borrow<u8>(v0, v1);
            let v4 = *v3 >= 97 && *v3 <= 122 || *v3 >= 48 && *v3 <= 57;
            if (!v4) {
                v2 = false;
                /* label 21 */
                assert!(v2, 28);
                assert!(0x1::vector::length<u8>(&arg5) == 32, 29);
                assert!(arg1 > 0, 21);
                let v5 = x"08101820";
                assert!(0x1::vector::contains<u8>(&v5, &arg2), 22);
                let v6 = vector[44100, 48000, 88200, 96000, 176400, 192000, 352800, 384000];
                assert!(0x1::vector::contains<u32>(&v6, &arg3), 23);
                assert!(arg4 > 0, 24);
                return Audio{
                    format         : arg0,
                    channels       : arg1,
                    bit_depth      : arg2,
                    sample_rate_hz : arg3,
                    samples        : arg4,
                    pcm_digest     : arg5,
                    blob_id        : arg6,
                }
            };
            v1 = v1 + 1;
        };
        v2 = true;
        /* goto 21 */
    }

    public fun pcm_digest(arg0: &Audio) : &vector<u8> {
        &arg0.pcm_digest
    }

    public fun sample_rate_hz(arg0: &Audio) : u32 {
        arg0.sample_rate_hz
    }

    public fun samples(arg0: &Audio) : u64 {
        arg0.samples
    }

    // decompiled from Move bytecode v7
}

