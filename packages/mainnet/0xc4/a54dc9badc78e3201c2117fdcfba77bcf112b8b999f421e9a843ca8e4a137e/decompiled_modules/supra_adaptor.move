module 0xc4a54dc9badc78e3201c2117fdcfba77bcf112b8b999f421e9a843ca8e4a137e::supra_adaptor {
    public fun convert_price(arg0: u128, arg1: u16, arg2: u64, arg3: u128, arg4: u16, arg5: u64, arg6: u8) : (u128, u16, u128, u64) {
        assert!(arg6 <= 1, 6);
        let v0 = if (arg6 == 0) {
            let v1 = arg1 + arg4;
            if (v1 > 18) {
                (arg0 as u256) * (arg3 as u256) / 0x1ee7b04f04ef049a6d711d0c0446d7b67b63c27c1397efa9536145085a4d1b7c::utils::calculate_power(10, v1 - 18)
            } else {
                (arg0 as u256) * (arg3 as u256) * 0x1ee7b04f04ef049a6d711d0c0446d7b67b63c27c1397efa9536145085a4d1b7c::utils::calculate_power(10, 18 - v1)
            }
        } else {
            scale_price((arg0 as u256), arg1) * 0x1ee7b04f04ef049a6d711d0c0446d7b67b63c27c1397efa9536145085a4d1b7c::utils::calculate_power(10, 18) / scale_price((arg3 as u256), arg4)
        };
        let v2 = 0;
        let v3 = if (arg2 > arg5) {
            v2 = 2;
            arg2 - arg5
        } else if (arg2 < arg5) {
            v2 = 1;
            arg5 - arg2
        } else {
            0
        };
        ((v0 as u128), 18, (v3 as u128), (v2 as u64))
    }

    public fun get_supra_price(arg0: &0x5d8fbbf6f908a4af8c6d072669a462d53e03eb3c1d863bd0359dc818c69ea706::SupraSValueFeed::OracleHolder, arg1: u32) : (u64, u8, u64) {
        let (v0, v1, v2, _) = 0x5d8fbbf6f908a4af8c6d072669a462d53e03eb3c1d863bd0359dc818c69ea706::SupraSValueFeed::get_price(arg0, arg1);
        assert!(v1 <= 255, 70401);
        assert!(v0 <= 18446744073709551615, 70402);
        let v4 = v2 / 1000;
        assert!(v4 <= 18446744073709551615, 70403);
        ((v0 as u64), (v1 as u8), (v4 as u64))
    }

    fun scale_price(arg0: u256, arg1: u16) : u256 {
        assert!(arg1 <= 18, 7);
        if (arg1 == 18) {
            arg0
        } else {
            arg0 * 0x1ee7b04f04ef049a6d711d0c0446d7b67b63c27c1397efa9536145085a4d1b7c::utils::calculate_power(10, 18 - arg1)
        }
    }

    // decompiled from Move bytecode v6
}

