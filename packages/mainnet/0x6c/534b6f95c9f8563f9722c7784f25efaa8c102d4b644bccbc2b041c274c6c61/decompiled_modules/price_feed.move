module 0x6c534b6f95c9f8563f9722c7784f25efaa8c102d4b644bccbc2b041c274c6c61::price_feed {
    struct PriceFeedState has store, key {
        id: 0x2::object::UID,
        pyth_price_feed_ids: 0x2::table::Table<0x1::string::String, 0x1::string::String>,
        supra_pair_indexes: 0x2::table::Table<0x1::string::String, vector<u32>>,
    }

    public fun get_price_by_pyth(arg0: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg1: u64, arg2: u64) : (0x6c534b6f95c9f8563f9722c7784f25efaa8c102d4b644bccbc2b041c274c6c61::price_info::PriceInfo, u64) {
        let v0 = 0;
        let v1 = 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::pyth::get_price_unsafe(arg0);
        if (arg2 > 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price::get_timestamp(&v1) * 1000 + arg1 || arg2 < 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price::get_timestamp(&v1) * 1000 - arg1) {
            v0 = 1;
        };
        let v2 = 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price::get_price(&v1);
        let v3 = 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price::get_expo(&v1);
        (0x6c534b6f95c9f8563f9722c7784f25efaa8c102d4b644bccbc2b041c274c6c61::price_info::new((0x6c534b6f95c9f8563f9722c7784f25efaa8c102d4b644bccbc2b041c274c6c61::utils::i64_to_u64(&v2) as u128), 0x6c534b6f95c9f8563f9722c7784f25efaa8c102d4b644bccbc2b041c274c6c61::utils::i64_to_u64(&v3), 0x6c534b6f95c9f8563f9722c7784f25efaa8c102d4b644bccbc2b041c274c6c61::utils::is_negative(&v3)), v0)
    }

    public fun get_price_by_supra(arg0: &PriceFeedState, arg1: &0x5d8fbbf6f908a4af8c6d072669a462d53e03eb3c1d863bd0359dc818c69ea706::SupraSValueFeed::OracleHolder, arg2: 0x1::string::String, arg3: u64, arg4: bool, arg5: u64) : (0x6c534b6f95c9f8563f9722c7784f25efaa8c102d4b644bccbc2b041c274c6c61::price_info::PriceInfo, u64) {
        let v0 = 0x2::table::borrow<0x1::string::String, vector<u32>>(&arg0.supra_pair_indexes, arg2);
        let v1 = 0;
        let v2 = if (0x1::vector::length<u32>(v0) == 1) {
            let (v3, v4, v5, _) = 0x5d8fbbf6f908a4af8c6d072669a462d53e03eb3c1d863bd0359dc818c69ea706::SupraSValueFeed::get_price(arg1, *0x1::vector::borrow<u32>(v0, 0));
            if (arg5 > (v5 as u64) + arg3 || arg5 < (v5 as u64) - arg3) {
                v1 = 2;
            };
            0x6c534b6f95c9f8563f9722c7784f25efaa8c102d4b644bccbc2b041c274c6c61::price_info::new(v3, (v4 as u64), true)
        } else {
            let (v7, v8, v9, _) = 0x5d8fbbf6f908a4af8c6d072669a462d53e03eb3c1d863bd0359dc818c69ea706::SupraSValueFeed::get_price(arg1, *0x1::vector::borrow<u32>(v0, 0));
            let (v11, v12, v13, _) = 0x5d8fbbf6f908a4af8c6d072669a462d53e03eb3c1d863bd0359dc818c69ea706::SupraSValueFeed::get_price(arg1, *0x1::vector::borrow<u32>(v0, 1));
            if (arg5 > (v9 as u64) + arg3 || arg5 < (v9 as u64) - arg3 || arg5 > (v13 as u64) + arg3 || arg5 < (v13 as u64) - arg3) {
                v1 = 2;
            };
            let (v15, v16) = if (arg4) {
                (v12, v11 * (0x6c534b6f95c9f8563f9722c7784f25efaa8c102d4b644bccbc2b041c274c6c61::utils::power(10, (v8 as u64)) as u128) / v7)
            } else {
                (v8 + v12, v7 * v11)
            };
            0x6c534b6f95c9f8563f9722c7784f25efaa8c102d4b644bccbc2b041c274c6c61::price_info::new(v16, (v15 as u64), true)
        };
        (v2, v1)
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = PriceFeedState{
            id                  : 0x2::object::new(arg0),
            pyth_price_feed_ids : 0x2::table::new<0x1::string::String, 0x1::string::String>(arg0),
            supra_pair_indexes  : 0x2::table::new<0x1::string::String, vector<u32>>(arg0),
        };
        0x2::transfer::public_share_object<PriceFeedState>(v0);
    }

    public fun is_valid_price_info_object<T0>(arg0: &PriceFeedState, arg1: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject) : bool {
        let v0 = 0x6c534b6f95c9f8563f9722c7784f25efaa8c102d4b644bccbc2b041c274c6c61::utils::get_type<T0>();
        if (!0x2::table::contains<0x1::string::String, 0x1::string::String>(&arg0.pyth_price_feed_ids, v0)) {
            return false
        };
        let v1 = 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::get_price_info_from_price_info_object(arg1);
        let v2 = 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::get_price_identifier(&v1);
        0x6c534b6f95c9f8563f9722c7784f25efaa8c102d4b644bccbc2b041c274c6c61::utils::vector_to_hex_char(0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_identifier::get_bytes(&v2)) == *0x2::table::borrow<0x1::string::String, 0x1::string::String>(&arg0.pyth_price_feed_ids, v0)
    }

    public(friend) fun update_price_feed_state(arg0: &mut PriceFeedState, arg1: 0x1::string::String, arg2: 0x1::string::String, arg3: 0x1::string::String) {
        if (arg3 == 0x1::string::utf8(b"pyth")) {
            if (!0x2::table::contains<0x1::string::String, 0x1::string::String>(&arg0.pyth_price_feed_ids, arg1)) {
                0x2::table::add<0x1::string::String, 0x1::string::String>(&mut arg0.pyth_price_feed_ids, arg1, arg2);
            } else {
                *0x2::table::borrow_mut<0x1::string::String, 0x1::string::String>(&mut arg0.pyth_price_feed_ids, arg1) = arg2;
            };
        } else if (arg3 == 0x1::string::utf8(b"supra")) {
            let v0 = 0x1::vector::empty<u32>();
            let v1 = 0x6c534b6f95c9f8563f9722c7784f25efaa8c102d4b644bccbc2b041c274c6c61::utils::split_string(arg2, 44);
            let v2 = 0;
            while (v2 < 0x1::vector::length<0x1::string::String>(&v1)) {
                0x1::vector::push_back<u32>(&mut v0, (0x6c534b6f95c9f8563f9722c7784f25efaa8c102d4b644bccbc2b041c274c6c61::utils::string_to_u64(*0x1::vector::borrow<0x1::string::String>(&v1, v2)) as u32));
                v2 = v2 + 1;
            };
            if (!0x2::table::contains<0x1::string::String, vector<u32>>(&arg0.supra_pair_indexes, arg1)) {
                0x2::table::add<0x1::string::String, vector<u32>>(&mut arg0.supra_pair_indexes, arg1, v0);
            } else {
                let v3 = 0x2::table::remove<0x1::string::String, vector<u32>>(&mut arg0.supra_pair_indexes, arg1);
                while (!0x1::vector::is_empty<u32>(&v3)) {
                    0x1::vector::pop_back<u32>(&mut v3);
                };
                0x2::table::add<0x1::string::String, vector<u32>>(&mut arg0.supra_pair_indexes, arg1, v0);
                0x1::vector::destroy_empty<u32>(v3);
            };
        };
    }

    // decompiled from Move bytecode v6
}

