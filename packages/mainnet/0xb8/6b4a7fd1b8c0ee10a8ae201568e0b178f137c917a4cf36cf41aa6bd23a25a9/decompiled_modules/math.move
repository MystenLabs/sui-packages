module 0xb86b4a7fd1b8c0ee10a8ae201568e0b178f137c917a4cf36cf41aa6bd23a25a9::math {
    public fun bytes_to_u256(arg0: &vector<u8>) : u256 {
        let v0 = 0;
        let v1 = 0;
        while (v1 < 32) {
            let v2 = v0 << 8;
            v0 = v2 | (*0x1::vector::borrow<u8>(arg0, v1) as u256);
            v1 = v1 + 1;
        };
        v0
    }

    public fun max_u64() : u64 {
        18446744073709551615
    }

    public fun mul_and_div(arg0: u64, arg1: u64, arg2: u64) : u64 {
        (((arg0 as u128) * (arg1 as u128) / (arg2 as u128)) as u64)
    }

    public fun mul_and_div_m_u128(arg0: u64, arg1: u64, arg2: u128) : u64 {
        (((arg0 as u128) * (arg1 as u128) / arg2) as u64)
    }

    public fun mul_and_div_u128(arg0: u64, arg1: u128, arg2: u128) : u64 {
        (((arg0 as u128) * arg1 / arg2) as u64)
    }

    public fun mul_rate(arg0: u64, arg1: u64) : u64 {
        (((arg0 as u128) * (arg1 as u128) / 1000000) as u64)
    }

    public fun pow(arg0: u64, arg1: u8) : u64 {
        let v0 = arg0;
        let v1 = arg1;
        let v2 = 1;
        while (v1 >= 1) {
            if (v1 % 2 == 0) {
                v0 = v0 * v0;
                v1 = v1 / 2;
                continue
            };
            v2 = v2 * v0;
            v1 = v1 - 1;
        };
        v2
    }

    public fun precision() : u64 {
        (1000000 as u64)
    }

    // decompiled from Move bytecode v6
}

