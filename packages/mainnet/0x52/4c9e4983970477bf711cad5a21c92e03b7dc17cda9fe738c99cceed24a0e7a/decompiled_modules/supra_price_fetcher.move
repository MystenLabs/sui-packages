module 0x524c9e4983970477bf711cad5a21c92e03b7dc17cda9fe738c99cceed24a0e7a::supra_price_fetcher {
    public fun fetch_price<T0>(arg0: &0x5d8fbbf6f908a4af8c6d072669a462d53e03eb3c1d863bd0359dc818c69ea706::SupraSValueFeed::OracleHolder, arg1: u32, arg2: u8) : 0x1::option::Option<0x524c9e4983970477bf711cad5a21c92e03b7dc17cda9fe738c99cceed24a0e7a::current_price::CurrentPrice<T0>> {
        let (v0, v1, v2, _) = 0x5d8fbbf6f908a4af8c6d072669a462d53e03eb3c1d863bd0359dc818c69ea706::SupraSValueFeed::get_price(arg0, arg1);
        let v4 = (v1 as u8);
        let v5 = if (v4 > arg2) {
            (v0 as u64) / 0x1::u64::pow(10, v4 - arg2)
        } else {
            (v0 as u64) * 0x1::u64::pow(10, arg2 - v4)
        };
        0x1::option::some<0x524c9e4983970477bf711cad5a21c92e03b7dc17cda9fe738c99cceed24a0e7a::current_price::CurrentPrice<T0>>(0x524c9e4983970477bf711cad5a21c92e03b7dc17cda9fe738c99cceed24a0e7a::current_price::new_current_price<T0>(v5, arg2, (v2 as u64)))
    }

    // decompiled from Move bytecode v6
}

