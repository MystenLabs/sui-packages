module 0x84cfd5e0062a9fabdc4aefd10a46a6fa05672090b993e49fd710e5102093d7e3::rule {
    struct Rule has drop {
        dummy_field: bool,
    }

    fun calc_price_feed(arg0: &0x5d8fbbf6f908a4af8c6d072669a462d53e03eb3c1d863bd0359dc818c69ea706::SupraSValueFeed::OracleHolder, arg1: &vector<u32>, arg2: &0x2::clock::Clock) : 0x2a5743e9350dbcd2461b84ec90c26c47129e86594180ec1acf8ae81acb87b057::price_feed::PriceFeed {
        let v0 = 1;
        let (v1, v2, v3, _) = 0x5d8fbbf6f908a4af8c6d072669a462d53e03eb3c1d863bd0359dc818c69ea706::SupraSValueFeed::get_price(arg0, *0x1::vector::borrow<u32>(arg1, 0));
        let v5 = v2;
        let v6 = v1;
        let v7 = v3 / 1000;
        let v8 = 0x2::clock::timestamp_ms(arg2) / 1000;
        assert!((v7 as u64) >= v8 - 60, 70404);
        assert!((v7 as u64) <= v8 + 10, 70405);
        while (v0 < 0x1::vector::length<u32>(arg1)) {
            let (v9, v10, v11, _) = 0x5d8fbbf6f908a4af8c6d072669a462d53e03eb3c1d863bd0359dc818c69ea706::SupraSValueFeed::get_price(arg0, *0x1::vector::borrow<u32>(arg1, v0 + 1));
            let v13 = v11 / 1000;
            assert!((v13 as u64) >= v8 - 60, 70404);
            assert!((v13 as u64) <= v8 + 10, 70405);
            let (v14, v15) = 0x84cfd5e0062a9fabdc4aefd10a46a6fa05672090b993e49fd710e5102093d7e3::supra_adaptor::convert_price(v6, v5, v9, v10, (*0x1::vector::borrow<u32>(arg1, v0) as u8));
            v6 = v14;
            v5 = v15;
            v0 = v0 + 2;
        };
        assert!(v5 <= 255, 70401);
        let v16 = (v5 as u8);
        assert!(v6 <= 18446744073709551615, 70402);
        let v17 = 0x2a5743e9350dbcd2461b84ec90c26c47129e86594180ec1acf8ae81acb87b057::price_feed::decimals();
        let v18 = if (v16 < v17) {
            (v6 as u64) * 0x1::u64::pow(10, v17 - v16)
        } else {
            (v6 as u64) / 0x1::u64::pow(10, v16 - v17)
        };
        assert!(v18 > 0, 70401);
        0x2a5743e9350dbcd2461b84ec90c26c47129e86594180ec1acf8ae81acb87b057::price_feed::new(v18, (v7 as u64))
    }

    public fun set_price_as_primary<T0>(arg0: &mut 0x2a5743e9350dbcd2461b84ec90c26c47129e86594180ec1acf8ae81acb87b057::x_oracle::XOraclePriceUpdateRequest<T0>, arg1: &0x5d8fbbf6f908a4af8c6d072669a462d53e03eb3c1d863bd0359dc818c69ea706::SupraSValueFeed::OracleHolder, arg2: &0x84cfd5e0062a9fabdc4aefd10a46a6fa05672090b993e49fd710e5102093d7e3::supra_registry::SupraRegistry, arg3: &0x2::clock::Clock) {
        let v0 = 0x84cfd5e0062a9fabdc4aefd10a46a6fa05672090b993e49fd710e5102093d7e3::supra_registry::get_supra_pairs_sequence<T0>(arg2);
        let v1 = Rule{dummy_field: false};
        0x2a5743e9350dbcd2461b84ec90c26c47129e86594180ec1acf8ae81acb87b057::x_oracle::set_primary_price<T0, Rule>(v1, arg0, calc_price_feed(arg1, &v0, arg3));
    }

    public fun set_price_as_secondary<T0>(arg0: &mut 0x2a5743e9350dbcd2461b84ec90c26c47129e86594180ec1acf8ae81acb87b057::x_oracle::XOraclePriceUpdateRequest<T0>, arg1: &0x5d8fbbf6f908a4af8c6d072669a462d53e03eb3c1d863bd0359dc818c69ea706::SupraSValueFeed::OracleHolder, arg2: &0x84cfd5e0062a9fabdc4aefd10a46a6fa05672090b993e49fd710e5102093d7e3::supra_registry::SupraRegistry, arg3: &0x2::clock::Clock) {
        let v0 = 0x84cfd5e0062a9fabdc4aefd10a46a6fa05672090b993e49fd710e5102093d7e3::supra_registry::get_supra_pairs_sequence<T0>(arg2);
        let v1 = Rule{dummy_field: false};
        0x2a5743e9350dbcd2461b84ec90c26c47129e86594180ec1acf8ae81acb87b057::x_oracle::set_secondary_price<T0, Rule>(v1, arg0, calc_price_feed(arg1, &v0, arg3));
    }

    // decompiled from Move bytecode v6
}

