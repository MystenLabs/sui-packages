module 0x58f6df360e1d410fc23a66313bd460171011c093d4b1c907c74fd329ed4ce28c::math {
    public fun bytes_to_u128(arg0: &vector<u8>) : u128 {
        let v0 = 0;
        assert!(0x1::vector::length<u8>(arg0) == 32, 0);
        let v1 = 0;
        while (v1 < 32) {
            let v2 = v0 << 8;
            v0 = v2 | (*0x1::vector::borrow<u8>(arg0, v1) as u128);
            v1 = v1 + 1;
        };
        v0
    }

    public fun get_random_u64(arg0: &vector<u8>) : u64 {
        ((bytes_to_u128(arg0) % 18446744073709551615) as u64)
    }

    public fun get_random_u64_in_range(arg0: &vector<u8>, arg1: u64) : u64 {
        ((bytes_to_u128(arg0) % (arg1 as u128)) as u64)
    }

    // decompiled from Move bytecode v6
}

