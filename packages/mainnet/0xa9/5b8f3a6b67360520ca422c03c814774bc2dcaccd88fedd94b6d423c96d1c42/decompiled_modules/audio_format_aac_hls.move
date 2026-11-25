module 0xa95b8f3a6b67360520ca422c03c814774bc2dcaccd88fedd94b6d423c96d1c42::audio_format_aac_hls {
    struct AacHls has copy, drop, store {
        bitrates_kbps: vector<u16>,
        sample_rate_hz: u32,
        source_pcm_digest: vector<u8>,
        manifest: vector<u8>,
    }

    public fun bitrates_kbps(arg0: &AacHls) : &vector<u16> {
        &arg0.bitrates_kbps
    }

    public fun manifest(arg0: &AacHls) : &vector<u8> {
        &arg0.manifest
    }

    public fun max_bitrates() : u64 {
        8
    }

    public fun new(arg0: vector<u16>, arg1: u32, arg2: vector<u8>, arg3: vector<u8>) : AacHls {
        let v0 = 0x1::vector::length<u16>(&arg0);
        assert!(v0 > 0, 0);
        assert!(v0 <= 8, 1);
        assert!(*0x1::vector::borrow<u16>(&arg0, 0) > 0, 2);
        let v1 = 1;
        while (v1 < v0) {
            assert!(*0x1::vector::borrow<u16>(&arg0, v1 - 1) < *0x1::vector::borrow<u16>(&arg0, v1), 2);
            v1 = v1 + 1;
        };
        assert!(arg1 > 0, 3);
        assert!(0x1::vector::length<u8>(&arg2) == 32, 4);
        assert!(0x1::vector::length<u8>(&arg3) == 32, 4);
        AacHls{
            bitrates_kbps     : arg0,
            sample_rate_hz    : arg1,
            source_pcm_digest : arg2,
            manifest          : arg3,
        }
    }

    public fun sample_rate_hz(arg0: &AacHls) : u32 {
        arg0.sample_rate_hz
    }

    public fun source_pcm_digest(arg0: &AacHls) : &vector<u8> {
        &arg0.source_pcm_digest
    }

    // decompiled from Move bytecode v7
}

