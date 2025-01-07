module 0x5b05e2c12f617b33b64ea2b004d89cc18c46b270bc0c214ddd32654fa9a8c84c::interface2 {
    public fun collect_fees_2<T0, T1>(arg0: &mut 0x5b05e2c12f617b33b64ea2b004d89cc18c46b270bc0c214ddd32654fa9a8c84c::ramm::RAMM, arg1: &0x5b05e2c12f617b33b64ea2b004d89cc18c46b270bc0c214ddd32654fa9a8c84c::ramm::RAMMAdminCap, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(0x5b05e2c12f617b33b64ea2b004d89cc18c46b270bc0c214ddd32654fa9a8c84c::ramm::get_admin_cap_id(arg0) == 0x2::object::id<0x5b05e2c12f617b33b64ea2b004d89cc18c46b270bc0c214ddd32654fa9a8c84c::ramm::RAMMAdminCap>(arg1), 12);
        assert!(0x5b05e2c12f617b33b64ea2b004d89cc18c46b270bc0c214ddd32654fa9a8c84c::ramm::get_asset_count(arg0) == 2, 0);
        let v0 = 0x2::coin::from_balance<T0>(0x5b05e2c12f617b33b64ea2b004d89cc18c46b270bc0c214ddd32654fa9a8c84c::ramm::get_fees_for_asset<T0>(arg0, 0x5b05e2c12f617b33b64ea2b004d89cc18c46b270bc0c214ddd32654fa9a8c84c::ramm::get_asset_index<T0>(arg0)), arg2);
        let v1 = 0x2::coin::from_balance<T1>(0x5b05e2c12f617b33b64ea2b004d89cc18c46b270bc0c214ddd32654fa9a8c84c::ramm::get_fees_for_asset<T1>(arg0, 0x5b05e2c12f617b33b64ea2b004d89cc18c46b270bc0c214ddd32654fa9a8c84c::ramm::get_asset_index<T1>(arg0)), arg2);
        let v2 = 0x2::coin::value<T0>(&v0);
        let v3 = 0x2::coin::value<T1>(&v1);
        let v4 = 0x2::vec_map::empty<0x1::type_name::TypeName, u64>();
        0x2::vec_map::insert<0x1::type_name::TypeName, u64>(&mut v4, 0x1::type_name::get<T0>(), v2);
        0x2::vec_map::insert<0x1::type_name::TypeName, u64>(&mut v4, 0x1::type_name::get<T1>(), v3);
        let v5 = 0x5b05e2c12f617b33b64ea2b004d89cc18c46b270bc0c214ddd32654fa9a8c84c::ramm::get_fee_collector(arg0);
        if (v2 > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(v0, v5);
        } else {
            0x2::coin::destroy_zero<T0>(v0);
        };
        if (v3 > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(v1, v5);
        } else {
            0x2::coin::destroy_zero<T1>(v1);
        };
        0x5b05e2c12f617b33b64ea2b004d89cc18c46b270bc0c214ddd32654fa9a8c84c::events::fee_collection_event(0x5b05e2c12f617b33b64ea2b004d89cc18c46b270bc0c214ddd32654fa9a8c84c::ramm::get_id(arg0), 0x2::tx_context::sender(arg2), v5, v4);
        0x5b05e2c12f617b33b64ea2b004d89cc18c46b270bc0c214ddd32654fa9a8c84c::ramm::check_ramm_invariants_2<T0, T1>(arg0);
    }

    public fun liquidity_deposit_2<T0, T1>(arg0: &mut 0x5b05e2c12f617b33b64ea2b004d89cc18c46b270bc0c214ddd32654fa9a8c84c::ramm::RAMM, arg1: &0x2::clock::Clock, arg2: 0x2::coin::Coin<T0>, arg3: &0x8d79f4d920b03d88faca1e421af023a87fbb1e4a6fd200248e6e9998d09e470::aggregator::Aggregator, arg4: &0x8d79f4d920b03d88faca1e421af023a87fbb1e4a6fd200248e6e9998d09e470::aggregator::Aggregator, arg5: &mut 0x2::tx_context::TxContext) {
        assert!(0x5b05e2c12f617b33b64ea2b004d89cc18c46b270bc0c214ddd32654fa9a8c84c::ramm::get_asset_count(arg0) == 2, 0);
        assert!(0x2::coin::value<T0>(&arg2) > 0, 2);
        let v0 = 0x5b05e2c12f617b33b64ea2b004d89cc18c46b270bc0c214ddd32654fa9a8c84c::ramm::get_asset_index<T0>(arg0);
        assert!(0x5b05e2c12f617b33b64ea2b004d89cc18c46b270bc0c214ddd32654fa9a8c84c::ramm::can_deposit_asset(arg0, v0), 1);
        let v1 = 0x5b05e2c12f617b33b64ea2b004d89cc18c46b270bc0c214ddd32654fa9a8c84c::ramm::get_asset_index<T1>(arg0);
        let v2 = 0x2::clock::timestamp_ms(arg1);
        let v3 = 0x2::vec_map::empty<u8, u256>();
        let v4 = 0x2::vec_map::empty<u8, u256>();
        let v5 = 0x2::vec_map::empty<u8, u64>();
        0x5b05e2c12f617b33b64ea2b004d89cc18c46b270bc0c214ddd32654fa9a8c84c::ramm::check_feed_and_get_price_data(arg0, v2, v0, arg3, &mut v3, &mut v4, &mut v5);
        0x5b05e2c12f617b33b64ea2b004d89cc18c46b270bc0c214ddd32654fa9a8c84c::ramm::check_feed_and_get_price_data(arg0, v2, v1, arg4, &mut v3, &mut v4, &mut v5);
        let v6 = 0x5b05e2c12f617b33b64ea2b004d89cc18c46b270bc0c214ddd32654fa9a8c84c::ramm::liq_dep<T0>(arg0, v0, 0x2::coin::value<T0>(&arg2), v3, v4);
        let v7 = *0x2::vec_map::get<u8, u256>(&v3, &v0);
        let v8 = *0x2::vec_map::get<u8, u64>(&v5, &v0);
        let v9 = *0x2::vec_map::get<u8, u256>(&v3, &v1);
        let v10 = *0x2::vec_map::get<u8, u64>(&v5, &v1);
        0x5b05e2c12f617b33b64ea2b004d89cc18c46b270bc0c214ddd32654fa9a8c84c::ramm::update_volatility_data(arg0, v0, 0x5b05e2c12f617b33b64ea2b004d89cc18c46b270bc0c214ddd32654fa9a8c84c::ramm::get_prev_prc(arg0, v0), 0x5b05e2c12f617b33b64ea2b004d89cc18c46b270bc0c214ddd32654fa9a8c84c::ramm::get_prev_prc_tmstmp(arg0, v0), v7, v8, 0x5b05e2c12f617b33b64ea2b004d89cc18c46b270bc0c214ddd32654fa9a8c84c::ramm::compute_volatility_fee(arg0, v0, *0x2::vec_map::get<u8, u256>(&v3, &v0), *0x2::vec_map::get<u8, u64>(&v5, &v0)));
        0x5b05e2c12f617b33b64ea2b004d89cc18c46b270bc0c214ddd32654fa9a8c84c::ramm::update_volatility_data(arg0, v1, 0x5b05e2c12f617b33b64ea2b004d89cc18c46b270bc0c214ddd32654fa9a8c84c::ramm::get_prev_prc(arg0, v1), 0x5b05e2c12f617b33b64ea2b004d89cc18c46b270bc0c214ddd32654fa9a8c84c::ramm::get_prev_prc_tmstmp(arg0, v1), v9, v10, 0x5b05e2c12f617b33b64ea2b004d89cc18c46b270bc0c214ddd32654fa9a8c84c::ramm::compute_volatility_fee(arg0, v1, *0x2::vec_map::get<u8, u256>(&v3, &v1), *0x2::vec_map::get<u8, u64>(&v5, &v1)));
        0x5b05e2c12f617b33b64ea2b004d89cc18c46b270bc0c214ddd32654fa9a8c84c::ramm::update_pricing_data<T0>(arg0, v7, v8);
        0x5b05e2c12f617b33b64ea2b004d89cc18c46b270bc0c214ddd32654fa9a8c84c::ramm::update_pricing_data<T1>(arg0, v9, v10);
        if (v6 == 0) {
            abort 13
        };
        let v11 = 0x2::coin::into_balance<T0>(arg2);
        0x5b05e2c12f617b33b64ea2b004d89cc18c46b270bc0c214ddd32654fa9a8c84c::ramm::join_bal(arg0, v0, (0x2::balance::value<T0>(&v11) as u256));
        0x5b05e2c12f617b33b64ea2b004d89cc18c46b270bc0c214ddd32654fa9a8c84c::ramm::join_typed_bal<T0>(arg0, v0, v11);
        0x5b05e2c12f617b33b64ea2b004d89cc18c46b270bc0c214ddd32654fa9a8c84c::ramm::incr_lptokens_issued<T0>(arg0, v6);
        let v12 = 0x2::coin::from_balance<0x5b05e2c12f617b33b64ea2b004d89cc18c46b270bc0c214ddd32654fa9a8c84c::ramm::LP<T0>>(0x5b05e2c12f617b33b64ea2b004d89cc18c46b270bc0c214ddd32654fa9a8c84c::ramm::mint_lp_tokens<T0>(arg0, v6), arg5);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x5b05e2c12f617b33b64ea2b004d89cc18c46b270bc0c214ddd32654fa9a8c84c::ramm::LP<T0>>>(v12, 0x2::tx_context::sender(arg5));
        0x5b05e2c12f617b33b64ea2b004d89cc18c46b270bc0c214ddd32654fa9a8c84c::events::liquidity_deposit_event(0x5b05e2c12f617b33b64ea2b004d89cc18c46b270bc0c214ddd32654fa9a8c84c::ramm::get_id(arg0), 0x2::tx_context::sender(arg5), 0x1::type_name::get<T0>(), 0x2::coin::value<T0>(&arg2), 0x2::coin::value<0x5b05e2c12f617b33b64ea2b004d89cc18c46b270bc0c214ddd32654fa9a8c84c::ramm::LP<T0>>(&v12));
        0x5b05e2c12f617b33b64ea2b004d89cc18c46b270bc0c214ddd32654fa9a8c84c::ramm::check_ramm_invariants_2<T0, T1>(arg0);
    }

    public fun liquidity_withdrawal_2<T0, T1, T2>(arg0: &mut 0x5b05e2c12f617b33b64ea2b004d89cc18c46b270bc0c214ddd32654fa9a8c84c::ramm::RAMM, arg1: &0x2::clock::Clock, arg2: 0x2::coin::Coin<0x5b05e2c12f617b33b64ea2b004d89cc18c46b270bc0c214ddd32654fa9a8c84c::ramm::LP<T2>>, arg3: &0x8d79f4d920b03d88faca1e421af023a87fbb1e4a6fd200248e6e9998d09e470::aggregator::Aggregator, arg4: &0x8d79f4d920b03d88faca1e421af023a87fbb1e4a6fd200248e6e9998d09e470::aggregator::Aggregator, arg5: &mut 0x2::tx_context::TxContext) {
        assert!(0x5b05e2c12f617b33b64ea2b004d89cc18c46b270bc0c214ddd32654fa9a8c84c::ramm::get_asset_count(arg0) == 2, 0);
        assert!(0x2::coin::value<0x5b05e2c12f617b33b64ea2b004d89cc18c46b270bc0c214ddd32654fa9a8c84c::ramm::LP<T2>>(&arg2) > 0, 15);
        let v0 = 0x5b05e2c12f617b33b64ea2b004d89cc18c46b270bc0c214ddd32654fa9a8c84c::ramm::get_asset_index<T0>(arg0);
        let v1 = 0x5b05e2c12f617b33b64ea2b004d89cc18c46b270bc0c214ddd32654fa9a8c84c::ramm::get_asset_index<T1>(arg0);
        let v2 = 0x5b05e2c12f617b33b64ea2b004d89cc18c46b270bc0c214ddd32654fa9a8c84c::ramm::get_asset_index<T2>(arg0);
        let v3 = 0x2::clock::timestamp_ms(arg1);
        let v4 = 0x2::vec_map::empty<u8, u256>();
        let v5 = 0x2::vec_map::empty<u8, u256>();
        let v6 = 0x2::vec_map::empty<u8, u64>();
        0x5b05e2c12f617b33b64ea2b004d89cc18c46b270bc0c214ddd32654fa9a8c84c::ramm::check_feed_and_get_price_data(arg0, v3, v0, arg3, &mut v4, &mut v5, &mut v6);
        0x5b05e2c12f617b33b64ea2b004d89cc18c46b270bc0c214ddd32654fa9a8c84c::ramm::check_feed_and_get_price_data(arg0, v3, v1, arg4, &mut v4, &mut v5, &mut v6);
        let v7 = 0x5b05e2c12f617b33b64ea2b004d89cc18c46b270bc0c214ddd32654fa9a8c84c::ramm::compute_volatility_fee(arg0, v0, *0x2::vec_map::get<u8, u256>(&v4, &v0), *0x2::vec_map::get<u8, u64>(&v6, &v0));
        let v8 = 0x5b05e2c12f617b33b64ea2b004d89cc18c46b270bc0c214ddd32654fa9a8c84c::ramm::compute_volatility_fee(arg0, v1, *0x2::vec_map::get<u8, u256>(&v4, &v1), *0x2::vec_map::get<u8, u64>(&v6, &v1));
        let v9 = 0x2::vec_map::empty<u8, u256>();
        0x2::vec_map::insert<u8, u256>(&mut v9, v0, v7);
        0x2::vec_map::insert<u8, u256>(&mut v9, v1, v8);
        let v10 = 0x2::coin::value<0x5b05e2c12f617b33b64ea2b004d89cc18c46b270bc0c214ddd32654fa9a8c84c::ramm::LP<T2>>(&arg2);
        let v11 = 0x5b05e2c12f617b33b64ea2b004d89cc18c46b270bc0c214ddd32654fa9a8c84c::ramm::get_fact_for_bal(arg0, v2);
        let v12 = 0x5b05e2c12f617b33b64ea2b004d89cc18c46b270bc0c214ddd32654fa9a8c84c::ramm::liq_wthdrw<T2>(arg0, v2, v10, v4, v5, v9);
        let v13 = *0x2::vec_map::get<u8, u256>(&v4, &v0);
        let v14 = *0x2::vec_map::get<u8, u64>(&v6, &v0);
        let v15 = *0x2::vec_map::get<u8, u256>(&v4, &v1);
        let v16 = *0x2::vec_map::get<u8, u64>(&v6, &v1);
        0x5b05e2c12f617b33b64ea2b004d89cc18c46b270bc0c214ddd32654fa9a8c84c::ramm::update_volatility_data(arg0, v0, 0x5b05e2c12f617b33b64ea2b004d89cc18c46b270bc0c214ddd32654fa9a8c84c::ramm::get_prev_prc(arg0, v0), 0x5b05e2c12f617b33b64ea2b004d89cc18c46b270bc0c214ddd32654fa9a8c84c::ramm::get_prev_prc_tmstmp(arg0, v0), v13, v14, v7);
        0x5b05e2c12f617b33b64ea2b004d89cc18c46b270bc0c214ddd32654fa9a8c84c::ramm::update_volatility_data(arg0, v1, 0x5b05e2c12f617b33b64ea2b004d89cc18c46b270bc0c214ddd32654fa9a8c84c::ramm::get_prev_prc(arg0, v1), 0x5b05e2c12f617b33b64ea2b004d89cc18c46b270bc0c214ddd32654fa9a8c84c::ramm::get_prev_prc_tmstmp(arg0, v1), v15, v16, v8);
        0x5b05e2c12f617b33b64ea2b004d89cc18c46b270bc0c214ddd32654fa9a8c84c::ramm::update_pricing_data<T0>(arg0, v13, v14);
        0x5b05e2c12f617b33b64ea2b004d89cc18c46b270bc0c214ddd32654fa9a8c84c::ramm::update_pricing_data<T1>(arg0, v15, v16);
        let v17 = (v10 as u256);
        let v18 = &mut v17;
        if (0x5b05e2c12f617b33b64ea2b004d89cc18c46b270bc0c214ddd32654fa9a8c84c::ramm::remaining(&v12) > 0) {
            *v18 = 0x5b05e2c12f617b33b64ea2b004d89cc18c46b270bc0c214ddd32654fa9a8c84c::ramm::div(0x5b05e2c12f617b33b64ea2b004d89cc18c46b270bc0c214ddd32654fa9a8c84c::ramm::mul(v17 * v11, (0x5b05e2c12f617b33b64ea2b004d89cc18c46b270bc0c214ddd32654fa9a8c84c::ramm::value(&v12) - 0x5b05e2c12f617b33b64ea2b004d89cc18c46b270bc0c214ddd32654fa9a8c84c::ramm::remaining(&v12)) * v11), 0x5b05e2c12f617b33b64ea2b004d89cc18c46b270bc0c214ddd32654fa9a8c84c::ramm::value(&v12) * v11) / v11;
        };
        let v19 = (*v18 as u64);
        let v20 = 0x2::coin::into_balance<0x5b05e2c12f617b33b64ea2b004d89cc18c46b270bc0c214ddd32654fa9a8c84c::ramm::LP<T2>>(arg2);
        0x5b05e2c12f617b33b64ea2b004d89cc18c46b270bc0c214ddd32654fa9a8c84c::ramm::decr_lptokens_issued<T2>(arg0, v19);
        assert!(0x5b05e2c12f617b33b64ea2b004d89cc18c46b270bc0c214ddd32654fa9a8c84c::ramm::burn_lp_tokens<T2>(arg0, 0x2::balance::split<0x5b05e2c12f617b33b64ea2b004d89cc18c46b270bc0c214ddd32654fa9a8c84c::ramm::LP<T2>>(&mut v20, v19)) == v19, 14);
        if (0x2::balance::value<0x5b05e2c12f617b33b64ea2b004d89cc18c46b270bc0c214ddd32654fa9a8c84c::ramm::LP<T2>>(&v20) == 0) {
            0x2::balance::destroy_zero<0x5b05e2c12f617b33b64ea2b004d89cc18c46b270bc0c214ddd32654fa9a8c84c::ramm::LP<T2>>(v20);
        } else {
            0x2::transfer::public_transfer<0x2::coin::Coin<0x5b05e2c12f617b33b64ea2b004d89cc18c46b270bc0c214ddd32654fa9a8c84c::ramm::LP<T2>>>(0x2::coin::from_balance<0x5b05e2c12f617b33b64ea2b004d89cc18c46b270bc0c214ddd32654fa9a8c84c::ramm::LP<T2>>(v20, arg5), 0x2::tx_context::sender(arg5));
        };
        let v21 = 0x5b05e2c12f617b33b64ea2b004d89cc18c46b270bc0c214ddd32654fa9a8c84c::ramm::amounts(&v12);
        let v22 = 0x5b05e2c12f617b33b64ea2b004d89cc18c46b270bc0c214ddd32654fa9a8c84c::ramm::fees(&v12);
        let v23 = *0x2::vec_map::get<u8, u256>(&v21, &v0);
        if (v23 != 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x5b05e2c12f617b33b64ea2b004d89cc18c46b270bc0c214ddd32654fa9a8c84c::ramm::liq_withdraw_helper<T0>(arg0, v0, v23, *0x2::vec_map::get<u8, u256>(&v22, &v0), arg5), 0x2::tx_context::sender(arg5));
        };
        let v24 = *0x2::vec_map::get<u8, u256>(&v21, &v1);
        if (v24 != 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(0x5b05e2c12f617b33b64ea2b004d89cc18c46b270bc0c214ddd32654fa9a8c84c::ramm::liq_withdraw_helper<T1>(arg0, v1, v24, *0x2::vec_map::get<u8, u256>(&v22, &v1), arg5), 0x2::tx_context::sender(arg5));
        };
        let v25 = 0x2::vec_map::empty<0x1::type_name::TypeName, u64>();
        let v26 = 0x2::vec_map::empty<0x1::type_name::TypeName, u64>();
        0x2::vec_map::insert<0x1::type_name::TypeName, u64>(&mut v25, 0x1::type_name::get<T0>(), (*0x2::vec_map::get<u8, u256>(&v21, &v0) as u64));
        0x2::vec_map::insert<0x1::type_name::TypeName, u64>(&mut v26, 0x1::type_name::get<T0>(), (*0x2::vec_map::get<u8, u256>(&v22, &v0) as u64));
        if (0x2::vec_map::contains<u8, u256>(&v21, &v1)) {
            0x2::vec_map::insert<0x1::type_name::TypeName, u64>(&mut v25, 0x1::type_name::get<T1>(), (*0x2::vec_map::get<u8, u256>(&v21, &v1) as u64));
            0x2::vec_map::insert<0x1::type_name::TypeName, u64>(&mut v26, 0x1::type_name::get<T1>(), (*0x2::vec_map::get<u8, u256>(&v22, &v1) as u64));
        };
        0x5b05e2c12f617b33b64ea2b004d89cc18c46b270bc0c214ddd32654fa9a8c84c::events::liquidity_withdrawal_event(0x5b05e2c12f617b33b64ea2b004d89cc18c46b270bc0c214ddd32654fa9a8c84c::ramm::get_id(arg0), 0x2::tx_context::sender(arg5), 0x1::type_name::get<T2>(), v10, v25, v26);
        0x5b05e2c12f617b33b64ea2b004d89cc18c46b270bc0c214ddd32654fa9a8c84c::ramm::check_ramm_invariants_2<T0, T1>(arg0);
    }

    public fun trade_amount_in_2<T0, T1>(arg0: &mut 0x5b05e2c12f617b33b64ea2b004d89cc18c46b270bc0c214ddd32654fa9a8c84c::ramm::RAMM, arg1: &0x2::clock::Clock, arg2: 0x2::coin::Coin<T0>, arg3: u64, arg4: &0x8d79f4d920b03d88faca1e421af023a87fbb1e4a6fd200248e6e9998d09e470::aggregator::Aggregator, arg5: &0x8d79f4d920b03d88faca1e421af023a87fbb1e4a6fd200248e6e9998d09e470::aggregator::Aggregator, arg6: &mut 0x2::tx_context::TxContext) {
        assert!(0x5b05e2c12f617b33b64ea2b004d89cc18c46b270bc0c214ddd32654fa9a8c84c::ramm::get_asset_count(arg0) == 2, 0);
        let v0 = 0x5b05e2c12f617b33b64ea2b004d89cc18c46b270bc0c214ddd32654fa9a8c84c::ramm::get_asset_index<T0>(arg0);
        assert!(0x2::coin::value<T0>(&arg2) >= 0x5b05e2c12f617b33b64ea2b004d89cc18c46b270bc0c214ddd32654fa9a8c84c::ramm::get_min_trade_amount(arg0, v0), 11);
        assert!(0x5b05e2c12f617b33b64ea2b004d89cc18c46b270bc0c214ddd32654fa9a8c84c::ramm::lptok_in_circulation<T0>(arg0, v0) > 0, 3);
        let v1 = 0x5b05e2c12f617b33b64ea2b004d89cc18c46b270bc0c214ddd32654fa9a8c84c::ramm::get_asset_index<T1>(arg0);
        assert!((0x5b05e2c12f617b33b64ea2b004d89cc18c46b270bc0c214ddd32654fa9a8c84c::ramm::get_bal(arg0, v1) as u64) > 0, 4);
        0x5b05e2c12f617b33b64ea2b004d89cc18c46b270bc0c214ddd32654fa9a8c84c::ramm::check_trade_amount_in<T0>(arg0, (0x2::coin::value<T0>(&arg2) as u256));
        let v2 = 0x2::clock::timestamp_ms(arg1);
        let v3 = 0x2::vec_map::empty<u8, u256>();
        let v4 = 0x2::vec_map::empty<u8, u256>();
        let v5 = 0x2::vec_map::empty<u8, u64>();
        0x5b05e2c12f617b33b64ea2b004d89cc18c46b270bc0c214ddd32654fa9a8c84c::ramm::check_feed_and_get_price_data(arg0, v2, v0, arg4, &mut v3, &mut v4, &mut v5);
        0x5b05e2c12f617b33b64ea2b004d89cc18c46b270bc0c214ddd32654fa9a8c84c::ramm::check_feed_and_get_price_data(arg0, v2, v1, arg5, &mut v3, &mut v4, &mut v5);
        let v6 = 0x5b05e2c12f617b33b64ea2b004d89cc18c46b270bc0c214ddd32654fa9a8c84c::ramm::compute_volatility_fee(arg0, v0, *0x2::vec_map::get<u8, u256>(&v3, &v0), *0x2::vec_map::get<u8, u64>(&v5, &v0));
        let v7 = 0x5b05e2c12f617b33b64ea2b004d89cc18c46b270bc0c214ddd32654fa9a8c84c::ramm::compute_volatility_fee(arg0, v1, *0x2::vec_map::get<u8, u256>(&v3, &v1), *0x2::vec_map::get<u8, u64>(&v5, &v1));
        let v8 = 0x2::coin::value<T0>(&arg2);
        let v9 = 0x5b05e2c12f617b33b64ea2b004d89cc18c46b270bc0c214ddd32654fa9a8c84c::ramm::trade_i<T0, T1>(arg0, v0, v1, (v8 as u256), v3, v4, v6 + v7);
        let v10 = *0x2::vec_map::get<u8, u256>(&v3, &v0);
        let v11 = *0x2::vec_map::get<u8, u64>(&v5, &v0);
        let v12 = *0x2::vec_map::get<u8, u256>(&v3, &v1);
        let v13 = *0x2::vec_map::get<u8, u64>(&v5, &v1);
        0x5b05e2c12f617b33b64ea2b004d89cc18c46b270bc0c214ddd32654fa9a8c84c::ramm::update_volatility_data(arg0, v0, 0x5b05e2c12f617b33b64ea2b004d89cc18c46b270bc0c214ddd32654fa9a8c84c::ramm::get_prev_prc(arg0, v0), 0x5b05e2c12f617b33b64ea2b004d89cc18c46b270bc0c214ddd32654fa9a8c84c::ramm::get_prev_prc_tmstmp(arg0, v0), v10, v11, v6);
        0x5b05e2c12f617b33b64ea2b004d89cc18c46b270bc0c214ddd32654fa9a8c84c::ramm::update_volatility_data(arg0, v1, 0x5b05e2c12f617b33b64ea2b004d89cc18c46b270bc0c214ddd32654fa9a8c84c::ramm::get_prev_prc(arg0, v1), 0x5b05e2c12f617b33b64ea2b004d89cc18c46b270bc0c214ddd32654fa9a8c84c::ramm::get_prev_prc_tmstmp(arg0, v1), v12, v13, v7);
        0x5b05e2c12f617b33b64ea2b004d89cc18c46b270bc0c214ddd32654fa9a8c84c::ramm::update_pricing_data<T0>(arg0, v10, v11);
        0x5b05e2c12f617b33b64ea2b004d89cc18c46b270bc0c214ddd32654fa9a8c84c::ramm::update_pricing_data<T1>(arg0, v12, v13);
        let v14 = 0x5b05e2c12f617b33b64ea2b004d89cc18c46b270bc0c214ddd32654fa9a8c84c::ramm::amount(&v9);
        0x5b05e2c12f617b33b64ea2b004d89cc18c46b270bc0c214ddd32654fa9a8c84c::ramm::check_trade_amount_out<T1>(arg0, v14);
        let v15 = (v14 as u64);
        if (0x5b05e2c12f617b33b64ea2b004d89cc18c46b270bc0c214ddd32654fa9a8c84c::ramm::is_successful(&v9)) {
            assert!(v15 >= arg3, 6);
            let v16 = 0x2::coin::into_balance<T0>(arg2);
            let v17 = (0x5b05e2c12f617b33b64ea2b004d89cc18c46b270bc0c214ddd32654fa9a8c84c::ramm::protocol_fee(&v9) as u64);
            0x5b05e2c12f617b33b64ea2b004d89cc18c46b270bc0c214ddd32654fa9a8c84c::ramm::join_protocol_fees<T0>(arg0, v0, 0x2::balance::split<T0>(&mut v16, v17));
            0x5b05e2c12f617b33b64ea2b004d89cc18c46b270bc0c214ddd32654fa9a8c84c::ramm::join_bal(arg0, v0, (0x2::balance::value<T0>(&v16) as u256));
            0x5b05e2c12f617b33b64ea2b004d89cc18c46b270bc0c214ddd32654fa9a8c84c::ramm::join_typed_bal<T0>(arg0, v0, v16);
            0x5b05e2c12f617b33b64ea2b004d89cc18c46b270bc0c214ddd32654fa9a8c84c::ramm::split_bal(arg0, v1, v14);
            0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(0x2::coin::from_balance<T1>(0x5b05e2c12f617b33b64ea2b004d89cc18c46b270bc0c214ddd32654fa9a8c84c::ramm::split_typed_bal<T1>(arg0, v1, v15), arg6), 0x2::tx_context::sender(arg6));
            0x5b05e2c12f617b33b64ea2b004d89cc18c46b270bc0c214ddd32654fa9a8c84c::events::trade_event<0x5b05e2c12f617b33b64ea2b004d89cc18c46b270bc0c214ddd32654fa9a8c84c::events::TradeIn>(0x5b05e2c12f617b33b64ea2b004d89cc18c46b270bc0c214ddd32654fa9a8c84c::ramm::get_id(arg0), 0x2::tx_context::sender(arg6), 0x1::type_name::get<T0>(), 0x1::type_name::get<T1>(), v8, v15, v17);
            0x5b05e2c12f617b33b64ea2b004d89cc18c46b270bc0c214ddd32654fa9a8c84c::ramm::check_ramm_invariants_2<T0, T1>(arg0);
            return
        } else if (0x5b05e2c12f617b33b64ea2b004d89cc18c46b270bc0c214ddd32654fa9a8c84c::ramm::trade_outcome(&v9) == 0x5b05e2c12f617b33b64ea2b004d89cc18c46b270bc0c214ddd32654fa9a8c84c::ramm::failed_pool_imbalance()) {
            abort 7
        } else if (0x5b05e2c12f617b33b64ea2b004d89cc18c46b270bc0c214ddd32654fa9a8c84c::ramm::trade_outcome(&v9) == 0x5b05e2c12f617b33b64ea2b004d89cc18c46b270bc0c214ddd32654fa9a8c84c::ramm::failed_insufficient_out_token_balance()) {
            abort 8
        } else {
            assert!(0x5b05e2c12f617b33b64ea2b004d89cc18c46b270bc0c214ddd32654fa9a8c84c::ramm::trade_outcome(&v9) == 0x5b05e2c12f617b33b64ea2b004d89cc18c46b270bc0c214ddd32654fa9a8c84c::ramm::failed_low_out_token_imb_ratio(), 10);
            abort 9
        };
    }

    public fun trade_amount_out_2<T0, T1>(arg0: &mut 0x5b05e2c12f617b33b64ea2b004d89cc18c46b270bc0c214ddd32654fa9a8c84c::ramm::RAMM, arg1: &0x2::clock::Clock, arg2: u64, arg3: 0x2::coin::Coin<T0>, arg4: &0x8d79f4d920b03d88faca1e421af023a87fbb1e4a6fd200248e6e9998d09e470::aggregator::Aggregator, arg5: &0x8d79f4d920b03d88faca1e421af023a87fbb1e4a6fd200248e6e9998d09e470::aggregator::Aggregator, arg6: &mut 0x2::tx_context::TxContext) {
        assert!(0x5b05e2c12f617b33b64ea2b004d89cc18c46b270bc0c214ddd32654fa9a8c84c::ramm::get_asset_count(arg0) == 2, 0);
        let v0 = 0x5b05e2c12f617b33b64ea2b004d89cc18c46b270bc0c214ddd32654fa9a8c84c::ramm::get_asset_index<T0>(arg0);
        assert!(0x5b05e2c12f617b33b64ea2b004d89cc18c46b270bc0c214ddd32654fa9a8c84c::ramm::lptok_in_circulation<T0>(arg0, v0) > 0, 3);
        let v1 = 0x5b05e2c12f617b33b64ea2b004d89cc18c46b270bc0c214ddd32654fa9a8c84c::ramm::get_asset_index<T1>(arg0);
        assert!(arg2 >= 0x5b05e2c12f617b33b64ea2b004d89cc18c46b270bc0c214ddd32654fa9a8c84c::ramm::get_min_trade_amount(arg0, v1), 11);
        let v2 = (0x5b05e2c12f617b33b64ea2b004d89cc18c46b270bc0c214ddd32654fa9a8c84c::ramm::get_bal(arg0, v1) as u64);
        assert!(v2 >= arg2, 4);
        if (arg2 == v2) {
            assert!(0x5b05e2c12f617b33b64ea2b004d89cc18c46b270bc0c214ddd32654fa9a8c84c::ramm::lptok_in_circulation<T1>(arg0, v1) == 0, 5);
        };
        0x5b05e2c12f617b33b64ea2b004d89cc18c46b270bc0c214ddd32654fa9a8c84c::ramm::check_trade_amount_out<T1>(arg0, (arg2 as u256));
        let v3 = 0x2::clock::timestamp_ms(arg1);
        let v4 = 0x2::vec_map::empty<u8, u256>();
        let v5 = 0x2::vec_map::empty<u8, u256>();
        let v6 = 0x2::vec_map::empty<u8, u64>();
        0x5b05e2c12f617b33b64ea2b004d89cc18c46b270bc0c214ddd32654fa9a8c84c::ramm::check_feed_and_get_price_data(arg0, v3, v0, arg4, &mut v4, &mut v5, &mut v6);
        0x5b05e2c12f617b33b64ea2b004d89cc18c46b270bc0c214ddd32654fa9a8c84c::ramm::check_feed_and_get_price_data(arg0, v3, v1, arg5, &mut v4, &mut v5, &mut v6);
        let v7 = 0x5b05e2c12f617b33b64ea2b004d89cc18c46b270bc0c214ddd32654fa9a8c84c::ramm::compute_volatility_fee(arg0, v0, *0x2::vec_map::get<u8, u256>(&v4, &v0), *0x2::vec_map::get<u8, u64>(&v6, &v0));
        let v8 = 0x5b05e2c12f617b33b64ea2b004d89cc18c46b270bc0c214ddd32654fa9a8c84c::ramm::compute_volatility_fee(arg0, v1, *0x2::vec_map::get<u8, u256>(&v4, &v1), *0x2::vec_map::get<u8, u64>(&v6, &v1));
        let v9 = 0x5b05e2c12f617b33b64ea2b004d89cc18c46b270bc0c214ddd32654fa9a8c84c::ramm::trade_o<T0, T1>(arg0, v0, v1, arg2, v4, v5, v7 + v8);
        let v10 = *0x2::vec_map::get<u8, u256>(&v4, &v0);
        let v11 = *0x2::vec_map::get<u8, u64>(&v6, &v0);
        let v12 = *0x2::vec_map::get<u8, u256>(&v4, &v1);
        let v13 = *0x2::vec_map::get<u8, u64>(&v6, &v1);
        0x5b05e2c12f617b33b64ea2b004d89cc18c46b270bc0c214ddd32654fa9a8c84c::ramm::update_volatility_data(arg0, v0, 0x5b05e2c12f617b33b64ea2b004d89cc18c46b270bc0c214ddd32654fa9a8c84c::ramm::get_prev_prc(arg0, v0), 0x5b05e2c12f617b33b64ea2b004d89cc18c46b270bc0c214ddd32654fa9a8c84c::ramm::get_prev_prc_tmstmp(arg0, v0), v10, v11, v7);
        0x5b05e2c12f617b33b64ea2b004d89cc18c46b270bc0c214ddd32654fa9a8c84c::ramm::update_volatility_data(arg0, v1, 0x5b05e2c12f617b33b64ea2b004d89cc18c46b270bc0c214ddd32654fa9a8c84c::ramm::get_prev_prc(arg0, v1), 0x5b05e2c12f617b33b64ea2b004d89cc18c46b270bc0c214ddd32654fa9a8c84c::ramm::get_prev_prc_tmstmp(arg0, v1), v12, v13, v8);
        0x5b05e2c12f617b33b64ea2b004d89cc18c46b270bc0c214ddd32654fa9a8c84c::ramm::update_pricing_data<T0>(arg0, v10, v11);
        0x5b05e2c12f617b33b64ea2b004d89cc18c46b270bc0c214ddd32654fa9a8c84c::ramm::update_pricing_data<T1>(arg0, v12, v13);
        0x5b05e2c12f617b33b64ea2b004d89cc18c46b270bc0c214ddd32654fa9a8c84c::ramm::check_trade_amount_in<T0>(arg0, 0x5b05e2c12f617b33b64ea2b004d89cc18c46b270bc0c214ddd32654fa9a8c84c::ramm::amount(&v9));
        let v14 = (0x5b05e2c12f617b33b64ea2b004d89cc18c46b270bc0c214ddd32654fa9a8c84c::ramm::amount(&v9) as u64);
        if (0x5b05e2c12f617b33b64ea2b004d89cc18c46b270bc0c214ddd32654fa9a8c84c::ramm::is_successful(&v9)) {
            assert!(v14 <= 0x2::coin::value<T0>(&arg3), 6);
            let v15 = 0x2::coin::into_balance<T0>(arg3);
            let v16 = 0x2::balance::split<T0>(&mut v15, v14);
            let v17 = (0x5b05e2c12f617b33b64ea2b004d89cc18c46b270bc0c214ddd32654fa9a8c84c::ramm::protocol_fee(&v9) as u64);
            0x5b05e2c12f617b33b64ea2b004d89cc18c46b270bc0c214ddd32654fa9a8c84c::ramm::join_protocol_fees<T0>(arg0, v0, 0x2::balance::split<T0>(&mut v16, v17));
            0x5b05e2c12f617b33b64ea2b004d89cc18c46b270bc0c214ddd32654fa9a8c84c::ramm::join_bal(arg0, v0, (0x2::balance::value<T0>(&v16) as u256));
            0x5b05e2c12f617b33b64ea2b004d89cc18c46b270bc0c214ddd32654fa9a8c84c::ramm::join_typed_bal<T0>(arg0, v0, v16);
            0x5b05e2c12f617b33b64ea2b004d89cc18c46b270bc0c214ddd32654fa9a8c84c::ramm::split_bal(arg0, v1, (arg2 as u256));
            0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(0x2::coin::from_balance<T1>(0x5b05e2c12f617b33b64ea2b004d89cc18c46b270bc0c214ddd32654fa9a8c84c::ramm::split_typed_bal<T1>(arg0, v1, arg2), arg6), 0x2::tx_context::sender(arg6));
            0x5b05e2c12f617b33b64ea2b004d89cc18c46b270bc0c214ddd32654fa9a8c84c::events::trade_event<0x5b05e2c12f617b33b64ea2b004d89cc18c46b270bc0c214ddd32654fa9a8c84c::events::TradeOut>(0x5b05e2c12f617b33b64ea2b004d89cc18c46b270bc0c214ddd32654fa9a8c84c::ramm::get_id(arg0), 0x2::tx_context::sender(arg6), 0x1::type_name::get<T0>(), 0x1::type_name::get<T1>(), v14, arg2, v17);
            if (0x2::balance::value<T0>(&v15) > 0) {
                0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(v15, arg6), 0x2::tx_context::sender(arg6));
            } else {
                0x2::balance::destroy_zero<T0>(v15);
            };
            0x5b05e2c12f617b33b64ea2b004d89cc18c46b270bc0c214ddd32654fa9a8c84c::ramm::check_ramm_invariants_2<T0, T1>(arg0);
            return
        } else if (0x5b05e2c12f617b33b64ea2b004d89cc18c46b270bc0c214ddd32654fa9a8c84c::ramm::trade_outcome(&v9) == 0x5b05e2c12f617b33b64ea2b004d89cc18c46b270bc0c214ddd32654fa9a8c84c::ramm::failed_pool_imbalance()) {
            abort 7
        } else if (0x5b05e2c12f617b33b64ea2b004d89cc18c46b270bc0c214ddd32654fa9a8c84c::ramm::trade_outcome(&v9) == 0x5b05e2c12f617b33b64ea2b004d89cc18c46b270bc0c214ddd32654fa9a8c84c::ramm::failed_insufficient_out_token_balance()) {
            abort 8
        } else {
            assert!(0x5b05e2c12f617b33b64ea2b004d89cc18c46b270bc0c214ddd32654fa9a8c84c::ramm::trade_outcome(&v9) == 0x5b05e2c12f617b33b64ea2b004d89cc18c46b270bc0c214ddd32654fa9a8c84c::ramm::failed_low_out_token_imb_ratio(), 10);
            abort 9
        };
    }

    // decompiled from Move bytecode v6
}

