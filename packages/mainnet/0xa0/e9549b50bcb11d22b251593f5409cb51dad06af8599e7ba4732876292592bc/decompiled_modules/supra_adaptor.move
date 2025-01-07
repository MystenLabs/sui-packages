module 0xa0e9549b50bcb11d22b251593f5409cb51dad06af8599e7ba4732876292592bc::supra_adaptor {
    public fun get_supra_price(arg0: &0x5d8fbbf6f908a4af8c6d072669a462d53e03eb3c1d863bd0359dc818c69ea706::SupraSValueFeed::OracleHolder, arg1: u32) : (u64, u8, u64) {
        let (v0, v1, v2, _) = 0x5d8fbbf6f908a4af8c6d072669a462d53e03eb3c1d863bd0359dc818c69ea706::SupraSValueFeed::get_price(arg0, arg1);
        assert!(v1 <= 255, 70401);
        assert!(v0 <= 18446744073709551615, 70402);
        let v4 = v2 / 1000;
        assert!(v4 <= 18446744073709551615, 70403);
        ((v0 as u64), (v1 as u8), (v4 as u64))
    }

    // decompiled from Move bytecode v6
}

