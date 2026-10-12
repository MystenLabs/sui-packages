module 0x55eb01b43f40795fd99e394f5662cc87bcc15337979fce5dc62149835259695::math {
    public fun convert_to_assets(arg0: u64, arg1: u64, arg2: u64) : u64 {
        mul_div(arg0, arg1 + 1, arg2 + 1)
    }

    public fun convert_to_shares(arg0: u64, arg1: u64, arg2: u64) : u64 {
        mul_div(arg0, arg2 + 1, arg1 + 1)
    }

    public fun max_bps() : u64 {
        10000
    }

    public fun mul_div(arg0: u64, arg1: u64, arg2: u64) : u64 {
        safe_cast((arg0 as u256) * (arg1 as u256) / (arg2 as u256))
    }

    public fun safe_cast(arg0: u256) : u64 {
        assert!(arg0 <= 18446744073709551615, 0x55eb01b43f40795fd99e394f5662cc87bcc15337979fce5dc62149835259695::error::cast_overflow());
        (arg0 as u64)
    }

    public fun u64_max() : u256 {
        18446744073709551615
    }

    public fun wad() : u64 {
        1000000000000000000
    }

    // decompiled from Move bytecode v7
}

