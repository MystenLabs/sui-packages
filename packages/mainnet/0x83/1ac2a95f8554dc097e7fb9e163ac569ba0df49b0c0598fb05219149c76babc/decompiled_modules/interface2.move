module 0x831ac2a95f8554dc097e7fb9e163ac569ba0df49b0c0598fb05219149c76babc::interface2 {
    public entry fun collect_fees_2<T0, T1>(arg0: &mut 0x831ac2a95f8554dc097e7fb9e163ac569ba0df49b0c0598fb05219149c76babc::ramm::RAMM, arg1: &0x831ac2a95f8554dc097e7fb9e163ac569ba0df49b0c0598fb05219149c76babc::ramm::RAMMAdminCap, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(0x831ac2a95f8554dc097e7fb9e163ac569ba0df49b0c0598fb05219149c76babc::ramm::get_admin_cap_id(arg0) == 0x2::object::id<0x831ac2a95f8554dc097e7fb9e163ac569ba0df49b0c0598fb05219149c76babc::ramm::RAMMAdminCap>(arg1), 7);
        assert!(0x831ac2a95f8554dc097e7fb9e163ac569ba0df49b0c0598fb05219149c76babc::ramm::get_asset_count(arg0) == 2, 0);
        let v0 = 0x2::coin::from_balance<T0>(0x831ac2a95f8554dc097e7fb9e163ac569ba0df49b0c0598fb05219149c76babc::ramm::get_fees_for_asset<T0>(arg0, 0x831ac2a95f8554dc097e7fb9e163ac569ba0df49b0c0598fb05219149c76babc::ramm::get_asset_index<T0>(arg0)), arg2);
        let v1 = 0x2::coin::from_balance<T1>(0x831ac2a95f8554dc097e7fb9e163ac569ba0df49b0c0598fb05219149c76babc::ramm::get_fees_for_asset<T1>(arg0, 0x831ac2a95f8554dc097e7fb9e163ac569ba0df49b0c0598fb05219149c76babc::ramm::get_asset_index<T1>(arg0)), arg2);
        let v2 = 0x2::coin::value<T0>(&v0);
        let v3 = 0x2::coin::value<T1>(&v1);
        let v4 = 0x2::vec_map::empty<0x1::type_name::TypeName, u64>();
        0x2::vec_map::insert<0x1::type_name::TypeName, u64>(&mut v4, 0x1::type_name::get<T0>(), v2);
        0x2::vec_map::insert<0x1::type_name::TypeName, u64>(&mut v4, 0x1::type_name::get<T1>(), v3);
        let v5 = 0x831ac2a95f8554dc097e7fb9e163ac569ba0df49b0c0598fb05219149c76babc::ramm::get_fee_collector(arg0);
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
        0x831ac2a95f8554dc097e7fb9e163ac569ba0df49b0c0598fb05219149c76babc::events::fee_collection_event(0x831ac2a95f8554dc097e7fb9e163ac569ba0df49b0c0598fb05219149c76babc::ramm::get_id(arg0), 0x2::tx_context::sender(arg2), v5, v4);
        0x831ac2a95f8554dc097e7fb9e163ac569ba0df49b0c0598fb05219149c76babc::ramm::check_ramm_invariants_2<T0, T1>(arg0);
    }

    public entry fun liquidity_deposit_2<T0, T1>(arg0: &mut 0x831ac2a95f8554dc097e7fb9e163ac569ba0df49b0c0598fb05219149c76babc::ramm::RAMM, arg1: 0x2::coin::Coin<T0>, arg2: &0x8d79f4d920b03d88faca1e421af023a87fbb1e4a6fd200248e6e9998d09e470::aggregator::Aggregator, arg3: &0x8d79f4d920b03d88faca1e421af023a87fbb1e4a6fd200248e6e9998d09e470::aggregator::Aggregator, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(0x831ac2a95f8554dc097e7fb9e163ac569ba0df49b0c0598fb05219149c76babc::ramm::get_asset_count(arg0) == 2, 0);
        assert!(0x2::coin::value<T0>(&arg1) > 0, 2);
        let v0 = 0x831ac2a95f8554dc097e7fb9e163ac569ba0df49b0c0598fb05219149c76babc::ramm::get_asset_index<T0>(arg0);
        assert!(0x831ac2a95f8554dc097e7fb9e163ac569ba0df49b0c0598fb05219149c76babc::ramm::can_deposit_asset(arg0, v0), 1);
        let v1 = 0x831ac2a95f8554dc097e7fb9e163ac569ba0df49b0c0598fb05219149c76babc::ramm::get_asset_index<T1>(arg0);
        let v2 = 0x2::vec_map::empty<u8, u256>();
        let v3 = 0x2::vec_map::empty<u8, u256>();
        let v4 = 0x2::vec_map::empty<u8, u64>();
        0x831ac2a95f8554dc097e7fb9e163ac569ba0df49b0c0598fb05219149c76babc::ramm::check_feed_and_get_price_data(arg0, v0, arg2, &mut v2, &mut v3, &mut v4);
        0x831ac2a95f8554dc097e7fb9e163ac569ba0df49b0c0598fb05219149c76babc::ramm::check_feed_and_get_price_data(arg0, v1, arg3, &mut v2, &mut v3, &mut v4);
        let v5 = 0x831ac2a95f8554dc097e7fb9e163ac569ba0df49b0c0598fb05219149c76babc::ramm::liq_dep<T0>(arg0, v0, 0x2::coin::value<T0>(&arg1), v2, v3);
        let v6 = *0x2::vec_map::get<u8, u256>(&v2, &v0);
        let v7 = *0x2::vec_map::get<u8, u64>(&v4, &v0);
        let v8 = *0x2::vec_map::get<u8, u256>(&v2, &v1);
        let v9 = *0x2::vec_map::get<u8, u64>(&v4, &v1);
        0x831ac2a95f8554dc097e7fb9e163ac569ba0df49b0c0598fb05219149c76babc::ramm::update_volatility_data(arg0, v0, 0x831ac2a95f8554dc097e7fb9e163ac569ba0df49b0c0598fb05219149c76babc::ramm::get_prev_prc(arg0, v0), 0x831ac2a95f8554dc097e7fb9e163ac569ba0df49b0c0598fb05219149c76babc::ramm::get_prev_prc_tmstmp(arg0, v0), v6, v7, 0x831ac2a95f8554dc097e7fb9e163ac569ba0df49b0c0598fb05219149c76babc::ramm::compute_volatility_fee(arg0, v0, *0x2::vec_map::get<u8, u256>(&v2, &v0), *0x2::vec_map::get<u8, u64>(&v4, &v0)));
        0x831ac2a95f8554dc097e7fb9e163ac569ba0df49b0c0598fb05219149c76babc::ramm::update_volatility_data(arg0, v1, 0x831ac2a95f8554dc097e7fb9e163ac569ba0df49b0c0598fb05219149c76babc::ramm::get_prev_prc(arg0, v1), 0x831ac2a95f8554dc097e7fb9e163ac569ba0df49b0c0598fb05219149c76babc::ramm::get_prev_prc_tmstmp(arg0, v1), v8, v9, 0x831ac2a95f8554dc097e7fb9e163ac569ba0df49b0c0598fb05219149c76babc::ramm::compute_volatility_fee(arg0, v1, *0x2::vec_map::get<u8, u256>(&v2, &v1), *0x2::vec_map::get<u8, u64>(&v4, &v1)));
        0x831ac2a95f8554dc097e7fb9e163ac569ba0df49b0c0598fb05219149c76babc::ramm::update_pricing_data<T0>(arg0, v6, v7);
        0x831ac2a95f8554dc097e7fb9e163ac569ba0df49b0c0598fb05219149c76babc::ramm::update_pricing_data<T1>(arg0, v8, v9);
        if (v5 == 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(arg1, 0x2::tx_context::sender(arg4));
            0x831ac2a95f8554dc097e7fb9e163ac569ba0df49b0c0598fb05219149c76babc::events::liquidity_deposit_failure_event(0x831ac2a95f8554dc097e7fb9e163ac569ba0df49b0c0598fb05219149c76babc::ramm::get_id(arg0), 0x2::tx_context::sender(arg4), 0x1::type_name::get<T0>(), 0x2::coin::value<T0>(&arg1));
        } else {
            let v10 = 0x2::coin::into_balance<T0>(arg1);
            0x831ac2a95f8554dc097e7fb9e163ac569ba0df49b0c0598fb05219149c76babc::ramm::join_bal(arg0, v0, (0x2::balance::value<T0>(&v10) as u256));
            0x831ac2a95f8554dc097e7fb9e163ac569ba0df49b0c0598fb05219149c76babc::ramm::join_typed_bal<T0>(arg0, v0, v10);
            0x831ac2a95f8554dc097e7fb9e163ac569ba0df49b0c0598fb05219149c76babc::ramm::incr_lptokens_issued<T0>(arg0, v5);
            let v11 = 0x2::coin::from_balance<0x831ac2a95f8554dc097e7fb9e163ac569ba0df49b0c0598fb05219149c76babc::ramm::LP<T0>>(0x831ac2a95f8554dc097e7fb9e163ac569ba0df49b0c0598fb05219149c76babc::ramm::mint_lp_tokens<T0>(arg0, v5), arg4);
            0x2::transfer::public_transfer<0x2::coin::Coin<0x831ac2a95f8554dc097e7fb9e163ac569ba0df49b0c0598fb05219149c76babc::ramm::LP<T0>>>(v11, 0x2::tx_context::sender(arg4));
            0x831ac2a95f8554dc097e7fb9e163ac569ba0df49b0c0598fb05219149c76babc::events::liquidity_deposit_event(0x831ac2a95f8554dc097e7fb9e163ac569ba0df49b0c0598fb05219149c76babc::ramm::get_id(arg0), 0x2::tx_context::sender(arg4), 0x1::type_name::get<T0>(), 0x2::coin::value<T0>(&arg1), 0x2::coin::value<0x831ac2a95f8554dc097e7fb9e163ac569ba0df49b0c0598fb05219149c76babc::ramm::LP<T0>>(&v11));
        };
        0x831ac2a95f8554dc097e7fb9e163ac569ba0df49b0c0598fb05219149c76babc::ramm::check_ramm_invariants_2<T0, T1>(arg0);
    }

    public entry fun liquidity_withdrawal_2<T0, T1, T2>(arg0: &mut 0x831ac2a95f8554dc097e7fb9e163ac569ba0df49b0c0598fb05219149c76babc::ramm::RAMM, arg1: 0x2::coin::Coin<0x831ac2a95f8554dc097e7fb9e163ac569ba0df49b0c0598fb05219149c76babc::ramm::LP<T2>>, arg2: &0x8d79f4d920b03d88faca1e421af023a87fbb1e4a6fd200248e6e9998d09e470::aggregator::Aggregator, arg3: &0x8d79f4d920b03d88faca1e421af023a87fbb1e4a6fd200248e6e9998d09e470::aggregator::Aggregator, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(0x831ac2a95f8554dc097e7fb9e163ac569ba0df49b0c0598fb05219149c76babc::ramm::get_asset_count(arg0) == 2, 0);
        assert!(0x2::coin::value<0x831ac2a95f8554dc097e7fb9e163ac569ba0df49b0c0598fb05219149c76babc::ramm::LP<T2>>(&arg1) > 0, 9);
        let v0 = 0x831ac2a95f8554dc097e7fb9e163ac569ba0df49b0c0598fb05219149c76babc::ramm::get_asset_index<T0>(arg0);
        let v1 = 0x831ac2a95f8554dc097e7fb9e163ac569ba0df49b0c0598fb05219149c76babc::ramm::get_asset_index<T1>(arg0);
        let v2 = 0x831ac2a95f8554dc097e7fb9e163ac569ba0df49b0c0598fb05219149c76babc::ramm::get_asset_index<T2>(arg0);
        let v3 = 0x2::vec_map::empty<u8, u256>();
        let v4 = 0x2::vec_map::empty<u8, u256>();
        let v5 = 0x2::vec_map::empty<u8, u64>();
        0x831ac2a95f8554dc097e7fb9e163ac569ba0df49b0c0598fb05219149c76babc::ramm::check_feed_and_get_price_data(arg0, v0, arg2, &mut v3, &mut v4, &mut v5);
        0x831ac2a95f8554dc097e7fb9e163ac569ba0df49b0c0598fb05219149c76babc::ramm::check_feed_and_get_price_data(arg0, v1, arg3, &mut v3, &mut v4, &mut v5);
        let v6 = 0x831ac2a95f8554dc097e7fb9e163ac569ba0df49b0c0598fb05219149c76babc::ramm::compute_volatility_fee(arg0, v0, *0x2::vec_map::get<u8, u256>(&v3, &v0), *0x2::vec_map::get<u8, u64>(&v5, &v0));
        let v7 = 0x831ac2a95f8554dc097e7fb9e163ac569ba0df49b0c0598fb05219149c76babc::ramm::compute_volatility_fee(arg0, v1, *0x2::vec_map::get<u8, u256>(&v3, &v1), *0x2::vec_map::get<u8, u64>(&v5, &v1));
        let v8 = 0x2::vec_map::empty<u8, u256>();
        0x2::vec_map::insert<u8, u256>(&mut v8, v0, v6);
        0x2::vec_map::insert<u8, u256>(&mut v8, v1, v7);
        let v9 = 0x2::coin::value<0x831ac2a95f8554dc097e7fb9e163ac569ba0df49b0c0598fb05219149c76babc::ramm::LP<T2>>(&arg1);
        let v10 = 0x831ac2a95f8554dc097e7fb9e163ac569ba0df49b0c0598fb05219149c76babc::ramm::get_fact_for_bal(arg0, v2);
        let v11 = 0x831ac2a95f8554dc097e7fb9e163ac569ba0df49b0c0598fb05219149c76babc::ramm::liq_wthdrw<T2>(arg0, v2, v9, v3, v4, v8);
        let v12 = *0x2::vec_map::get<u8, u256>(&v3, &v0);
        let v13 = *0x2::vec_map::get<u8, u64>(&v5, &v0);
        let v14 = *0x2::vec_map::get<u8, u256>(&v3, &v1);
        let v15 = *0x2::vec_map::get<u8, u64>(&v5, &v1);
        0x831ac2a95f8554dc097e7fb9e163ac569ba0df49b0c0598fb05219149c76babc::ramm::update_volatility_data(arg0, v0, 0x831ac2a95f8554dc097e7fb9e163ac569ba0df49b0c0598fb05219149c76babc::ramm::get_prev_prc(arg0, v0), 0x831ac2a95f8554dc097e7fb9e163ac569ba0df49b0c0598fb05219149c76babc::ramm::get_prev_prc_tmstmp(arg0, v0), v12, v13, v6);
        0x831ac2a95f8554dc097e7fb9e163ac569ba0df49b0c0598fb05219149c76babc::ramm::update_volatility_data(arg0, v1, 0x831ac2a95f8554dc097e7fb9e163ac569ba0df49b0c0598fb05219149c76babc::ramm::get_prev_prc(arg0, v1), 0x831ac2a95f8554dc097e7fb9e163ac569ba0df49b0c0598fb05219149c76babc::ramm::get_prev_prc_tmstmp(arg0, v1), v14, v15, v7);
        0x831ac2a95f8554dc097e7fb9e163ac569ba0df49b0c0598fb05219149c76babc::ramm::update_pricing_data<T0>(arg0, v12, v13);
        0x831ac2a95f8554dc097e7fb9e163ac569ba0df49b0c0598fb05219149c76babc::ramm::update_pricing_data<T1>(arg0, v14, v15);
        let v16 = (v9 as u256);
        let v17 = &mut v16;
        if (0x831ac2a95f8554dc097e7fb9e163ac569ba0df49b0c0598fb05219149c76babc::ramm::remaining(&v11) > 0) {
            *v17 = 0x831ac2a95f8554dc097e7fb9e163ac569ba0df49b0c0598fb05219149c76babc::ramm::div(0x831ac2a95f8554dc097e7fb9e163ac569ba0df49b0c0598fb05219149c76babc::ramm::mul(v16 * 1000, (0x831ac2a95f8554dc097e7fb9e163ac569ba0df49b0c0598fb05219149c76babc::ramm::value(&v11) - 0x831ac2a95f8554dc097e7fb9e163ac569ba0df49b0c0598fb05219149c76babc::ramm::remaining(&v11)) * v10), 0x831ac2a95f8554dc097e7fb9e163ac569ba0df49b0c0598fb05219149c76babc::ramm::value(&v11) * v10) / 1000;
        };
        let v18 = (*v17 as u64);
        let v19 = 0x2::coin::into_balance<0x831ac2a95f8554dc097e7fb9e163ac569ba0df49b0c0598fb05219149c76babc::ramm::LP<T2>>(arg1);
        0x831ac2a95f8554dc097e7fb9e163ac569ba0df49b0c0598fb05219149c76babc::ramm::decr_lptokens_issued<T2>(arg0, v18);
        assert!(0x831ac2a95f8554dc097e7fb9e163ac569ba0df49b0c0598fb05219149c76babc::ramm::burn_lp_tokens<T2>(arg0, 0x2::balance::split<0x831ac2a95f8554dc097e7fb9e163ac569ba0df49b0c0598fb05219149c76babc::ramm::LP<T2>>(&mut v19, v18)) == v18, 8);
        if (0x2::balance::value<0x831ac2a95f8554dc097e7fb9e163ac569ba0df49b0c0598fb05219149c76babc::ramm::LP<T2>>(&v19) == 0) {
            0x2::balance::destroy_zero<0x831ac2a95f8554dc097e7fb9e163ac569ba0df49b0c0598fb05219149c76babc::ramm::LP<T2>>(v19);
        } else {
            0x2::transfer::public_transfer<0x2::coin::Coin<0x831ac2a95f8554dc097e7fb9e163ac569ba0df49b0c0598fb05219149c76babc::ramm::LP<T2>>>(0x2::coin::from_balance<0x831ac2a95f8554dc097e7fb9e163ac569ba0df49b0c0598fb05219149c76babc::ramm::LP<T2>>(v19, arg4), 0x2::tx_context::sender(arg4));
        };
        let v20 = 0x831ac2a95f8554dc097e7fb9e163ac569ba0df49b0c0598fb05219149c76babc::ramm::amounts(&v11);
        let v21 = 0x831ac2a95f8554dc097e7fb9e163ac569ba0df49b0c0598fb05219149c76babc::ramm::fees(&v11);
        let v22 = *0x2::vec_map::get<u8, u256>(&v20, &v0);
        if (v22 != 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x831ac2a95f8554dc097e7fb9e163ac569ba0df49b0c0598fb05219149c76babc::ramm::liq_withdraw_helper<T0>(arg0, v0, v22, *0x2::vec_map::get<u8, u256>(&v21, &v0), arg4), 0x2::tx_context::sender(arg4));
        };
        let v23 = *0x2::vec_map::get<u8, u256>(&v20, &v1);
        if (v23 != 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(0x831ac2a95f8554dc097e7fb9e163ac569ba0df49b0c0598fb05219149c76babc::ramm::liq_withdraw_helper<T1>(arg0, v1, v23, *0x2::vec_map::get<u8, u256>(&v21, &v1), arg4), 0x2::tx_context::sender(arg4));
        };
        let v24 = 0x2::vec_map::empty<0x1::type_name::TypeName, u64>();
        let v25 = 0x2::vec_map::empty<0x1::type_name::TypeName, u64>();
        0x2::vec_map::insert<0x1::type_name::TypeName, u64>(&mut v24, 0x1::type_name::get<T0>(), (*0x2::vec_map::get<u8, u256>(&v20, &v0) as u64));
        0x2::vec_map::insert<0x1::type_name::TypeName, u64>(&mut v25, 0x1::type_name::get<T0>(), (*0x2::vec_map::get<u8, u256>(&v21, &v0) as u64));
        if (0x2::vec_map::contains<u8, u256>(&v20, &v1)) {
            0x2::vec_map::insert<0x1::type_name::TypeName, u64>(&mut v24, 0x1::type_name::get<T1>(), (*0x2::vec_map::get<u8, u256>(&v20, &v1) as u64));
            0x2::vec_map::insert<0x1::type_name::TypeName, u64>(&mut v25, 0x1::type_name::get<T1>(), (*0x2::vec_map::get<u8, u256>(&v21, &v1) as u64));
        };
        0x831ac2a95f8554dc097e7fb9e163ac569ba0df49b0c0598fb05219149c76babc::events::liquidity_withdrawal_event(0x831ac2a95f8554dc097e7fb9e163ac569ba0df49b0c0598fb05219149c76babc::ramm::get_id(arg0), 0x2::tx_context::sender(arg4), 0x1::type_name::get<T2>(), v9, v24, v25);
        0x831ac2a95f8554dc097e7fb9e163ac569ba0df49b0c0598fb05219149c76babc::ramm::check_ramm_invariants_2<T0, T1>(arg0);
    }

    public entry fun trade_amount_in_2<T0, T1>(arg0: &mut 0x831ac2a95f8554dc097e7fb9e163ac569ba0df49b0c0598fb05219149c76babc::ramm::RAMM, arg1: 0x2::coin::Coin<T0>, arg2: u64, arg3: &0x8d79f4d920b03d88faca1e421af023a87fbb1e4a6fd200248e6e9998d09e470::aggregator::Aggregator, arg4: &0x8d79f4d920b03d88faca1e421af023a87fbb1e4a6fd200248e6e9998d09e470::aggregator::Aggregator, arg5: &mut 0x2::tx_context::TxContext) {
        assert!(0x831ac2a95f8554dc097e7fb9e163ac569ba0df49b0c0598fb05219149c76babc::ramm::get_asset_count(arg0) == 2, 0);
        let v0 = 0x831ac2a95f8554dc097e7fb9e163ac569ba0df49b0c0598fb05219149c76babc::ramm::get_asset_index<T0>(arg0);
        assert!(0x2::coin::value<T0>(&arg1) >= 0x831ac2a95f8554dc097e7fb9e163ac569ba0df49b0c0598fb05219149c76babc::ramm::get_min_trade_amount(arg0, v0), 6);
        assert!(0x831ac2a95f8554dc097e7fb9e163ac569ba0df49b0c0598fb05219149c76babc::ramm::lptok_in_circulation<T0>(arg0, v0) > 0, 3);
        let v1 = 0x831ac2a95f8554dc097e7fb9e163ac569ba0df49b0c0598fb05219149c76babc::ramm::get_asset_index<T1>(arg0);
        assert!((0x831ac2a95f8554dc097e7fb9e163ac569ba0df49b0c0598fb05219149c76babc::ramm::get_bal(arg0, v1) as u64) > 0, 4);
        0x831ac2a95f8554dc097e7fb9e163ac569ba0df49b0c0598fb05219149c76babc::ramm::check_trade_amount_in<T0>(arg0, (0x2::coin::value<T0>(&arg1) as u256));
        let v2 = 0x2::vec_map::empty<u8, u256>();
        let v3 = 0x2::vec_map::empty<u8, u256>();
        let v4 = 0x2::vec_map::empty<u8, u64>();
        0x831ac2a95f8554dc097e7fb9e163ac569ba0df49b0c0598fb05219149c76babc::ramm::check_feed_and_get_price_data(arg0, v0, arg3, &mut v2, &mut v3, &mut v4);
        0x831ac2a95f8554dc097e7fb9e163ac569ba0df49b0c0598fb05219149c76babc::ramm::check_feed_and_get_price_data(arg0, v1, arg4, &mut v2, &mut v3, &mut v4);
        let v5 = 0x831ac2a95f8554dc097e7fb9e163ac569ba0df49b0c0598fb05219149c76babc::ramm::compute_volatility_fee(arg0, v0, *0x2::vec_map::get<u8, u256>(&v2, &v0), *0x2::vec_map::get<u8, u64>(&v4, &v0));
        let v6 = 0x831ac2a95f8554dc097e7fb9e163ac569ba0df49b0c0598fb05219149c76babc::ramm::compute_volatility_fee(arg0, v1, *0x2::vec_map::get<u8, u256>(&v2, &v1), *0x2::vec_map::get<u8, u64>(&v4, &v1));
        let v7 = 0x2::coin::value<T0>(&arg1);
        let v8 = 0x831ac2a95f8554dc097e7fb9e163ac569ba0df49b0c0598fb05219149c76babc::ramm::trade_i<T0, T1>(arg0, v0, v1, (v7 as u256), v2, v3, v5 + v6);
        let v9 = *0x2::vec_map::get<u8, u256>(&v2, &v0);
        let v10 = *0x2::vec_map::get<u8, u64>(&v4, &v0);
        let v11 = *0x2::vec_map::get<u8, u256>(&v2, &v1);
        let v12 = *0x2::vec_map::get<u8, u64>(&v4, &v1);
        0x831ac2a95f8554dc097e7fb9e163ac569ba0df49b0c0598fb05219149c76babc::ramm::update_volatility_data(arg0, v0, 0x831ac2a95f8554dc097e7fb9e163ac569ba0df49b0c0598fb05219149c76babc::ramm::get_prev_prc(arg0, v0), 0x831ac2a95f8554dc097e7fb9e163ac569ba0df49b0c0598fb05219149c76babc::ramm::get_prev_prc_tmstmp(arg0, v0), v9, v10, v5);
        0x831ac2a95f8554dc097e7fb9e163ac569ba0df49b0c0598fb05219149c76babc::ramm::update_volatility_data(arg0, v1, 0x831ac2a95f8554dc097e7fb9e163ac569ba0df49b0c0598fb05219149c76babc::ramm::get_prev_prc(arg0, v1), 0x831ac2a95f8554dc097e7fb9e163ac569ba0df49b0c0598fb05219149c76babc::ramm::get_prev_prc_tmstmp(arg0, v1), v11, v12, v6);
        0x831ac2a95f8554dc097e7fb9e163ac569ba0df49b0c0598fb05219149c76babc::ramm::update_pricing_data<T0>(arg0, v9, v10);
        0x831ac2a95f8554dc097e7fb9e163ac569ba0df49b0c0598fb05219149c76babc::ramm::update_pricing_data<T1>(arg0, v11, v12);
        let v13 = 0x831ac2a95f8554dc097e7fb9e163ac569ba0df49b0c0598fb05219149c76babc::ramm::amount(&v8);
        0x831ac2a95f8554dc097e7fb9e163ac569ba0df49b0c0598fb05219149c76babc::ramm::check_trade_amount_out<T1>(arg0, v13);
        let v14 = (v13 as u64);
        if (0x831ac2a95f8554dc097e7fb9e163ac569ba0df49b0c0598fb05219149c76babc::ramm::execute(&v8) && v14 >= arg2) {
            let v15 = 0x2::coin::into_balance<T0>(arg1);
            let v16 = (0x831ac2a95f8554dc097e7fb9e163ac569ba0df49b0c0598fb05219149c76babc::ramm::protocol_fee(&v8) as u64);
            0x831ac2a95f8554dc097e7fb9e163ac569ba0df49b0c0598fb05219149c76babc::ramm::join_protocol_fees<T0>(arg0, v0, 0x2::balance::split<T0>(&mut v15, v16));
            0x831ac2a95f8554dc097e7fb9e163ac569ba0df49b0c0598fb05219149c76babc::ramm::join_bal(arg0, v0, (0x2::balance::value<T0>(&v15) as u256));
            0x831ac2a95f8554dc097e7fb9e163ac569ba0df49b0c0598fb05219149c76babc::ramm::join_typed_bal<T0>(arg0, v0, v15);
            0x831ac2a95f8554dc097e7fb9e163ac569ba0df49b0c0598fb05219149c76babc::ramm::split_bal(arg0, v1, v13);
            0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(0x2::coin::from_balance<T1>(0x831ac2a95f8554dc097e7fb9e163ac569ba0df49b0c0598fb05219149c76babc::ramm::split_typed_bal<T1>(arg0, v1, v14), arg5), 0x2::tx_context::sender(arg5));
            0x831ac2a95f8554dc097e7fb9e163ac569ba0df49b0c0598fb05219149c76babc::events::trade_event<0x831ac2a95f8554dc097e7fb9e163ac569ba0df49b0c0598fb05219149c76babc::events::TradeIn>(0x831ac2a95f8554dc097e7fb9e163ac569ba0df49b0c0598fb05219149c76babc::ramm::get_id(arg0), 0x2::tx_context::sender(arg5), 0x1::type_name::get<T0>(), 0x1::type_name::get<T1>(), v7, v14, v16, 0x831ac2a95f8554dc097e7fb9e163ac569ba0df49b0c0598fb05219149c76babc::ramm::execute(&v8));
        } else if (!0x831ac2a95f8554dc097e7fb9e163ac569ba0df49b0c0598fb05219149c76babc::ramm::execute(&v8)) {
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(arg1, 0x2::tx_context::sender(arg5));
            0x831ac2a95f8554dc097e7fb9e163ac569ba0df49b0c0598fb05219149c76babc::events::trade_failure_event<0x831ac2a95f8554dc097e7fb9e163ac569ba0df49b0c0598fb05219149c76babc::events::TradeIn>(0x831ac2a95f8554dc097e7fb9e163ac569ba0df49b0c0598fb05219149c76babc::ramm::get_id(arg0), 0x2::tx_context::sender(arg5), 0x1::type_name::get<T0>(), 0x1::type_name::get<T1>(), v7, 0x831ac2a95f8554dc097e7fb9e163ac569ba0df49b0c0598fb05219149c76babc::ramm::message(&v8));
        } else {
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(arg1, 0x2::tx_context::sender(arg5));
            0x831ac2a95f8554dc097e7fb9e163ac569ba0df49b0c0598fb05219149c76babc::events::trade_failure_event<0x831ac2a95f8554dc097e7fb9e163ac569ba0df49b0c0598fb05219149c76babc::events::TradeIn>(0x831ac2a95f8554dc097e7fb9e163ac569ba0df49b0c0598fb05219149c76babc::ramm::get_id(arg0), 0x2::tx_context::sender(arg5), 0x1::type_name::get<T0>(), 0x1::type_name::get<T1>(), v7, 0x1::string::utf8(b"Trade not executed due to slippage tolerance."));
        };
        0x831ac2a95f8554dc097e7fb9e163ac569ba0df49b0c0598fb05219149c76babc::ramm::check_ramm_invariants_2<T0, T1>(arg0);
    }

    public entry fun trade_amount_out_2<T0, T1>(arg0: &mut 0x831ac2a95f8554dc097e7fb9e163ac569ba0df49b0c0598fb05219149c76babc::ramm::RAMM, arg1: u64, arg2: 0x2::coin::Coin<T0>, arg3: &0x8d79f4d920b03d88faca1e421af023a87fbb1e4a6fd200248e6e9998d09e470::aggregator::Aggregator, arg4: &0x8d79f4d920b03d88faca1e421af023a87fbb1e4a6fd200248e6e9998d09e470::aggregator::Aggregator, arg5: &mut 0x2::tx_context::TxContext) {
        assert!(0x831ac2a95f8554dc097e7fb9e163ac569ba0df49b0c0598fb05219149c76babc::ramm::get_asset_count(arg0) == 2, 0);
        let v0 = 0x831ac2a95f8554dc097e7fb9e163ac569ba0df49b0c0598fb05219149c76babc::ramm::get_asset_index<T0>(arg0);
        assert!(0x831ac2a95f8554dc097e7fb9e163ac569ba0df49b0c0598fb05219149c76babc::ramm::lptok_in_circulation<T0>(arg0, v0) > 0, 3);
        let v1 = 0x831ac2a95f8554dc097e7fb9e163ac569ba0df49b0c0598fb05219149c76babc::ramm::get_asset_index<T1>(arg0);
        assert!(arg1 >= 0x831ac2a95f8554dc097e7fb9e163ac569ba0df49b0c0598fb05219149c76babc::ramm::get_min_trade_amount(arg0, v1), 6);
        let v2 = (0x831ac2a95f8554dc097e7fb9e163ac569ba0df49b0c0598fb05219149c76babc::ramm::get_bal(arg0, v1) as u64);
        assert!(v2 >= arg1, 4);
        if (arg1 == v2) {
            assert!(0x831ac2a95f8554dc097e7fb9e163ac569ba0df49b0c0598fb05219149c76babc::ramm::lptok_in_circulation<T1>(arg0, v1) == 0, 5);
        };
        0x831ac2a95f8554dc097e7fb9e163ac569ba0df49b0c0598fb05219149c76babc::ramm::check_trade_amount_out<T1>(arg0, (arg1 as u256));
        let v3 = 0x2::vec_map::empty<u8, u256>();
        let v4 = 0x2::vec_map::empty<u8, u256>();
        let v5 = 0x2::vec_map::empty<u8, u64>();
        0x831ac2a95f8554dc097e7fb9e163ac569ba0df49b0c0598fb05219149c76babc::ramm::check_feed_and_get_price_data(arg0, v0, arg3, &mut v3, &mut v4, &mut v5);
        0x831ac2a95f8554dc097e7fb9e163ac569ba0df49b0c0598fb05219149c76babc::ramm::check_feed_and_get_price_data(arg0, v1, arg4, &mut v3, &mut v4, &mut v5);
        let v6 = 0x831ac2a95f8554dc097e7fb9e163ac569ba0df49b0c0598fb05219149c76babc::ramm::compute_volatility_fee(arg0, v0, *0x2::vec_map::get<u8, u256>(&v3, &v0), *0x2::vec_map::get<u8, u64>(&v5, &v0));
        let v7 = 0x831ac2a95f8554dc097e7fb9e163ac569ba0df49b0c0598fb05219149c76babc::ramm::compute_volatility_fee(arg0, v1, *0x2::vec_map::get<u8, u256>(&v3, &v1), *0x2::vec_map::get<u8, u64>(&v5, &v1));
        let v8 = 0x831ac2a95f8554dc097e7fb9e163ac569ba0df49b0c0598fb05219149c76babc::ramm::trade_o<T0, T1>(arg0, v0, v1, arg1, v3, v4, v6 + v7);
        let v9 = *0x2::vec_map::get<u8, u256>(&v3, &v0);
        let v10 = *0x2::vec_map::get<u8, u64>(&v5, &v0);
        let v11 = *0x2::vec_map::get<u8, u256>(&v3, &v1);
        let v12 = *0x2::vec_map::get<u8, u64>(&v5, &v1);
        0x831ac2a95f8554dc097e7fb9e163ac569ba0df49b0c0598fb05219149c76babc::ramm::update_volatility_data(arg0, v0, 0x831ac2a95f8554dc097e7fb9e163ac569ba0df49b0c0598fb05219149c76babc::ramm::get_prev_prc(arg0, v0), 0x831ac2a95f8554dc097e7fb9e163ac569ba0df49b0c0598fb05219149c76babc::ramm::get_prev_prc_tmstmp(arg0, v0), v9, v10, v6);
        0x831ac2a95f8554dc097e7fb9e163ac569ba0df49b0c0598fb05219149c76babc::ramm::update_volatility_data(arg0, v1, 0x831ac2a95f8554dc097e7fb9e163ac569ba0df49b0c0598fb05219149c76babc::ramm::get_prev_prc(arg0, v1), 0x831ac2a95f8554dc097e7fb9e163ac569ba0df49b0c0598fb05219149c76babc::ramm::get_prev_prc_tmstmp(arg0, v1), v11, v12, v7);
        0x831ac2a95f8554dc097e7fb9e163ac569ba0df49b0c0598fb05219149c76babc::ramm::update_pricing_data<T0>(arg0, v9, v10);
        0x831ac2a95f8554dc097e7fb9e163ac569ba0df49b0c0598fb05219149c76babc::ramm::update_pricing_data<T1>(arg0, v11, v12);
        0x831ac2a95f8554dc097e7fb9e163ac569ba0df49b0c0598fb05219149c76babc::ramm::check_trade_amount_in<T0>(arg0, 0x831ac2a95f8554dc097e7fb9e163ac569ba0df49b0c0598fb05219149c76babc::ramm::amount(&v8));
        let v13 = (0x831ac2a95f8554dc097e7fb9e163ac569ba0df49b0c0598fb05219149c76babc::ramm::amount(&v8) as u64);
        let v14 = 0x2::coin::value<T0>(&arg2);
        if (0x831ac2a95f8554dc097e7fb9e163ac569ba0df49b0c0598fb05219149c76babc::ramm::execute(&v8) && v13 <= v14) {
            let v15 = 0x2::coin::into_balance<T0>(arg2);
            let v16 = 0x2::balance::split<T0>(&mut v15, v13);
            let v17 = (0x831ac2a95f8554dc097e7fb9e163ac569ba0df49b0c0598fb05219149c76babc::ramm::protocol_fee(&v8) as u64);
            0x831ac2a95f8554dc097e7fb9e163ac569ba0df49b0c0598fb05219149c76babc::ramm::join_protocol_fees<T0>(arg0, v0, 0x2::balance::split<T0>(&mut v16, v17));
            0x831ac2a95f8554dc097e7fb9e163ac569ba0df49b0c0598fb05219149c76babc::ramm::join_bal(arg0, v0, (0x2::balance::value<T0>(&v16) as u256));
            0x831ac2a95f8554dc097e7fb9e163ac569ba0df49b0c0598fb05219149c76babc::ramm::join_typed_bal<T0>(arg0, v0, v16);
            0x831ac2a95f8554dc097e7fb9e163ac569ba0df49b0c0598fb05219149c76babc::ramm::split_bal(arg0, v1, (arg1 as u256));
            0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(0x2::coin::from_balance<T1>(0x831ac2a95f8554dc097e7fb9e163ac569ba0df49b0c0598fb05219149c76babc::ramm::split_typed_bal<T1>(arg0, v1, arg1), arg5), 0x2::tx_context::sender(arg5));
            0x831ac2a95f8554dc097e7fb9e163ac569ba0df49b0c0598fb05219149c76babc::events::trade_event<0x831ac2a95f8554dc097e7fb9e163ac569ba0df49b0c0598fb05219149c76babc::events::TradeOut>(0x831ac2a95f8554dc097e7fb9e163ac569ba0df49b0c0598fb05219149c76babc::ramm::get_id(arg0), 0x2::tx_context::sender(arg5), 0x1::type_name::get<T0>(), 0x1::type_name::get<T1>(), v13, arg1, v17, 0x831ac2a95f8554dc097e7fb9e163ac569ba0df49b0c0598fb05219149c76babc::ramm::execute(&v8));
            if (0x2::balance::value<T0>(&v15) > 0) {
                0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(v15, arg5), 0x2::tx_context::sender(arg5));
            } else {
                0x2::balance::destroy_zero<T0>(v15);
            };
        } else if (!0x831ac2a95f8554dc097e7fb9e163ac569ba0df49b0c0598fb05219149c76babc::ramm::execute(&v8)) {
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(arg2, 0x2::tx_context::sender(arg5));
            0x831ac2a95f8554dc097e7fb9e163ac569ba0df49b0c0598fb05219149c76babc::events::trade_failure_event<0x831ac2a95f8554dc097e7fb9e163ac569ba0df49b0c0598fb05219149c76babc::events::TradeOut>(0x831ac2a95f8554dc097e7fb9e163ac569ba0df49b0c0598fb05219149c76babc::ramm::get_id(arg0), 0x2::tx_context::sender(arg5), 0x1::type_name::get<T0>(), 0x1::type_name::get<T1>(), v14, 0x831ac2a95f8554dc097e7fb9e163ac569ba0df49b0c0598fb05219149c76babc::ramm::message(&v8));
        } else {
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(arg2, 0x2::tx_context::sender(arg5));
            0x831ac2a95f8554dc097e7fb9e163ac569ba0df49b0c0598fb05219149c76babc::events::trade_failure_event<0x831ac2a95f8554dc097e7fb9e163ac569ba0df49b0c0598fb05219149c76babc::events::TradeOut>(0x831ac2a95f8554dc097e7fb9e163ac569ba0df49b0c0598fb05219149c76babc::ramm::get_id(arg0), 0x2::tx_context::sender(arg5), 0x1::type_name::get<T0>(), 0x1::type_name::get<T1>(), v14, 0x1::string::utf8(b"Trade not executed due to slippage tolerance."));
        };
        0x831ac2a95f8554dc097e7fb9e163ac569ba0df49b0c0598fb05219149c76babc::ramm::check_ramm_invariants_2<T0, T1>(arg0);
    }

    // decompiled from Move bytecode v6
}

