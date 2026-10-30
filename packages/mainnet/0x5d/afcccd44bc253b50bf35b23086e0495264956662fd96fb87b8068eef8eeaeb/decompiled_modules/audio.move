module 0x5dafcccd44bc253b50bf35b23086e0495264956662fd96fb87b8068eef8eeaeb::audio {
    struct Audio<phantom T0> has key {
        id: 0x2::object::UID,
        channels: u8,
        bit_depth: u8,
        sample_rate_hz: u32,
        samples_per_channel: u64,
        pcm_digest: vector<u8>,
    }

    struct AudioRegistry has key {
        id: 0x2::object::UID,
    }

    struct AudioKey<phantom T0> has copy, drop, store {
        pos0: u8,
        pos1: u8,
        pos2: u32,
        pos3: u64,
        pos4: vector<u8>,
    }

    struct AudioCreatedEvent<phantom T0> has copy, drop {
        audio_id: 0x2::object::ID,
        channels: u8,
        bit_depth: u8,
        sample_rate_hz: u32,
        samples_per_channel: u64,
        pcm_digest: vector<u8>,
    }

    public fun derive_address<T0>(arg0: &AudioRegistry, arg1: u8, arg2: u8, arg3: u32, arg4: u64, arg5: vector<u8>) : address {
        let v0 = AudioKey<T0>{
            pos0 : arg1,
            pos1 : arg2,
            pos2 : arg3,
            pos3 : arg4,
            pos4 : arg5,
        };
        0x2::derived_object::derive_address<AudioKey<T0>>(0x2::object::id<AudioRegistry>(arg0), v0)
    }

    public fun new<T0: drop>(arg0: &mut AudioRegistry, arg1: T0, arg2: u8, arg3: u8, arg4: u32, arg5: u64, arg6: vector<u8>) : Audio<T0> {
        assert!(arg2 > 0, 0);
        assert!(arg3 > 0 && arg3 <= 32, 1);
        assert!(arg4 > 0, 2);
        assert!(arg5 > 0, 3);
        let v0 = 0x1::u64::checked_mul(arg5, 1000);
        assert!(0x1::option::is_some<u64>(&v0), 4);
        assert!(0x1::vector::length<u8>(&arg6) == 32, 5);
        let v1 = AudioKey<T0>{
            pos0 : arg2,
            pos1 : arg3,
            pos2 : arg4,
            pos3 : arg5,
            pos4 : arg6,
        };
        let v2 = 0x2::derived_object::claim<AudioKey<T0>>(&mut arg0.id, v1);
        let v3 = AudioCreatedEvent<T0>{
            audio_id            : 0x2::object::uid_to_inner(&v2),
            channels            : arg2,
            bit_depth           : arg3,
            sample_rate_hz      : arg4,
            samples_per_channel : arg5,
            pcm_digest          : arg6,
        };
        0x2::event::emit<AudioCreatedEvent<T0>>(v3);
        Audio<T0>{
            id                  : v2,
            channels            : arg2,
            bit_depth           : arg3,
            sample_rate_hz      : arg4,
            samples_per_channel : arg5,
            pcm_digest          : arg6,
        }
    }

    public fun bit_depth<T0>(arg0: &Audio<T0>) : u8 {
        arg0.bit_depth
    }

    public fun channels<T0>(arg0: &Audio<T0>) : u8 {
        arg0.channels
    }

    public fun duration_ms<T0>(arg0: &Audio<T0>) : u64 {
        0x1::u64::mul_div(arg0.samples_per_channel, 1000, (arg0.sample_rate_hz as u64))
    }

    public fun freeze_audio<T0>(arg0: Audio<T0>) {
        0x2::transfer::freeze_object<Audio<T0>>(arg0);
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = AudioRegistry{id: 0x2::object::new(arg0)};
        0x2::transfer::share_object<AudioRegistry>(v0);
    }

    public fun pcm_digest<T0>(arg0: &Audio<T0>) : &vector<u8> {
        &arg0.pcm_digest
    }

    public fun sample_rate_hz<T0>(arg0: &Audio<T0>) : u32 {
        arg0.sample_rate_hz
    }

    public fun samples_per_channel<T0>(arg0: &Audio<T0>) : u64 {
        arg0.samples_per_channel
    }

    // decompiled from Move bytecode v7
}

