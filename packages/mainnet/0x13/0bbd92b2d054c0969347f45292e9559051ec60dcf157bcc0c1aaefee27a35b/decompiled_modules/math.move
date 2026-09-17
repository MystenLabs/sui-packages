module 0x130bbd92b2d054c0969347f45292e9559051ec60dcf157bcc0c1aaefee27a35b::math {
    public fun convert_to_assets(arg0: u64, arg1: u64, arg2: u64) : u64 {
        mul_div(arg0, arg1 + 1, arg2 + virtual_shares())
    }

    public fun convert_to_shares(arg0: u64, arg1: u64, arg2: u64) : u64 {
        mul_div(arg0, arg2 + virtual_shares(), arg1 + 1)
    }

    public fun max_bps() : u64 {
        10000
    }

    public fun mul_div(arg0: u64, arg1: u64, arg2: u64) : u64 {
        safe_cast((arg0 as u256) * (arg1 as u256) / (arg2 as u256))
    }

    public fun safe_cast(arg0: u256) : u64 {
        assert!(arg0 <= 18446744073709551615, 0x130bbd92b2d054c0969347f45292e9559051ec60dcf157bcc0c1aaefee27a35b::error::cast_overflow());
        (arg0 as u64)
    }

    fun virtual_shares() : u64 {
        1
    }

    public fun wad() : u64 {
        1000000000000000000
    }

    // decompiled from Move bytecode v7
}

