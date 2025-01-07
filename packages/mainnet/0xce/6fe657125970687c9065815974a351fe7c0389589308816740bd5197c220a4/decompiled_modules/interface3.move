module 0xd4e097d82d73dc5d152f277bd17ba7980cad4c0b238c3609517cbd0cf686ddd1::interface3 {
    public fun collect_fees_3<T0, T1, T2>(arg0: &mut 0xd4e097d82d73dc5d152f277bd17ba7980cad4c0b238c3609517cbd0cf686ddd1::ramm::RAMM, arg1: &0xd4e097d82d73dc5d152f277bd17ba7980cad4c0b238c3609517cbd0cf686ddd1::ramm::RAMMAdminCap, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(0xd4e097d82d73dc5d152f277bd17ba7980cad4c0b238c3609517cbd0cf686ddd1::ramm::get_admin_cap_id(arg0) == 0x2::object::id<0xd4e097d82d73dc5d152f277bd17ba7980cad4c0b238c3609517cbd0cf686ddd1::ramm::RAMMAdminCap>(arg1), 12);
        assert!(0xd4e097d82d73dc5d152f277bd17ba7980cad4c0b238c3609517cbd0cf686ddd1::ramm::get_asset_count(arg0) == 3, 0);
        let v0 = 0x2::coin::from_balance<T0>(0xd4e097d82d73dc5d152f277bd17ba7980cad4c0b238c3609517cbd0cf686ddd1::ramm::get_fees_for_asset<T0>(arg0, 0xd4e097d82d73dc5d152f277bd17ba7980cad4c0b238c3609517cbd0cf686ddd1::ramm::get_asset_index<T0>(arg0)), arg2);
        let v1 = 0x2::coin::from_balance<T1>(0xd4e097d82d73dc5d152f277bd17ba7980cad4c0b238c3609517cbd0cf686ddd1::ramm::get_fees_for_asset<T1>(arg0, 0xd4e097d82d73dc5d152f277bd17ba7980cad4c0b238c3609517cbd0cf686ddd1::ramm::get_asset_index<T1>(arg0)), arg2);
        let v2 = 0x2::coin::from_balance<T2>(0xd4e097d82d73dc5d152f277bd17ba7980cad4c0b238c3609517cbd0cf686ddd1::ramm::get_fees_for_asset<T2>(arg0, 0xd4e097d82d73dc5d152f277bd17ba7980cad4c0b238c3609517cbd0cf686ddd1::ramm::get_asset_index<T2>(arg0)), arg2);
        let v3 = 0x2::coin::value<T0>(&v0);
        let v4 = 0x2::coin::value<T1>(&v1);
        let v5 = 0x2::coin::value<T2>(&v2);
        let v6 = 0x2::vec_map::empty<0x1::type_name::TypeName, u64>();
        0x2::vec_map::insert<0x1::type_name::TypeName, u64>(&mut v6, 0x1::type_name::get<T0>(), v3);
        0x2::vec_map::insert<0x1::type_name::TypeName, u64>(&mut v6, 0x1::type_name::get<T1>(), v4);
        0x2::vec_map::insert<0x1::type_name::TypeName, u64>(&mut v6, 0x1::type_name::get<T2>(), v5);
        let v7 = 0xd4e097d82d73dc5d152f277bd17ba7980cad4c0b238c3609517cbd0cf686ddd1::ramm::get_fee_collector(arg0);
        if (v3 > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(v0, v7);
        } else {
            0x2::coin::destroy_zero<T0>(v0);
        };
        if (v4 > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(v1, v7);
        } else {
            0x2::coin::destroy_zero<T1>(v1);
        };
        if (v5 > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<T2>>(v2, v7);
        } else {
            0x2::coin::destroy_zero<T2>(v2);
        };
        0xd4e097d82d73dc5d152f277bd17ba7980cad4c0b238c3609517cbd0cf686ddd1::events::fee_collection_event(0xd4e097d82d73dc5d152f277bd17ba7980cad4c0b238c3609517cbd0cf686ddd1::ramm::get_id(arg0), 0x2::tx_context::sender(arg2), v7, v6);
        0xd4e097d82d73dc5d152f277bd17ba7980cad4c0b238c3609517cbd0cf686ddd1::ramm::check_ramm_invariants_3<T0, T1, T2>(arg0);
    }

    public fun imbalance_ratios_event_3<T0, T1, T2>(arg0: &0xd4e097d82d73dc5d152f277bd17ba7980cad4c0b238c3609517cbd0cf686ddd1::ramm::RAMM, arg1: &0x2::clock::Clock, arg2: &0x8d79f4d920b03d88faca1e421af023a87fbb1e4a6fd200248e6e9998d09e470::aggregator::Aggregator, arg3: &0x8d79f4d920b03d88faca1e421af023a87fbb1e4a6fd200248e6e9998d09e470::aggregator::Aggregator, arg4: &0x8d79f4d920b03d88faca1e421af023a87fbb1e4a6fd200248e6e9998d09e470::aggregator::Aggregator, arg5: &0x2::tx_context::TxContext) {
        assert!(0xd4e097d82d73dc5d152f277bd17ba7980cad4c0b238c3609517cbd0cf686ddd1::ramm::get_asset_count(arg0) == 3, 0);
        let v0 = 0xd4e097d82d73dc5d152f277bd17ba7980cad4c0b238c3609517cbd0cf686ddd1::ramm::get_asset_index<T0>(arg0);
        let v1 = 0xd4e097d82d73dc5d152f277bd17ba7980cad4c0b238c3609517cbd0cf686ddd1::ramm::get_asset_index<T1>(arg0);
        let v2 = 0xd4e097d82d73dc5d152f277bd17ba7980cad4c0b238c3609517cbd0cf686ddd1::ramm::get_asset_index<T2>(arg0);
        let v3 = 0x2::clock::timestamp_ms(arg1);
        let v4 = 0x2::vec_map::empty<u8, u256>();
        let v5 = 0x2::vec_map::empty<u8, u256>();
        let v6 = 0x2::vec_map::empty<u8, u64>();
        0xd4e097d82d73dc5d152f277bd17ba7980cad4c0b238c3609517cbd0cf686ddd1::ramm::check_feed_and_get_price_data(arg0, v3, v0, arg2, &mut v4, &mut v5, &mut v6);
        0xd4e097d82d73dc5d152f277bd17ba7980cad4c0b238c3609517cbd0cf686ddd1::ramm::check_feed_and_get_price_data(arg0, v3, v1, arg3, &mut v4, &mut v5, &mut v6);
        0xd4e097d82d73dc5d152f277bd17ba7980cad4c0b238c3609517cbd0cf686ddd1::ramm::check_feed_and_get_price_data(arg0, v3, v2, arg4, &mut v4, &mut v5, &mut v6);
        let v7 = 0xd4e097d82d73dc5d152f277bd17ba7980cad4c0b238c3609517cbd0cf686ddd1::ramm::imbalance_ratios(arg0, &v4, &v5);
        let v8 = 0x2::vec_map::empty<0x1::type_name::TypeName, u64>();
        0x2::vec_map::insert<0x1::type_name::TypeName, u64>(&mut v8, 0x1::type_name::get<T0>(), (*0x2::vec_map::get<u8, u256>(&v7, &v0) as u64));
        0x2::vec_map::insert<0x1::type_name::TypeName, u64>(&mut v8, 0x1::type_name::get<T1>(), (*0x2::vec_map::get<u8, u256>(&v7, &v1) as u64));
        0x2::vec_map::insert<0x1::type_name::TypeName, u64>(&mut v8, 0x1::type_name::get<T2>(), (*0x2::vec_map::get<u8, u256>(&v7, &v2) as u64));
        0xd4e097d82d73dc5d152f277bd17ba7980cad4c0b238c3609517cbd0cf686ddd1::events::imbalance_ratios_event(0xd4e097d82d73dc5d152f277bd17ba7980cad4c0b238c3609517cbd0cf686ddd1::ramm::get_id(arg0), 0x2::tx_context::sender(arg5), v8);
    }

    public fun liquidity_deposit_3<T0, T1, T2>(arg0: &mut 0xd4e097d82d73dc5d152f277bd17ba7980cad4c0b238c3609517cbd0cf686ddd1::ramm::RAMM, arg1: &0x2::clock::Clock, arg2: 0x2::coin::Coin<T0>, arg3: &0x8d79f4d920b03d88faca1e421af023a87fbb1e4a6fd200248e6e9998d09e470::aggregator::Aggregator, arg4: &0x8d79f4d920b03d88faca1e421af023a87fbb1e4a6fd200248e6e9998d09e470::aggregator::Aggregator, arg5: &0x8d79f4d920b03d88faca1e421af023a87fbb1e4a6fd200248e6e9998d09e470::aggregator::Aggregator, arg6: &mut 0x2::tx_context::TxContext) {
        assert!(0xd4e097d82d73dc5d152f277bd17ba7980cad4c0b238c3609517cbd0cf686ddd1::ramm::get_asset_count(arg0) == 3, 0);
        assert!(0x2::coin::value<T0>(&arg2) > 0, 2);
        let v0 = 0xd4e097d82d73dc5d152f277bd17ba7980cad4c0b238c3609517cbd0cf686ddd1::ramm::get_asset_index<T0>(arg0);
        assert!(0xd4e097d82d73dc5d152f277bd17ba7980cad4c0b238c3609517cbd0cf686ddd1::ramm::can_deposit_asset(arg0, v0), 1);
        let v1 = 0xd4e097d82d73dc5d152f277bd17ba7980cad4c0b238c3609517cbd0cf686ddd1::ramm::get_asset_index<T1>(arg0);
        let v2 = 0xd4e097d82d73dc5d152f277bd17ba7980cad4c0b238c3609517cbd0cf686ddd1::ramm::get_asset_index<T2>(arg0);
        let v3 = 0x2::clock::timestamp_ms(arg1);
        let v4 = 0x2::vec_map::empty<u8, u256>();
        let v5 = 0x2::vec_map::empty<u8, u256>();
        let v6 = 0x2::vec_map::empty<u8, u64>();
        0xd4e097d82d73dc5d152f277bd17ba7980cad4c0b238c3609517cbd0cf686ddd1::ramm::check_feed_and_get_price_data(arg0, v3, v0, arg3, &mut v4, &mut v5, &mut v6);
        0xd4e097d82d73dc5d152f277bd17ba7980cad4c0b238c3609517cbd0cf686ddd1::ramm::check_feed_and_get_price_data(arg0, v3, v1, arg4, &mut v4, &mut v5, &mut v6);
        0xd4e097d82d73dc5d152f277bd17ba7980cad4c0b238c3609517cbd0cf686ddd1::ramm::check_feed_and_get_price_data(arg0, v3, v2, arg5, &mut v4, &mut v5, &mut v6);
        let v7 = 0xd4e097d82d73dc5d152f277bd17ba7980cad4c0b238c3609517cbd0cf686ddd1::ramm::liq_dep<T0>(arg0, v0, 0x2::coin::value<T0>(&arg2), v4, v5);
        let v8 = *0x2::vec_map::get<u8, u256>(&v4, &v0);
        let v9 = *0x2::vec_map::get<u8, u64>(&v6, &v0);
        let v10 = *0x2::vec_map::get<u8, u256>(&v4, &v1);
        let v11 = *0x2::vec_map::get<u8, u64>(&v6, &v1);
        let v12 = *0x2::vec_map::get<u8, u256>(&v4, &v2);
        let v13 = *0x2::vec_map::get<u8, u64>(&v6, &v2);
        0xd4e097d82d73dc5d152f277bd17ba7980cad4c0b238c3609517cbd0cf686ddd1::ramm::update_volatility_data(arg0, v0, 0xd4e097d82d73dc5d152f277bd17ba7980cad4c0b238c3609517cbd0cf686ddd1::ramm::get_prev_prc(arg0, v0), 0xd4e097d82d73dc5d152f277bd17ba7980cad4c0b238c3609517cbd0cf686ddd1::ramm::get_prev_prc_tmstmp(arg0, v0), v8, v9, 0xd4e097d82d73dc5d152f277bd17ba7980cad4c0b238c3609517cbd0cf686ddd1::ramm::compute_volatility_fee(arg0, v0, *0x2::vec_map::get<u8, u256>(&v4, &v0), *0x2::vec_map::get<u8, u64>(&v6, &v0)));
        0xd4e097d82d73dc5d152f277bd17ba7980cad4c0b238c3609517cbd0cf686ddd1::ramm::update_volatility_data(arg0, v1, 0xd4e097d82d73dc5d152f277bd17ba7980cad4c0b238c3609517cbd0cf686ddd1::ramm::get_prev_prc(arg0, v1), 0xd4e097d82d73dc5d152f277bd17ba7980cad4c0b238c3609517cbd0cf686ddd1::ramm::get_prev_prc_tmstmp(arg0, v1), v10, v11, 0xd4e097d82d73dc5d152f277bd17ba7980cad4c0b238c3609517cbd0cf686ddd1::ramm::compute_volatility_fee(arg0, v1, *0x2::vec_map::get<u8, u256>(&v4, &v1), *0x2::vec_map::get<u8, u64>(&v6, &v1)));
        0xd4e097d82d73dc5d152f277bd17ba7980cad4c0b238c3609517cbd0cf686ddd1::ramm::update_volatility_data(arg0, v2, 0xd4e097d82d73dc5d152f277bd17ba7980cad4c0b238c3609517cbd0cf686ddd1::ramm::get_prev_prc(arg0, v2), 0xd4e097d82d73dc5d152f277bd17ba7980cad4c0b238c3609517cbd0cf686ddd1::ramm::get_prev_prc_tmstmp(arg0, v2), v12, v13, 0xd4e097d82d73dc5d152f277bd17ba7980cad4c0b238c3609517cbd0cf686ddd1::ramm::compute_volatility_fee(arg0, v2, *0x2::vec_map::get<u8, u256>(&v4, &v2), *0x2::vec_map::get<u8, u64>(&v6, &v2)));
        0xd4e097d82d73dc5d152f277bd17ba7980cad4c0b238c3609517cbd0cf686ddd1::ramm::update_pricing_data<T0>(arg0, v8, v9);
        0xd4e097d82d73dc5d152f277bd17ba7980cad4c0b238c3609517cbd0cf686ddd1::ramm::update_pricing_data<T1>(arg0, v10, v11);
        0xd4e097d82d73dc5d152f277bd17ba7980cad4c0b238c3609517cbd0cf686ddd1::ramm::update_pricing_data<T2>(arg0, v12, v13);
        if (v7 == 0) {
            abort 13
        };
        let v14 = 0x2::coin::into_balance<T0>(arg2);
        0xd4e097d82d73dc5d152f277bd17ba7980cad4c0b238c3609517cbd0cf686ddd1::ramm::join_bal(arg0, v0, (0x2::balance::value<T0>(&v14) as u256));
        0xd4e097d82d73dc5d152f277bd17ba7980cad4c0b238c3609517cbd0cf686ddd1::ramm::join_typed_bal<T0>(arg0, v0, v14);
        0xd4e097d82d73dc5d152f277bd17ba7980cad4c0b238c3609517cbd0cf686ddd1::ramm::incr_lptokens_issued<T0>(arg0, v7);
        let v15 = 0x2::coin::from_balance<0xd4e097d82d73dc5d152f277bd17ba7980cad4c0b238c3609517cbd0cf686ddd1::ramm::LP<T0>>(0xd4e097d82d73dc5d152f277bd17ba7980cad4c0b238c3609517cbd0cf686ddd1::ramm::mint_lp_tokens<T0>(arg0, v7), arg6);
        0x2::transfer::public_transfer<0x2::coin::Coin<0xd4e097d82d73dc5d152f277bd17ba7980cad4c0b238c3609517cbd0cf686ddd1::ramm::LP<T0>>>(v15, 0x2::tx_context::sender(arg6));
        0xd4e097d82d73dc5d152f277bd17ba7980cad4c0b238c3609517cbd0cf686ddd1::events::liquidity_deposit_event(0xd4e097d82d73dc5d152f277bd17ba7980cad4c0b238c3609517cbd0cf686ddd1::ramm::get_id(arg0), 0x2::tx_context::sender(arg6), 0x1::type_name::get<T0>(), 0x2::coin::value<T0>(&arg2), 0x2::coin::value<0xd4e097d82d73dc5d152f277bd17ba7980cad4c0b238c3609517cbd0cf686ddd1::ramm::LP<T0>>(&v15));
        0xd4e097d82d73dc5d152f277bd17ba7980cad4c0b238c3609517cbd0cf686ddd1::ramm::check_ramm_invariants_3<T0, T1, T2>(arg0);
    }

    public fun liquidity_withdrawal_3<T0, T1, T2, T3>(arg0: &mut 0xd4e097d82d73dc5d152f277bd17ba7980cad4c0b238c3609517cbd0cf686ddd1::ramm::RAMM, arg1: &0x2::clock::Clock, arg2: 0x2::coin::Coin<0xd4e097d82d73dc5d152f277bd17ba7980cad4c0b238c3609517cbd0cf686ddd1::ramm::LP<T3>>, arg3: &0x8d79f4d920b03d88faca1e421af023a87fbb1e4a6fd200248e6e9998d09e470::aggregator::Aggregator, arg4: &0x8d79f4d920b03d88faca1e421af023a87fbb1e4a6fd200248e6e9998d09e470::aggregator::Aggregator, arg5: &0x8d79f4d920b03d88faca1e421af023a87fbb1e4a6fd200248e6e9998d09e470::aggregator::Aggregator, arg6: &mut 0x2::tx_context::TxContext) {
        assert!(0xd4e097d82d73dc5d152f277bd17ba7980cad4c0b238c3609517cbd0cf686ddd1::ramm::get_asset_count(arg0) == 3, 0);
        assert!(0x2::coin::value<0xd4e097d82d73dc5d152f277bd17ba7980cad4c0b238c3609517cbd0cf686ddd1::ramm::LP<T3>>(&arg2) > 0, 15);
        let v0 = 0xd4e097d82d73dc5d152f277bd17ba7980cad4c0b238c3609517cbd0cf686ddd1::ramm::get_asset_index<T0>(arg0);
        let v1 = 0xd4e097d82d73dc5d152f277bd17ba7980cad4c0b238c3609517cbd0cf686ddd1::ramm::get_asset_index<T1>(arg0);
        let v2 = 0xd4e097d82d73dc5d152f277bd17ba7980cad4c0b238c3609517cbd0cf686ddd1::ramm::get_asset_index<T2>(arg0);
        let v3 = 0xd4e097d82d73dc5d152f277bd17ba7980cad4c0b238c3609517cbd0cf686ddd1::ramm::get_asset_index<T3>(arg0);
        let v4 = 0x2::clock::timestamp_ms(arg1);
        let v5 = 0x2::vec_map::empty<u8, u256>();
        let v6 = 0x2::vec_map::empty<u8, u256>();
        let v7 = 0x2::vec_map::empty<u8, u64>();
        0xd4e097d82d73dc5d152f277bd17ba7980cad4c0b238c3609517cbd0cf686ddd1::ramm::check_feed_and_get_price_data(arg0, v4, v0, arg3, &mut v5, &mut v6, &mut v7);
        0xd4e097d82d73dc5d152f277bd17ba7980cad4c0b238c3609517cbd0cf686ddd1::ramm::check_feed_and_get_price_data(arg0, v4, v1, arg4, &mut v5, &mut v6, &mut v7);
        0xd4e097d82d73dc5d152f277bd17ba7980cad4c0b238c3609517cbd0cf686ddd1::ramm::check_feed_and_get_price_data(arg0, v4, v2, arg5, &mut v5, &mut v6, &mut v7);
        let v8 = 0xd4e097d82d73dc5d152f277bd17ba7980cad4c0b238c3609517cbd0cf686ddd1::ramm::compute_volatility_fee(arg0, v0, *0x2::vec_map::get<u8, u256>(&v5, &v0), *0x2::vec_map::get<u8, u64>(&v7, &v0));
        let v9 = 0xd4e097d82d73dc5d152f277bd17ba7980cad4c0b238c3609517cbd0cf686ddd1::ramm::compute_volatility_fee(arg0, v1, *0x2::vec_map::get<u8, u256>(&v5, &v1), *0x2::vec_map::get<u8, u64>(&v7, &v1));
        let v10 = 0xd4e097d82d73dc5d152f277bd17ba7980cad4c0b238c3609517cbd0cf686ddd1::ramm::compute_volatility_fee(arg0, v2, *0x2::vec_map::get<u8, u256>(&v5, &v2), *0x2::vec_map::get<u8, u64>(&v7, &v2));
        let v11 = 0x2::vec_map::empty<u8, u256>();
        0x2::vec_map::insert<u8, u256>(&mut v11, v0, v8);
        0x2::vec_map::insert<u8, u256>(&mut v11, v1, v9);
        0x2::vec_map::insert<u8, u256>(&mut v11, v2, v10);
        let v12 = 0x2::coin::value<0xd4e097d82d73dc5d152f277bd17ba7980cad4c0b238c3609517cbd0cf686ddd1::ramm::LP<T3>>(&arg2);
        let v13 = 0xd4e097d82d73dc5d152f277bd17ba7980cad4c0b238c3609517cbd0cf686ddd1::ramm::get_fact_for_bal(arg0, v3);
        let v14 = 0xd4e097d82d73dc5d152f277bd17ba7980cad4c0b238c3609517cbd0cf686ddd1::ramm::liq_wthdrw<T3>(arg0, v3, v12, v5, v6, v11);
        let v15 = *0x2::vec_map::get<u8, u256>(&v5, &v0);
        let v16 = *0x2::vec_map::get<u8, u64>(&v7, &v0);
        let v17 = *0x2::vec_map::get<u8, u256>(&v5, &v1);
        let v18 = *0x2::vec_map::get<u8, u64>(&v7, &v1);
        let v19 = *0x2::vec_map::get<u8, u256>(&v5, &v2);
        let v20 = *0x2::vec_map::get<u8, u64>(&v7, &v2);
        0xd4e097d82d73dc5d152f277bd17ba7980cad4c0b238c3609517cbd0cf686ddd1::ramm::update_volatility_data(arg0, v0, 0xd4e097d82d73dc5d152f277bd17ba7980cad4c0b238c3609517cbd0cf686ddd1::ramm::get_prev_prc(arg0, v0), 0xd4e097d82d73dc5d152f277bd17ba7980cad4c0b238c3609517cbd0cf686ddd1::ramm::get_prev_prc_tmstmp(arg0, v0), v15, v16, v8);
        0xd4e097d82d73dc5d152f277bd17ba7980cad4c0b238c3609517cbd0cf686ddd1::ramm::update_volatility_data(arg0, v1, 0xd4e097d82d73dc5d152f277bd17ba7980cad4c0b238c3609517cbd0cf686ddd1::ramm::get_prev_prc(arg0, v1), 0xd4e097d82d73dc5d152f277bd17ba7980cad4c0b238c3609517cbd0cf686ddd1::ramm::get_prev_prc_tmstmp(arg0, v1), v17, v18, v9);
        0xd4e097d82d73dc5d152f277bd17ba7980cad4c0b238c3609517cbd0cf686ddd1::ramm::update_volatility_data(arg0, v2, 0xd4e097d82d73dc5d152f277bd17ba7980cad4c0b238c3609517cbd0cf686ddd1::ramm::get_prev_prc(arg0, v2), 0xd4e097d82d73dc5d152f277bd17ba7980cad4c0b238c3609517cbd0cf686ddd1::ramm::get_prev_prc_tmstmp(arg0, v2), v19, v20, v10);
        0xd4e097d82d73dc5d152f277bd17ba7980cad4c0b238c3609517cbd0cf686ddd1::ramm::update_pricing_data<T0>(arg0, v15, v16);
        0xd4e097d82d73dc5d152f277bd17ba7980cad4c0b238c3609517cbd0cf686ddd1::ramm::update_pricing_data<T1>(arg0, v17, v18);
        0xd4e097d82d73dc5d152f277bd17ba7980cad4c0b238c3609517cbd0cf686ddd1::ramm::update_pricing_data<T2>(arg0, v19, v20);
        let v21 = (v12 as u256);
        let v22 = &mut v21;
        if (0xd4e097d82d73dc5d152f277bd17ba7980cad4c0b238c3609517cbd0cf686ddd1::ramm::remaining(&v14) > 0) {
            *v22 = 0xd4e097d82d73dc5d152f277bd17ba7980cad4c0b238c3609517cbd0cf686ddd1::ramm::div(0xd4e097d82d73dc5d152f277bd17ba7980cad4c0b238c3609517cbd0cf686ddd1::ramm::mul(v21 * 1000, (0xd4e097d82d73dc5d152f277bd17ba7980cad4c0b238c3609517cbd0cf686ddd1::ramm::value(&v14) - 0xd4e097d82d73dc5d152f277bd17ba7980cad4c0b238c3609517cbd0cf686ddd1::ramm::remaining(&v14)) * v13), 0xd4e097d82d73dc5d152f277bd17ba7980cad4c0b238c3609517cbd0cf686ddd1::ramm::value(&v14) * v13) / 1000;
        };
        let v23 = (*v22 as u64);
        let v24 = 0x2::coin::into_balance<0xd4e097d82d73dc5d152f277bd17ba7980cad4c0b238c3609517cbd0cf686ddd1::ramm::LP<T3>>(arg2);
        0xd4e097d82d73dc5d152f277bd17ba7980cad4c0b238c3609517cbd0cf686ddd1::ramm::decr_lptokens_issued<T3>(arg0, v23);
        assert!(0xd4e097d82d73dc5d152f277bd17ba7980cad4c0b238c3609517cbd0cf686ddd1::ramm::burn_lp_tokens<T3>(arg0, 0x2::balance::split<0xd4e097d82d73dc5d152f277bd17ba7980cad4c0b238c3609517cbd0cf686ddd1::ramm::LP<T3>>(&mut v24, v23)) == v23, 14);
        if (0x2::balance::value<0xd4e097d82d73dc5d152f277bd17ba7980cad4c0b238c3609517cbd0cf686ddd1::ramm::LP<T3>>(&v24) == 0) {
            0x2::balance::destroy_zero<0xd4e097d82d73dc5d152f277bd17ba7980cad4c0b238c3609517cbd0cf686ddd1::ramm::LP<T3>>(v24);
        } else {
            0x2::transfer::public_transfer<0x2::coin::Coin<0xd4e097d82d73dc5d152f277bd17ba7980cad4c0b238c3609517cbd0cf686ddd1::ramm::LP<T3>>>(0x2::coin::from_balance<0xd4e097d82d73dc5d152f277bd17ba7980cad4c0b238c3609517cbd0cf686ddd1::ramm::LP<T3>>(v24, arg6), 0x2::tx_context::sender(arg6));
        };
        let v25 = 0xd4e097d82d73dc5d152f277bd17ba7980cad4c0b238c3609517cbd0cf686ddd1::ramm::amounts(&v14);
        let v26 = 0xd4e097d82d73dc5d152f277bd17ba7980cad4c0b238c3609517cbd0cf686ddd1::ramm::fees(&v14);
        let v27 = *0x2::vec_map::get<u8, u256>(&v25, &v0);
        if (v27 != 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0xd4e097d82d73dc5d152f277bd17ba7980cad4c0b238c3609517cbd0cf686ddd1::ramm::liq_withdraw_helper<T0>(arg0, v0, v27, *0x2::vec_map::get<u8, u256>(&v26, &v0), arg6), 0x2::tx_context::sender(arg6));
        };
        let v28 = *0x2::vec_map::get<u8, u256>(&v25, &v1);
        if (v28 != 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(0xd4e097d82d73dc5d152f277bd17ba7980cad4c0b238c3609517cbd0cf686ddd1::ramm::liq_withdraw_helper<T1>(arg0, v1, v28, *0x2::vec_map::get<u8, u256>(&v26, &v1), arg6), 0x2::tx_context::sender(arg6));
        };
        let v29 = *0x2::vec_map::get<u8, u256>(&v25, &v2);
        if (v29 != 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<T2>>(0xd4e097d82d73dc5d152f277bd17ba7980cad4c0b238c3609517cbd0cf686ddd1::ramm::liq_withdraw_helper<T2>(arg0, v2, v29, *0x2::vec_map::get<u8, u256>(&v26, &v2), arg6), 0x2::tx_context::sender(arg6));
        };
        let v30 = 0x2::vec_map::empty<0x1::type_name::TypeName, u64>();
        let v31 = 0x2::vec_map::empty<0x1::type_name::TypeName, u64>();
        0x2::vec_map::insert<0x1::type_name::TypeName, u64>(&mut v30, 0x1::type_name::get<T0>(), (*0x2::vec_map::get<u8, u256>(&v25, &v0) as u64));
        0x2::vec_map::insert<0x1::type_name::TypeName, u64>(&mut v31, 0x1::type_name::get<T0>(), (*0x2::vec_map::get<u8, u256>(&v26, &v0) as u64));
        if (0x2::vec_map::contains<u8, u256>(&v25, &v1)) {
            0x2::vec_map::insert<0x1::type_name::TypeName, u64>(&mut v30, 0x1::type_name::get<T1>(), (*0x2::vec_map::get<u8, u256>(&v25, &v1) as u64));
            0x2::vec_map::insert<0x1::type_name::TypeName, u64>(&mut v31, 0x1::type_name::get<T1>(), (*0x2::vec_map::get<u8, u256>(&v26, &v1) as u64));
        };
        if (0x2::vec_map::contains<u8, u256>(&v25, &v2)) {
            0x2::vec_map::insert<0x1::type_name::TypeName, u64>(&mut v30, 0x1::type_name::get<T2>(), (*0x2::vec_map::get<u8, u256>(&v25, &v2) as u64));
            0x2::vec_map::insert<0x1::type_name::TypeName, u64>(&mut v31, 0x1::type_name::get<T2>(), (*0x2::vec_map::get<u8, u256>(&v26, &v2) as u64));
        };
        0xd4e097d82d73dc5d152f277bd17ba7980cad4c0b238c3609517cbd0cf686ddd1::events::liquidity_withdrawal_event(0xd4e097d82d73dc5d152f277bd17ba7980cad4c0b238c3609517cbd0cf686ddd1::ramm::get_id(arg0), 0x2::tx_context::sender(arg6), 0x1::type_name::get<T3>(), v12, v30, v31);
        0xd4e097d82d73dc5d152f277bd17ba7980cad4c0b238c3609517cbd0cf686ddd1::ramm::check_ramm_invariants_3<T0, T1, T2>(arg0);
    }

    public fun trade_amount_in_3<T0, T1, T2>(arg0: &mut 0xd4e097d82d73dc5d152f277bd17ba7980cad4c0b238c3609517cbd0cf686ddd1::ramm::RAMM, arg1: &0x2::clock::Clock, arg2: 0x2::coin::Coin<T0>, arg3: u64, arg4: &0x8d79f4d920b03d88faca1e421af023a87fbb1e4a6fd200248e6e9998d09e470::aggregator::Aggregator, arg5: &0x8d79f4d920b03d88faca1e421af023a87fbb1e4a6fd200248e6e9998d09e470::aggregator::Aggregator, arg6: &0x8d79f4d920b03d88faca1e421af023a87fbb1e4a6fd200248e6e9998d09e470::aggregator::Aggregator, arg7: &mut 0x2::tx_context::TxContext) {
        assert!(0xd4e097d82d73dc5d152f277bd17ba7980cad4c0b238c3609517cbd0cf686ddd1::ramm::get_asset_count(arg0) == 3, 0);
        let v0 = 0xd4e097d82d73dc5d152f277bd17ba7980cad4c0b238c3609517cbd0cf686ddd1::ramm::get_asset_index<T0>(arg0);
        assert!(0x2::coin::value<T0>(&arg2) >= 0xd4e097d82d73dc5d152f277bd17ba7980cad4c0b238c3609517cbd0cf686ddd1::ramm::get_min_trade_amount(arg0, v0), 11);
        assert!(0xd4e097d82d73dc5d152f277bd17ba7980cad4c0b238c3609517cbd0cf686ddd1::ramm::lptok_in_circulation<T0>(arg0, v0) > 0, 3);
        let v1 = 0xd4e097d82d73dc5d152f277bd17ba7980cad4c0b238c3609517cbd0cf686ddd1::ramm::get_asset_index<T1>(arg0);
        assert!((0xd4e097d82d73dc5d152f277bd17ba7980cad4c0b238c3609517cbd0cf686ddd1::ramm::get_bal(arg0, v1) as u64) > 0, 4);
        0xd4e097d82d73dc5d152f277bd17ba7980cad4c0b238c3609517cbd0cf686ddd1::ramm::check_trade_amount_in<T0>(arg0, (0x2::coin::value<T0>(&arg2) as u256));
        let v2 = 0xd4e097d82d73dc5d152f277bd17ba7980cad4c0b238c3609517cbd0cf686ddd1::ramm::get_asset_index<T2>(arg0);
        let v3 = 0x2::clock::timestamp_ms(arg1);
        let v4 = 0x2::vec_map::empty<u8, u256>();
        let v5 = 0x2::vec_map::empty<u8, u256>();
        let v6 = 0x2::vec_map::empty<u8, u64>();
        0xd4e097d82d73dc5d152f277bd17ba7980cad4c0b238c3609517cbd0cf686ddd1::ramm::check_feed_and_get_price_data(arg0, v3, v0, arg4, &mut v4, &mut v5, &mut v6);
        0xd4e097d82d73dc5d152f277bd17ba7980cad4c0b238c3609517cbd0cf686ddd1::ramm::check_feed_and_get_price_data(arg0, v3, v1, arg5, &mut v4, &mut v5, &mut v6);
        0xd4e097d82d73dc5d152f277bd17ba7980cad4c0b238c3609517cbd0cf686ddd1::ramm::check_feed_and_get_price_data(arg0, v3, v2, arg6, &mut v4, &mut v5, &mut v6);
        let v7 = 0xd4e097d82d73dc5d152f277bd17ba7980cad4c0b238c3609517cbd0cf686ddd1::ramm::compute_volatility_fee(arg0, v0, *0x2::vec_map::get<u8, u256>(&v4, &v0), *0x2::vec_map::get<u8, u64>(&v6, &v0));
        let v8 = 0xd4e097d82d73dc5d152f277bd17ba7980cad4c0b238c3609517cbd0cf686ddd1::ramm::compute_volatility_fee(arg0, v1, *0x2::vec_map::get<u8, u256>(&v4, &v1), *0x2::vec_map::get<u8, u64>(&v6, &v1));
        let v9 = 0x2::coin::value<T0>(&arg2);
        let v10 = 0xd4e097d82d73dc5d152f277bd17ba7980cad4c0b238c3609517cbd0cf686ddd1::ramm::trade_i<T0, T1>(arg0, v0, v1, (v9 as u256), v4, v5, v7 + v8);
        let v11 = *0x2::vec_map::get<u8, u256>(&v4, &v0);
        let v12 = *0x2::vec_map::get<u8, u64>(&v6, &v0);
        let v13 = *0x2::vec_map::get<u8, u256>(&v4, &v1);
        let v14 = *0x2::vec_map::get<u8, u64>(&v6, &v1);
        let v15 = *0x2::vec_map::get<u8, u256>(&v4, &v2);
        let v16 = *0x2::vec_map::get<u8, u64>(&v6, &v2);
        0xd4e097d82d73dc5d152f277bd17ba7980cad4c0b238c3609517cbd0cf686ddd1::ramm::update_volatility_data(arg0, v0, 0xd4e097d82d73dc5d152f277bd17ba7980cad4c0b238c3609517cbd0cf686ddd1::ramm::get_prev_prc(arg0, v0), 0xd4e097d82d73dc5d152f277bd17ba7980cad4c0b238c3609517cbd0cf686ddd1::ramm::get_prev_prc_tmstmp(arg0, v0), v11, v12, v7);
        0xd4e097d82d73dc5d152f277bd17ba7980cad4c0b238c3609517cbd0cf686ddd1::ramm::update_volatility_data(arg0, v1, 0xd4e097d82d73dc5d152f277bd17ba7980cad4c0b238c3609517cbd0cf686ddd1::ramm::get_prev_prc(arg0, v1), 0xd4e097d82d73dc5d152f277bd17ba7980cad4c0b238c3609517cbd0cf686ddd1::ramm::get_prev_prc_tmstmp(arg0, v1), v13, v14, v8);
        0xd4e097d82d73dc5d152f277bd17ba7980cad4c0b238c3609517cbd0cf686ddd1::ramm::update_volatility_data(arg0, v2, 0xd4e097d82d73dc5d152f277bd17ba7980cad4c0b238c3609517cbd0cf686ddd1::ramm::get_prev_prc(arg0, v2), 0xd4e097d82d73dc5d152f277bd17ba7980cad4c0b238c3609517cbd0cf686ddd1::ramm::get_prev_prc_tmstmp(arg0, v2), v15, v16, 0xd4e097d82d73dc5d152f277bd17ba7980cad4c0b238c3609517cbd0cf686ddd1::ramm::compute_volatility_fee(arg0, v2, *0x2::vec_map::get<u8, u256>(&v4, &v2), *0x2::vec_map::get<u8, u64>(&v6, &v2)));
        0xd4e097d82d73dc5d152f277bd17ba7980cad4c0b238c3609517cbd0cf686ddd1::ramm::update_pricing_data<T0>(arg0, v11, v12);
        0xd4e097d82d73dc5d152f277bd17ba7980cad4c0b238c3609517cbd0cf686ddd1::ramm::update_pricing_data<T1>(arg0, v13, v14);
        0xd4e097d82d73dc5d152f277bd17ba7980cad4c0b238c3609517cbd0cf686ddd1::ramm::update_pricing_data<T2>(arg0, v15, v16);
        let v17 = 0xd4e097d82d73dc5d152f277bd17ba7980cad4c0b238c3609517cbd0cf686ddd1::ramm::amount(&v10);
        0xd4e097d82d73dc5d152f277bd17ba7980cad4c0b238c3609517cbd0cf686ddd1::ramm::check_trade_amount_out<T1>(arg0, v17);
        let v18 = (v17 as u64);
        if (0xd4e097d82d73dc5d152f277bd17ba7980cad4c0b238c3609517cbd0cf686ddd1::ramm::is_successful(&v10)) {
            assert!(v18 >= arg3, 6);
            let v19 = 0x2::coin::into_balance<T0>(arg2);
            let v20 = (0xd4e097d82d73dc5d152f277bd17ba7980cad4c0b238c3609517cbd0cf686ddd1::ramm::protocol_fee(&v10) as u64);
            0xd4e097d82d73dc5d152f277bd17ba7980cad4c0b238c3609517cbd0cf686ddd1::ramm::join_protocol_fees<T0>(arg0, v0, 0x2::balance::split<T0>(&mut v19, v20));
            0xd4e097d82d73dc5d152f277bd17ba7980cad4c0b238c3609517cbd0cf686ddd1::ramm::join_bal(arg0, v0, (0x2::balance::value<T0>(&v19) as u256));
            0xd4e097d82d73dc5d152f277bd17ba7980cad4c0b238c3609517cbd0cf686ddd1::ramm::join_typed_bal<T0>(arg0, v0, v19);
            0xd4e097d82d73dc5d152f277bd17ba7980cad4c0b238c3609517cbd0cf686ddd1::ramm::split_bal(arg0, v1, v17);
            0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(0x2::coin::from_balance<T1>(0xd4e097d82d73dc5d152f277bd17ba7980cad4c0b238c3609517cbd0cf686ddd1::ramm::split_typed_bal<T1>(arg0, v1, v18), arg7), 0x2::tx_context::sender(arg7));
            0xd4e097d82d73dc5d152f277bd17ba7980cad4c0b238c3609517cbd0cf686ddd1::events::trade_event<0xd4e097d82d73dc5d152f277bd17ba7980cad4c0b238c3609517cbd0cf686ddd1::events::TradeIn>(0xd4e097d82d73dc5d152f277bd17ba7980cad4c0b238c3609517cbd0cf686ddd1::ramm::get_id(arg0), 0x2::tx_context::sender(arg7), 0x1::type_name::get<T0>(), 0x1::type_name::get<T1>(), v9, v18, v20);
            0xd4e097d82d73dc5d152f277bd17ba7980cad4c0b238c3609517cbd0cf686ddd1::ramm::check_ramm_invariants_3<T0, T1, T2>(arg0);
            return
        } else if (0xd4e097d82d73dc5d152f277bd17ba7980cad4c0b238c3609517cbd0cf686ddd1::ramm::trade_outcome(&v10) == 0xd4e097d82d73dc5d152f277bd17ba7980cad4c0b238c3609517cbd0cf686ddd1::ramm::failed_pool_imbalance()) {
            abort 7
        } else if (0xd4e097d82d73dc5d152f277bd17ba7980cad4c0b238c3609517cbd0cf686ddd1::ramm::trade_outcome(&v10) == 0xd4e097d82d73dc5d152f277bd17ba7980cad4c0b238c3609517cbd0cf686ddd1::ramm::failed_insufficient_out_token_balance()) {
            abort 8
        } else {
            assert!(0xd4e097d82d73dc5d152f277bd17ba7980cad4c0b238c3609517cbd0cf686ddd1::ramm::trade_outcome(&v10) == 0xd4e097d82d73dc5d152f277bd17ba7980cad4c0b238c3609517cbd0cf686ddd1::ramm::failed_low_out_token_imb_ratio(), 10);
            abort 9
        };
    }

    public fun trade_amount_out_3<T0, T1, T2>(arg0: &mut 0xd4e097d82d73dc5d152f277bd17ba7980cad4c0b238c3609517cbd0cf686ddd1::ramm::RAMM, arg1: &0x2::clock::Clock, arg2: u64, arg3: 0x2::coin::Coin<T0>, arg4: &0x8d79f4d920b03d88faca1e421af023a87fbb1e4a6fd200248e6e9998d09e470::aggregator::Aggregator, arg5: &0x8d79f4d920b03d88faca1e421af023a87fbb1e4a6fd200248e6e9998d09e470::aggregator::Aggregator, arg6: &0x8d79f4d920b03d88faca1e421af023a87fbb1e4a6fd200248e6e9998d09e470::aggregator::Aggregator, arg7: &mut 0x2::tx_context::TxContext) {
        assert!(0xd4e097d82d73dc5d152f277bd17ba7980cad4c0b238c3609517cbd0cf686ddd1::ramm::get_asset_count(arg0) == 3, 0);
        let v0 = 0xd4e097d82d73dc5d152f277bd17ba7980cad4c0b238c3609517cbd0cf686ddd1::ramm::get_asset_index<T0>(arg0);
        assert!(0xd4e097d82d73dc5d152f277bd17ba7980cad4c0b238c3609517cbd0cf686ddd1::ramm::lptok_in_circulation<T0>(arg0, v0) > 0, 3);
        let v1 = 0xd4e097d82d73dc5d152f277bd17ba7980cad4c0b238c3609517cbd0cf686ddd1::ramm::get_asset_index<T1>(arg0);
        assert!(arg2 >= 0xd4e097d82d73dc5d152f277bd17ba7980cad4c0b238c3609517cbd0cf686ddd1::ramm::get_min_trade_amount(arg0, v1), 11);
        let v2 = (0xd4e097d82d73dc5d152f277bd17ba7980cad4c0b238c3609517cbd0cf686ddd1::ramm::get_bal(arg0, v1) as u64);
        assert!(v2 >= arg2, 4);
        if (arg2 == v2) {
            assert!(0xd4e097d82d73dc5d152f277bd17ba7980cad4c0b238c3609517cbd0cf686ddd1::ramm::lptok_in_circulation<T1>(arg0, v1) == 0, 5);
        };
        let v3 = 0xd4e097d82d73dc5d152f277bd17ba7980cad4c0b238c3609517cbd0cf686ddd1::ramm::get_asset_index<T2>(arg0);
        0xd4e097d82d73dc5d152f277bd17ba7980cad4c0b238c3609517cbd0cf686ddd1::ramm::check_trade_amount_out<T1>(arg0, (arg2 as u256));
        let v4 = 0x2::clock::timestamp_ms(arg1);
        let v5 = 0x2::vec_map::empty<u8, u256>();
        let v6 = 0x2::vec_map::empty<u8, u256>();
        let v7 = 0x2::vec_map::empty<u8, u64>();
        0xd4e097d82d73dc5d152f277bd17ba7980cad4c0b238c3609517cbd0cf686ddd1::ramm::check_feed_and_get_price_data(arg0, v4, v0, arg4, &mut v5, &mut v6, &mut v7);
        0xd4e097d82d73dc5d152f277bd17ba7980cad4c0b238c3609517cbd0cf686ddd1::ramm::check_feed_and_get_price_data(arg0, v4, v1, arg5, &mut v5, &mut v6, &mut v7);
        0xd4e097d82d73dc5d152f277bd17ba7980cad4c0b238c3609517cbd0cf686ddd1::ramm::check_feed_and_get_price_data(arg0, v4, v3, arg6, &mut v5, &mut v6, &mut v7);
        let v8 = 0xd4e097d82d73dc5d152f277bd17ba7980cad4c0b238c3609517cbd0cf686ddd1::ramm::compute_volatility_fee(arg0, v0, *0x2::vec_map::get<u8, u256>(&v5, &v0), *0x2::vec_map::get<u8, u64>(&v7, &v0));
        let v9 = 0xd4e097d82d73dc5d152f277bd17ba7980cad4c0b238c3609517cbd0cf686ddd1::ramm::compute_volatility_fee(arg0, v1, *0x2::vec_map::get<u8, u256>(&v5, &v1), *0x2::vec_map::get<u8, u64>(&v7, &v1));
        let v10 = 0xd4e097d82d73dc5d152f277bd17ba7980cad4c0b238c3609517cbd0cf686ddd1::ramm::trade_o<T0, T1>(arg0, v0, v1, arg2, v5, v6, v8 + v9);
        let v11 = *0x2::vec_map::get<u8, u256>(&v5, &v0);
        let v12 = *0x2::vec_map::get<u8, u64>(&v7, &v0);
        let v13 = *0x2::vec_map::get<u8, u256>(&v5, &v1);
        let v14 = *0x2::vec_map::get<u8, u64>(&v7, &v1);
        let v15 = *0x2::vec_map::get<u8, u256>(&v5, &v3);
        let v16 = *0x2::vec_map::get<u8, u64>(&v7, &v3);
        0xd4e097d82d73dc5d152f277bd17ba7980cad4c0b238c3609517cbd0cf686ddd1::ramm::update_volatility_data(arg0, v0, 0xd4e097d82d73dc5d152f277bd17ba7980cad4c0b238c3609517cbd0cf686ddd1::ramm::get_prev_prc(arg0, v0), 0xd4e097d82d73dc5d152f277bd17ba7980cad4c0b238c3609517cbd0cf686ddd1::ramm::get_prev_prc_tmstmp(arg0, v0), v11, v12, v8);
        0xd4e097d82d73dc5d152f277bd17ba7980cad4c0b238c3609517cbd0cf686ddd1::ramm::update_volatility_data(arg0, v1, 0xd4e097d82d73dc5d152f277bd17ba7980cad4c0b238c3609517cbd0cf686ddd1::ramm::get_prev_prc(arg0, v1), 0xd4e097d82d73dc5d152f277bd17ba7980cad4c0b238c3609517cbd0cf686ddd1::ramm::get_prev_prc_tmstmp(arg0, v1), v13, v14, v9);
        0xd4e097d82d73dc5d152f277bd17ba7980cad4c0b238c3609517cbd0cf686ddd1::ramm::update_volatility_data(arg0, v3, 0xd4e097d82d73dc5d152f277bd17ba7980cad4c0b238c3609517cbd0cf686ddd1::ramm::get_prev_prc(arg0, v3), 0xd4e097d82d73dc5d152f277bd17ba7980cad4c0b238c3609517cbd0cf686ddd1::ramm::get_prev_prc_tmstmp(arg0, v3), v15, v16, 0xd4e097d82d73dc5d152f277bd17ba7980cad4c0b238c3609517cbd0cf686ddd1::ramm::compute_volatility_fee(arg0, v3, *0x2::vec_map::get<u8, u256>(&v5, &v3), *0x2::vec_map::get<u8, u64>(&v7, &v3)));
        0xd4e097d82d73dc5d152f277bd17ba7980cad4c0b238c3609517cbd0cf686ddd1::ramm::update_pricing_data<T0>(arg0, v11, v12);
        0xd4e097d82d73dc5d152f277bd17ba7980cad4c0b238c3609517cbd0cf686ddd1::ramm::update_pricing_data<T1>(arg0, v13, v14);
        0xd4e097d82d73dc5d152f277bd17ba7980cad4c0b238c3609517cbd0cf686ddd1::ramm::update_pricing_data<T2>(arg0, v15, v16);
        0xd4e097d82d73dc5d152f277bd17ba7980cad4c0b238c3609517cbd0cf686ddd1::ramm::check_trade_amount_in<T0>(arg0, 0xd4e097d82d73dc5d152f277bd17ba7980cad4c0b238c3609517cbd0cf686ddd1::ramm::amount(&v10));
        let v17 = (0xd4e097d82d73dc5d152f277bd17ba7980cad4c0b238c3609517cbd0cf686ddd1::ramm::amount(&v10) as u64);
        if (0xd4e097d82d73dc5d152f277bd17ba7980cad4c0b238c3609517cbd0cf686ddd1::ramm::is_successful(&v10)) {
            assert!(v17 <= 0x2::coin::value<T0>(&arg3), 6);
            let v18 = 0x2::coin::into_balance<T0>(arg3);
            let v19 = 0x2::balance::split<T0>(&mut v18, v17);
            let v20 = (0xd4e097d82d73dc5d152f277bd17ba7980cad4c0b238c3609517cbd0cf686ddd1::ramm::protocol_fee(&v10) as u64);
            0xd4e097d82d73dc5d152f277bd17ba7980cad4c0b238c3609517cbd0cf686ddd1::ramm::join_protocol_fees<T0>(arg0, v0, 0x2::balance::split<T0>(&mut v19, v20));
            0xd4e097d82d73dc5d152f277bd17ba7980cad4c0b238c3609517cbd0cf686ddd1::ramm::join_bal(arg0, v0, (0x2::balance::value<T0>(&v19) as u256));
            0xd4e097d82d73dc5d152f277bd17ba7980cad4c0b238c3609517cbd0cf686ddd1::ramm::join_typed_bal<T0>(arg0, v0, v19);
            0xd4e097d82d73dc5d152f277bd17ba7980cad4c0b238c3609517cbd0cf686ddd1::ramm::split_bal(arg0, v1, (arg2 as u256));
            0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(0x2::coin::from_balance<T1>(0xd4e097d82d73dc5d152f277bd17ba7980cad4c0b238c3609517cbd0cf686ddd1::ramm::split_typed_bal<T1>(arg0, v1, arg2), arg7), 0x2::tx_context::sender(arg7));
            0xd4e097d82d73dc5d152f277bd17ba7980cad4c0b238c3609517cbd0cf686ddd1::events::trade_event<0xd4e097d82d73dc5d152f277bd17ba7980cad4c0b238c3609517cbd0cf686ddd1::events::TradeOut>(0xd4e097d82d73dc5d152f277bd17ba7980cad4c0b238c3609517cbd0cf686ddd1::ramm::get_id(arg0), 0x2::tx_context::sender(arg7), 0x1::type_name::get<T0>(), 0x1::type_name::get<T1>(), v17, arg2, v20);
            if (0x2::balance::value<T0>(&v18) > 0) {
                0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(v18, arg7), 0x2::tx_context::sender(arg7));
            } else {
                0x2::balance::destroy_zero<T0>(v18);
            };
            0xd4e097d82d73dc5d152f277bd17ba7980cad4c0b238c3609517cbd0cf686ddd1::ramm::check_ramm_invariants_3<T0, T1, T2>(arg0);
            return
        } else if (0xd4e097d82d73dc5d152f277bd17ba7980cad4c0b238c3609517cbd0cf686ddd1::ramm::trade_outcome(&v10) == 0xd4e097d82d73dc5d152f277bd17ba7980cad4c0b238c3609517cbd0cf686ddd1::ramm::failed_pool_imbalance()) {
            abort 7
        } else if (0xd4e097d82d73dc5d152f277bd17ba7980cad4c0b238c3609517cbd0cf686ddd1::ramm::trade_outcome(&v10) == 0xd4e097d82d73dc5d152f277bd17ba7980cad4c0b238c3609517cbd0cf686ddd1::ramm::failed_insufficient_out_token_balance()) {
            abort 8
        } else {
            assert!(0xd4e097d82d73dc5d152f277bd17ba7980cad4c0b238c3609517cbd0cf686ddd1::ramm::trade_outcome(&v10) == 0xd4e097d82d73dc5d152f277bd17ba7980cad4c0b238c3609517cbd0cf686ddd1::ramm::failed_low_out_token_imb_ratio(), 10);
            abort 9
        };
    }

    public fun trade_price_estimate_3<T0, T1, T2>(arg0: &0xd4e097d82d73dc5d152f277bd17ba7980cad4c0b238c3609517cbd0cf686ddd1::ramm::RAMM, arg1: &0x2::clock::Clock, arg2: u64, arg3: &0x8d79f4d920b03d88faca1e421af023a87fbb1e4a6fd200248e6e9998d09e470::aggregator::Aggregator, arg4: &0x8d79f4d920b03d88faca1e421af023a87fbb1e4a6fd200248e6e9998d09e470::aggregator::Aggregator, arg5: &0x8d79f4d920b03d88faca1e421af023a87fbb1e4a6fd200248e6e9998d09e470::aggregator::Aggregator, arg6: &0x2::tx_context::TxContext) {
        assert!(0xd4e097d82d73dc5d152f277bd17ba7980cad4c0b238c3609517cbd0cf686ddd1::ramm::get_asset_count(arg0) == 3, 0);
        let v0 = 0xd4e097d82d73dc5d152f277bd17ba7980cad4c0b238c3609517cbd0cf686ddd1::ramm::get_asset_index<T0>(arg0);
        assert!(arg2 >= 0xd4e097d82d73dc5d152f277bd17ba7980cad4c0b238c3609517cbd0cf686ddd1::ramm::get_min_trade_amount(arg0, v0), 11);
        assert!(0xd4e097d82d73dc5d152f277bd17ba7980cad4c0b238c3609517cbd0cf686ddd1::ramm::lptok_in_circulation<T0>(arg0, v0) > 0, 3);
        let v1 = 0xd4e097d82d73dc5d152f277bd17ba7980cad4c0b238c3609517cbd0cf686ddd1::ramm::get_asset_index<T1>(arg0);
        assert!((0xd4e097d82d73dc5d152f277bd17ba7980cad4c0b238c3609517cbd0cf686ddd1::ramm::get_bal(arg0, v1) as u64) > 0, 4);
        0xd4e097d82d73dc5d152f277bd17ba7980cad4c0b238c3609517cbd0cf686ddd1::ramm::check_trade_amount_in<T0>(arg0, (arg2 as u256));
        let v2 = 0x2::clock::timestamp_ms(arg1);
        let v3 = 0x2::vec_map::empty<u8, u256>();
        let v4 = 0x2::vec_map::empty<u8, u256>();
        let v5 = 0x2::vec_map::empty<u8, u64>();
        0xd4e097d82d73dc5d152f277bd17ba7980cad4c0b238c3609517cbd0cf686ddd1::ramm::check_feed_and_get_price_data(arg0, v2, v0, arg3, &mut v3, &mut v4, &mut v5);
        0xd4e097d82d73dc5d152f277bd17ba7980cad4c0b238c3609517cbd0cf686ddd1::ramm::check_feed_and_get_price_data(arg0, v2, v1, arg4, &mut v3, &mut v4, &mut v5);
        0xd4e097d82d73dc5d152f277bd17ba7980cad4c0b238c3609517cbd0cf686ddd1::ramm::check_feed_and_get_price_data(arg0, v2, 0xd4e097d82d73dc5d152f277bd17ba7980cad4c0b238c3609517cbd0cf686ddd1::ramm::get_asset_index<T2>(arg0), arg5, &mut v3, &mut v4, &mut v5);
        let v6 = 0xd4e097d82d73dc5d152f277bd17ba7980cad4c0b238c3609517cbd0cf686ddd1::ramm::trade_i<T0, T1>(arg0, v0, v1, (arg2 as u256), v3, v4, 0xd4e097d82d73dc5d152f277bd17ba7980cad4c0b238c3609517cbd0cf686ddd1::ramm::compute_volatility_fee(arg0, v0, *0x2::vec_map::get<u8, u256>(&v3, &v0), *0x2::vec_map::get<u8, u64>(&v5, &v0)) + 0xd4e097d82d73dc5d152f277bd17ba7980cad4c0b238c3609517cbd0cf686ddd1::ramm::compute_volatility_fee(arg0, v1, *0x2::vec_map::get<u8, u256>(&v3, &v1), *0x2::vec_map::get<u8, u64>(&v5, &v1)));
        assert!(0xd4e097d82d73dc5d152f277bd17ba7980cad4c0b238c3609517cbd0cf686ddd1::ramm::is_successful(&v6), 10);
        0xd4e097d82d73dc5d152f277bd17ba7980cad4c0b238c3609517cbd0cf686ddd1::events::price_estimation_event(0xd4e097d82d73dc5d152f277bd17ba7980cad4c0b238c3609517cbd0cf686ddd1::ramm::get_id(arg0), 0x2::tx_context::sender(arg6), 0x1::type_name::get<T0>(), 0x1::type_name::get<T1>(), arg2, (0xd4e097d82d73dc5d152f277bd17ba7980cad4c0b238c3609517cbd0cf686ddd1::ramm::amount(&v6) as u64), (0xd4e097d82d73dc5d152f277bd17ba7980cad4c0b238c3609517cbd0cf686ddd1::ramm::protocol_fee(&v6) as u64));
    }

    // decompiled from Move bytecode v6
}

