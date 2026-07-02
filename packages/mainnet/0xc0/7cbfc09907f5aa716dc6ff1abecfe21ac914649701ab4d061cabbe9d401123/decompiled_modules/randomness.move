module 0xc07cbfc09907f5aa716dc6ff1abecfe21ac914649701ab4d061cabbe9d401123::randomness {
    public fun new_generator(arg0: &0x2::random::Random, arg1: &mut 0x2::tx_context::TxContext) : 0x2::random::RandomGenerator {
        0x2::random::new_generator(arg0, arg1)
    }

    public fun shuffle_u8(arg0: &mut 0x2::random::RandomGenerator, arg1: &mut vector<u8>) {
        let v0 = 0x1::vector::length<u8>(arg1);
        if (v0 < 2) {
            return
        };
        let v1 = 0;
        while (v1 < v0 - 1) {
            assert!(v0 <= 256, 0);
            0x1::vector::swap<u8>(arg1, v1, (0x2::random::generate_u8_in_range(arg0, (v1 as u8), ((v0 - 1) as u8)) as u64));
            v1 = v1 + 1;
        };
    }

    public fun u16_in_range(arg0: &mut 0x2::random::RandomGenerator, arg1: u16, arg2: u16) : u16 {
        0x2::random::generate_u16_in_range(arg0, arg1, arg2)
    }

    public fun u32_in_range(arg0: &mut 0x2::random::RandomGenerator, arg1: u32, arg2: u32) : u32 {
        0x2::random::generate_u32_in_range(arg0, arg1, arg2)
    }

    public fun u64_in_range(arg0: &mut 0x2::random::RandomGenerator, arg1: u64, arg2: u64) : u64 {
        0x2::random::generate_u64_in_range(arg0, arg1, arg2)
    }

    public fun u8_in_range(arg0: &mut 0x2::random::RandomGenerator, arg1: u8, arg2: u8) : u8 {
        0x2::random::generate_u8_in_range(arg0, arg1, arg2)
    }

    // decompiled from Move bytecode v7
}

