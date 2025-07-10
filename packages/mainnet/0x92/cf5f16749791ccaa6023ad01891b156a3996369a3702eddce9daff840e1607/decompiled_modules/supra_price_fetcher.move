module 0x92cf5f16749791ccaa6023ad01891b156a3996369a3702eddce9daff840e1607::supra_price_fetcher {
    public fun fetch_price(arg0: 0x1::ascii::String, arg1: &0x5d8fbbf6f908a4af8c6d072669a462d53e03eb3c1d863bd0359dc818c69ea706::SupraSValueFeed::OracleHolder, arg2: u32, arg3: u8) : 0x1::option::Option<0x92cf5f16749791ccaa6023ad01891b156a3996369a3702eddce9daff840e1607::current_price::CurrentPrice> {
        let (v0, v1, v2, _) = 0x5d8fbbf6f908a4af8c6d072669a462d53e03eb3c1d863bd0359dc818c69ea706::SupraSValueFeed::get_price(arg1, arg2);
        let v4 = (v1 as u8);
        let v5 = if (v4 > arg3) {
            (v0 as u64) / 0x1::u64::pow(10, v4 - arg3)
        } else {
            (v0 as u64) * 0x1::u64::pow(10, arg3 - v4)
        };
        0x1::option::some<0x92cf5f16749791ccaa6023ad01891b156a3996369a3702eddce9daff840e1607::current_price::CurrentPrice>(0x92cf5f16749791ccaa6023ad01891b156a3996369a3702eddce9daff840e1607::current_price::new_current_price(arg0, v5, arg3, (v2 as u64)))
    }

    // decompiled from Move bytecode v6
}

