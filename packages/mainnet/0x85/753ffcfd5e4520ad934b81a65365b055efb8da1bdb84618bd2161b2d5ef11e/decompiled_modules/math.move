module 0x85753ffcfd5e4520ad934b81a65365b055efb8da1bdb84618bd2161b2d5ef11e::math {
    public fun bytes_to_u256(arg0: &vector<u8>) : u256 {
        let v0 = 0;
        let v1 = 32;
        assert!(0x1::vector::length<u8>(arg0) == v1, 0);
        let v2 = 0;
        while (v2 < v1) {
            let v3 = v0 << 8;
            v0 = v3 | (*0x1::vector::borrow<u8>(arg0, v2) as u256);
            v2 = v2 + 1;
        };
        v0
    }

    public fun get_random_u64(arg0: &vector<u8>) : u64 {
        ((bytes_to_u256(arg0) % 18446744073709551615) as u64)
    }

    public fun get_random_u64_in_range(arg0: &vector<u8>, arg1: u64) : u64 {
        ((bytes_to_u256(arg0) % 18446744073709551615) as u64) % arg1
    }

    // decompiled from Move bytecode v6
}

