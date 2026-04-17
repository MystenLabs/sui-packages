module 0x27158ec83407d16d243bcd4e96e4bdaa1aad9d102a87df1fe087d03f0d954f4c::bin_math {
    public fun decode_bin_id(arg0: u32) : (u64, bool) {
        let v0 = (arg0 as u64);
        if (v0 >= 2147483648) {
            (v0 - 2147483648, false)
        } else {
            (2147483648 - v0, true)
        }
    }

    public fun encode_bin_id(arg0: u64) : u32 {
        assert!(arg0 <= 2147483647, 0);
        ((arg0 + 2147483648) as u32)
    }

    public fun encode_negative_bin_id(arg0: u64) : u32 {
        assert!(arg0 <= 2147483648, 0);
        ((2147483648 - arg0) as u32)
    }

    public fun encoded_gte(arg0: u32, arg1: u32) : bool {
        arg0 >= arg1
    }

    public fun encoded_lte(arg0: u32, arg1: u32) : bool {
        arg0 <= arg1
    }

    public fun is_limit_order_filled(arg0: u32, arg1: u32, arg2: u8) : bool {
        arg2 == 0 && encoded_lte(arg0, arg1) || encoded_gte(arg0, arg1)
    }

    // decompiled from Move bytecode v7
}

