module 0xc4a54dc9badc78e3201c2117fdcfba77bcf112b8b999f421e9a843ca8e4a137e::rule {
    struct Rule has drop {
        dummy_field: bool,
    }

    fun calc_price_feed(arg0: &0x5d8fbbf6f908a4af8c6d072669a462d53e03eb3c1d863bd0359dc818c69ea706::SupraSValueFeed::OracleHolder, arg1: &vector<u32>, arg2: &0x2::clock::Clock) : 0x2a5743e9350dbcd2461b84ec90c26c47129e86594180ec1acf8ae81acb87b057::price_feed::PriceFeed {
        let v0 = 1;
        let (v1, v2, v3, v4) = 0x5d8fbbf6f908a4af8c6d072669a462d53e03eb3c1d863bd0359dc818c69ea706::SupraSValueFeed::get_price(arg0, *0x1::vector::borrow<u32>(arg1, 0));
        let v5 = v4;
        let v6 = v3;
        let v7 = v2;
        let v8 = v1;
        let v9 = 0x2::clock::timestamp_ms(arg2) / 1000;
        assert!(((v3 / 1000) as u64) >= v9 - 60, 70404);
        assert!(((v3 / 1000) as u64) <= v9 + 10, 70405);
        while (v0 < 0x1::vector::length<u32>(arg1)) {
            let (v10, v11, v12, v13) = 0x5d8fbbf6f908a4af8c6d072669a462d53e03eb3c1d863bd0359dc818c69ea706::SupraSValueFeed::get_price(arg0, *0x1::vector::borrow<u32>(arg1, v0 + 1));
            assert!(((v12 / 1000) as u64) >= v9 - 60, 70404);
            assert!(((v12 / 1000) as u64) <= v9 + 10, 70405);
            let (v14, v15, v16, v17) = 0xc4a54dc9badc78e3201c2117fdcfba77bcf112b8b999f421e9a843ca8e4a137e::supra_adaptor::convert_price(v8, v7, v5, v10, v11, v13, (*0x1::vector::borrow<u32>(arg1, v0) as u8));
            v8 = v14;
            v7 = v15;
            v6 = v16;
            v5 = (v17 as u64);
            v0 = v0 + 2;
        };
        assert!(v7 <= 255, 70401);
        let v18 = (v7 as u8);
        let v19 = ((v6 / 1000) as u64);
        assert!(v8 <= 18446744073709551615, 70402);
        let v20 = 0x2a5743e9350dbcd2461b84ec90c26c47129e86594180ec1acf8ae81acb87b057::price_feed::decimals();
        let v21 = if (v18 < v20) {
            (v8 as u64) * 0x1::u64::pow(10, v20 - v18)
        } else {
            (v8 as u64) / 0x1::u64::pow(10, v18 - v20)
        };
        assert!(v21 > 0, 70401);
        assert!(v19 >= v9 - 60, 70404);
        assert!(v19 <= v9 + 10, 70405);
        0x2a5743e9350dbcd2461b84ec90c26c47129e86594180ec1acf8ae81acb87b057::price_feed::new(v21, v19)
    }

    public fun set_price_as_primary<T0>(arg0: &mut 0x2a5743e9350dbcd2461b84ec90c26c47129e86594180ec1acf8ae81acb87b057::x_oracle::XOraclePriceUpdateRequest<T0>, arg1: &0x5d8fbbf6f908a4af8c6d072669a462d53e03eb3c1d863bd0359dc818c69ea706::SupraSValueFeed::OracleHolder, arg2: &0xc4a54dc9badc78e3201c2117fdcfba77bcf112b8b999f421e9a843ca8e4a137e::supra_registry::SupraRegistry, arg3: &0x2::clock::Clock) {
        let v0 = 0xc4a54dc9badc78e3201c2117fdcfba77bcf112b8b999f421e9a843ca8e4a137e::supra_registry::get_supra_pairs_sequence<T0>(arg2);
        let v1 = Rule{dummy_field: false};
        0x2a5743e9350dbcd2461b84ec90c26c47129e86594180ec1acf8ae81acb87b057::x_oracle::set_primary_price<T0, Rule>(v1, arg0, calc_price_feed(arg1, &v0, arg3));
    }

    public fun set_price_as_secondary<T0>(arg0: &mut 0x2a5743e9350dbcd2461b84ec90c26c47129e86594180ec1acf8ae81acb87b057::x_oracle::XOraclePriceUpdateRequest<T0>, arg1: &0x5d8fbbf6f908a4af8c6d072669a462d53e03eb3c1d863bd0359dc818c69ea706::SupraSValueFeed::OracleHolder, arg2: &0xc4a54dc9badc78e3201c2117fdcfba77bcf112b8b999f421e9a843ca8e4a137e::supra_registry::SupraRegistry, arg3: &0x2::clock::Clock) {
        let v0 = 0xc4a54dc9badc78e3201c2117fdcfba77bcf112b8b999f421e9a843ca8e4a137e::supra_registry::get_supra_pairs_sequence<T0>(arg2);
        let v1 = Rule{dummy_field: false};
        0x2a5743e9350dbcd2461b84ec90c26c47129e86594180ec1acf8ae81acb87b057::x_oracle::set_secondary_price<T0, Rule>(v1, arg0, calc_price_feed(arg1, &v0, arg3));
    }

    // decompiled from Move bytecode v6
}

