module 0x63ffbdadd2fb06111ff4b00c66684fd2d02f11b42b57f1dca6b87a1e9295f49a::math {
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

