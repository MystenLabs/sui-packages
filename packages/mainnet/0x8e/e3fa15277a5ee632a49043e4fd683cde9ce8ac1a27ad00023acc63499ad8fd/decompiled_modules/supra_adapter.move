module 0x8ee3fa15277a5ee632a49043e4fd683cde9ce8ac1a27ad00023acc63499ad8fd::supra_adapter {
    public fun get_supra_price(arg0: &mut 0x5d8fbbf6f908a4af8c6d072669a462d53e03eb3c1d863bd0359dc818c69ea706::SupraSValueFeed::OracleHolder, arg1: u32) : (u64, u64) {
        let (v0, v1, v2, _) = 0x5d8fbbf6f908a4af8c6d072669a462d53e03eb3c1d863bd0359dc818c69ea706::SupraSValueFeed::get_price(arg0, arg1);
        assert!(v1 <= 255, 0);
        assert!(v0 <= 18446744073709551615, 0);
        assert!(v2 <= 18446744073709551615, 0);
        (scale_price_to_formatted_decimals((v0 as u64), (v1 as u8)), (v2 as u64))
    }

    fun scale_price_to_formatted_decimals(arg0: u64, arg1: u8) : u64 {
        if (arg1 < 9) {
            arg0 * 0x2::math::pow(10, 9 - arg1)
        } else {
            arg0 / 0x2::math::pow(10, arg1 - 9)
        }
    }

    // decompiled from Move bytecode v6
}

