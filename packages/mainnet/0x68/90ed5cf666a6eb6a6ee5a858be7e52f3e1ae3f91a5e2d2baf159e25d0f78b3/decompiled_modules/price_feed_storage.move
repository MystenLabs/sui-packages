module 0x6890ed5cf666a6eb6a6ee5a858be7e52f3e1ae3f91a5e2d2baf159e25d0f78b3::price_feed_storage {
    public fun new_price_feed(arg0: &0x6890ed5cf666a6eb6a6ee5a858be7e52f3e1ae3f91a5e2d2baf159e25d0f78b3::pyth_lazer_rolling::OracleAggregatorPythLazerRollingIntegration, arg1: &0xa8172ed2a6f14cd0ee55124326685713d6f765039e7c5339f7a0b57be06fddb5::authority::AuthorityCap<0xa8172ed2a6f14cd0ee55124326685713d6f765039e7c5339f7a0b57be06fddb5::authority::PACKAGE, 0xa8172ed2a6f14cd0ee55124326685713d6f765039e7c5339f7a0b57be06fddb5::authority::ADMIN>, arg2: &mut 0xa8172ed2a6f14cd0ee55124326685713d6f765039e7c5339f7a0b57be06fddb5::price_feed_storage::PriceFeedStorage, arg3: &0xa8172ed2a6f14cd0ee55124326685713d6f765039e7c5339f7a0b57be06fddb5::config::Config, arg4: &0x7b502c8a7bcb3915892347f11086745570e759fe9708d03c03accf4c90bbf580::state::State, arg5: &0x2::clock::Clock, arg6: vector<u8>, arg7: &0x6890ed5cf666a6eb6a6ee5a858be7e52f3e1ae3f91a5e2d2baf159e25d0f78b3::feed_info_object::FeedInfoObject, arg8: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x7b502c8a7bcb3915892347f11086745570e759fe9708d03c03accf4c90bbf580::pyth_lazer::parse_and_verify_le_ecdsa_update(arg4, arg5, arg6);
        new_price_feed_from_update(arg0, arg1, arg2, arg3, &v0, arg7, arg5, arg8);
    }

    public fun new_price_feed_from_update(arg0: &0x6890ed5cf666a6eb6a6ee5a858be7e52f3e1ae3f91a5e2d2baf159e25d0f78b3::pyth_lazer_rolling::OracleAggregatorPythLazerRollingIntegration, arg1: &0xa8172ed2a6f14cd0ee55124326685713d6f765039e7c5339f7a0b57be06fddb5::authority::AuthorityCap<0xa8172ed2a6f14cd0ee55124326685713d6f765039e7c5339f7a0b57be06fddb5::authority::PACKAGE, 0xa8172ed2a6f14cd0ee55124326685713d6f765039e7c5339f7a0b57be06fddb5::authority::ADMIN>, arg2: &mut 0xa8172ed2a6f14cd0ee55124326685713d6f765039e7c5339f7a0b57be06fddb5::price_feed_storage::PriceFeedStorage, arg3: &0xa8172ed2a6f14cd0ee55124326685713d6f765039e7c5339f7a0b57be06fddb5::config::Config, arg4: &0x7b502c8a7bcb3915892347f11086745570e759fe9708d03c03accf4c90bbf580::update::Update, arg5: &0x6890ed5cf666a6eb6a6ee5a858be7e52f3e1ae3f91a5e2d2baf159e25d0f78b3::feed_info_object::FeedInfoObject, arg6: &0x2::clock::Clock, arg7: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x6890ed5cf666a6eb6a6ee5a858be7e52f3e1ae3f91a5e2d2baf159e25d0f78b3::feed_info_object::expiry_timestamp_ms(arg5);
        let v1 = 0x2::clock::timestamp_ms(arg6);
        let v2 = if (v1 >= v0) {
            0
        } else {
            v0 - v1
        };
        let v3 = 0x6890ed5cf666a6eb6a6ee5a858be7e52f3e1ae3f91a5e2d2baf159e25d0f78b3::feed_info_object::roll_start_days(arg5) * 86400000;
        let v4 = 0x6890ed5cf666a6eb6a6ee5a858be7e52f3e1ae3f91a5e2d2baf159e25d0f78b3::feed_info_object::cutoff_days(arg5) * 86400000;
        let (v5, v6) = if (v2 > v3) {
            (1000000000000000000, 0)
        } else if (v2 <= v4) {
            (0, 1000000000000000000)
        } else {
            let v7 = 0x46234ba81f3a5ba6571383233df0f9ea5fe60a3a327537be1f5fec447bced693::ifixed::div(0x46234ba81f3a5ba6571383233df0f9ea5fe60a3a327537be1f5fec447bced693::ifixed::from_u64(v2 - v4), 0x46234ba81f3a5ba6571383233df0f9ea5fe60a3a327537be1f5fec447bced693::ifixed::from_u64(v3 - v4));
            (v7, 0x46234ba81f3a5ba6571383233df0f9ea5fe60a3a327537be1f5fec447bced693::ifixed::sub(1000000000000000000, v7))
        };
        if (v6 == 0) {
            let v8 = 0x7b502c8a7bcb3915892347f11086745570e759fe9708d03c03accf4c90bbf580::update::feeds_ref(arg4);
            let v9 = 0;
            let v10;
            loop {
                assert!(v9 < 0x1::vector::length<0x7b502c8a7bcb3915892347f11086745570e759fe9708d03c03accf4c90bbf580::feed::Feed>(v8), 0);
                v10 = 0x1::vector::borrow<0x7b502c8a7bcb3915892347f11086745570e759fe9708d03c03accf4c90bbf580::feed::Feed>(v8, v9);
                if (0x7b502c8a7bcb3915892347f11086745570e759fe9708d03c03accf4c90bbf580::feed::feed_id(v10) == 0x6890ed5cf666a6eb6a6ee5a858be7e52f3e1ae3f91a5e2d2baf159e25d0f78b3::feed_info_object::current_feed_id(arg5)) {
                    break
                };
                v9 = v9 + 1;
            };
            let v11 = *v10;
            let v12 = &v11;
            let v13 = 0x7b502c8a7bcb3915892347f11086745570e759fe9708d03c03accf4c90bbf580::feed::price(v12);
            let v14 = if (0x1::option::is_none<0x1::option::Option<0x7b502c8a7bcb3915892347f11086745570e759fe9708d03c03accf4c90bbf580::i64::I64>>(&v13)) {
                0x1::option::none<0x7b502c8a7bcb3915892347f11086745570e759fe9708d03c03accf4c90bbf580::i64::I64>()
            } else {
                0x1::option::extract<0x1::option::Option<0x7b502c8a7bcb3915892347f11086745570e759fe9708d03c03accf4c90bbf580::i64::I64>>(&mut v13)
            };
            let v15 = v14;
            if (0x1::option::is_none<0x7b502c8a7bcb3915892347f11086745570e759fe9708d03c03accf4c90bbf580::i64::I64>(&v15)) {
                abort 1
            };
            let v16 = 0x1::option::extract<0x7b502c8a7bcb3915892347f11086745570e759fe9708d03c03accf4c90bbf580::i64::I64>(&mut v15);
            assert!(!0x7b502c8a7bcb3915892347f11086745570e759fe9708d03c03accf4c90bbf580::i64::get_is_negative(&v16), 3);
            let v17 = 0x7b502c8a7bcb3915892347f11086745570e759fe9708d03c03accf4c90bbf580::feed::exponent(v12);
            if (0x1::option::is_none<0x7b502c8a7bcb3915892347f11086745570e759fe9708d03c03accf4c90bbf580::i16::I16>(&v17)) {
                abort 2
            };
            let v18 = 0x1::option::extract<0x7b502c8a7bcb3915892347f11086745570e759fe9708d03c03accf4c90bbf580::i16::I16>(&mut v17);
            let v19 = if (0x7b502c8a7bcb3915892347f11086745570e759fe9708d03c03accf4c90bbf580::i16::get_is_negative(&v18)) {
                0x46234ba81f3a5ba6571383233df0f9ea5fe60a3a327537be1f5fec447bced693::ifixed::div(0x46234ba81f3a5ba6571383233df0f9ea5fe60a3a327537be1f5fec447bced693::ifixed::from_u64(0x7b502c8a7bcb3915892347f11086745570e759fe9708d03c03accf4c90bbf580::i64::get_magnitude_if_positive(&v16)), 0x46234ba81f3a5ba6571383233df0f9ea5fe60a3a327537be1f5fec447bced693::ifixed::from_u64(0x1::u64::pow(10, (0x7b502c8a7bcb3915892347f11086745570e759fe9708d03c03accf4c90bbf580::i16::get_magnitude_if_negative(&v18) as u8))))
            } else {
                0x46234ba81f3a5ba6571383233df0f9ea5fe60a3a327537be1f5fec447bced693::ifixed::from_u64(0x7b502c8a7bcb3915892347f11086745570e759fe9708d03c03accf4c90bbf580::i64::get_magnitude_if_positive(&v16) * 0x1::u64::pow(10, (0x7b502c8a7bcb3915892347f11086745570e759fe9708d03c03accf4c90bbf580::i16::get_magnitude_if_positive(&v18) as u8)))
            };
            let v20 = 0x7b502c8a7bcb3915892347f11086745570e759fe9708d03c03accf4c90bbf580::feed::confidence(v12);
            let v21 = if (0x1::option::is_none<0x1::option::Option<0x7b502c8a7bcb3915892347f11086745570e759fe9708d03c03accf4c90bbf580::i64::I64>>(&v20)) {
                0x1::option::none<0x7b502c8a7bcb3915892347f11086745570e759fe9708d03c03accf4c90bbf580::i64::I64>()
            } else {
                0x1::option::extract<0x1::option::Option<0x7b502c8a7bcb3915892347f11086745570e759fe9708d03c03accf4c90bbf580::i64::I64>>(&mut v20)
            };
            let v22 = v21;
            let v23 = if (0x1::option::is_none<0x7b502c8a7bcb3915892347f11086745570e759fe9708d03c03accf4c90bbf580::i64::I64>(&v22)) {
                0xa8172ed2a6f14cd0ee55124326685713d6f765039e7c5339f7a0b57be06fddb5::price_feed::confidence_not_reported_by_source()
            } else {
                let v24 = 0x1::option::extract<0x7b502c8a7bcb3915892347f11086745570e759fe9708d03c03accf4c90bbf580::i64::I64>(&mut v22);
                assert!(!0x7b502c8a7bcb3915892347f11086745570e759fe9708d03c03accf4c90bbf580::i64::get_is_negative(&v24), 4);
                if (0x7b502c8a7bcb3915892347f11086745570e759fe9708d03c03accf4c90bbf580::i16::get_is_negative(&v18)) {
                    0x46234ba81f3a5ba6571383233df0f9ea5fe60a3a327537be1f5fec447bced693::ifixed::div(0x46234ba81f3a5ba6571383233df0f9ea5fe60a3a327537be1f5fec447bced693::ifixed::from_u64(0x7b502c8a7bcb3915892347f11086745570e759fe9708d03c03accf4c90bbf580::i64::get_magnitude_if_positive(&v24)), 0x46234ba81f3a5ba6571383233df0f9ea5fe60a3a327537be1f5fec447bced693::ifixed::from_u64(0x1::u64::pow(10, (0x7b502c8a7bcb3915892347f11086745570e759fe9708d03c03accf4c90bbf580::i16::get_magnitude_if_negative(&v18) as u8))))
                } else {
                    0x46234ba81f3a5ba6571383233df0f9ea5fe60a3a327537be1f5fec447bced693::ifixed::from_u64(0x7b502c8a7bcb3915892347f11086745570e759fe9708d03c03accf4c90bbf580::i64::get_magnitude_if_positive(&v24) * 0x1::u64::pow(10, (0x7b502c8a7bcb3915892347f11086745570e759fe9708d03c03accf4c90bbf580::i16::get_magnitude_if_positive(&v18) as u8)))
                }
            };
            let v25 = 0x7b502c8a7bcb3915892347f11086745570e759fe9708d03c03accf4c90bbf580::feed::market_session(v12);
            let v26 = &v25;
            let v27 = if (0x1::option::is_some<0x7b502c8a7bcb3915892347f11086745570e759fe9708d03c03accf4c90bbf580::market_session::MarketSession>(v26) && 0x7b502c8a7bcb3915892347f11086745570e759fe9708d03c03accf4c90bbf580::market_session::is_closed(0x1::option::borrow<0x7b502c8a7bcb3915892347f11086745570e759fe9708d03c03accf4c90bbf580::market_session::MarketSession>(v26))) {
                0x7b502c8a7bcb3915892347f11086745570e759fe9708d03c03accf4c90bbf580::update::timestamp(arg4) / 1000
            } else {
                let v28 = 0x7b502c8a7bcb3915892347f11086745570e759fe9708d03c03accf4c90bbf580::feed::feed_update_timestamp(v12);
                let v29 = if (0x1::option::is_none<0x1::option::Option<u64>>(&v28)) {
                    0x1::option::none<u64>()
                } else {
                    0x1::option::extract<0x1::option::Option<u64>>(&mut v28)
                };
                let v30 = v29;
                let v31 = if (0x1::option::is_none<u64>(&v30)) {
                    0x7b502c8a7bcb3915892347f11086745570e759fe9708d03c03accf4c90bbf580::update::timestamp(arg4)
                } else {
                    0x1::option::extract<u64>(&mut v30)
                };
                v31 / 1000
            };
            0xa8172ed2a6f14cd0ee55124326685713d6f765039e7c5339f7a0b57be06fddb5::price_feed_storage::new_price_feed<0xa8172ed2a6f14cd0ee55124326685713d6f765039e7c5339f7a0b57be06fddb5::authority::ADMIN, 0x6890ed5cf666a6eb6a6ee5a858be7e52f3e1ae3f91a5e2d2baf159e25d0f78b3::feed_info_object::FeedInfoObject>(arg2, arg1, arg3, 0x6890ed5cf666a6eb6a6ee5a858be7e52f3e1ae3f91a5e2d2baf159e25d0f78b3::pyth_lazer_rolling::borrow_id(arg0), arg5, v19, v23, v27, arg7);
        } else if (v5 == 0) {
            let v32 = 0x7b502c8a7bcb3915892347f11086745570e759fe9708d03c03accf4c90bbf580::update::feeds_ref(arg4);
            let v33 = 0;
            let v34;
            loop {
                assert!(v33 < 0x1::vector::length<0x7b502c8a7bcb3915892347f11086745570e759fe9708d03c03accf4c90bbf580::feed::Feed>(v32), 0);
                v34 = 0x1::vector::borrow<0x7b502c8a7bcb3915892347f11086745570e759fe9708d03c03accf4c90bbf580::feed::Feed>(v32, v33);
                if (0x7b502c8a7bcb3915892347f11086745570e759fe9708d03c03accf4c90bbf580::feed::feed_id(v34) == 0x6890ed5cf666a6eb6a6ee5a858be7e52f3e1ae3f91a5e2d2baf159e25d0f78b3::feed_info_object::next_feed_id(arg5)) {
                    break
                };
                v33 = v33 + 1;
            };
            let v35 = *v34;
            let v36 = &v35;
            let v37 = 0x7b502c8a7bcb3915892347f11086745570e759fe9708d03c03accf4c90bbf580::feed::price(v36);
            let v38 = if (0x1::option::is_none<0x1::option::Option<0x7b502c8a7bcb3915892347f11086745570e759fe9708d03c03accf4c90bbf580::i64::I64>>(&v37)) {
                0x1::option::none<0x7b502c8a7bcb3915892347f11086745570e759fe9708d03c03accf4c90bbf580::i64::I64>()
            } else {
                0x1::option::extract<0x1::option::Option<0x7b502c8a7bcb3915892347f11086745570e759fe9708d03c03accf4c90bbf580::i64::I64>>(&mut v37)
            };
            let v39 = v38;
            if (0x1::option::is_none<0x7b502c8a7bcb3915892347f11086745570e759fe9708d03c03accf4c90bbf580::i64::I64>(&v39)) {
                abort 1
            };
            let v40 = 0x1::option::extract<0x7b502c8a7bcb3915892347f11086745570e759fe9708d03c03accf4c90bbf580::i64::I64>(&mut v39);
            assert!(!0x7b502c8a7bcb3915892347f11086745570e759fe9708d03c03accf4c90bbf580::i64::get_is_negative(&v40), 3);
            let v41 = 0x7b502c8a7bcb3915892347f11086745570e759fe9708d03c03accf4c90bbf580::feed::exponent(v36);
            if (0x1::option::is_none<0x7b502c8a7bcb3915892347f11086745570e759fe9708d03c03accf4c90bbf580::i16::I16>(&v41)) {
                abort 2
            };
            let v42 = 0x1::option::extract<0x7b502c8a7bcb3915892347f11086745570e759fe9708d03c03accf4c90bbf580::i16::I16>(&mut v41);
            let v43 = if (0x7b502c8a7bcb3915892347f11086745570e759fe9708d03c03accf4c90bbf580::i16::get_is_negative(&v42)) {
                0x46234ba81f3a5ba6571383233df0f9ea5fe60a3a327537be1f5fec447bced693::ifixed::div(0x46234ba81f3a5ba6571383233df0f9ea5fe60a3a327537be1f5fec447bced693::ifixed::from_u64(0x7b502c8a7bcb3915892347f11086745570e759fe9708d03c03accf4c90bbf580::i64::get_magnitude_if_positive(&v40)), 0x46234ba81f3a5ba6571383233df0f9ea5fe60a3a327537be1f5fec447bced693::ifixed::from_u64(0x1::u64::pow(10, (0x7b502c8a7bcb3915892347f11086745570e759fe9708d03c03accf4c90bbf580::i16::get_magnitude_if_negative(&v42) as u8))))
            } else {
                0x46234ba81f3a5ba6571383233df0f9ea5fe60a3a327537be1f5fec447bced693::ifixed::from_u64(0x7b502c8a7bcb3915892347f11086745570e759fe9708d03c03accf4c90bbf580::i64::get_magnitude_if_positive(&v40) * 0x1::u64::pow(10, (0x7b502c8a7bcb3915892347f11086745570e759fe9708d03c03accf4c90bbf580::i16::get_magnitude_if_positive(&v42) as u8)))
            };
            let v44 = 0x7b502c8a7bcb3915892347f11086745570e759fe9708d03c03accf4c90bbf580::feed::confidence(v36);
            let v45 = if (0x1::option::is_none<0x1::option::Option<0x7b502c8a7bcb3915892347f11086745570e759fe9708d03c03accf4c90bbf580::i64::I64>>(&v44)) {
                0x1::option::none<0x7b502c8a7bcb3915892347f11086745570e759fe9708d03c03accf4c90bbf580::i64::I64>()
            } else {
                0x1::option::extract<0x1::option::Option<0x7b502c8a7bcb3915892347f11086745570e759fe9708d03c03accf4c90bbf580::i64::I64>>(&mut v44)
            };
            let v46 = v45;
            let v47 = if (0x1::option::is_none<0x7b502c8a7bcb3915892347f11086745570e759fe9708d03c03accf4c90bbf580::i64::I64>(&v46)) {
                0xa8172ed2a6f14cd0ee55124326685713d6f765039e7c5339f7a0b57be06fddb5::price_feed::confidence_not_reported_by_source()
            } else {
                let v48 = 0x1::option::extract<0x7b502c8a7bcb3915892347f11086745570e759fe9708d03c03accf4c90bbf580::i64::I64>(&mut v46);
                assert!(!0x7b502c8a7bcb3915892347f11086745570e759fe9708d03c03accf4c90bbf580::i64::get_is_negative(&v48), 4);
                if (0x7b502c8a7bcb3915892347f11086745570e759fe9708d03c03accf4c90bbf580::i16::get_is_negative(&v42)) {
                    0x46234ba81f3a5ba6571383233df0f9ea5fe60a3a327537be1f5fec447bced693::ifixed::div(0x46234ba81f3a5ba6571383233df0f9ea5fe60a3a327537be1f5fec447bced693::ifixed::from_u64(0x7b502c8a7bcb3915892347f11086745570e759fe9708d03c03accf4c90bbf580::i64::get_magnitude_if_positive(&v48)), 0x46234ba81f3a5ba6571383233df0f9ea5fe60a3a327537be1f5fec447bced693::ifixed::from_u64(0x1::u64::pow(10, (0x7b502c8a7bcb3915892347f11086745570e759fe9708d03c03accf4c90bbf580::i16::get_magnitude_if_negative(&v42) as u8))))
                } else {
                    0x46234ba81f3a5ba6571383233df0f9ea5fe60a3a327537be1f5fec447bced693::ifixed::from_u64(0x7b502c8a7bcb3915892347f11086745570e759fe9708d03c03accf4c90bbf580::i64::get_magnitude_if_positive(&v48) * 0x1::u64::pow(10, (0x7b502c8a7bcb3915892347f11086745570e759fe9708d03c03accf4c90bbf580::i16::get_magnitude_if_positive(&v42) as u8)))
                }
            };
            let v49 = 0x7b502c8a7bcb3915892347f11086745570e759fe9708d03c03accf4c90bbf580::feed::market_session(v36);
            let v50 = &v49;
            let v51 = if (0x1::option::is_some<0x7b502c8a7bcb3915892347f11086745570e759fe9708d03c03accf4c90bbf580::market_session::MarketSession>(v50) && 0x7b502c8a7bcb3915892347f11086745570e759fe9708d03c03accf4c90bbf580::market_session::is_closed(0x1::option::borrow<0x7b502c8a7bcb3915892347f11086745570e759fe9708d03c03accf4c90bbf580::market_session::MarketSession>(v50))) {
                0x7b502c8a7bcb3915892347f11086745570e759fe9708d03c03accf4c90bbf580::update::timestamp(arg4) / 1000
            } else {
                let v52 = 0x7b502c8a7bcb3915892347f11086745570e759fe9708d03c03accf4c90bbf580::feed::feed_update_timestamp(v36);
                let v53 = if (0x1::option::is_none<0x1::option::Option<u64>>(&v52)) {
                    0x1::option::none<u64>()
                } else {
                    0x1::option::extract<0x1::option::Option<u64>>(&mut v52)
                };
                let v54 = v53;
                let v55 = if (0x1::option::is_none<u64>(&v54)) {
                    0x7b502c8a7bcb3915892347f11086745570e759fe9708d03c03accf4c90bbf580::update::timestamp(arg4)
                } else {
                    0x1::option::extract<u64>(&mut v54)
                };
                v55 / 1000
            };
            0xa8172ed2a6f14cd0ee55124326685713d6f765039e7c5339f7a0b57be06fddb5::price_feed_storage::new_price_feed<0xa8172ed2a6f14cd0ee55124326685713d6f765039e7c5339f7a0b57be06fddb5::authority::ADMIN, 0x6890ed5cf666a6eb6a6ee5a858be7e52f3e1ae3f91a5e2d2baf159e25d0f78b3::feed_info_object::FeedInfoObject>(arg2, arg1, arg3, 0x6890ed5cf666a6eb6a6ee5a858be7e52f3e1ae3f91a5e2d2baf159e25d0f78b3::pyth_lazer_rolling::borrow_id(arg0), arg5, v43, v47, v51, arg7);
        } else {
            let v56 = 0x7b502c8a7bcb3915892347f11086745570e759fe9708d03c03accf4c90bbf580::update::feeds_ref(arg4);
            let v57 = 0;
            let v58;
            loop {
                assert!(v57 < 0x1::vector::length<0x7b502c8a7bcb3915892347f11086745570e759fe9708d03c03accf4c90bbf580::feed::Feed>(v56), 0);
                v58 = 0x1::vector::borrow<0x7b502c8a7bcb3915892347f11086745570e759fe9708d03c03accf4c90bbf580::feed::Feed>(v56, v57);
                if (0x7b502c8a7bcb3915892347f11086745570e759fe9708d03c03accf4c90bbf580::feed::feed_id(v58) == 0x6890ed5cf666a6eb6a6ee5a858be7e52f3e1ae3f91a5e2d2baf159e25d0f78b3::feed_info_object::current_feed_id(arg5)) {
                    break
                };
                v57 = v57 + 1;
            };
            let v59 = *v58;
            let v60 = 0x7b502c8a7bcb3915892347f11086745570e759fe9708d03c03accf4c90bbf580::update::feeds_ref(arg4);
            let v61 = 0;
            let v62;
            loop {
                assert!(v61 < 0x1::vector::length<0x7b502c8a7bcb3915892347f11086745570e759fe9708d03c03accf4c90bbf580::feed::Feed>(v60), 0);
                v62 = 0x1::vector::borrow<0x7b502c8a7bcb3915892347f11086745570e759fe9708d03c03accf4c90bbf580::feed::Feed>(v60, v61);
                if (0x7b502c8a7bcb3915892347f11086745570e759fe9708d03c03accf4c90bbf580::feed::feed_id(v62) == 0x6890ed5cf666a6eb6a6ee5a858be7e52f3e1ae3f91a5e2d2baf159e25d0f78b3::feed_info_object::next_feed_id(arg5)) {
                    break
                };
                v61 = v61 + 1;
            };
            let v63 = *v62;
            let v64 = &v59;
            let v65 = 0x7b502c8a7bcb3915892347f11086745570e759fe9708d03c03accf4c90bbf580::feed::price(v64);
            let v66 = if (0x1::option::is_none<0x1::option::Option<0x7b502c8a7bcb3915892347f11086745570e759fe9708d03c03accf4c90bbf580::i64::I64>>(&v65)) {
                0x1::option::none<0x7b502c8a7bcb3915892347f11086745570e759fe9708d03c03accf4c90bbf580::i64::I64>()
            } else {
                0x1::option::extract<0x1::option::Option<0x7b502c8a7bcb3915892347f11086745570e759fe9708d03c03accf4c90bbf580::i64::I64>>(&mut v65)
            };
            let v67 = v66;
            if (0x1::option::is_none<0x7b502c8a7bcb3915892347f11086745570e759fe9708d03c03accf4c90bbf580::i64::I64>(&v67)) {
                abort 1
            };
            let v68 = 0x1::option::extract<0x7b502c8a7bcb3915892347f11086745570e759fe9708d03c03accf4c90bbf580::i64::I64>(&mut v67);
            assert!(!0x7b502c8a7bcb3915892347f11086745570e759fe9708d03c03accf4c90bbf580::i64::get_is_negative(&v68), 3);
            let v69 = 0x7b502c8a7bcb3915892347f11086745570e759fe9708d03c03accf4c90bbf580::feed::exponent(v64);
            if (0x1::option::is_none<0x7b502c8a7bcb3915892347f11086745570e759fe9708d03c03accf4c90bbf580::i16::I16>(&v69)) {
                abort 2
            };
            let v70 = 0x1::option::extract<0x7b502c8a7bcb3915892347f11086745570e759fe9708d03c03accf4c90bbf580::i16::I16>(&mut v69);
            let v71 = if (0x7b502c8a7bcb3915892347f11086745570e759fe9708d03c03accf4c90bbf580::i16::get_is_negative(&v70)) {
                0x46234ba81f3a5ba6571383233df0f9ea5fe60a3a327537be1f5fec447bced693::ifixed::div(0x46234ba81f3a5ba6571383233df0f9ea5fe60a3a327537be1f5fec447bced693::ifixed::from_u64(0x7b502c8a7bcb3915892347f11086745570e759fe9708d03c03accf4c90bbf580::i64::get_magnitude_if_positive(&v68)), 0x46234ba81f3a5ba6571383233df0f9ea5fe60a3a327537be1f5fec447bced693::ifixed::from_u64(0x1::u64::pow(10, (0x7b502c8a7bcb3915892347f11086745570e759fe9708d03c03accf4c90bbf580::i16::get_magnitude_if_negative(&v70) as u8))))
            } else {
                0x46234ba81f3a5ba6571383233df0f9ea5fe60a3a327537be1f5fec447bced693::ifixed::from_u64(0x7b502c8a7bcb3915892347f11086745570e759fe9708d03c03accf4c90bbf580::i64::get_magnitude_if_positive(&v68) * 0x1::u64::pow(10, (0x7b502c8a7bcb3915892347f11086745570e759fe9708d03c03accf4c90bbf580::i16::get_magnitude_if_positive(&v70) as u8)))
            };
            let v72 = 0x7b502c8a7bcb3915892347f11086745570e759fe9708d03c03accf4c90bbf580::feed::confidence(v64);
            let v73 = if (0x1::option::is_none<0x1::option::Option<0x7b502c8a7bcb3915892347f11086745570e759fe9708d03c03accf4c90bbf580::i64::I64>>(&v72)) {
                0x1::option::none<0x7b502c8a7bcb3915892347f11086745570e759fe9708d03c03accf4c90bbf580::i64::I64>()
            } else {
                0x1::option::extract<0x1::option::Option<0x7b502c8a7bcb3915892347f11086745570e759fe9708d03c03accf4c90bbf580::i64::I64>>(&mut v72)
            };
            let v74 = v73;
            let v75 = if (0x1::option::is_none<0x7b502c8a7bcb3915892347f11086745570e759fe9708d03c03accf4c90bbf580::i64::I64>(&v74)) {
                0xa8172ed2a6f14cd0ee55124326685713d6f765039e7c5339f7a0b57be06fddb5::price_feed::confidence_not_reported_by_source()
            } else {
                let v76 = 0x1::option::extract<0x7b502c8a7bcb3915892347f11086745570e759fe9708d03c03accf4c90bbf580::i64::I64>(&mut v74);
                assert!(!0x7b502c8a7bcb3915892347f11086745570e759fe9708d03c03accf4c90bbf580::i64::get_is_negative(&v76), 4);
                if (0x7b502c8a7bcb3915892347f11086745570e759fe9708d03c03accf4c90bbf580::i16::get_is_negative(&v70)) {
                    0x46234ba81f3a5ba6571383233df0f9ea5fe60a3a327537be1f5fec447bced693::ifixed::div(0x46234ba81f3a5ba6571383233df0f9ea5fe60a3a327537be1f5fec447bced693::ifixed::from_u64(0x7b502c8a7bcb3915892347f11086745570e759fe9708d03c03accf4c90bbf580::i64::get_magnitude_if_positive(&v76)), 0x46234ba81f3a5ba6571383233df0f9ea5fe60a3a327537be1f5fec447bced693::ifixed::from_u64(0x1::u64::pow(10, (0x7b502c8a7bcb3915892347f11086745570e759fe9708d03c03accf4c90bbf580::i16::get_magnitude_if_negative(&v70) as u8))))
                } else {
                    0x46234ba81f3a5ba6571383233df0f9ea5fe60a3a327537be1f5fec447bced693::ifixed::from_u64(0x7b502c8a7bcb3915892347f11086745570e759fe9708d03c03accf4c90bbf580::i64::get_magnitude_if_positive(&v76) * 0x1::u64::pow(10, (0x7b502c8a7bcb3915892347f11086745570e759fe9708d03c03accf4c90bbf580::i16::get_magnitude_if_positive(&v70) as u8)))
                }
            };
            let v77 = 0x7b502c8a7bcb3915892347f11086745570e759fe9708d03c03accf4c90bbf580::feed::market_session(v64);
            let v78 = &v77;
            let v79 = if (0x1::option::is_some<0x7b502c8a7bcb3915892347f11086745570e759fe9708d03c03accf4c90bbf580::market_session::MarketSession>(v78) && 0x7b502c8a7bcb3915892347f11086745570e759fe9708d03c03accf4c90bbf580::market_session::is_closed(0x1::option::borrow<0x7b502c8a7bcb3915892347f11086745570e759fe9708d03c03accf4c90bbf580::market_session::MarketSession>(v78))) {
                0x7b502c8a7bcb3915892347f11086745570e759fe9708d03c03accf4c90bbf580::update::timestamp(arg4) / 1000
            } else {
                let v80 = 0x7b502c8a7bcb3915892347f11086745570e759fe9708d03c03accf4c90bbf580::feed::feed_update_timestamp(v64);
                let v81 = if (0x1::option::is_none<0x1::option::Option<u64>>(&v80)) {
                    0x1::option::none<u64>()
                } else {
                    0x1::option::extract<0x1::option::Option<u64>>(&mut v80)
                };
                let v82 = v81;
                let v83 = if (0x1::option::is_none<u64>(&v82)) {
                    0x7b502c8a7bcb3915892347f11086745570e759fe9708d03c03accf4c90bbf580::update::timestamp(arg4)
                } else {
                    0x1::option::extract<u64>(&mut v82)
                };
                v83 / 1000
            };
            let v84 = &v63;
            let v85 = 0x7b502c8a7bcb3915892347f11086745570e759fe9708d03c03accf4c90bbf580::feed::price(v84);
            let v86 = if (0x1::option::is_none<0x1::option::Option<0x7b502c8a7bcb3915892347f11086745570e759fe9708d03c03accf4c90bbf580::i64::I64>>(&v85)) {
                0x1::option::none<0x7b502c8a7bcb3915892347f11086745570e759fe9708d03c03accf4c90bbf580::i64::I64>()
            } else {
                0x1::option::extract<0x1::option::Option<0x7b502c8a7bcb3915892347f11086745570e759fe9708d03c03accf4c90bbf580::i64::I64>>(&mut v85)
            };
            let v87 = v86;
            if (0x1::option::is_none<0x7b502c8a7bcb3915892347f11086745570e759fe9708d03c03accf4c90bbf580::i64::I64>(&v87)) {
                abort 1
            };
            let v88 = 0x1::option::extract<0x7b502c8a7bcb3915892347f11086745570e759fe9708d03c03accf4c90bbf580::i64::I64>(&mut v87);
            assert!(!0x7b502c8a7bcb3915892347f11086745570e759fe9708d03c03accf4c90bbf580::i64::get_is_negative(&v88), 3);
            let v89 = 0x7b502c8a7bcb3915892347f11086745570e759fe9708d03c03accf4c90bbf580::feed::exponent(v84);
            if (0x1::option::is_none<0x7b502c8a7bcb3915892347f11086745570e759fe9708d03c03accf4c90bbf580::i16::I16>(&v89)) {
                abort 2
            };
            let v90 = 0x1::option::extract<0x7b502c8a7bcb3915892347f11086745570e759fe9708d03c03accf4c90bbf580::i16::I16>(&mut v89);
            let v91 = if (0x7b502c8a7bcb3915892347f11086745570e759fe9708d03c03accf4c90bbf580::i16::get_is_negative(&v90)) {
                0x46234ba81f3a5ba6571383233df0f9ea5fe60a3a327537be1f5fec447bced693::ifixed::div(0x46234ba81f3a5ba6571383233df0f9ea5fe60a3a327537be1f5fec447bced693::ifixed::from_u64(0x7b502c8a7bcb3915892347f11086745570e759fe9708d03c03accf4c90bbf580::i64::get_magnitude_if_positive(&v88)), 0x46234ba81f3a5ba6571383233df0f9ea5fe60a3a327537be1f5fec447bced693::ifixed::from_u64(0x1::u64::pow(10, (0x7b502c8a7bcb3915892347f11086745570e759fe9708d03c03accf4c90bbf580::i16::get_magnitude_if_negative(&v90) as u8))))
            } else {
                0x46234ba81f3a5ba6571383233df0f9ea5fe60a3a327537be1f5fec447bced693::ifixed::from_u64(0x7b502c8a7bcb3915892347f11086745570e759fe9708d03c03accf4c90bbf580::i64::get_magnitude_if_positive(&v88) * 0x1::u64::pow(10, (0x7b502c8a7bcb3915892347f11086745570e759fe9708d03c03accf4c90bbf580::i16::get_magnitude_if_positive(&v90) as u8)))
            };
            let v92 = 0x7b502c8a7bcb3915892347f11086745570e759fe9708d03c03accf4c90bbf580::feed::confidence(v84);
            let v93 = if (0x1::option::is_none<0x1::option::Option<0x7b502c8a7bcb3915892347f11086745570e759fe9708d03c03accf4c90bbf580::i64::I64>>(&v92)) {
                0x1::option::none<0x7b502c8a7bcb3915892347f11086745570e759fe9708d03c03accf4c90bbf580::i64::I64>()
            } else {
                0x1::option::extract<0x1::option::Option<0x7b502c8a7bcb3915892347f11086745570e759fe9708d03c03accf4c90bbf580::i64::I64>>(&mut v92)
            };
            let v94 = v93;
            let v95 = if (0x1::option::is_none<0x7b502c8a7bcb3915892347f11086745570e759fe9708d03c03accf4c90bbf580::i64::I64>(&v94)) {
                0xa8172ed2a6f14cd0ee55124326685713d6f765039e7c5339f7a0b57be06fddb5::price_feed::confidence_not_reported_by_source()
            } else {
                let v96 = 0x1::option::extract<0x7b502c8a7bcb3915892347f11086745570e759fe9708d03c03accf4c90bbf580::i64::I64>(&mut v94);
                assert!(!0x7b502c8a7bcb3915892347f11086745570e759fe9708d03c03accf4c90bbf580::i64::get_is_negative(&v96), 4);
                if (0x7b502c8a7bcb3915892347f11086745570e759fe9708d03c03accf4c90bbf580::i16::get_is_negative(&v90)) {
                    0x46234ba81f3a5ba6571383233df0f9ea5fe60a3a327537be1f5fec447bced693::ifixed::div(0x46234ba81f3a5ba6571383233df0f9ea5fe60a3a327537be1f5fec447bced693::ifixed::from_u64(0x7b502c8a7bcb3915892347f11086745570e759fe9708d03c03accf4c90bbf580::i64::get_magnitude_if_positive(&v96)), 0x46234ba81f3a5ba6571383233df0f9ea5fe60a3a327537be1f5fec447bced693::ifixed::from_u64(0x1::u64::pow(10, (0x7b502c8a7bcb3915892347f11086745570e759fe9708d03c03accf4c90bbf580::i16::get_magnitude_if_negative(&v90) as u8))))
                } else {
                    0x46234ba81f3a5ba6571383233df0f9ea5fe60a3a327537be1f5fec447bced693::ifixed::from_u64(0x7b502c8a7bcb3915892347f11086745570e759fe9708d03c03accf4c90bbf580::i64::get_magnitude_if_positive(&v96) * 0x1::u64::pow(10, (0x7b502c8a7bcb3915892347f11086745570e759fe9708d03c03accf4c90bbf580::i16::get_magnitude_if_positive(&v90) as u8)))
                }
            };
            let v97 = 0x7b502c8a7bcb3915892347f11086745570e759fe9708d03c03accf4c90bbf580::feed::market_session(v84);
            let v98 = &v97;
            let v99 = if (0x1::option::is_some<0x7b502c8a7bcb3915892347f11086745570e759fe9708d03c03accf4c90bbf580::market_session::MarketSession>(v98) && 0x7b502c8a7bcb3915892347f11086745570e759fe9708d03c03accf4c90bbf580::market_session::is_closed(0x1::option::borrow<0x7b502c8a7bcb3915892347f11086745570e759fe9708d03c03accf4c90bbf580::market_session::MarketSession>(v98))) {
                0x7b502c8a7bcb3915892347f11086745570e759fe9708d03c03accf4c90bbf580::update::timestamp(arg4) / 1000
            } else {
                let v100 = 0x7b502c8a7bcb3915892347f11086745570e759fe9708d03c03accf4c90bbf580::feed::feed_update_timestamp(v84);
                let v101 = if (0x1::option::is_none<0x1::option::Option<u64>>(&v100)) {
                    0x1::option::none<u64>()
                } else {
                    0x1::option::extract<0x1::option::Option<u64>>(&mut v100)
                };
                let v102 = v101;
                let v103 = if (0x1::option::is_none<u64>(&v102)) {
                    0x7b502c8a7bcb3915892347f11086745570e759fe9708d03c03accf4c90bbf580::update::timestamp(arg4)
                } else {
                    0x1::option::extract<u64>(&mut v102)
                };
                v103 / 1000
            };
            let v104 = if (v79 > v99) {
                v79
            } else {
                v99
            };
            0xa8172ed2a6f14cd0ee55124326685713d6f765039e7c5339f7a0b57be06fddb5::price_feed_storage::new_price_feed<0xa8172ed2a6f14cd0ee55124326685713d6f765039e7c5339f7a0b57be06fddb5::authority::ADMIN, 0x6890ed5cf666a6eb6a6ee5a858be7e52f3e1ae3f91a5e2d2baf159e25d0f78b3::feed_info_object::FeedInfoObject>(arg2, arg1, arg3, 0x6890ed5cf666a6eb6a6ee5a858be7e52f3e1ae3f91a5e2d2baf159e25d0f78b3::pyth_lazer_rolling::borrow_id(arg0), arg5, 0x46234ba81f3a5ba6571383233df0f9ea5fe60a3a327537be1f5fec447bced693::ifixed::add(0x46234ba81f3a5ba6571383233df0f9ea5fe60a3a327537be1f5fec447bced693::ifixed::mul(v5, v71), 0x46234ba81f3a5ba6571383233df0f9ea5fe60a3a327537be1f5fec447bced693::ifixed::mul(v6, v91)), 0x46234ba81f3a5ba6571383233df0f9ea5fe60a3a327537be1f5fec447bced693::ifixed::add(0x46234ba81f3a5ba6571383233df0f9ea5fe60a3a327537be1f5fec447bced693::ifixed::mul(v5, v75), 0x46234ba81f3a5ba6571383233df0f9ea5fe60a3a327537be1f5fec447bced693::ifixed::mul(v6, v95)), v104, arg7);
        };
    }

    public fun remove_price_feed<T0>(arg0: &0x6890ed5cf666a6eb6a6ee5a858be7e52f3e1ae3f91a5e2d2baf159e25d0f78b3::pyth_lazer_rolling::OracleAggregatorPythLazerRollingIntegration, arg1: &0xa8172ed2a6f14cd0ee55124326685713d6f765039e7c5339f7a0b57be06fddb5::authority::AuthorityCap<0xa8172ed2a6f14cd0ee55124326685713d6f765039e7c5339f7a0b57be06fddb5::authority::PACKAGE, T0>, arg2: &mut 0xa8172ed2a6f14cd0ee55124326685713d6f765039e7c5339f7a0b57be06fddb5::price_feed_storage::PriceFeedStorage, arg3: &0xa8172ed2a6f14cd0ee55124326685713d6f765039e7c5339f7a0b57be06fddb5::config::Config) {
        0xa8172ed2a6f14cd0ee55124326685713d6f765039e7c5339f7a0b57be06fddb5::price_feed_storage::remove_price_feed<T0>(arg2, arg1, arg3, 0x6890ed5cf666a6eb6a6ee5a858be7e52f3e1ae3f91a5e2d2baf159e25d0f78b3::pyth_lazer_rolling::borrow_id(arg0));
    }

    public fun update_price_feed(arg0: &0x6890ed5cf666a6eb6a6ee5a858be7e52f3e1ae3f91a5e2d2baf159e25d0f78b3::pyth_lazer_rolling::OracleAggregatorPythLazerRollingIntegration, arg1: &mut 0xa8172ed2a6f14cd0ee55124326685713d6f765039e7c5339f7a0b57be06fddb5::price_feed_storage::PriceFeedStorage, arg2: &0xa8172ed2a6f14cd0ee55124326685713d6f765039e7c5339f7a0b57be06fddb5::config::Config, arg3: &0x7b502c8a7bcb3915892347f11086745570e759fe9708d03c03accf4c90bbf580::state::State, arg4: &0x2::clock::Clock, arg5: vector<u8>, arg6: &0x6890ed5cf666a6eb6a6ee5a858be7e52f3e1ae3f91a5e2d2baf159e25d0f78b3::feed_info_object::FeedInfoObject) {
        let v0 = 0x7b502c8a7bcb3915892347f11086745570e759fe9708d03c03accf4c90bbf580::pyth_lazer::parse_and_verify_le_ecdsa_update(arg3, arg4, arg5);
        update_price_feed_from_update(arg0, arg1, arg2, &v0, arg6, arg4);
    }

    public fun update_price_feed_from_update(arg0: &0x6890ed5cf666a6eb6a6ee5a858be7e52f3e1ae3f91a5e2d2baf159e25d0f78b3::pyth_lazer_rolling::OracleAggregatorPythLazerRollingIntegration, arg1: &mut 0xa8172ed2a6f14cd0ee55124326685713d6f765039e7c5339f7a0b57be06fddb5::price_feed_storage::PriceFeedStorage, arg2: &0xa8172ed2a6f14cd0ee55124326685713d6f765039e7c5339f7a0b57be06fddb5::config::Config, arg3: &0x7b502c8a7bcb3915892347f11086745570e759fe9708d03c03accf4c90bbf580::update::Update, arg4: &0x6890ed5cf666a6eb6a6ee5a858be7e52f3e1ae3f91a5e2d2baf159e25d0f78b3::feed_info_object::FeedInfoObject, arg5: &0x2::clock::Clock) {
        let v0 = 0x6890ed5cf666a6eb6a6ee5a858be7e52f3e1ae3f91a5e2d2baf159e25d0f78b3::feed_info_object::expiry_timestamp_ms(arg4);
        let v1 = 0x2::clock::timestamp_ms(arg5);
        let v2 = if (v1 >= v0) {
            0
        } else {
            v0 - v1
        };
        let v3 = 0x6890ed5cf666a6eb6a6ee5a858be7e52f3e1ae3f91a5e2d2baf159e25d0f78b3::feed_info_object::roll_start_days(arg4) * 86400000;
        let v4 = 0x6890ed5cf666a6eb6a6ee5a858be7e52f3e1ae3f91a5e2d2baf159e25d0f78b3::feed_info_object::cutoff_days(arg4) * 86400000;
        let (v5, v6) = if (v2 > v3) {
            (1000000000000000000, 0)
        } else if (v2 <= v4) {
            (0, 1000000000000000000)
        } else {
            let v7 = 0x46234ba81f3a5ba6571383233df0f9ea5fe60a3a327537be1f5fec447bced693::ifixed::div(0x46234ba81f3a5ba6571383233df0f9ea5fe60a3a327537be1f5fec447bced693::ifixed::from_u64(v2 - v4), 0x46234ba81f3a5ba6571383233df0f9ea5fe60a3a327537be1f5fec447bced693::ifixed::from_u64(v3 - v4));
            (v7, 0x46234ba81f3a5ba6571383233df0f9ea5fe60a3a327537be1f5fec447bced693::ifixed::sub(1000000000000000000, v7))
        };
        if (v6 == 0) {
            let v8 = 0x7b502c8a7bcb3915892347f11086745570e759fe9708d03c03accf4c90bbf580::update::feeds_ref(arg3);
            let v9 = 0;
            let v10;
            loop {
                assert!(v9 < 0x1::vector::length<0x7b502c8a7bcb3915892347f11086745570e759fe9708d03c03accf4c90bbf580::feed::Feed>(v8), 0);
                v10 = 0x1::vector::borrow<0x7b502c8a7bcb3915892347f11086745570e759fe9708d03c03accf4c90bbf580::feed::Feed>(v8, v9);
                if (0x7b502c8a7bcb3915892347f11086745570e759fe9708d03c03accf4c90bbf580::feed::feed_id(v10) == 0x6890ed5cf666a6eb6a6ee5a858be7e52f3e1ae3f91a5e2d2baf159e25d0f78b3::feed_info_object::current_feed_id(arg4)) {
                    break
                };
                v9 = v9 + 1;
            };
            let v11 = *v10;
            let v12 = &v11;
            let v13 = 0x7b502c8a7bcb3915892347f11086745570e759fe9708d03c03accf4c90bbf580::feed::price(v12);
            let v14 = if (0x1::option::is_none<0x1::option::Option<0x7b502c8a7bcb3915892347f11086745570e759fe9708d03c03accf4c90bbf580::i64::I64>>(&v13)) {
                0x1::option::none<0x7b502c8a7bcb3915892347f11086745570e759fe9708d03c03accf4c90bbf580::i64::I64>()
            } else {
                0x1::option::extract<0x1::option::Option<0x7b502c8a7bcb3915892347f11086745570e759fe9708d03c03accf4c90bbf580::i64::I64>>(&mut v13)
            };
            let v15 = v14;
            if (0x1::option::is_none<0x7b502c8a7bcb3915892347f11086745570e759fe9708d03c03accf4c90bbf580::i64::I64>(&v15)) {
                abort 1
            };
            let v16 = 0x1::option::extract<0x7b502c8a7bcb3915892347f11086745570e759fe9708d03c03accf4c90bbf580::i64::I64>(&mut v15);
            assert!(!0x7b502c8a7bcb3915892347f11086745570e759fe9708d03c03accf4c90bbf580::i64::get_is_negative(&v16), 3);
            let v17 = 0x7b502c8a7bcb3915892347f11086745570e759fe9708d03c03accf4c90bbf580::feed::exponent(v12);
            if (0x1::option::is_none<0x7b502c8a7bcb3915892347f11086745570e759fe9708d03c03accf4c90bbf580::i16::I16>(&v17)) {
                abort 2
            };
            let v18 = 0x1::option::extract<0x7b502c8a7bcb3915892347f11086745570e759fe9708d03c03accf4c90bbf580::i16::I16>(&mut v17);
            let v19 = if (0x7b502c8a7bcb3915892347f11086745570e759fe9708d03c03accf4c90bbf580::i16::get_is_negative(&v18)) {
                0x46234ba81f3a5ba6571383233df0f9ea5fe60a3a327537be1f5fec447bced693::ifixed::div(0x46234ba81f3a5ba6571383233df0f9ea5fe60a3a327537be1f5fec447bced693::ifixed::from_u64(0x7b502c8a7bcb3915892347f11086745570e759fe9708d03c03accf4c90bbf580::i64::get_magnitude_if_positive(&v16)), 0x46234ba81f3a5ba6571383233df0f9ea5fe60a3a327537be1f5fec447bced693::ifixed::from_u64(0x1::u64::pow(10, (0x7b502c8a7bcb3915892347f11086745570e759fe9708d03c03accf4c90bbf580::i16::get_magnitude_if_negative(&v18) as u8))))
            } else {
                0x46234ba81f3a5ba6571383233df0f9ea5fe60a3a327537be1f5fec447bced693::ifixed::from_u64(0x7b502c8a7bcb3915892347f11086745570e759fe9708d03c03accf4c90bbf580::i64::get_magnitude_if_positive(&v16) * 0x1::u64::pow(10, (0x7b502c8a7bcb3915892347f11086745570e759fe9708d03c03accf4c90bbf580::i16::get_magnitude_if_positive(&v18) as u8)))
            };
            let v20 = 0x7b502c8a7bcb3915892347f11086745570e759fe9708d03c03accf4c90bbf580::feed::confidence(v12);
            let v21 = if (0x1::option::is_none<0x1::option::Option<0x7b502c8a7bcb3915892347f11086745570e759fe9708d03c03accf4c90bbf580::i64::I64>>(&v20)) {
                0x1::option::none<0x7b502c8a7bcb3915892347f11086745570e759fe9708d03c03accf4c90bbf580::i64::I64>()
            } else {
                0x1::option::extract<0x1::option::Option<0x7b502c8a7bcb3915892347f11086745570e759fe9708d03c03accf4c90bbf580::i64::I64>>(&mut v20)
            };
            let v22 = v21;
            let v23 = if (0x1::option::is_none<0x7b502c8a7bcb3915892347f11086745570e759fe9708d03c03accf4c90bbf580::i64::I64>(&v22)) {
                0xa8172ed2a6f14cd0ee55124326685713d6f765039e7c5339f7a0b57be06fddb5::price_feed::confidence_not_reported_by_source()
            } else {
                let v24 = 0x1::option::extract<0x7b502c8a7bcb3915892347f11086745570e759fe9708d03c03accf4c90bbf580::i64::I64>(&mut v22);
                assert!(!0x7b502c8a7bcb3915892347f11086745570e759fe9708d03c03accf4c90bbf580::i64::get_is_negative(&v24), 4);
                if (0x7b502c8a7bcb3915892347f11086745570e759fe9708d03c03accf4c90bbf580::i16::get_is_negative(&v18)) {
                    0x46234ba81f3a5ba6571383233df0f9ea5fe60a3a327537be1f5fec447bced693::ifixed::div(0x46234ba81f3a5ba6571383233df0f9ea5fe60a3a327537be1f5fec447bced693::ifixed::from_u64(0x7b502c8a7bcb3915892347f11086745570e759fe9708d03c03accf4c90bbf580::i64::get_magnitude_if_positive(&v24)), 0x46234ba81f3a5ba6571383233df0f9ea5fe60a3a327537be1f5fec447bced693::ifixed::from_u64(0x1::u64::pow(10, (0x7b502c8a7bcb3915892347f11086745570e759fe9708d03c03accf4c90bbf580::i16::get_magnitude_if_negative(&v18) as u8))))
                } else {
                    0x46234ba81f3a5ba6571383233df0f9ea5fe60a3a327537be1f5fec447bced693::ifixed::from_u64(0x7b502c8a7bcb3915892347f11086745570e759fe9708d03c03accf4c90bbf580::i64::get_magnitude_if_positive(&v24) * 0x1::u64::pow(10, (0x7b502c8a7bcb3915892347f11086745570e759fe9708d03c03accf4c90bbf580::i16::get_magnitude_if_positive(&v18) as u8)))
                }
            };
            let v25 = 0x7b502c8a7bcb3915892347f11086745570e759fe9708d03c03accf4c90bbf580::feed::market_session(v12);
            let v26 = &v25;
            let v27 = if (0x1::option::is_some<0x7b502c8a7bcb3915892347f11086745570e759fe9708d03c03accf4c90bbf580::market_session::MarketSession>(v26) && 0x7b502c8a7bcb3915892347f11086745570e759fe9708d03c03accf4c90bbf580::market_session::is_closed(0x1::option::borrow<0x7b502c8a7bcb3915892347f11086745570e759fe9708d03c03accf4c90bbf580::market_session::MarketSession>(v26))) {
                0x7b502c8a7bcb3915892347f11086745570e759fe9708d03c03accf4c90bbf580::update::timestamp(arg3) / 1000
            } else {
                let v28 = 0x7b502c8a7bcb3915892347f11086745570e759fe9708d03c03accf4c90bbf580::feed::feed_update_timestamp(v12);
                let v29 = if (0x1::option::is_none<0x1::option::Option<u64>>(&v28)) {
                    0x1::option::none<u64>()
                } else {
                    0x1::option::extract<0x1::option::Option<u64>>(&mut v28)
                };
                let v30 = v29;
                let v31 = if (0x1::option::is_none<u64>(&v30)) {
                    0x7b502c8a7bcb3915892347f11086745570e759fe9708d03c03accf4c90bbf580::update::timestamp(arg3)
                } else {
                    0x1::option::extract<u64>(&mut v30)
                };
                v31 / 1000
            };
            0xa8172ed2a6f14cd0ee55124326685713d6f765039e7c5339f7a0b57be06fddb5::price_feed_storage::update_price_feed<0x6890ed5cf666a6eb6a6ee5a858be7e52f3e1ae3f91a5e2d2baf159e25d0f78b3::feed_info_object::FeedInfoObject>(arg1, arg2, 0x6890ed5cf666a6eb6a6ee5a858be7e52f3e1ae3f91a5e2d2baf159e25d0f78b3::pyth_lazer_rolling::borrow_id(arg0), arg4, v19, v23, v27);
        } else if (v5 == 0) {
            let v32 = 0x7b502c8a7bcb3915892347f11086745570e759fe9708d03c03accf4c90bbf580::update::feeds_ref(arg3);
            let v33 = 0;
            let v34;
            loop {
                assert!(v33 < 0x1::vector::length<0x7b502c8a7bcb3915892347f11086745570e759fe9708d03c03accf4c90bbf580::feed::Feed>(v32), 0);
                v34 = 0x1::vector::borrow<0x7b502c8a7bcb3915892347f11086745570e759fe9708d03c03accf4c90bbf580::feed::Feed>(v32, v33);
                if (0x7b502c8a7bcb3915892347f11086745570e759fe9708d03c03accf4c90bbf580::feed::feed_id(v34) == 0x6890ed5cf666a6eb6a6ee5a858be7e52f3e1ae3f91a5e2d2baf159e25d0f78b3::feed_info_object::next_feed_id(arg4)) {
                    break
                };
                v33 = v33 + 1;
            };
            let v35 = *v34;
            let v36 = &v35;
            let v37 = 0x7b502c8a7bcb3915892347f11086745570e759fe9708d03c03accf4c90bbf580::feed::price(v36);
            let v38 = if (0x1::option::is_none<0x1::option::Option<0x7b502c8a7bcb3915892347f11086745570e759fe9708d03c03accf4c90bbf580::i64::I64>>(&v37)) {
                0x1::option::none<0x7b502c8a7bcb3915892347f11086745570e759fe9708d03c03accf4c90bbf580::i64::I64>()
            } else {
                0x1::option::extract<0x1::option::Option<0x7b502c8a7bcb3915892347f11086745570e759fe9708d03c03accf4c90bbf580::i64::I64>>(&mut v37)
            };
            let v39 = v38;
            if (0x1::option::is_none<0x7b502c8a7bcb3915892347f11086745570e759fe9708d03c03accf4c90bbf580::i64::I64>(&v39)) {
                abort 1
            };
            let v40 = 0x1::option::extract<0x7b502c8a7bcb3915892347f11086745570e759fe9708d03c03accf4c90bbf580::i64::I64>(&mut v39);
            assert!(!0x7b502c8a7bcb3915892347f11086745570e759fe9708d03c03accf4c90bbf580::i64::get_is_negative(&v40), 3);
            let v41 = 0x7b502c8a7bcb3915892347f11086745570e759fe9708d03c03accf4c90bbf580::feed::exponent(v36);
            if (0x1::option::is_none<0x7b502c8a7bcb3915892347f11086745570e759fe9708d03c03accf4c90bbf580::i16::I16>(&v41)) {
                abort 2
            };
            let v42 = 0x1::option::extract<0x7b502c8a7bcb3915892347f11086745570e759fe9708d03c03accf4c90bbf580::i16::I16>(&mut v41);
            let v43 = if (0x7b502c8a7bcb3915892347f11086745570e759fe9708d03c03accf4c90bbf580::i16::get_is_negative(&v42)) {
                0x46234ba81f3a5ba6571383233df0f9ea5fe60a3a327537be1f5fec447bced693::ifixed::div(0x46234ba81f3a5ba6571383233df0f9ea5fe60a3a327537be1f5fec447bced693::ifixed::from_u64(0x7b502c8a7bcb3915892347f11086745570e759fe9708d03c03accf4c90bbf580::i64::get_magnitude_if_positive(&v40)), 0x46234ba81f3a5ba6571383233df0f9ea5fe60a3a327537be1f5fec447bced693::ifixed::from_u64(0x1::u64::pow(10, (0x7b502c8a7bcb3915892347f11086745570e759fe9708d03c03accf4c90bbf580::i16::get_magnitude_if_negative(&v42) as u8))))
            } else {
                0x46234ba81f3a5ba6571383233df0f9ea5fe60a3a327537be1f5fec447bced693::ifixed::from_u64(0x7b502c8a7bcb3915892347f11086745570e759fe9708d03c03accf4c90bbf580::i64::get_magnitude_if_positive(&v40) * 0x1::u64::pow(10, (0x7b502c8a7bcb3915892347f11086745570e759fe9708d03c03accf4c90bbf580::i16::get_magnitude_if_positive(&v42) as u8)))
            };
            let v44 = 0x7b502c8a7bcb3915892347f11086745570e759fe9708d03c03accf4c90bbf580::feed::confidence(v36);
            let v45 = if (0x1::option::is_none<0x1::option::Option<0x7b502c8a7bcb3915892347f11086745570e759fe9708d03c03accf4c90bbf580::i64::I64>>(&v44)) {
                0x1::option::none<0x7b502c8a7bcb3915892347f11086745570e759fe9708d03c03accf4c90bbf580::i64::I64>()
            } else {
                0x1::option::extract<0x1::option::Option<0x7b502c8a7bcb3915892347f11086745570e759fe9708d03c03accf4c90bbf580::i64::I64>>(&mut v44)
            };
            let v46 = v45;
            let v47 = if (0x1::option::is_none<0x7b502c8a7bcb3915892347f11086745570e759fe9708d03c03accf4c90bbf580::i64::I64>(&v46)) {
                0xa8172ed2a6f14cd0ee55124326685713d6f765039e7c5339f7a0b57be06fddb5::price_feed::confidence_not_reported_by_source()
            } else {
                let v48 = 0x1::option::extract<0x7b502c8a7bcb3915892347f11086745570e759fe9708d03c03accf4c90bbf580::i64::I64>(&mut v46);
                assert!(!0x7b502c8a7bcb3915892347f11086745570e759fe9708d03c03accf4c90bbf580::i64::get_is_negative(&v48), 4);
                if (0x7b502c8a7bcb3915892347f11086745570e759fe9708d03c03accf4c90bbf580::i16::get_is_negative(&v42)) {
                    0x46234ba81f3a5ba6571383233df0f9ea5fe60a3a327537be1f5fec447bced693::ifixed::div(0x46234ba81f3a5ba6571383233df0f9ea5fe60a3a327537be1f5fec447bced693::ifixed::from_u64(0x7b502c8a7bcb3915892347f11086745570e759fe9708d03c03accf4c90bbf580::i64::get_magnitude_if_positive(&v48)), 0x46234ba81f3a5ba6571383233df0f9ea5fe60a3a327537be1f5fec447bced693::ifixed::from_u64(0x1::u64::pow(10, (0x7b502c8a7bcb3915892347f11086745570e759fe9708d03c03accf4c90bbf580::i16::get_magnitude_if_negative(&v42) as u8))))
                } else {
                    0x46234ba81f3a5ba6571383233df0f9ea5fe60a3a327537be1f5fec447bced693::ifixed::from_u64(0x7b502c8a7bcb3915892347f11086745570e759fe9708d03c03accf4c90bbf580::i64::get_magnitude_if_positive(&v48) * 0x1::u64::pow(10, (0x7b502c8a7bcb3915892347f11086745570e759fe9708d03c03accf4c90bbf580::i16::get_magnitude_if_positive(&v42) as u8)))
                }
            };
            let v49 = 0x7b502c8a7bcb3915892347f11086745570e759fe9708d03c03accf4c90bbf580::feed::market_session(v36);
            let v50 = &v49;
            let v51 = if (0x1::option::is_some<0x7b502c8a7bcb3915892347f11086745570e759fe9708d03c03accf4c90bbf580::market_session::MarketSession>(v50) && 0x7b502c8a7bcb3915892347f11086745570e759fe9708d03c03accf4c90bbf580::market_session::is_closed(0x1::option::borrow<0x7b502c8a7bcb3915892347f11086745570e759fe9708d03c03accf4c90bbf580::market_session::MarketSession>(v50))) {
                0x7b502c8a7bcb3915892347f11086745570e759fe9708d03c03accf4c90bbf580::update::timestamp(arg3) / 1000
            } else {
                let v52 = 0x7b502c8a7bcb3915892347f11086745570e759fe9708d03c03accf4c90bbf580::feed::feed_update_timestamp(v36);
                let v53 = if (0x1::option::is_none<0x1::option::Option<u64>>(&v52)) {
                    0x1::option::none<u64>()
                } else {
                    0x1::option::extract<0x1::option::Option<u64>>(&mut v52)
                };
                let v54 = v53;
                let v55 = if (0x1::option::is_none<u64>(&v54)) {
                    0x7b502c8a7bcb3915892347f11086745570e759fe9708d03c03accf4c90bbf580::update::timestamp(arg3)
                } else {
                    0x1::option::extract<u64>(&mut v54)
                };
                v55 / 1000
            };
            0xa8172ed2a6f14cd0ee55124326685713d6f765039e7c5339f7a0b57be06fddb5::price_feed_storage::update_price_feed<0x6890ed5cf666a6eb6a6ee5a858be7e52f3e1ae3f91a5e2d2baf159e25d0f78b3::feed_info_object::FeedInfoObject>(arg1, arg2, 0x6890ed5cf666a6eb6a6ee5a858be7e52f3e1ae3f91a5e2d2baf159e25d0f78b3::pyth_lazer_rolling::borrow_id(arg0), arg4, v43, v47, v51);
        } else {
            let v56 = 0x7b502c8a7bcb3915892347f11086745570e759fe9708d03c03accf4c90bbf580::update::feeds_ref(arg3);
            let v57 = 0;
            let v58;
            loop {
                assert!(v57 < 0x1::vector::length<0x7b502c8a7bcb3915892347f11086745570e759fe9708d03c03accf4c90bbf580::feed::Feed>(v56), 0);
                v58 = 0x1::vector::borrow<0x7b502c8a7bcb3915892347f11086745570e759fe9708d03c03accf4c90bbf580::feed::Feed>(v56, v57);
                if (0x7b502c8a7bcb3915892347f11086745570e759fe9708d03c03accf4c90bbf580::feed::feed_id(v58) == 0x6890ed5cf666a6eb6a6ee5a858be7e52f3e1ae3f91a5e2d2baf159e25d0f78b3::feed_info_object::current_feed_id(arg4)) {
                    break
                };
                v57 = v57 + 1;
            };
            let v59 = *v58;
            let v60 = 0x7b502c8a7bcb3915892347f11086745570e759fe9708d03c03accf4c90bbf580::update::feeds_ref(arg3);
            let v61 = 0;
            let v62;
            loop {
                assert!(v61 < 0x1::vector::length<0x7b502c8a7bcb3915892347f11086745570e759fe9708d03c03accf4c90bbf580::feed::Feed>(v60), 0);
                v62 = 0x1::vector::borrow<0x7b502c8a7bcb3915892347f11086745570e759fe9708d03c03accf4c90bbf580::feed::Feed>(v60, v61);
                if (0x7b502c8a7bcb3915892347f11086745570e759fe9708d03c03accf4c90bbf580::feed::feed_id(v62) == 0x6890ed5cf666a6eb6a6ee5a858be7e52f3e1ae3f91a5e2d2baf159e25d0f78b3::feed_info_object::next_feed_id(arg4)) {
                    break
                };
                v61 = v61 + 1;
            };
            let v63 = *v62;
            let v64 = &v59;
            let v65 = 0x7b502c8a7bcb3915892347f11086745570e759fe9708d03c03accf4c90bbf580::feed::price(v64);
            let v66 = if (0x1::option::is_none<0x1::option::Option<0x7b502c8a7bcb3915892347f11086745570e759fe9708d03c03accf4c90bbf580::i64::I64>>(&v65)) {
                0x1::option::none<0x7b502c8a7bcb3915892347f11086745570e759fe9708d03c03accf4c90bbf580::i64::I64>()
            } else {
                0x1::option::extract<0x1::option::Option<0x7b502c8a7bcb3915892347f11086745570e759fe9708d03c03accf4c90bbf580::i64::I64>>(&mut v65)
            };
            let v67 = v66;
            if (0x1::option::is_none<0x7b502c8a7bcb3915892347f11086745570e759fe9708d03c03accf4c90bbf580::i64::I64>(&v67)) {
                abort 1
            };
            let v68 = 0x1::option::extract<0x7b502c8a7bcb3915892347f11086745570e759fe9708d03c03accf4c90bbf580::i64::I64>(&mut v67);
            assert!(!0x7b502c8a7bcb3915892347f11086745570e759fe9708d03c03accf4c90bbf580::i64::get_is_negative(&v68), 3);
            let v69 = 0x7b502c8a7bcb3915892347f11086745570e759fe9708d03c03accf4c90bbf580::feed::exponent(v64);
            if (0x1::option::is_none<0x7b502c8a7bcb3915892347f11086745570e759fe9708d03c03accf4c90bbf580::i16::I16>(&v69)) {
                abort 2
            };
            let v70 = 0x1::option::extract<0x7b502c8a7bcb3915892347f11086745570e759fe9708d03c03accf4c90bbf580::i16::I16>(&mut v69);
            let v71 = if (0x7b502c8a7bcb3915892347f11086745570e759fe9708d03c03accf4c90bbf580::i16::get_is_negative(&v70)) {
                0x46234ba81f3a5ba6571383233df0f9ea5fe60a3a327537be1f5fec447bced693::ifixed::div(0x46234ba81f3a5ba6571383233df0f9ea5fe60a3a327537be1f5fec447bced693::ifixed::from_u64(0x7b502c8a7bcb3915892347f11086745570e759fe9708d03c03accf4c90bbf580::i64::get_magnitude_if_positive(&v68)), 0x46234ba81f3a5ba6571383233df0f9ea5fe60a3a327537be1f5fec447bced693::ifixed::from_u64(0x1::u64::pow(10, (0x7b502c8a7bcb3915892347f11086745570e759fe9708d03c03accf4c90bbf580::i16::get_magnitude_if_negative(&v70) as u8))))
            } else {
                0x46234ba81f3a5ba6571383233df0f9ea5fe60a3a327537be1f5fec447bced693::ifixed::from_u64(0x7b502c8a7bcb3915892347f11086745570e759fe9708d03c03accf4c90bbf580::i64::get_magnitude_if_positive(&v68) * 0x1::u64::pow(10, (0x7b502c8a7bcb3915892347f11086745570e759fe9708d03c03accf4c90bbf580::i16::get_magnitude_if_positive(&v70) as u8)))
            };
            let v72 = 0x7b502c8a7bcb3915892347f11086745570e759fe9708d03c03accf4c90bbf580::feed::confidence(v64);
            let v73 = if (0x1::option::is_none<0x1::option::Option<0x7b502c8a7bcb3915892347f11086745570e759fe9708d03c03accf4c90bbf580::i64::I64>>(&v72)) {
                0x1::option::none<0x7b502c8a7bcb3915892347f11086745570e759fe9708d03c03accf4c90bbf580::i64::I64>()
            } else {
                0x1::option::extract<0x1::option::Option<0x7b502c8a7bcb3915892347f11086745570e759fe9708d03c03accf4c90bbf580::i64::I64>>(&mut v72)
            };
            let v74 = v73;
            let v75 = if (0x1::option::is_none<0x7b502c8a7bcb3915892347f11086745570e759fe9708d03c03accf4c90bbf580::i64::I64>(&v74)) {
                0xa8172ed2a6f14cd0ee55124326685713d6f765039e7c5339f7a0b57be06fddb5::price_feed::confidence_not_reported_by_source()
            } else {
                let v76 = 0x1::option::extract<0x7b502c8a7bcb3915892347f11086745570e759fe9708d03c03accf4c90bbf580::i64::I64>(&mut v74);
                assert!(!0x7b502c8a7bcb3915892347f11086745570e759fe9708d03c03accf4c90bbf580::i64::get_is_negative(&v76), 4);
                if (0x7b502c8a7bcb3915892347f11086745570e759fe9708d03c03accf4c90bbf580::i16::get_is_negative(&v70)) {
                    0x46234ba81f3a5ba6571383233df0f9ea5fe60a3a327537be1f5fec447bced693::ifixed::div(0x46234ba81f3a5ba6571383233df0f9ea5fe60a3a327537be1f5fec447bced693::ifixed::from_u64(0x7b502c8a7bcb3915892347f11086745570e759fe9708d03c03accf4c90bbf580::i64::get_magnitude_if_positive(&v76)), 0x46234ba81f3a5ba6571383233df0f9ea5fe60a3a327537be1f5fec447bced693::ifixed::from_u64(0x1::u64::pow(10, (0x7b502c8a7bcb3915892347f11086745570e759fe9708d03c03accf4c90bbf580::i16::get_magnitude_if_negative(&v70) as u8))))
                } else {
                    0x46234ba81f3a5ba6571383233df0f9ea5fe60a3a327537be1f5fec447bced693::ifixed::from_u64(0x7b502c8a7bcb3915892347f11086745570e759fe9708d03c03accf4c90bbf580::i64::get_magnitude_if_positive(&v76) * 0x1::u64::pow(10, (0x7b502c8a7bcb3915892347f11086745570e759fe9708d03c03accf4c90bbf580::i16::get_magnitude_if_positive(&v70) as u8)))
                }
            };
            let v77 = 0x7b502c8a7bcb3915892347f11086745570e759fe9708d03c03accf4c90bbf580::feed::market_session(v64);
            let v78 = &v77;
            let v79 = if (0x1::option::is_some<0x7b502c8a7bcb3915892347f11086745570e759fe9708d03c03accf4c90bbf580::market_session::MarketSession>(v78) && 0x7b502c8a7bcb3915892347f11086745570e759fe9708d03c03accf4c90bbf580::market_session::is_closed(0x1::option::borrow<0x7b502c8a7bcb3915892347f11086745570e759fe9708d03c03accf4c90bbf580::market_session::MarketSession>(v78))) {
                0x7b502c8a7bcb3915892347f11086745570e759fe9708d03c03accf4c90bbf580::update::timestamp(arg3) / 1000
            } else {
                let v80 = 0x7b502c8a7bcb3915892347f11086745570e759fe9708d03c03accf4c90bbf580::feed::feed_update_timestamp(v64);
                let v81 = if (0x1::option::is_none<0x1::option::Option<u64>>(&v80)) {
                    0x1::option::none<u64>()
                } else {
                    0x1::option::extract<0x1::option::Option<u64>>(&mut v80)
                };
                let v82 = v81;
                let v83 = if (0x1::option::is_none<u64>(&v82)) {
                    0x7b502c8a7bcb3915892347f11086745570e759fe9708d03c03accf4c90bbf580::update::timestamp(arg3)
                } else {
                    0x1::option::extract<u64>(&mut v82)
                };
                v83 / 1000
            };
            let v84 = &v63;
            let v85 = 0x7b502c8a7bcb3915892347f11086745570e759fe9708d03c03accf4c90bbf580::feed::price(v84);
            let v86 = if (0x1::option::is_none<0x1::option::Option<0x7b502c8a7bcb3915892347f11086745570e759fe9708d03c03accf4c90bbf580::i64::I64>>(&v85)) {
                0x1::option::none<0x7b502c8a7bcb3915892347f11086745570e759fe9708d03c03accf4c90bbf580::i64::I64>()
            } else {
                0x1::option::extract<0x1::option::Option<0x7b502c8a7bcb3915892347f11086745570e759fe9708d03c03accf4c90bbf580::i64::I64>>(&mut v85)
            };
            let v87 = v86;
            if (0x1::option::is_none<0x7b502c8a7bcb3915892347f11086745570e759fe9708d03c03accf4c90bbf580::i64::I64>(&v87)) {
                abort 1
            };
            let v88 = 0x1::option::extract<0x7b502c8a7bcb3915892347f11086745570e759fe9708d03c03accf4c90bbf580::i64::I64>(&mut v87);
            assert!(!0x7b502c8a7bcb3915892347f11086745570e759fe9708d03c03accf4c90bbf580::i64::get_is_negative(&v88), 3);
            let v89 = 0x7b502c8a7bcb3915892347f11086745570e759fe9708d03c03accf4c90bbf580::feed::exponent(v84);
            if (0x1::option::is_none<0x7b502c8a7bcb3915892347f11086745570e759fe9708d03c03accf4c90bbf580::i16::I16>(&v89)) {
                abort 2
            };
            let v90 = 0x1::option::extract<0x7b502c8a7bcb3915892347f11086745570e759fe9708d03c03accf4c90bbf580::i16::I16>(&mut v89);
            let v91 = if (0x7b502c8a7bcb3915892347f11086745570e759fe9708d03c03accf4c90bbf580::i16::get_is_negative(&v90)) {
                0x46234ba81f3a5ba6571383233df0f9ea5fe60a3a327537be1f5fec447bced693::ifixed::div(0x46234ba81f3a5ba6571383233df0f9ea5fe60a3a327537be1f5fec447bced693::ifixed::from_u64(0x7b502c8a7bcb3915892347f11086745570e759fe9708d03c03accf4c90bbf580::i64::get_magnitude_if_positive(&v88)), 0x46234ba81f3a5ba6571383233df0f9ea5fe60a3a327537be1f5fec447bced693::ifixed::from_u64(0x1::u64::pow(10, (0x7b502c8a7bcb3915892347f11086745570e759fe9708d03c03accf4c90bbf580::i16::get_magnitude_if_negative(&v90) as u8))))
            } else {
                0x46234ba81f3a5ba6571383233df0f9ea5fe60a3a327537be1f5fec447bced693::ifixed::from_u64(0x7b502c8a7bcb3915892347f11086745570e759fe9708d03c03accf4c90bbf580::i64::get_magnitude_if_positive(&v88) * 0x1::u64::pow(10, (0x7b502c8a7bcb3915892347f11086745570e759fe9708d03c03accf4c90bbf580::i16::get_magnitude_if_positive(&v90) as u8)))
            };
            let v92 = 0x7b502c8a7bcb3915892347f11086745570e759fe9708d03c03accf4c90bbf580::feed::confidence(v84);
            let v93 = if (0x1::option::is_none<0x1::option::Option<0x7b502c8a7bcb3915892347f11086745570e759fe9708d03c03accf4c90bbf580::i64::I64>>(&v92)) {
                0x1::option::none<0x7b502c8a7bcb3915892347f11086745570e759fe9708d03c03accf4c90bbf580::i64::I64>()
            } else {
                0x1::option::extract<0x1::option::Option<0x7b502c8a7bcb3915892347f11086745570e759fe9708d03c03accf4c90bbf580::i64::I64>>(&mut v92)
            };
            let v94 = v93;
            let v95 = if (0x1::option::is_none<0x7b502c8a7bcb3915892347f11086745570e759fe9708d03c03accf4c90bbf580::i64::I64>(&v94)) {
                0xa8172ed2a6f14cd0ee55124326685713d6f765039e7c5339f7a0b57be06fddb5::price_feed::confidence_not_reported_by_source()
            } else {
                let v96 = 0x1::option::extract<0x7b502c8a7bcb3915892347f11086745570e759fe9708d03c03accf4c90bbf580::i64::I64>(&mut v94);
                assert!(!0x7b502c8a7bcb3915892347f11086745570e759fe9708d03c03accf4c90bbf580::i64::get_is_negative(&v96), 4);
                if (0x7b502c8a7bcb3915892347f11086745570e759fe9708d03c03accf4c90bbf580::i16::get_is_negative(&v90)) {
                    0x46234ba81f3a5ba6571383233df0f9ea5fe60a3a327537be1f5fec447bced693::ifixed::div(0x46234ba81f3a5ba6571383233df0f9ea5fe60a3a327537be1f5fec447bced693::ifixed::from_u64(0x7b502c8a7bcb3915892347f11086745570e759fe9708d03c03accf4c90bbf580::i64::get_magnitude_if_positive(&v96)), 0x46234ba81f3a5ba6571383233df0f9ea5fe60a3a327537be1f5fec447bced693::ifixed::from_u64(0x1::u64::pow(10, (0x7b502c8a7bcb3915892347f11086745570e759fe9708d03c03accf4c90bbf580::i16::get_magnitude_if_negative(&v90) as u8))))
                } else {
                    0x46234ba81f3a5ba6571383233df0f9ea5fe60a3a327537be1f5fec447bced693::ifixed::from_u64(0x7b502c8a7bcb3915892347f11086745570e759fe9708d03c03accf4c90bbf580::i64::get_magnitude_if_positive(&v96) * 0x1::u64::pow(10, (0x7b502c8a7bcb3915892347f11086745570e759fe9708d03c03accf4c90bbf580::i16::get_magnitude_if_positive(&v90) as u8)))
                }
            };
            let v97 = 0x7b502c8a7bcb3915892347f11086745570e759fe9708d03c03accf4c90bbf580::feed::market_session(v84);
            let v98 = &v97;
            let v99 = if (0x1::option::is_some<0x7b502c8a7bcb3915892347f11086745570e759fe9708d03c03accf4c90bbf580::market_session::MarketSession>(v98) && 0x7b502c8a7bcb3915892347f11086745570e759fe9708d03c03accf4c90bbf580::market_session::is_closed(0x1::option::borrow<0x7b502c8a7bcb3915892347f11086745570e759fe9708d03c03accf4c90bbf580::market_session::MarketSession>(v98))) {
                0x7b502c8a7bcb3915892347f11086745570e759fe9708d03c03accf4c90bbf580::update::timestamp(arg3) / 1000
            } else {
                let v100 = 0x7b502c8a7bcb3915892347f11086745570e759fe9708d03c03accf4c90bbf580::feed::feed_update_timestamp(v84);
                let v101 = if (0x1::option::is_none<0x1::option::Option<u64>>(&v100)) {
                    0x1::option::none<u64>()
                } else {
                    0x1::option::extract<0x1::option::Option<u64>>(&mut v100)
                };
                let v102 = v101;
                let v103 = if (0x1::option::is_none<u64>(&v102)) {
                    0x7b502c8a7bcb3915892347f11086745570e759fe9708d03c03accf4c90bbf580::update::timestamp(arg3)
                } else {
                    0x1::option::extract<u64>(&mut v102)
                };
                v103 / 1000
            };
            let v104 = if (v79 > v99) {
                v79
            } else {
                v99
            };
            0xa8172ed2a6f14cd0ee55124326685713d6f765039e7c5339f7a0b57be06fddb5::price_feed_storage::update_price_feed<0x6890ed5cf666a6eb6a6ee5a858be7e52f3e1ae3f91a5e2d2baf159e25d0f78b3::feed_info_object::FeedInfoObject>(arg1, arg2, 0x6890ed5cf666a6eb6a6ee5a858be7e52f3e1ae3f91a5e2d2baf159e25d0f78b3::pyth_lazer_rolling::borrow_id(arg0), arg4, 0x46234ba81f3a5ba6571383233df0f9ea5fe60a3a327537be1f5fec447bced693::ifixed::add(0x46234ba81f3a5ba6571383233df0f9ea5fe60a3a327537be1f5fec447bced693::ifixed::mul(v5, v71), 0x46234ba81f3a5ba6571383233df0f9ea5fe60a3a327537be1f5fec447bced693::ifixed::mul(v6, v91)), 0x46234ba81f3a5ba6571383233df0f9ea5fe60a3a327537be1f5fec447bced693::ifixed::add(0x46234ba81f3a5ba6571383233df0f9ea5fe60a3a327537be1f5fec447bced693::ifixed::mul(v5, v75), 0x46234ba81f3a5ba6571383233df0f9ea5fe60a3a327537be1f5fec447bced693::ifixed::mul(v6, v95)), v104);
        };
    }

    // decompiled from Move bytecode v6
}

