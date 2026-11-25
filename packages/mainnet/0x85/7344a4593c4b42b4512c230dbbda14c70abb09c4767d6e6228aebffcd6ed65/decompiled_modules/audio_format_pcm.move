module 0x857344a4593c4b42b4512c230dbbda14c70abb09c4767d6e6228aebffcd6ed65::audio_format_pcm {
    struct Pcm has copy, drop, store {
        channels: u8,
        bit_depth: u8,
        sample_rate_hz: u32,
        samples_per_channel: u64,
        digest: vector<u8>,
    }

    public fun bit_depth(arg0: &Pcm) : u8 {
        arg0.bit_depth
    }

    public fun channels(arg0: &Pcm) : u8 {
        arg0.channels
    }

    public fun digest(arg0: &Pcm) : &vector<u8> {
        &arg0.digest
    }

    public fun duration_ms(arg0: &Pcm) : u64 {
        0x1::u64::mul_div(arg0.samples_per_channel, 1000, (arg0.sample_rate_hz as u64))
    }

    public fun new(arg0: u8, arg1: u8, arg2: u32, arg3: u64, arg4: vector<u8>) : Pcm {
        assert!(arg0 > 0, 0);
        assert!(arg1 > 0 && arg1 <= 32, 1);
        assert!(arg2 > 0, 2);
        assert!(arg3 > 0, 3);
        let v0 = 0x1::u64::checked_mul(arg3, 1000);
        assert!(0x1::option::is_some<u64>(&v0), 4);
        assert!(0x1::vector::length<u8>(&arg4) == 32, 5);
        Pcm{
            channels            : arg0,
            bit_depth           : arg1,
            sample_rate_hz      : arg2,
            samples_per_channel : arg3,
            digest              : arg4,
        }
    }

    public fun sample_rate_hz(arg0: &Pcm) : u32 {
        arg0.sample_rate_hz
    }

    public fun samples_per_channel(arg0: &Pcm) : u64 {
        arg0.samples_per_channel
    }

    // decompiled from Move bytecode v7
}

