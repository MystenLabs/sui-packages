module 0xa9daa5db9a04206aa3fccd61b2154792070674d0edc15caceada21fcdba8e606::random {
    struct RandomBoolEvent has copy, drop {
        rand_u64: u64,
        rand_bool: bool,
    }

    struct Random has drop, store {
        state: vector<u8>,
    }

    public fun new(arg0: vector<u8>) : Random {
        Random{state: arg0}
    }

    public fun next_bool(arg0: &mut Random) : bool {
        next_u8(arg0) % 2 == 1
    }

    public fun next_bool_with_p(arg0: &mut Random, arg1: 0x1::fixed_point32::FixedPoint32) : bool {
        let v0 = next_u64(arg0);
        let v1 = v0 < 0x1::fixed_point32::multiply_u64(18446744073709551615, arg1);
        let v2 = RandomBoolEvent{
            rand_u64  : v0,
            rand_bool : v1,
        };
        0x2::event::emit<RandomBoolEvent>(v2);
        v1
    }

    public fun next_bytes(arg0: &mut Random, arg1: u64) : vector<u8> {
        let v0 = arg1 / 32;
        let v1 = arg1 - v0 * 32;
        let v2 = b"";
        let v3 = 0;
        while (v3 < v0) {
            let v4 = next_digest(arg0);
            0x1::vector::append<u8>(&mut v2, v4);
            v3 = v3 + 1;
        };
        if (v1 > 0) {
            let v5 = next_digest(arg0);
            let v6 = 0;
            while (v6 < v1) {
                0x1::vector::push_back<u8>(&mut v2, *0x1::vector::borrow<u8>(&mut v5, v6));
                v6 = v6 + 1;
            };
        };
        v2
    }

    fun next_digest(arg0: &mut Random) : vector<u8> {
        arg0.state = 0x1::hash::sha3_256(arg0.state);
        arg0.state
    }

    public fun next_u128(arg0: &mut Random) : u128 {
        (next_u256_in_range(arg0, 340282366920938463463374607431768211456) as u128)
    }

    public fun next_u128_in_range(arg0: &mut Random, arg1: u128) : u128 {
        assert!(arg1 > 0, 0);
        next_u128(arg0) % arg1
    }

    public fun next_u16(arg0: &mut Random) : u16 {
        (next_u256_in_range(arg0, 65536) as u16)
    }

    public fun next_u16_in_range(arg0: &mut Random, arg1: u16) : u16 {
        assert!(arg1 > 0, 0);
        next_u16(arg0) % arg1
    }

    public fun next_u256(arg0: &mut Random) : u256 {
        let v0 = next_digest(arg0);
        let v1 = 0;
        let v2 = 0;
        while (v1 < 32) {
            v2 = v2 + ((0x1::vector::pop_back<u8>(&mut v0) as u256) << 8 * v1);
            v1 = v1 + 1;
        };
        v2
    }

    public fun next_u256_in_range(arg0: &mut Random, arg1: u256) : u256 {
        assert!(arg1 > 0, 0);
        next_u256(arg0) % arg1
    }

    public fun next_u32(arg0: &mut Random) : u32 {
        (next_u256_in_range(arg0, 4294967296) as u32)
    }

    public fun next_u32_in_range(arg0: &mut Random, arg1: u32) : u32 {
        assert!(arg1 > 0, 0);
        next_u32(arg0) % arg1
    }

    public fun next_u64(arg0: &mut Random) : u64 {
        (next_u256_in_range(arg0, 18446744073709551616) as u64)
    }

    public fun next_u64_in_range(arg0: &mut Random, arg1: u64) : u64 {
        assert!(arg1 > 0, 0);
        next_u64(arg0) % arg1
    }

    public fun next_u8(arg0: &mut Random) : u8 {
        let v0 = next_digest(arg0);
        0x1::vector::pop_back<u8>(&mut v0)
    }

    public fun next_u8_in_range(arg0: &mut Random, arg1: u8) : u8 {
        assert!(arg1 > 0, 0);
        next_u8(arg0) % arg1
    }

    public fun pseudo_random_num_generator(arg0: &0x2::object::UID, arg1: &0x2::clock::Clock) : vector<u8> {
        let v0 = 0x2::object::uid_to_bytes(arg0);
        let v1 = 0x1::vector::empty<u8>();
        let v2 = 0x2::clock::timestamp_ms(arg1);
        0x1::vector::append<u8>(&mut v0, 0x1::bcs::to_bytes<u64>(&v2));
        let v3 = v0;
        v0 = 0x1::hash::sha3_256(v3);
        let v4 = 0;
        while (v4 < 32) {
            0x1::vector::push_back<u8>(&mut v1, (*0x1::vector::borrow<u8>(&v0, v4) as u8) % (32 as u8));
            v4 = v4 + 1;
        };
        v1
    }

    // decompiled from Move bytecode v6
}

