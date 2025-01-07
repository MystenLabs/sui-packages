module 0x9a795e9a2ffbdf2e95769c000b5fa1fc85c87e8f944569738615cac80b5e7275::index {
    public fun get_price_from_supra(arg0: &0x2::clock::Clock, arg1: &0x5d8fbbf6f908a4af8c6d072669a462d53e03eb3c1d863bd0359dc818c69ea706::SupraSValueFeed::OracleHolder, arg2: u32) : u128 {
        let v0 = 0x1::vector::empty<u32>();
        0x1::vector::push_back<u32>(&mut v0, arg2);
        let v1 = 0x5d8fbbf6f908a4af8c6d072669a462d53e03eb3c1d863bd0359dc818c69ea706::SupraSValueFeed::get_prices(arg1, v0);
        assert!(0x1::vector::length<0x5d8fbbf6f908a4af8c6d072669a462d53e03eb3c1d863bd0359dc818c69ea706::SupraSValueFeed::Price>(&v1) == 1, 2000);
        let (v2, v3, v4, v5, _) = 0x5d8fbbf6f908a4af8c6d072669a462d53e03eb3c1d863bd0359dc818c69ea706::SupraSValueFeed::extract_price(0x1::vector::borrow<0x5d8fbbf6f908a4af8c6d072669a462d53e03eb3c1d863bd0359dc818c69ea706::SupraSValueFeed::Price>(&v1, 0));
        assert!(v2 == arg2, 2001);
        assert!((v5 as u64) + 5 <= 0x2::clock::timestamp_ms(arg0), 2002);
        assert!(v4 >= (9 as u16), 2002);
        to_target_decimals(v3, v4, 9)
    }

    public fun to_target_decimals(arg0: u128, arg1: u16, arg2: u16) : u128 {
        while (arg1 != arg2) {
            if (arg1 < arg2) {
                arg0 = arg0 * 10;
                arg1 = arg1 + 1;
                continue
            };
            arg0 = arg0 / 10;
            arg1 = arg1 - 1;
        };
        arg0
    }

    // decompiled from Move bytecode v6
}

