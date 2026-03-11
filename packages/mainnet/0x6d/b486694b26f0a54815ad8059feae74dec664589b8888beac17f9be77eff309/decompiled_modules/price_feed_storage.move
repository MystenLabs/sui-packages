module 0x6db486694b26f0a54815ad8059feae74dec664589b8888beac17f9be77eff309::price_feed_storage {
    public fun new_price_feed(arg0: &0x6db486694b26f0a54815ad8059feae74dec664589b8888beac17f9be77eff309::pyth_lazer::OracleAggregatorPythLazerIntegration, arg1: &0xa8172ed2a6f14cd0ee55124326685713d6f765039e7c5339f7a0b57be06fddb5::authority::AuthorityCap<0xa8172ed2a6f14cd0ee55124326685713d6f765039e7c5339f7a0b57be06fddb5::authority::PACKAGE, 0xa8172ed2a6f14cd0ee55124326685713d6f765039e7c5339f7a0b57be06fddb5::authority::ADMIN>, arg2: &mut 0xa8172ed2a6f14cd0ee55124326685713d6f765039e7c5339f7a0b57be06fddb5::price_feed_storage::PriceFeedStorage, arg3: &0xa8172ed2a6f14cd0ee55124326685713d6f765039e7c5339f7a0b57be06fddb5::config::Config, arg4: &0x7b502c8a7bcb3915892347f11086745570e759fe9708d03c03accf4c90bbf580::state::State, arg5: &0x2::clock::Clock, arg6: vector<u8>, arg7: &mut 0x6db486694b26f0a54815ad8059feae74dec664589b8888beac17f9be77eff309::feed_info_object::FeedInfoObject, arg8: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x7b502c8a7bcb3915892347f11086745570e759fe9708d03c03accf4c90bbf580::pyth_lazer::parse_and_verify_le_ecdsa_update(arg4, arg5, arg6);
        new_price_feed_from_update(arg0, arg1, arg2, arg3, &v0, arg7, arg8);
    }

    public fun new_price_feed_from_update(arg0: &0x6db486694b26f0a54815ad8059feae74dec664589b8888beac17f9be77eff309::pyth_lazer::OracleAggregatorPythLazerIntegration, arg1: &0xa8172ed2a6f14cd0ee55124326685713d6f765039e7c5339f7a0b57be06fddb5::authority::AuthorityCap<0xa8172ed2a6f14cd0ee55124326685713d6f765039e7c5339f7a0b57be06fddb5::authority::PACKAGE, 0xa8172ed2a6f14cd0ee55124326685713d6f765039e7c5339f7a0b57be06fddb5::authority::ADMIN>, arg2: &mut 0xa8172ed2a6f14cd0ee55124326685713d6f765039e7c5339f7a0b57be06fddb5::price_feed_storage::PriceFeedStorage, arg3: &0xa8172ed2a6f14cd0ee55124326685713d6f765039e7c5339f7a0b57be06fddb5::config::Config, arg4: &0x7b502c8a7bcb3915892347f11086745570e759fe9708d03c03accf4c90bbf580::update::Update, arg5: &mut 0x6db486694b26f0a54815ad8059feae74dec664589b8888beac17f9be77eff309::feed_info_object::FeedInfoObject, arg6: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x7b502c8a7bcb3915892347f11086745570e759fe9708d03c03accf4c90bbf580::update::feeds_ref(arg4);
        let v1 = 0;
        let v2;
        loop {
            assert!(v1 < 0x1::vector::length<0x7b502c8a7bcb3915892347f11086745570e759fe9708d03c03accf4c90bbf580::feed::Feed>(v0), 0);
            v2 = 0x1::vector::borrow<0x7b502c8a7bcb3915892347f11086745570e759fe9708d03c03accf4c90bbf580::feed::Feed>(v0, v1);
            if (0x7b502c8a7bcb3915892347f11086745570e759fe9708d03c03accf4c90bbf580::feed::feed_id(v2) == 0x6db486694b26f0a54815ad8059feae74dec664589b8888beac17f9be77eff309::feed_info_object::feed_id(arg5)) {
                break
            };
            v1 = v1 + 1;
        };
        let v3 = *v2;
        let v4 = 0x7b502c8a7bcb3915892347f11086745570e759fe9708d03c03accf4c90bbf580::feed::price(&v3);
        let v5 = if (0x1::option::is_none<0x1::option::Option<0x7b502c8a7bcb3915892347f11086745570e759fe9708d03c03accf4c90bbf580::i64::I64>>(&v4)) {
            0x1::option::none<0x7b502c8a7bcb3915892347f11086745570e759fe9708d03c03accf4c90bbf580::i64::I64>()
        } else {
            0x1::option::extract<0x1::option::Option<0x7b502c8a7bcb3915892347f11086745570e759fe9708d03c03accf4c90bbf580::i64::I64>>(&mut v4)
        };
        let v6 = v5;
        let (v7, v8) = if (0x1::option::is_none<0x7b502c8a7bcb3915892347f11086745570e759fe9708d03c03accf4c90bbf580::i64::I64>(&v6)) {
            let v9 = 0x7b502c8a7bcb3915892347f11086745570e759fe9708d03c03accf4c90bbf580::feed::market_session(&v3);
            let v10 = &v9;
            let v11 = 0x1::option::is_some<0x7b502c8a7bcb3915892347f11086745570e759fe9708d03c03accf4c90bbf580::market_session::MarketSession>(v10) && 0x7b502c8a7bcb3915892347f11086745570e759fe9708d03c03accf4c90bbf580::market_session::is_closed(0x1::option::borrow<0x7b502c8a7bcb3915892347f11086745570e759fe9708d03c03accf4c90bbf580::market_session::MarketSession>(v10));
            if (!v11) {
                abort 1
            };
            let v12 = 0x6db486694b26f0a54815ad8059feae74dec664589b8888beac17f9be77eff309::feed_info_object::cached_feed(arg5);
            if (!0x6db486694b26f0a54815ad8059feae74dec664589b8888beac17f9be77eff309::feed_info_object::is_fresh(&v12)) {
                abort 1
            };
            (0x6db486694b26f0a54815ad8059feae74dec664589b8888beac17f9be77eff309::feed_info_object::price(&v12), 0xa8172ed2a6f14cd0ee55124326685713d6f765039e7c5339f7a0b57be06fddb5::price_feed::confidence_not_reported_by_source())
        } else {
            let v13 = 0x1::option::extract<0x7b502c8a7bcb3915892347f11086745570e759fe9708d03c03accf4c90bbf580::i64::I64>(&mut v6);
            assert!(!0x7b502c8a7bcb3915892347f11086745570e759fe9708d03c03accf4c90bbf580::i64::get_is_negative(&v13), 3);
            let v14 = 0x7b502c8a7bcb3915892347f11086745570e759fe9708d03c03accf4c90bbf580::feed::exponent(&v3);
            if (0x1::option::is_none<0x7b502c8a7bcb3915892347f11086745570e759fe9708d03c03accf4c90bbf580::i16::I16>(&v14)) {
                abort 2
            };
            let v15 = 0x1::option::extract<0x7b502c8a7bcb3915892347f11086745570e759fe9708d03c03accf4c90bbf580::i16::I16>(&mut v14);
            let v16 = if (0x7b502c8a7bcb3915892347f11086745570e759fe9708d03c03accf4c90bbf580::i16::get_is_negative(&v15)) {
                0x46234ba81f3a5ba6571383233df0f9ea5fe60a3a327537be1f5fec447bced693::ifixed::div(0x46234ba81f3a5ba6571383233df0f9ea5fe60a3a327537be1f5fec447bced693::ifixed::from_u64(0x7b502c8a7bcb3915892347f11086745570e759fe9708d03c03accf4c90bbf580::i64::get_magnitude_if_positive(&v13)), 0x46234ba81f3a5ba6571383233df0f9ea5fe60a3a327537be1f5fec447bced693::ifixed::from_u64(0x1::u64::pow(10, (0x7b502c8a7bcb3915892347f11086745570e759fe9708d03c03accf4c90bbf580::i16::get_magnitude_if_negative(&v15) as u8))))
            } else {
                0x46234ba81f3a5ba6571383233df0f9ea5fe60a3a327537be1f5fec447bced693::ifixed::from_u64(0x7b502c8a7bcb3915892347f11086745570e759fe9708d03c03accf4c90bbf580::i64::get_magnitude_if_positive(&v13) * 0x1::u64::pow(10, (0x7b502c8a7bcb3915892347f11086745570e759fe9708d03c03accf4c90bbf580::i16::get_magnitude_if_positive(&v15) as u8)))
            };
            let v17 = 0x7b502c8a7bcb3915892347f11086745570e759fe9708d03c03accf4c90bbf580::feed::confidence(&v3);
            let v18 = if (0x1::option::is_none<0x1::option::Option<0x7b502c8a7bcb3915892347f11086745570e759fe9708d03c03accf4c90bbf580::i64::I64>>(&v17)) {
                0x1::option::none<0x7b502c8a7bcb3915892347f11086745570e759fe9708d03c03accf4c90bbf580::i64::I64>()
            } else {
                0x1::option::extract<0x1::option::Option<0x7b502c8a7bcb3915892347f11086745570e759fe9708d03c03accf4c90bbf580::i64::I64>>(&mut v17)
            };
            let v19 = v18;
            let v20 = if (0x1::option::is_none<0x7b502c8a7bcb3915892347f11086745570e759fe9708d03c03accf4c90bbf580::i64::I64>(&v19)) {
                0xa8172ed2a6f14cd0ee55124326685713d6f765039e7c5339f7a0b57be06fddb5::price_feed::confidence_not_reported_by_source()
            } else {
                let v21 = 0x1::option::extract<0x7b502c8a7bcb3915892347f11086745570e759fe9708d03c03accf4c90bbf580::i64::I64>(&mut v19);
                assert!(!0x7b502c8a7bcb3915892347f11086745570e759fe9708d03c03accf4c90bbf580::i64::get_is_negative(&v21), 4);
                if (0x7b502c8a7bcb3915892347f11086745570e759fe9708d03c03accf4c90bbf580::i16::get_is_negative(&v15)) {
                    0x46234ba81f3a5ba6571383233df0f9ea5fe60a3a327537be1f5fec447bced693::ifixed::div(0x46234ba81f3a5ba6571383233df0f9ea5fe60a3a327537be1f5fec447bced693::ifixed::from_u64(0x7b502c8a7bcb3915892347f11086745570e759fe9708d03c03accf4c90bbf580::i64::get_magnitude_if_positive(&v21)), 0x46234ba81f3a5ba6571383233df0f9ea5fe60a3a327537be1f5fec447bced693::ifixed::from_u64(0x1::u64::pow(10, (0x7b502c8a7bcb3915892347f11086745570e759fe9708d03c03accf4c90bbf580::i16::get_magnitude_if_negative(&v15) as u8))))
                } else {
                    0x46234ba81f3a5ba6571383233df0f9ea5fe60a3a327537be1f5fec447bced693::ifixed::from_u64(0x7b502c8a7bcb3915892347f11086745570e759fe9708d03c03accf4c90bbf580::i64::get_magnitude_if_positive(&v21) * 0x1::u64::pow(10, (0x7b502c8a7bcb3915892347f11086745570e759fe9708d03c03accf4c90bbf580::i16::get_magnitude_if_positive(&v15) as u8)))
                }
            };
            (v16, v20)
        };
        let v22 = &v3;
        let v23 = 0x7b502c8a7bcb3915892347f11086745570e759fe9708d03c03accf4c90bbf580::feed::market_session(v22);
        let v24 = &v23;
        let v25 = if (0x1::option::is_some<0x7b502c8a7bcb3915892347f11086745570e759fe9708d03c03accf4c90bbf580::market_session::MarketSession>(v24) && 0x7b502c8a7bcb3915892347f11086745570e759fe9708d03c03accf4c90bbf580::market_session::is_closed(0x1::option::borrow<0x7b502c8a7bcb3915892347f11086745570e759fe9708d03c03accf4c90bbf580::market_session::MarketSession>(v24))) {
            0x7b502c8a7bcb3915892347f11086745570e759fe9708d03c03accf4c90bbf580::update::timestamp(arg4) / 1000
        } else {
            let v26 = 0x7b502c8a7bcb3915892347f11086745570e759fe9708d03c03accf4c90bbf580::feed::feed_update_timestamp(v22);
            let v27 = if (0x1::option::is_none<0x1::option::Option<u64>>(&v26)) {
                0x1::option::none<u64>()
            } else {
                0x1::option::extract<0x1::option::Option<u64>>(&mut v26)
            };
            let v28 = v27;
            let v29 = if (0x1::option::is_none<u64>(&v28)) {
                0x7b502c8a7bcb3915892347f11086745570e759fe9708d03c03accf4c90bbf580::update::timestamp(arg4)
            } else {
                0x1::option::extract<u64>(&mut v28)
            };
            v29 / 1000
        };
        0x6db486694b26f0a54815ad8059feae74dec664589b8888beac17f9be77eff309::feed_info_object::maybe_cache_quote(arg5, v7, v8, v25);
        0xa8172ed2a6f14cd0ee55124326685713d6f765039e7c5339f7a0b57be06fddb5::price_feed_storage::new_price_feed<0xa8172ed2a6f14cd0ee55124326685713d6f765039e7c5339f7a0b57be06fddb5::authority::ADMIN, 0x6db486694b26f0a54815ad8059feae74dec664589b8888beac17f9be77eff309::feed_info_object::FeedInfoObject>(arg2, arg1, arg3, 0x6db486694b26f0a54815ad8059feae74dec664589b8888beac17f9be77eff309::pyth_lazer::borrow_id(arg0), arg5, v7, v8, v25, arg6);
    }

    public fun remove_price_feed<T0>(arg0: &0x6db486694b26f0a54815ad8059feae74dec664589b8888beac17f9be77eff309::pyth_lazer::OracleAggregatorPythLazerIntegration, arg1: &0xa8172ed2a6f14cd0ee55124326685713d6f765039e7c5339f7a0b57be06fddb5::authority::AuthorityCap<0xa8172ed2a6f14cd0ee55124326685713d6f765039e7c5339f7a0b57be06fddb5::authority::PACKAGE, T0>, arg2: &mut 0xa8172ed2a6f14cd0ee55124326685713d6f765039e7c5339f7a0b57be06fddb5::price_feed_storage::PriceFeedStorage, arg3: &0xa8172ed2a6f14cd0ee55124326685713d6f765039e7c5339f7a0b57be06fddb5::config::Config) {
        0xa8172ed2a6f14cd0ee55124326685713d6f765039e7c5339f7a0b57be06fddb5::price_feed_storage::remove_price_feed<T0>(arg2, arg1, arg3, 0x6db486694b26f0a54815ad8059feae74dec664589b8888beac17f9be77eff309::pyth_lazer::borrow_id(arg0));
    }

    public fun update_price_feed(arg0: &0x6db486694b26f0a54815ad8059feae74dec664589b8888beac17f9be77eff309::pyth_lazer::OracleAggregatorPythLazerIntegration, arg1: &mut 0xa8172ed2a6f14cd0ee55124326685713d6f765039e7c5339f7a0b57be06fddb5::price_feed_storage::PriceFeedStorage, arg2: &0xa8172ed2a6f14cd0ee55124326685713d6f765039e7c5339f7a0b57be06fddb5::config::Config, arg3: &0x7b502c8a7bcb3915892347f11086745570e759fe9708d03c03accf4c90bbf580::state::State, arg4: &0x2::clock::Clock, arg5: vector<u8>, arg6: &mut 0x6db486694b26f0a54815ad8059feae74dec664589b8888beac17f9be77eff309::feed_info_object::FeedInfoObject) {
        let v0 = 0x7b502c8a7bcb3915892347f11086745570e759fe9708d03c03accf4c90bbf580::pyth_lazer::parse_and_verify_le_ecdsa_update(arg3, arg4, arg5);
        update_price_feed_from_update(arg0, arg1, arg2, &v0, arg6);
    }

    public fun update_price_feed_from_update(arg0: &0x6db486694b26f0a54815ad8059feae74dec664589b8888beac17f9be77eff309::pyth_lazer::OracleAggregatorPythLazerIntegration, arg1: &mut 0xa8172ed2a6f14cd0ee55124326685713d6f765039e7c5339f7a0b57be06fddb5::price_feed_storage::PriceFeedStorage, arg2: &0xa8172ed2a6f14cd0ee55124326685713d6f765039e7c5339f7a0b57be06fddb5::config::Config, arg3: &0x7b502c8a7bcb3915892347f11086745570e759fe9708d03c03accf4c90bbf580::update::Update, arg4: &mut 0x6db486694b26f0a54815ad8059feae74dec664589b8888beac17f9be77eff309::feed_info_object::FeedInfoObject) {
        let v0 = 0x7b502c8a7bcb3915892347f11086745570e759fe9708d03c03accf4c90bbf580::update::feeds_ref(arg3);
        let v1 = 0;
        let v2;
        loop {
            assert!(v1 < 0x1::vector::length<0x7b502c8a7bcb3915892347f11086745570e759fe9708d03c03accf4c90bbf580::feed::Feed>(v0), 0);
            v2 = 0x1::vector::borrow<0x7b502c8a7bcb3915892347f11086745570e759fe9708d03c03accf4c90bbf580::feed::Feed>(v0, v1);
            if (0x7b502c8a7bcb3915892347f11086745570e759fe9708d03c03accf4c90bbf580::feed::feed_id(v2) == 0x6db486694b26f0a54815ad8059feae74dec664589b8888beac17f9be77eff309::feed_info_object::feed_id(arg4)) {
                break
            };
            v1 = v1 + 1;
        };
        let v3 = *v2;
        let v4 = 0x7b502c8a7bcb3915892347f11086745570e759fe9708d03c03accf4c90bbf580::feed::price(&v3);
        let v5 = if (0x1::option::is_none<0x1::option::Option<0x7b502c8a7bcb3915892347f11086745570e759fe9708d03c03accf4c90bbf580::i64::I64>>(&v4)) {
            0x1::option::none<0x7b502c8a7bcb3915892347f11086745570e759fe9708d03c03accf4c90bbf580::i64::I64>()
        } else {
            0x1::option::extract<0x1::option::Option<0x7b502c8a7bcb3915892347f11086745570e759fe9708d03c03accf4c90bbf580::i64::I64>>(&mut v4)
        };
        let v6 = v5;
        let (v7, v8) = if (0x1::option::is_none<0x7b502c8a7bcb3915892347f11086745570e759fe9708d03c03accf4c90bbf580::i64::I64>(&v6)) {
            let v9 = 0x7b502c8a7bcb3915892347f11086745570e759fe9708d03c03accf4c90bbf580::feed::market_session(&v3);
            let v10 = &v9;
            let v11 = 0x1::option::is_some<0x7b502c8a7bcb3915892347f11086745570e759fe9708d03c03accf4c90bbf580::market_session::MarketSession>(v10) && 0x7b502c8a7bcb3915892347f11086745570e759fe9708d03c03accf4c90bbf580::market_session::is_closed(0x1::option::borrow<0x7b502c8a7bcb3915892347f11086745570e759fe9708d03c03accf4c90bbf580::market_session::MarketSession>(v10));
            if (!v11) {
                abort 1
            };
            let v12 = 0x6db486694b26f0a54815ad8059feae74dec664589b8888beac17f9be77eff309::feed_info_object::cached_feed(arg4);
            if (!0x6db486694b26f0a54815ad8059feae74dec664589b8888beac17f9be77eff309::feed_info_object::is_fresh(&v12)) {
                abort 1
            };
            (0x6db486694b26f0a54815ad8059feae74dec664589b8888beac17f9be77eff309::feed_info_object::price(&v12), 0xa8172ed2a6f14cd0ee55124326685713d6f765039e7c5339f7a0b57be06fddb5::price_feed::confidence_not_reported_by_source())
        } else {
            let v13 = 0x1::option::extract<0x7b502c8a7bcb3915892347f11086745570e759fe9708d03c03accf4c90bbf580::i64::I64>(&mut v6);
            assert!(!0x7b502c8a7bcb3915892347f11086745570e759fe9708d03c03accf4c90bbf580::i64::get_is_negative(&v13), 3);
            let v14 = 0x7b502c8a7bcb3915892347f11086745570e759fe9708d03c03accf4c90bbf580::feed::exponent(&v3);
            if (0x1::option::is_none<0x7b502c8a7bcb3915892347f11086745570e759fe9708d03c03accf4c90bbf580::i16::I16>(&v14)) {
                abort 2
            };
            let v15 = 0x1::option::extract<0x7b502c8a7bcb3915892347f11086745570e759fe9708d03c03accf4c90bbf580::i16::I16>(&mut v14);
            let v16 = if (0x7b502c8a7bcb3915892347f11086745570e759fe9708d03c03accf4c90bbf580::i16::get_is_negative(&v15)) {
                0x46234ba81f3a5ba6571383233df0f9ea5fe60a3a327537be1f5fec447bced693::ifixed::div(0x46234ba81f3a5ba6571383233df0f9ea5fe60a3a327537be1f5fec447bced693::ifixed::from_u64(0x7b502c8a7bcb3915892347f11086745570e759fe9708d03c03accf4c90bbf580::i64::get_magnitude_if_positive(&v13)), 0x46234ba81f3a5ba6571383233df0f9ea5fe60a3a327537be1f5fec447bced693::ifixed::from_u64(0x1::u64::pow(10, (0x7b502c8a7bcb3915892347f11086745570e759fe9708d03c03accf4c90bbf580::i16::get_magnitude_if_negative(&v15) as u8))))
            } else {
                0x46234ba81f3a5ba6571383233df0f9ea5fe60a3a327537be1f5fec447bced693::ifixed::from_u64(0x7b502c8a7bcb3915892347f11086745570e759fe9708d03c03accf4c90bbf580::i64::get_magnitude_if_positive(&v13) * 0x1::u64::pow(10, (0x7b502c8a7bcb3915892347f11086745570e759fe9708d03c03accf4c90bbf580::i16::get_magnitude_if_positive(&v15) as u8)))
            };
            let v17 = 0x7b502c8a7bcb3915892347f11086745570e759fe9708d03c03accf4c90bbf580::feed::confidence(&v3);
            let v18 = if (0x1::option::is_none<0x1::option::Option<0x7b502c8a7bcb3915892347f11086745570e759fe9708d03c03accf4c90bbf580::i64::I64>>(&v17)) {
                0x1::option::none<0x7b502c8a7bcb3915892347f11086745570e759fe9708d03c03accf4c90bbf580::i64::I64>()
            } else {
                0x1::option::extract<0x1::option::Option<0x7b502c8a7bcb3915892347f11086745570e759fe9708d03c03accf4c90bbf580::i64::I64>>(&mut v17)
            };
            let v19 = v18;
            let v20 = if (0x1::option::is_none<0x7b502c8a7bcb3915892347f11086745570e759fe9708d03c03accf4c90bbf580::i64::I64>(&v19)) {
                0xa8172ed2a6f14cd0ee55124326685713d6f765039e7c5339f7a0b57be06fddb5::price_feed::confidence_not_reported_by_source()
            } else {
                let v21 = 0x1::option::extract<0x7b502c8a7bcb3915892347f11086745570e759fe9708d03c03accf4c90bbf580::i64::I64>(&mut v19);
                assert!(!0x7b502c8a7bcb3915892347f11086745570e759fe9708d03c03accf4c90bbf580::i64::get_is_negative(&v21), 4);
                if (0x7b502c8a7bcb3915892347f11086745570e759fe9708d03c03accf4c90bbf580::i16::get_is_negative(&v15)) {
                    0x46234ba81f3a5ba6571383233df0f9ea5fe60a3a327537be1f5fec447bced693::ifixed::div(0x46234ba81f3a5ba6571383233df0f9ea5fe60a3a327537be1f5fec447bced693::ifixed::from_u64(0x7b502c8a7bcb3915892347f11086745570e759fe9708d03c03accf4c90bbf580::i64::get_magnitude_if_positive(&v21)), 0x46234ba81f3a5ba6571383233df0f9ea5fe60a3a327537be1f5fec447bced693::ifixed::from_u64(0x1::u64::pow(10, (0x7b502c8a7bcb3915892347f11086745570e759fe9708d03c03accf4c90bbf580::i16::get_magnitude_if_negative(&v15) as u8))))
                } else {
                    0x46234ba81f3a5ba6571383233df0f9ea5fe60a3a327537be1f5fec447bced693::ifixed::from_u64(0x7b502c8a7bcb3915892347f11086745570e759fe9708d03c03accf4c90bbf580::i64::get_magnitude_if_positive(&v21) * 0x1::u64::pow(10, (0x7b502c8a7bcb3915892347f11086745570e759fe9708d03c03accf4c90bbf580::i16::get_magnitude_if_positive(&v15) as u8)))
                }
            };
            (v16, v20)
        };
        let v22 = &v3;
        let v23 = 0x7b502c8a7bcb3915892347f11086745570e759fe9708d03c03accf4c90bbf580::feed::market_session(v22);
        let v24 = &v23;
        let v25 = if (0x1::option::is_some<0x7b502c8a7bcb3915892347f11086745570e759fe9708d03c03accf4c90bbf580::market_session::MarketSession>(v24) && 0x7b502c8a7bcb3915892347f11086745570e759fe9708d03c03accf4c90bbf580::market_session::is_closed(0x1::option::borrow<0x7b502c8a7bcb3915892347f11086745570e759fe9708d03c03accf4c90bbf580::market_session::MarketSession>(v24))) {
            0x7b502c8a7bcb3915892347f11086745570e759fe9708d03c03accf4c90bbf580::update::timestamp(arg3) / 1000
        } else {
            let v26 = 0x7b502c8a7bcb3915892347f11086745570e759fe9708d03c03accf4c90bbf580::feed::feed_update_timestamp(v22);
            let v27 = if (0x1::option::is_none<0x1::option::Option<u64>>(&v26)) {
                0x1::option::none<u64>()
            } else {
                0x1::option::extract<0x1::option::Option<u64>>(&mut v26)
            };
            let v28 = v27;
            let v29 = if (0x1::option::is_none<u64>(&v28)) {
                0x7b502c8a7bcb3915892347f11086745570e759fe9708d03c03accf4c90bbf580::update::timestamp(arg3)
            } else {
                0x1::option::extract<u64>(&mut v28)
            };
            v29 / 1000
        };
        0x6db486694b26f0a54815ad8059feae74dec664589b8888beac17f9be77eff309::feed_info_object::maybe_cache_quote(arg4, v7, v8, v25);
        0xa8172ed2a6f14cd0ee55124326685713d6f765039e7c5339f7a0b57be06fddb5::price_feed_storage::update_price_feed<0x6db486694b26f0a54815ad8059feae74dec664589b8888beac17f9be77eff309::feed_info_object::FeedInfoObject>(arg1, arg2, 0x6db486694b26f0a54815ad8059feae74dec664589b8888beac17f9be77eff309::pyth_lazer::borrow_id(arg0), arg4, v7, v8, v25);
    }

    // decompiled from Move bytecode v6
}

