module 0x8c36ea167c5e6da8c3d60b4fc897416105dcb986471bd81cfbfd38720a4487c0::supra {
    public fun get_price(arg0: &0x8c36ea167c5e6da8c3d60b4fc897416105dcb986471bd81cfbfd38720a4487c0::oracle::OracleConfig, arg1: &mut 0x8c36ea167c5e6da8c3d60b4fc897416105dcb986471bd81cfbfd38720a4487c0::oracle::OracleHolder, arg2: &0x5d8fbbf6f908a4af8c6d072669a462d53e03eb3c1d863bd0359dc818c69ea706::SupraSValueFeed::OracleHolder, arg3: &0x2::clock::Clock) {
        0x8c36ea167c5e6da8c3d60b4fc897416105dcb986471bd81cfbfd38720a4487c0::oracle::assert_version(arg0);
        assert!(0x8c36ea167c5e6da8c3d60b4fc897416105dcb986471bd81cfbfd38720a4487c0::oracle::oracle_type(arg0) == 0x8c36ea167c5e6da8c3d60b4fc897416105dcb986471bd81cfbfd38720a4487c0::oracle::oracle_type_supra(), 1);
        let v0 = 0x2::bcs::new(0x8c36ea167c5e6da8c3d60b4fc897416105dcb986471bd81cfbfd38720a4487c0::oracle::oracle_id(arg0));
        let v1 = 0x2::bcs::peel_vec_u32(&mut v0);
        let (v2, v3) = if (0x1::vector::length<u32>(&v1) == 1) {
            let (v4, v5, v6, _) = 0x5d8fbbf6f908a4af8c6d072669a462d53e03eb3c1d863bd0359dc818c69ea706::SupraSValueFeed::get_price(arg2, *0x1::vector::borrow<u32>(&v1, 0));
            ((0x8c36ea167c5e6da8c3d60b4fc897416105dcb986471bd81cfbfd38720a4487c0::oracle::div_u128(v4, 0x1::u128::pow(10, (v5 as u8))) as u64), ((v6 / 1000) as u64))
        } else {
            let (_, _, v10, _) = 0x5d8fbbf6f908a4af8c6d072669a462d53e03eb3c1d863bd0359dc818c69ea706::SupraSValueFeed::get_price(arg2, *0x1::vector::borrow<u32>(&v1, 0));
            let (_, _, v14, _) = 0x5d8fbbf6f908a4af8c6d072669a462d53e03eb3c1d863bd0359dc818c69ea706::SupraSValueFeed::get_price(arg2, *0x1::vector::borrow<u32>(&v1, 1));
            let (v16, v17, _, _) = 0x5d8fbbf6f908a4af8c6d072669a462d53e03eb3c1d863bd0359dc818c69ea706::SupraSValueFeed::get_derived_price(arg2, *0x1::vector::borrow<u32>(&v1, 0), *0x1::vector::borrow<u32>(&v1, 1), (*0x1::vector::borrow<u32>(&v1, 2) as u8));
            ((0x8c36ea167c5e6da8c3d60b4fc897416105dcb986471bd81cfbfd38720a4487c0::oracle::div_u128(v16, 0x1::u128::pow(10, (v17 as u8))) as u64), ((0x1::u128::min(v10, v14) / 1000) as u64))
        };
        assert!(v3 + 0x8c36ea167c5e6da8c3d60b4fc897416105dcb986471bd81cfbfd38720a4487c0::oracle::max_staleness_threshold_s(arg0) >= 0x2::clock::timestamp_ms(arg3) / 1000, 2);
        0x2::vec_map::insert<0x2::object::ID, 0x8c36ea167c5e6da8c3d60b4fc897416105dcb986471bd81cfbfd38720a4487c0::oracle::PriceFeed>(0x8c36ea167c5e6da8c3d60b4fc897416105dcb986471bd81cfbfd38720a4487c0::oracle::price_feeds_mut(arg1), 0x2::object::id<0x8c36ea167c5e6da8c3d60b4fc897416105dcb986471bd81cfbfd38720a4487c0::oracle::OracleConfig>(arg0), 0x8c36ea167c5e6da8c3d60b4fc897416105dcb986471bd81cfbfd38720a4487c0::oracle::new_price_feed(v2, 0x1::option::none<u64>(), v3));
    }

    public fun new_oracle(arg0: vector<u32>, arg1: u64, arg2: u64, arg3: &0x8c36ea167c5e6da8c3d60b4fc897416105dcb986471bd81cfbfd38720a4487c0::oracle::AdminCap, arg4: &mut 0x2::tx_context::TxContext) {
        validate_supra_id(arg0);
        0x2::transfer::public_share_object<0x8c36ea167c5e6da8c3d60b4fc897416105dcb986471bd81cfbfd38720a4487c0::oracle::OracleConfig>(0x8c36ea167c5e6da8c3d60b4fc897416105dcb986471bd81cfbfd38720a4487c0::oracle::new_config(arg1, arg2, 0x2::bcs::to_bytes<vector<u32>>(&arg0), 0x8c36ea167c5e6da8c3d60b4fc897416105dcb986471bd81cfbfd38720a4487c0::oracle::oracle_type_supra(), arg4));
    }

    fun validate_supra_id(arg0: vector<u32>) {
        let v0 = 0x1::vector::length<u32>(&arg0);
        assert!(v0 == 1 || v0 == 3, 0);
        if (v0 == 3) {
            assert!(*0x1::vector::borrow<u32>(&arg0, 2) == 0 || *0x1::vector::borrow<u32>(&arg0, 2) == 1 && *0x1::vector::borrow<u32>(&arg0, 0) != *0x1::vector::borrow<u32>(&arg0, 1), 0);
        };
    }

    // decompiled from Move bytecode v6
}

