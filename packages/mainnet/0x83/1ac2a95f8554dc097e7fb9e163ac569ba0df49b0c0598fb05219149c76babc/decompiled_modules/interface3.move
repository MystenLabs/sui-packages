module 0x831ac2a95f8554dc097e7fb9e163ac569ba0df49b0c0598fb05219149c76babc::interface3 {
    public entry fun collect_fees_3<T0, T1, T2>(arg0: &mut 0x831ac2a95f8554dc097e7fb9e163ac569ba0df49b0c0598fb05219149c76babc::ramm::RAMM, arg1: &0x831ac2a95f8554dc097e7fb9e163ac569ba0df49b0c0598fb05219149c76babc::ramm::RAMMAdminCap, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(0x831ac2a95f8554dc097e7fb9e163ac569ba0df49b0c0598fb05219149c76babc::ramm::get_admin_cap_id(arg0) == 0x2::object::id<0x831ac2a95f8554dc097e7fb9e163ac569ba0df49b0c0598fb05219149c76babc::ramm::RAMMAdminCap>(arg1), 7);
        assert!(0x831ac2a95f8554dc097e7fb9e163ac569ba0df49b0c0598fb05219149c76babc::ramm::get_asset_count(arg0) == 3, 0);
        let v0 = 0x2::coin::from_balance<T0>(0x831ac2a95f8554dc097e7fb9e163ac569ba0df49b0c0598fb05219149c76babc::ramm::get_fees_for_asset<T0>(arg0, 0x831ac2a95f8554dc097e7fb9e163ac569ba0df49b0c0598fb05219149c76babc::ramm::get_asset_index<T0>(arg0)), arg2);
        let v1 = 0x2::coin::from_balance<T1>(0x831ac2a95f8554dc097e7fb9e163ac569ba0df49b0c0598fb05219149c76babc::ramm::get_fees_for_asset<T1>(arg0, 0x831ac2a95f8554dc097e7fb9e163ac569ba0df49b0c0598fb05219149c76babc::ramm::get_asset_index<T1>(arg0)), arg2);
        let v2 = 0x2::coin::from_balance<T2>(0x831ac2a95f8554dc097e7fb9e163ac569ba0df49b0c0598fb05219149c76babc::ramm::get_fees_for_asset<T2>(arg0, 0x831ac2a95f8554dc097e7fb9e163ac569ba0df49b0c0598fb05219149c76babc::ramm::get_asset_index<T2>(arg0)), arg2);
        let v3 = 0x2::coin::value<T0>(&v0);
        let v4 = 0x2::coin::value<T1>(&v1);
        let v5 = 0x2::coin::value<T2>(&v2);
        let v6 = 0x2::vec_map::empty<0x1::type_name::TypeName, u64>();
        0x2::vec_map::insert<0x1::type_name::TypeName, u64>(&mut v6, 0x1::type_name::get<T0>(), v3);
        0x2::vec_map::insert<0x1::type_name::TypeName, u64>(&mut v6, 0x1::type_name::get<T1>(), v4);
        0x2::vec_map::insert<0x1::type_name::TypeName, u64>(&mut v6, 0x1::type_name::get<T2>(), v5);
        let v7 = 0x831ac2a95f8554dc097e7fb9e163ac569ba0df49b0c0598fb05219149c76babc::ramm::get_fee_collector(arg0);
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
        0x831ac2a95f8554dc097e7fb9e163ac569ba0df49b0c0598fb05219149c76babc::events::fee_collection_event(0x831ac2a95f8554dc097e7fb9e163ac569ba0df49b0c0598fb05219149c76babc::ramm::get_id(arg0), 0x2::tx_context::sender(arg2), v7, v6);
        0x831ac2a95f8554dc097e7fb9e163ac569ba0df49b0c0598fb05219149c76babc::ramm::check_ramm_invariants_3<T0, T1, T2>(arg0);
    }

    public entry fun liquidity_deposit_3<T0, T1, T2>(arg0: &mut 0x831ac2a95f8554dc097e7fb9e163ac569ba0df49b0c0598fb05219149c76babc::ramm::RAMM, arg1: 0x2::coin::Coin<T0>, arg2: &0x8d79f4d920b03d88faca1e421af023a87fbb1e4a6fd200248e6e9998d09e470::aggregator::Aggregator, arg3: &0x8d79f4d920b03d88faca1e421af023a87fbb1e4a6fd200248e6e9998d09e470::aggregator::Aggregator, arg4: &0x8d79f4d920b03d88faca1e421af023a87fbb1e4a6fd200248e6e9998d09e470::aggregator::Aggregator, arg5: &mut 0x2::tx_context::TxContext) {
        assert!(0x831ac2a95f8554dc097e7fb9e163ac569ba0df49b0c0598fb05219149c76babc::ramm::get_asset_count(arg0) == 3, 0);
        assert!(0x2::coin::value<T0>(&arg1) > 0, 2);
        let v0 = 0x831ac2a95f8554dc097e7fb9e163ac569ba0df49b0c0598fb05219149c76babc::ramm::get_asset_index<T0>(arg0);
        assert!(0x831ac2a95f8554dc097e7fb9e163ac569ba0df49b0c0598fb05219149c76babc::ramm::can_deposit_asset(arg0, v0), 1);
        let v1 = 0x831ac2a95f8554dc097e7fb9e163ac569ba0df49b0c0598fb05219149c76babc::ramm::get_asset_index<T1>(arg0);
        let v2 = 0x831ac2a95f8554dc097e7fb9e163ac569ba0df49b0c0598fb05219149c76babc::ramm::get_asset_index<T2>(arg0);
        let v3 = 0x2::vec_map::empty<u8, u256>();
        let v4 = 0x2::vec_map::empty<u8, u256>();
        let v5 = 0x2::vec_map::empty<u8, u64>();
        0x831ac2a95f8554dc097e7fb9e163ac569ba0df49b0c0598fb05219149c76babc::ramm::check_feed_and_get_price_data(arg0, v0, arg2, &mut v3, &mut v4, &mut v5);
        0x831ac2a95f8554dc097e7fb9e163ac569ba0df49b0c0598fb05219149c76babc::ramm::check_feed_and_get_price_data(arg0, v1, arg3, &mut v3, &mut v4, &mut v5);
        0x831ac2a95f8554dc097e7fb9e163ac569ba0df49b0c0598fb05219149c76babc::ramm::check_feed_and_get_price_data(arg0, v2, arg4, &mut v3, &mut v4, &mut v5);
        let v6 = 0x831ac2a95f8554dc097e7fb9e163ac569ba0df49b0c0598fb05219149c76babc::ramm::liq_dep<T0>(arg0, v0, 0x2::coin::value<T0>(&arg1), v3, v4);
        let v7 = *0x2::vec_map::get<u8, u256>(&v3, &v0);
        let v8 = *0x2::vec_map::get<u8, u64>(&v5, &v0);
        let v9 = *0x2::vec_map::get<u8, u256>(&v3, &v1);
        let v10 = *0x2::vec_map::get<u8, u64>(&v5, &v1);
        let v11 = *0x2::vec_map::get<u8, u256>(&v3, &v2);
        let v12 = *0x2::vec_map::get<u8, u64>(&v5, &v2);
        0x831ac2a95f8554dc097e7fb9e163ac569ba0df49b0c0598fb05219149c76babc::ramm::update_volatility_data(arg0, v0, 0x831ac2a95f8554dc097e7fb9e163ac569ba0df49b0c0598fb05219149c76babc::ramm::get_prev_prc(arg0, v0), 0x831ac2a95f8554dc097e7fb9e163ac569ba0df49b0c0598fb05219149c76babc::ramm::get_prev_prc_tmstmp(arg0, v0), v7, v8, 0x831ac2a95f8554dc097e7fb9e163ac569ba0df49b0c0598fb05219149c76babc::ramm::compute_volatility_fee(arg0, v0, *0x2::vec_map::get<u8, u256>(&v3, &v0), *0x2::vec_map::get<u8, u64>(&v5, &v0)));
        0x831ac2a95f8554dc097e7fb9e163ac569ba0df49b0c0598fb05219149c76babc::ramm::update_volatility_data(arg0, v1, 0x831ac2a95f8554dc097e7fb9e163ac569ba0df49b0c0598fb05219149c76babc::ramm::get_prev_prc(arg0, v1), 0x831ac2a95f8554dc097e7fb9e163ac569ba0df49b0c0598fb05219149c76babc::ramm::get_prev_prc_tmstmp(arg0, v1), v9, v10, 0x831ac2a95f8554dc097e7fb9e163ac569ba0df49b0c0598fb05219149c76babc::ramm::compute_volatility_fee(arg0, v1, *0x2::vec_map::get<u8, u256>(&v3, &v1), *0x2::vec_map::get<u8, u64>(&v5, &v1)));
        0x831ac2a95f8554dc097e7fb9e163ac569ba0df49b0c0598fb05219149c76babc::ramm::update_volatility_data(arg0, v2, 0x831ac2a95f8554dc097e7fb9e163ac569ba0df49b0c0598fb05219149c76babc::ramm::get_prev_prc(arg0, v2), 0x831ac2a95f8554dc097e7fb9e163ac569ba0df49b0c0598fb05219149c76babc::ramm::get_prev_prc_tmstmp(arg0, v2), v11, v12, 0x831ac2a95f8554dc097e7fb9e163ac569ba0df49b0c0598fb05219149c76babc::ramm::compute_volatility_fee(arg0, v2, *0x2::vec_map::get<u8, u256>(&v3, &v2), *0x2::vec_map::get<u8, u64>(&v5, &v2)));
        0x831ac2a95f8554dc097e7fb9e163ac569ba0df49b0c0598fb05219149c76babc::ramm::update_pricing_data<T0>(arg0, v7, v8);
        0x831ac2a95f8554dc097e7fb9e163ac569ba0df49b0c0598fb05219149c76babc::ramm::update_pricing_data<T1>(arg0, v9, v10);
        0x831ac2a95f8554dc097e7fb9e163ac569ba0df49b0c0598fb05219149c76babc::ramm::update_pricing_data<T2>(arg0, v11, v12);
        if (v6 == 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(arg1, 0x2::tx_context::sender(arg5));
            0x831ac2a95f8554dc097e7fb9e163ac569ba0df49b0c0598fb05219149c76babc::events::liquidity_deposit_failure_event(0x831ac2a95f8554dc097e7fb9e163ac569ba0df49b0c0598fb05219149c76babc::ramm::get_id(arg0), 0x2::tx_context::sender(arg5), 0x1::type_name::get<T0>(), 0x2::coin::value<T0>(&arg1));
        } else {
            let v13 = 0x2::coin::into_balance<T0>(arg1);
            0x831ac2a95f8554dc097e7fb9e163ac569ba0df49b0c0598fb05219149c76babc::ramm::join_bal(arg0, v0, (0x2::balance::value<T0>(&v13) as u256));
            0x831ac2a95f8554dc097e7fb9e163ac569ba0df49b0c0598fb05219149c76babc::ramm::join_typed_bal<T0>(arg0, v0, v13);
            0x831ac2a95f8554dc097e7fb9e163ac569ba0df49b0c0598fb05219149c76babc::ramm::incr_lptokens_issued<T0>(arg0, v6);
            let v14 = 0x2::coin::from_balance<0x831ac2a95f8554dc097e7fb9e163ac569ba0df49b0c0598fb05219149c76babc::ramm::LP<T0>>(0x831ac2a95f8554dc097e7fb9e163ac569ba0df49b0c0598fb05219149c76babc::ramm::mint_lp_tokens<T0>(arg0, v6), arg5);
            0x2::transfer::public_transfer<0x2::coin::Coin<0x831ac2a95f8554dc097e7fb9e163ac569ba0df49b0c0598fb05219149c76babc::ramm::LP<T0>>>(v14, 0x2::tx_context::sender(arg5));
            0x831ac2a95f8554dc097e7fb9e163ac569ba0df49b0c0598fb05219149c76babc::events::liquidity_deposit_event(0x831ac2a95f8554dc097e7fb9e163ac569ba0df49b0c0598fb05219149c76babc::ramm::get_id(arg0), 0x2::tx_context::sender(arg5), 0x1::type_name::get<T0>(), 0x2::coin::value<T0>(&arg1), 0x2::coin::value<0x831ac2a95f8554dc097e7fb9e163ac569ba0df49b0c0598fb05219149c76babc::ramm::LP<T0>>(&v14));
        };
        0x831ac2a95f8554dc097e7fb9e163ac569ba0df49b0c0598fb05219149c76babc::ramm::check_ramm_invariants_3<T0, T1, T2>(arg0);
    }

    public entry fun liquidity_withdrawal_3<T0, T1, T2, T3>(arg0: &mut 0x831ac2a95f8554dc097e7fb9e163ac569ba0df49b0c0598fb05219149c76babc::ramm::RAMM, arg1: 0x2::coin::Coin<0x831ac2a95f8554dc097e7fb9e163ac569ba0df49b0c0598fb05219149c76babc::ramm::LP<T3>>, arg2: &0x8d79f4d920b03d88faca1e421af023a87fbb1e4a6fd200248e6e9998d09e470::aggregator::Aggregator, arg3: &0x8d79f4d920b03d88faca1e421af023a87fbb1e4a6fd200248e6e9998d09e470::aggregator::Aggregator, arg4: &0x8d79f4d920b03d88faca1e421af023a87fbb1e4a6fd200248e6e9998d09e470::aggregator::Aggregator, arg5: &mut 0x2::tx_context::TxContext) {
        assert!(0x831ac2a95f8554dc097e7fb9e163ac569ba0df49b0c0598fb05219149c76babc::ramm::get_asset_count(arg0) == 3, 0);
        assert!(0x2::coin::value<0x831ac2a95f8554dc097e7fb9e163ac569ba0df49b0c0598fb05219149c76babc::ramm::LP<T3>>(&arg1) > 0, 9);
        let v0 = 0x831ac2a95f8554dc097e7fb9e163ac569ba0df49b0c0598fb05219149c76babc::ramm::get_asset_index<T0>(arg0);
        let v1 = 0x831ac2a95f8554dc097e7fb9e163ac569ba0df49b0c0598fb05219149c76babc::ramm::get_asset_index<T1>(arg0);
        let v2 = 0x831ac2a95f8554dc097e7fb9e163ac569ba0df49b0c0598fb05219149c76babc::ramm::get_asset_index<T2>(arg0);
        let v3 = 0x831ac2a95f8554dc097e7fb9e163ac569ba0df49b0c0598fb05219149c76babc::ramm::get_asset_index<T3>(arg0);
        let v4 = 0x2::vec_map::empty<u8, u256>();
        let v5 = 0x2::vec_map::empty<u8, u256>();
        let v6 = 0x2::vec_map::empty<u8, u64>();
        0x831ac2a95f8554dc097e7fb9e163ac569ba0df49b0c0598fb05219149c76babc::ramm::check_feed_and_get_price_data(arg0, v0, arg2, &mut v4, &mut v5, &mut v6);
        0x831ac2a95f8554dc097e7fb9e163ac569ba0df49b0c0598fb05219149c76babc::ramm::check_feed_and_get_price_data(arg0, v1, arg3, &mut v4, &mut v5, &mut v6);
        0x831ac2a95f8554dc097e7fb9e163ac569ba0df49b0c0598fb05219149c76babc::ramm::check_feed_and_get_price_data(arg0, v2, arg4, &mut v4, &mut v5, &mut v6);
        let v7 = 0x831ac2a95f8554dc097e7fb9e163ac569ba0df49b0c0598fb05219149c76babc::ramm::compute_volatility_fee(arg0, v0, *0x2::vec_map::get<u8, u256>(&v4, &v0), *0x2::vec_map::get<u8, u64>(&v6, &v0));
        let v8 = 0x831ac2a95f8554dc097e7fb9e163ac569ba0df49b0c0598fb05219149c76babc::ramm::compute_volatility_fee(arg0, v1, *0x2::vec_map::get<u8, u256>(&v4, &v1), *0x2::vec_map::get<u8, u64>(&v6, &v1));
        let v9 = 0x831ac2a95f8554dc097e7fb9e163ac569ba0df49b0c0598fb05219149c76babc::ramm::compute_volatility_fee(arg0, v2, *0x2::vec_map::get<u8, u256>(&v4, &v2), *0x2::vec_map::get<u8, u64>(&v6, &v2));
        let v10 = 0x2::vec_map::empty<u8, u256>();
        0x2::vec_map::insert<u8, u256>(&mut v10, v0, v7);
        0x2::vec_map::insert<u8, u256>(&mut v10, v1, v8);
        0x2::vec_map::insert<u8, u256>(&mut v10, v2, v9);
        let v11 = 0x2::coin::value<0x831ac2a95f8554dc097e7fb9e163ac569ba0df49b0c0598fb05219149c76babc::ramm::LP<T3>>(&arg1);
        let v12 = 0x831ac2a95f8554dc097e7fb9e163ac569ba0df49b0c0598fb05219149c76babc::ramm::get_fact_for_bal(arg0, v3);
        let v13 = 0x831ac2a95f8554dc097e7fb9e163ac569ba0df49b0c0598fb05219149c76babc::ramm::liq_wthdrw<T3>(arg0, v3, v11, v4, v5, v10);
        let v14 = *0x2::vec_map::get<u8, u256>(&v4, &v0);
        let v15 = *0x2::vec_map::get<u8, u64>(&v6, &v0);
        let v16 = *0x2::vec_map::get<u8, u256>(&v4, &v1);
        let v17 = *0x2::vec_map::get<u8, u64>(&v6, &v1);
        let v18 = *0x2::vec_map::get<u8, u256>(&v4, &v2);
        let v19 = *0x2::vec_map::get<u8, u64>(&v6, &v2);
        0x831ac2a95f8554dc097e7fb9e163ac569ba0df49b0c0598fb05219149c76babc::ramm::update_volatility_data(arg0, v0, 0x831ac2a95f8554dc097e7fb9e163ac569ba0df49b0c0598fb05219149c76babc::ramm::get_prev_prc(arg0, v0), 0x831ac2a95f8554dc097e7fb9e163ac569ba0df49b0c0598fb05219149c76babc::ramm::get_prev_prc_tmstmp(arg0, v0), v14, v15, v7);
        0x831ac2a95f8554dc097e7fb9e163ac569ba0df49b0c0598fb05219149c76babc::ramm::update_volatility_data(arg0, v1, 0x831ac2a95f8554dc097e7fb9e163ac569ba0df49b0c0598fb05219149c76babc::ramm::get_prev_prc(arg0, v1), 0x831ac2a95f8554dc097e7fb9e163ac569ba0df49b0c0598fb05219149c76babc::ramm::get_prev_prc_tmstmp(arg0, v1), v16, v17, v8);
        0x831ac2a95f8554dc097e7fb9e163ac569ba0df49b0c0598fb05219149c76babc::ramm::update_volatility_data(arg0, v2, 0x831ac2a95f8554dc097e7fb9e163ac569ba0df49b0c0598fb05219149c76babc::ramm::get_prev_prc(arg0, v2), 0x831ac2a95f8554dc097e7fb9e163ac569ba0df49b0c0598fb05219149c76babc::ramm::get_prev_prc_tmstmp(arg0, v2), v18, v19, v9);
        0x831ac2a95f8554dc097e7fb9e163ac569ba0df49b0c0598fb05219149c76babc::ramm::update_pricing_data<T0>(arg0, v14, v15);
        0x831ac2a95f8554dc097e7fb9e163ac569ba0df49b0c0598fb05219149c76babc::ramm::update_pricing_data<T1>(arg0, v16, v17);
        0x831ac2a95f8554dc097e7fb9e163ac569ba0df49b0c0598fb05219149c76babc::ramm::update_pricing_data<T2>(arg0, v18, v19);
        let v20 = (v11 as u256);
        let v21 = &mut v20;
        if (0x831ac2a95f8554dc097e7fb9e163ac569ba0df49b0c0598fb05219149c76babc::ramm::remaining(&v13) > 0) {
            *v21 = 0x831ac2a95f8554dc097e7fb9e163ac569ba0df49b0c0598fb05219149c76babc::ramm::div(0x831ac2a95f8554dc097e7fb9e163ac569ba0df49b0c0598fb05219149c76babc::ramm::mul(v20 * 1000, (0x831ac2a95f8554dc097e7fb9e163ac569ba0df49b0c0598fb05219149c76babc::ramm::value(&v13) - 0x831ac2a95f8554dc097e7fb9e163ac569ba0df49b0c0598fb05219149c76babc::ramm::remaining(&v13)) * v12), 0x831ac2a95f8554dc097e7fb9e163ac569ba0df49b0c0598fb05219149c76babc::ramm::value(&v13) * v12) / 1000;
        };
        let v22 = (*v21 as u64);
        let v23 = 0x2::coin::into_balance<0x831ac2a95f8554dc097e7fb9e163ac569ba0df49b0c0598fb05219149c76babc::ramm::LP<T3>>(arg1);
        0x831ac2a95f8554dc097e7fb9e163ac569ba0df49b0c0598fb05219149c76babc::ramm::decr_lptokens_issued<T3>(arg0, v22);
        assert!(0x831ac2a95f8554dc097e7fb9e163ac569ba0df49b0c0598fb05219149c76babc::ramm::burn_lp_tokens<T3>(arg0, 0x2::balance::split<0x831ac2a95f8554dc097e7fb9e163ac569ba0df49b0c0598fb05219149c76babc::ramm::LP<T3>>(&mut v23, v22)) == v22, 8);
        if (0x2::balance::value<0x831ac2a95f8554dc097e7fb9e163ac569ba0df49b0c0598fb05219149c76babc::ramm::LP<T3>>(&v23) == 0) {
            0x2::balance::destroy_zero<0x831ac2a95f8554dc097e7fb9e163ac569ba0df49b0c0598fb05219149c76babc::ramm::LP<T3>>(v23);
        } else {
            0x2::transfer::public_transfer<0x2::coin::Coin<0x831ac2a95f8554dc097e7fb9e163ac569ba0df49b0c0598fb05219149c76babc::ramm::LP<T3>>>(0x2::coin::from_balance<0x831ac2a95f8554dc097e7fb9e163ac569ba0df49b0c0598fb05219149c76babc::ramm::LP<T3>>(v23, arg5), 0x2::tx_context::sender(arg5));
        };
        let v24 = 0x831ac2a95f8554dc097e7fb9e163ac569ba0df49b0c0598fb05219149c76babc::ramm::amounts(&v13);
        let v25 = 0x831ac2a95f8554dc097e7fb9e163ac569ba0df49b0c0598fb05219149c76babc::ramm::fees(&v13);
        let v26 = *0x2::vec_map::get<u8, u256>(&v24, &v0);
        if (v26 != 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x831ac2a95f8554dc097e7fb9e163ac569ba0df49b0c0598fb05219149c76babc::ramm::liq_withdraw_helper<T0>(arg0, v0, v26, *0x2::vec_map::get<u8, u256>(&v25, &v0), arg5), 0x2::tx_context::sender(arg5));
        };
        let v27 = *0x2::vec_map::get<u8, u256>(&v24, &v1);
        if (v27 != 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(0x831ac2a95f8554dc097e7fb9e163ac569ba0df49b0c0598fb05219149c76babc::ramm::liq_withdraw_helper<T1>(arg0, v1, v27, *0x2::vec_map::get<u8, u256>(&v25, &v1), arg5), 0x2::tx_context::sender(arg5));
        };
        let v28 = *0x2::vec_map::get<u8, u256>(&v24, &v2);
        if (v28 != 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<T2>>(0x831ac2a95f8554dc097e7fb9e163ac569ba0df49b0c0598fb05219149c76babc::ramm::liq_withdraw_helper<T2>(arg0, v2, v28, *0x2::vec_map::get<u8, u256>(&v25, &v2), arg5), 0x2::tx_context::sender(arg5));
        };
        let v29 = 0x2::vec_map::empty<0x1::type_name::TypeName, u64>();
        let v30 = 0x2::vec_map::empty<0x1::type_name::TypeName, u64>();
        0x2::vec_map::insert<0x1::type_name::TypeName, u64>(&mut v29, 0x1::type_name::get<T0>(), (*0x2::vec_map::get<u8, u256>(&v24, &v0) as u64));
        0x2::vec_map::insert<0x1::type_name::TypeName, u64>(&mut v30, 0x1::type_name::get<T0>(), (*0x2::vec_map::get<u8, u256>(&v25, &v0) as u64));
        if (0x2::vec_map::contains<u8, u256>(&v24, &v1)) {
            0x2::vec_map::insert<0x1::type_name::TypeName, u64>(&mut v29, 0x1::type_name::get<T1>(), (*0x2::vec_map::get<u8, u256>(&v24, &v1) as u64));
            0x2::vec_map::insert<0x1::type_name::TypeName, u64>(&mut v30, 0x1::type_name::get<T1>(), (*0x2::vec_map::get<u8, u256>(&v25, &v1) as u64));
        };
        if (0x2::vec_map::contains<u8, u256>(&v24, &v2)) {
            0x2::vec_map::insert<0x1::type_name::TypeName, u64>(&mut v29, 0x1::type_name::get<T2>(), (*0x2::vec_map::get<u8, u256>(&v24, &v2) as u64));
            0x2::vec_map::insert<0x1::type_name::TypeName, u64>(&mut v30, 0x1::type_name::get<T2>(), (*0x2::vec_map::get<u8, u256>(&v25, &v2) as u64));
        };
        0x831ac2a95f8554dc097e7fb9e163ac569ba0df49b0c0598fb05219149c76babc::events::liquidity_withdrawal_event(0x831ac2a95f8554dc097e7fb9e163ac569ba0df49b0c0598fb05219149c76babc::ramm::get_id(arg0), 0x2::tx_context::sender(arg5), 0x1::type_name::get<T3>(), v11, v29, v30);
        0x831ac2a95f8554dc097e7fb9e163ac569ba0df49b0c0598fb05219149c76babc::ramm::check_ramm_invariants_3<T0, T1, T2>(arg0);
    }

    public entry fun trade_amount_in_3<T0, T1, T2>(arg0: &mut 0x831ac2a95f8554dc097e7fb9e163ac569ba0df49b0c0598fb05219149c76babc::ramm::RAMM, arg1: 0x2::coin::Coin<T0>, arg2: u64, arg3: &0x8d79f4d920b03d88faca1e421af023a87fbb1e4a6fd200248e6e9998d09e470::aggregator::Aggregator, arg4: &0x8d79f4d920b03d88faca1e421af023a87fbb1e4a6fd200248e6e9998d09e470::aggregator::Aggregator, arg5: &0x8d79f4d920b03d88faca1e421af023a87fbb1e4a6fd200248e6e9998d09e470::aggregator::Aggregator, arg6: &mut 0x2::tx_context::TxContext) {
        assert!(0x831ac2a95f8554dc097e7fb9e163ac569ba0df49b0c0598fb05219149c76babc::ramm::get_asset_count(arg0) == 3, 0);
        let v0 = 0x831ac2a95f8554dc097e7fb9e163ac569ba0df49b0c0598fb05219149c76babc::ramm::get_asset_index<T0>(arg0);
        assert!(0x2::coin::value<T0>(&arg1) >= 0x831ac2a95f8554dc097e7fb9e163ac569ba0df49b0c0598fb05219149c76babc::ramm::get_min_trade_amount(arg0, v0), 6);
        assert!(0x831ac2a95f8554dc097e7fb9e163ac569ba0df49b0c0598fb05219149c76babc::ramm::lptok_in_circulation<T0>(arg0, v0) > 0, 3);
        let v1 = 0x831ac2a95f8554dc097e7fb9e163ac569ba0df49b0c0598fb05219149c76babc::ramm::get_asset_index<T1>(arg0);
        assert!((0x831ac2a95f8554dc097e7fb9e163ac569ba0df49b0c0598fb05219149c76babc::ramm::get_bal(arg0, v1) as u64) > 0, 4);
        0x831ac2a95f8554dc097e7fb9e163ac569ba0df49b0c0598fb05219149c76babc::ramm::check_trade_amount_in<T0>(arg0, (0x2::coin::value<T0>(&arg1) as u256));
        let v2 = 0x831ac2a95f8554dc097e7fb9e163ac569ba0df49b0c0598fb05219149c76babc::ramm::get_asset_index<T2>(arg0);
        let v3 = 0x2::vec_map::empty<u8, u256>();
        let v4 = 0x2::vec_map::empty<u8, u256>();
        let v5 = 0x2::vec_map::empty<u8, u64>();
        0x831ac2a95f8554dc097e7fb9e163ac569ba0df49b0c0598fb05219149c76babc::ramm::check_feed_and_get_price_data(arg0, v0, arg3, &mut v3, &mut v4, &mut v5);
        0x831ac2a95f8554dc097e7fb9e163ac569ba0df49b0c0598fb05219149c76babc::ramm::check_feed_and_get_price_data(arg0, v1, arg4, &mut v3, &mut v4, &mut v5);
        0x831ac2a95f8554dc097e7fb9e163ac569ba0df49b0c0598fb05219149c76babc::ramm::check_feed_and_get_price_data(arg0, v2, arg5, &mut v3, &mut v4, &mut v5);
        let v6 = 0x831ac2a95f8554dc097e7fb9e163ac569ba0df49b0c0598fb05219149c76babc::ramm::compute_volatility_fee(arg0, v0, *0x2::vec_map::get<u8, u256>(&v3, &v0), *0x2::vec_map::get<u8, u64>(&v5, &v0));
        let v7 = 0x831ac2a95f8554dc097e7fb9e163ac569ba0df49b0c0598fb05219149c76babc::ramm::compute_volatility_fee(arg0, v1, *0x2::vec_map::get<u8, u256>(&v3, &v1), *0x2::vec_map::get<u8, u64>(&v5, &v1));
        let v8 = 0x2::coin::value<T0>(&arg1);
        let v9 = 0x831ac2a95f8554dc097e7fb9e163ac569ba0df49b0c0598fb05219149c76babc::ramm::trade_i<T0, T1>(arg0, v0, v1, (v8 as u256), v3, v4, v6 + v7);
        let v10 = *0x2::vec_map::get<u8, u256>(&v3, &v0);
        let v11 = *0x2::vec_map::get<u8, u64>(&v5, &v0);
        let v12 = *0x2::vec_map::get<u8, u256>(&v3, &v1);
        let v13 = *0x2::vec_map::get<u8, u64>(&v5, &v1);
        let v14 = *0x2::vec_map::get<u8, u256>(&v3, &v2);
        let v15 = *0x2::vec_map::get<u8, u64>(&v5, &v2);
        0x831ac2a95f8554dc097e7fb9e163ac569ba0df49b0c0598fb05219149c76babc::ramm::update_volatility_data(arg0, v0, 0x831ac2a95f8554dc097e7fb9e163ac569ba0df49b0c0598fb05219149c76babc::ramm::get_prev_prc(arg0, v0), 0x831ac2a95f8554dc097e7fb9e163ac569ba0df49b0c0598fb05219149c76babc::ramm::get_prev_prc_tmstmp(arg0, v0), v10, v11, v6);
        0x831ac2a95f8554dc097e7fb9e163ac569ba0df49b0c0598fb05219149c76babc::ramm::update_volatility_data(arg0, v1, 0x831ac2a95f8554dc097e7fb9e163ac569ba0df49b0c0598fb05219149c76babc::ramm::get_prev_prc(arg0, v1), 0x831ac2a95f8554dc097e7fb9e163ac569ba0df49b0c0598fb05219149c76babc::ramm::get_prev_prc_tmstmp(arg0, v1), v12, v13, v7);
        0x831ac2a95f8554dc097e7fb9e163ac569ba0df49b0c0598fb05219149c76babc::ramm::update_volatility_data(arg0, v2, 0x831ac2a95f8554dc097e7fb9e163ac569ba0df49b0c0598fb05219149c76babc::ramm::get_prev_prc(arg0, v2), 0x831ac2a95f8554dc097e7fb9e163ac569ba0df49b0c0598fb05219149c76babc::ramm::get_prev_prc_tmstmp(arg0, v2), v14, v15, 0x831ac2a95f8554dc097e7fb9e163ac569ba0df49b0c0598fb05219149c76babc::ramm::compute_volatility_fee(arg0, v2, *0x2::vec_map::get<u8, u256>(&v3, &v2), *0x2::vec_map::get<u8, u64>(&v5, &v2)));
        0x831ac2a95f8554dc097e7fb9e163ac569ba0df49b0c0598fb05219149c76babc::ramm::update_pricing_data<T0>(arg0, v10, v11);
        0x831ac2a95f8554dc097e7fb9e163ac569ba0df49b0c0598fb05219149c76babc::ramm::update_pricing_data<T1>(arg0, v12, v13);
        0x831ac2a95f8554dc097e7fb9e163ac569ba0df49b0c0598fb05219149c76babc::ramm::update_pricing_data<T2>(arg0, v14, v15);
        let v16 = 0x831ac2a95f8554dc097e7fb9e163ac569ba0df49b0c0598fb05219149c76babc::ramm::amount(&v9);
        0x831ac2a95f8554dc097e7fb9e163ac569ba0df49b0c0598fb05219149c76babc::ramm::check_trade_amount_out<T1>(arg0, v16);
        let v17 = (v16 as u64);
        if (0x831ac2a95f8554dc097e7fb9e163ac569ba0df49b0c0598fb05219149c76babc::ramm::execute(&v9) && v17 >= arg2) {
            let v18 = 0x2::coin::into_balance<T0>(arg1);
            let v19 = (0x831ac2a95f8554dc097e7fb9e163ac569ba0df49b0c0598fb05219149c76babc::ramm::protocol_fee(&v9) as u64);
            0x831ac2a95f8554dc097e7fb9e163ac569ba0df49b0c0598fb05219149c76babc::ramm::join_protocol_fees<T0>(arg0, v0, 0x2::balance::split<T0>(&mut v18, v19));
            0x831ac2a95f8554dc097e7fb9e163ac569ba0df49b0c0598fb05219149c76babc::ramm::join_bal(arg0, v0, (0x2::balance::value<T0>(&v18) as u256));
            0x831ac2a95f8554dc097e7fb9e163ac569ba0df49b0c0598fb05219149c76babc::ramm::join_typed_bal<T0>(arg0, v0, v18);
            0x831ac2a95f8554dc097e7fb9e163ac569ba0df49b0c0598fb05219149c76babc::ramm::split_bal(arg0, v1, v16);
            0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(0x2::coin::from_balance<T1>(0x831ac2a95f8554dc097e7fb9e163ac569ba0df49b0c0598fb05219149c76babc::ramm::split_typed_bal<T1>(arg0, v1, v17), arg6), 0x2::tx_context::sender(arg6));
            0x831ac2a95f8554dc097e7fb9e163ac569ba0df49b0c0598fb05219149c76babc::events::trade_event<0x831ac2a95f8554dc097e7fb9e163ac569ba0df49b0c0598fb05219149c76babc::events::TradeIn>(0x831ac2a95f8554dc097e7fb9e163ac569ba0df49b0c0598fb05219149c76babc::ramm::get_id(arg0), 0x2::tx_context::sender(arg6), 0x1::type_name::get<T0>(), 0x1::type_name::get<T1>(), v8, v17, v19, 0x831ac2a95f8554dc097e7fb9e163ac569ba0df49b0c0598fb05219149c76babc::ramm::execute(&v9));
        } else if (!0x831ac2a95f8554dc097e7fb9e163ac569ba0df49b0c0598fb05219149c76babc::ramm::execute(&v9)) {
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(arg1, 0x2::tx_context::sender(arg6));
            0x831ac2a95f8554dc097e7fb9e163ac569ba0df49b0c0598fb05219149c76babc::events::trade_failure_event<0x831ac2a95f8554dc097e7fb9e163ac569ba0df49b0c0598fb05219149c76babc::events::TradeIn>(0x831ac2a95f8554dc097e7fb9e163ac569ba0df49b0c0598fb05219149c76babc::ramm::get_id(arg0), 0x2::tx_context::sender(arg6), 0x1::type_name::get<T0>(), 0x1::type_name::get<T1>(), v8, 0x831ac2a95f8554dc097e7fb9e163ac569ba0df49b0c0598fb05219149c76babc::ramm::message(&v9));
        } else {
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(arg1, 0x2::tx_context::sender(arg6));
            0x831ac2a95f8554dc097e7fb9e163ac569ba0df49b0c0598fb05219149c76babc::events::trade_failure_event<0x831ac2a95f8554dc097e7fb9e163ac569ba0df49b0c0598fb05219149c76babc::events::TradeIn>(0x831ac2a95f8554dc097e7fb9e163ac569ba0df49b0c0598fb05219149c76babc::ramm::get_id(arg0), 0x2::tx_context::sender(arg6), 0x1::type_name::get<T0>(), 0x1::type_name::get<T1>(), v8, 0x1::string::utf8(b"Trade not executed due to slippage tolerance."));
        };
        0x831ac2a95f8554dc097e7fb9e163ac569ba0df49b0c0598fb05219149c76babc::ramm::check_ramm_invariants_3<T0, T1, T2>(arg0);
    }

    public entry fun trade_amount_out_3<T0, T1, T2>(arg0: &mut 0x831ac2a95f8554dc097e7fb9e163ac569ba0df49b0c0598fb05219149c76babc::ramm::RAMM, arg1: u64, arg2: 0x2::coin::Coin<T0>, arg3: &0x8d79f4d920b03d88faca1e421af023a87fbb1e4a6fd200248e6e9998d09e470::aggregator::Aggregator, arg4: &0x8d79f4d920b03d88faca1e421af023a87fbb1e4a6fd200248e6e9998d09e470::aggregator::Aggregator, arg5: &0x8d79f4d920b03d88faca1e421af023a87fbb1e4a6fd200248e6e9998d09e470::aggregator::Aggregator, arg6: &mut 0x2::tx_context::TxContext) {
        assert!(0x831ac2a95f8554dc097e7fb9e163ac569ba0df49b0c0598fb05219149c76babc::ramm::get_asset_count(arg0) == 3, 0);
        let v0 = 0x831ac2a95f8554dc097e7fb9e163ac569ba0df49b0c0598fb05219149c76babc::ramm::get_asset_index<T0>(arg0);
        assert!(0x831ac2a95f8554dc097e7fb9e163ac569ba0df49b0c0598fb05219149c76babc::ramm::lptok_in_circulation<T0>(arg0, v0) > 0, 3);
        let v1 = 0x831ac2a95f8554dc097e7fb9e163ac569ba0df49b0c0598fb05219149c76babc::ramm::get_asset_index<T1>(arg0);
        assert!(arg1 >= 0x831ac2a95f8554dc097e7fb9e163ac569ba0df49b0c0598fb05219149c76babc::ramm::get_min_trade_amount(arg0, v1), 6);
        let v2 = (0x831ac2a95f8554dc097e7fb9e163ac569ba0df49b0c0598fb05219149c76babc::ramm::get_bal(arg0, v1) as u64);
        assert!(v2 >= arg1, 4);
        if (arg1 == v2) {
            assert!(0x831ac2a95f8554dc097e7fb9e163ac569ba0df49b0c0598fb05219149c76babc::ramm::lptok_in_circulation<T1>(arg0, v1) == 0, 5);
        };
        let v3 = 0x831ac2a95f8554dc097e7fb9e163ac569ba0df49b0c0598fb05219149c76babc::ramm::get_asset_index<T2>(arg0);
        0x831ac2a95f8554dc097e7fb9e163ac569ba0df49b0c0598fb05219149c76babc::ramm::check_trade_amount_out<T1>(arg0, (arg1 as u256));
        let v4 = 0x2::vec_map::empty<u8, u256>();
        let v5 = 0x2::vec_map::empty<u8, u256>();
        let v6 = 0x2::vec_map::empty<u8, u64>();
        0x831ac2a95f8554dc097e7fb9e163ac569ba0df49b0c0598fb05219149c76babc::ramm::check_feed_and_get_price_data(arg0, v0, arg3, &mut v4, &mut v5, &mut v6);
        0x831ac2a95f8554dc097e7fb9e163ac569ba0df49b0c0598fb05219149c76babc::ramm::check_feed_and_get_price_data(arg0, v1, arg4, &mut v4, &mut v5, &mut v6);
        0x831ac2a95f8554dc097e7fb9e163ac569ba0df49b0c0598fb05219149c76babc::ramm::check_feed_and_get_price_data(arg0, v3, arg5, &mut v4, &mut v5, &mut v6);
        let v7 = 0x831ac2a95f8554dc097e7fb9e163ac569ba0df49b0c0598fb05219149c76babc::ramm::compute_volatility_fee(arg0, v0, *0x2::vec_map::get<u8, u256>(&v4, &v0), *0x2::vec_map::get<u8, u64>(&v6, &v0));
        let v8 = 0x831ac2a95f8554dc097e7fb9e163ac569ba0df49b0c0598fb05219149c76babc::ramm::compute_volatility_fee(arg0, v1, *0x2::vec_map::get<u8, u256>(&v4, &v1), *0x2::vec_map::get<u8, u64>(&v6, &v1));
        let v9 = 0x831ac2a95f8554dc097e7fb9e163ac569ba0df49b0c0598fb05219149c76babc::ramm::trade_o<T0, T1>(arg0, v0, v1, arg1, v4, v5, v7 + v8);
        let v10 = *0x2::vec_map::get<u8, u256>(&v4, &v0);
        let v11 = *0x2::vec_map::get<u8, u64>(&v6, &v0);
        let v12 = *0x2::vec_map::get<u8, u256>(&v4, &v1);
        let v13 = *0x2::vec_map::get<u8, u64>(&v6, &v1);
        let v14 = *0x2::vec_map::get<u8, u256>(&v4, &v3);
        let v15 = *0x2::vec_map::get<u8, u64>(&v6, &v3);
        0x831ac2a95f8554dc097e7fb9e163ac569ba0df49b0c0598fb05219149c76babc::ramm::update_volatility_data(arg0, v0, 0x831ac2a95f8554dc097e7fb9e163ac569ba0df49b0c0598fb05219149c76babc::ramm::get_prev_prc(arg0, v0), 0x831ac2a95f8554dc097e7fb9e163ac569ba0df49b0c0598fb05219149c76babc::ramm::get_prev_prc_tmstmp(arg0, v0), v10, v11, v7);
        0x831ac2a95f8554dc097e7fb9e163ac569ba0df49b0c0598fb05219149c76babc::ramm::update_volatility_data(arg0, v1, 0x831ac2a95f8554dc097e7fb9e163ac569ba0df49b0c0598fb05219149c76babc::ramm::get_prev_prc(arg0, v1), 0x831ac2a95f8554dc097e7fb9e163ac569ba0df49b0c0598fb05219149c76babc::ramm::get_prev_prc_tmstmp(arg0, v1), v12, v13, v8);
        0x831ac2a95f8554dc097e7fb9e163ac569ba0df49b0c0598fb05219149c76babc::ramm::update_volatility_data(arg0, v3, 0x831ac2a95f8554dc097e7fb9e163ac569ba0df49b0c0598fb05219149c76babc::ramm::get_prev_prc(arg0, v3), 0x831ac2a95f8554dc097e7fb9e163ac569ba0df49b0c0598fb05219149c76babc::ramm::get_prev_prc_tmstmp(arg0, v3), v14, v15, 0x831ac2a95f8554dc097e7fb9e163ac569ba0df49b0c0598fb05219149c76babc::ramm::compute_volatility_fee(arg0, v3, *0x2::vec_map::get<u8, u256>(&v4, &v3), *0x2::vec_map::get<u8, u64>(&v6, &v3)));
        0x831ac2a95f8554dc097e7fb9e163ac569ba0df49b0c0598fb05219149c76babc::ramm::update_pricing_data<T0>(arg0, v10, v11);
        0x831ac2a95f8554dc097e7fb9e163ac569ba0df49b0c0598fb05219149c76babc::ramm::update_pricing_data<T1>(arg0, v12, v13);
        0x831ac2a95f8554dc097e7fb9e163ac569ba0df49b0c0598fb05219149c76babc::ramm::update_pricing_data<T2>(arg0, v14, v15);
        0x831ac2a95f8554dc097e7fb9e163ac569ba0df49b0c0598fb05219149c76babc::ramm::check_trade_amount_in<T0>(arg0, 0x831ac2a95f8554dc097e7fb9e163ac569ba0df49b0c0598fb05219149c76babc::ramm::amount(&v9));
        let v16 = (0x831ac2a95f8554dc097e7fb9e163ac569ba0df49b0c0598fb05219149c76babc::ramm::amount(&v9) as u64);
        let v17 = 0x2::coin::value<T0>(&arg2);
        if (0x831ac2a95f8554dc097e7fb9e163ac569ba0df49b0c0598fb05219149c76babc::ramm::execute(&v9) && v16 <= v17) {
            let v18 = 0x2::coin::into_balance<T0>(arg2);
            let v19 = 0x2::balance::split<T0>(&mut v18, v16);
            let v20 = (0x831ac2a95f8554dc097e7fb9e163ac569ba0df49b0c0598fb05219149c76babc::ramm::protocol_fee(&v9) as u64);
            0x831ac2a95f8554dc097e7fb9e163ac569ba0df49b0c0598fb05219149c76babc::ramm::join_protocol_fees<T0>(arg0, v0, 0x2::balance::split<T0>(&mut v19, v20));
            0x831ac2a95f8554dc097e7fb9e163ac569ba0df49b0c0598fb05219149c76babc::ramm::join_bal(arg0, v0, (0x2::balance::value<T0>(&v19) as u256));
            0x831ac2a95f8554dc097e7fb9e163ac569ba0df49b0c0598fb05219149c76babc::ramm::join_typed_bal<T0>(arg0, v0, v19);
            0x831ac2a95f8554dc097e7fb9e163ac569ba0df49b0c0598fb05219149c76babc::ramm::split_bal(arg0, v1, (arg1 as u256));
            0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(0x2::coin::from_balance<T1>(0x831ac2a95f8554dc097e7fb9e163ac569ba0df49b0c0598fb05219149c76babc::ramm::split_typed_bal<T1>(arg0, v1, arg1), arg6), 0x2::tx_context::sender(arg6));
            0x831ac2a95f8554dc097e7fb9e163ac569ba0df49b0c0598fb05219149c76babc::events::trade_event<0x831ac2a95f8554dc097e7fb9e163ac569ba0df49b0c0598fb05219149c76babc::events::TradeOut>(0x831ac2a95f8554dc097e7fb9e163ac569ba0df49b0c0598fb05219149c76babc::ramm::get_id(arg0), 0x2::tx_context::sender(arg6), 0x1::type_name::get<T0>(), 0x1::type_name::get<T1>(), v16, arg1, v20, 0x831ac2a95f8554dc097e7fb9e163ac569ba0df49b0c0598fb05219149c76babc::ramm::execute(&v9));
            if (0x2::balance::value<T0>(&v18) > 0) {
                0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(v18, arg6), 0x2::tx_context::sender(arg6));
            } else {
                0x2::balance::destroy_zero<T0>(v18);
            };
        } else if (!0x831ac2a95f8554dc097e7fb9e163ac569ba0df49b0c0598fb05219149c76babc::ramm::execute(&v9)) {
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(arg2, 0x2::tx_context::sender(arg6));
            0x831ac2a95f8554dc097e7fb9e163ac569ba0df49b0c0598fb05219149c76babc::events::trade_failure_event<0x831ac2a95f8554dc097e7fb9e163ac569ba0df49b0c0598fb05219149c76babc::events::TradeOut>(0x831ac2a95f8554dc097e7fb9e163ac569ba0df49b0c0598fb05219149c76babc::ramm::get_id(arg0), 0x2::tx_context::sender(arg6), 0x1::type_name::get<T0>(), 0x1::type_name::get<T1>(), v17, 0x831ac2a95f8554dc097e7fb9e163ac569ba0df49b0c0598fb05219149c76babc::ramm::message(&v9));
        } else {
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(arg2, 0x2::tx_context::sender(arg6));
            0x831ac2a95f8554dc097e7fb9e163ac569ba0df49b0c0598fb05219149c76babc::events::trade_failure_event<0x831ac2a95f8554dc097e7fb9e163ac569ba0df49b0c0598fb05219149c76babc::events::TradeOut>(0x831ac2a95f8554dc097e7fb9e163ac569ba0df49b0c0598fb05219149c76babc::ramm::get_id(arg0), 0x2::tx_context::sender(arg6), 0x1::type_name::get<T0>(), 0x1::type_name::get<T1>(), v17, 0x1::string::utf8(b"Trade not executed due to slippage tolerance."));
        };
        0x831ac2a95f8554dc097e7fb9e163ac569ba0df49b0c0598fb05219149c76babc::ramm::check_ramm_invariants_3<T0, T1, T2>(arg0);
    }

    // decompiled from Move bytecode v6
}

