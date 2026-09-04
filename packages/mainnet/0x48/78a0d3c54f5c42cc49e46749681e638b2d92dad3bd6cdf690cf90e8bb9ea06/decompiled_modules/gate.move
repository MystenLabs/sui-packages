module 0x4878a0d3c54f5c42cc49e46749681e638b2d92dad3bd6cdf690cf90e8bb9ea06::gate {
    public fun can_liquidate_batch<T0, T1, T2, T3>(arg0: &0xf7fade57462e56e2eff1d7adef32e4fd285b21fd81f983f407bb7110ca766cda::market::Market<T0>, arg1: &0xf7fade57462e56e2eff1d7adef32e4fd285b21fd81f983f407bb7110ca766cda::model::ReservingFeeModel, arg2: &0xf7fade57462e56e2eff1d7adef32e4fd285b21fd81f983f407bb7110ca766cda::model::FundingFeeModel, arg3: &0x460fe6da5e82b6633a57cbb17bb09e61252d2db836f133f9188b2835f9d2824::core::OracleRegistry, arg4: &0x7b502c8a7bcb3915892347f11086745570e759fe9708d03c03accf4c90bbf580::update_v2::Update, arg5: &0xbc96aa8e79e0831131f00e7d9568fb40f283e6b96c2516dd99aa26b67459b60a::state::StorkState, arg6: &0x2::clock::Clock, arg7: bool, arg8: vector<address>, arg9: vector<address>) : vector<bool> {
        assert!(0x1::vector::length<address>(&arg8) == 0x1::vector::length<address>(&arg9), 1);
        let v0 = 0xf7fade57462e56e2eff1d7adef32e4fd285b21fd81f983f407bb7110ca766cda::market::vault<T0, T1>(arg0);
        let v1 = 0xf7fade57462e56e2eff1d7adef32e4fd285b21fd81f983f407bb7110ca766cda::market::symbol<T0, T2, T3>(arg0);
        let v2 = 0xf7fade57462e56e2eff1d7adef32e4fd285b21fd81f983f407bb7110ca766cda::pool::vault_price_config<T1>(v0);
        let v3 = 0xf7fade57462e56e2eff1d7adef32e4fd285b21fd81f983f407bb7110ca766cda::pool::symbol_price_config(v1);
        let v4 = 0xf7fade57462e56e2eff1d7adef32e4fd285b21fd81f983f407bb7110ca766cda::oracle_adpater::get_validated_pyth_pro_price_v2<T1>(arg3, arg4, arg5, arg6, 0xf7fade57462e56e2eff1d7adef32e4fd285b21fd81f983f407bb7110ca766cda::agg_price::max_interval_of(v2) * 1000);
        let v5 = 0xf7fade57462e56e2eff1d7adef32e4fd285b21fd81f983f407bb7110ca766cda::oracle_adpater::get_validated_pyth_pro_price_v2<T2>(arg3, arg4, arg5, arg6, 0xf7fade57462e56e2eff1d7adef32e4fd285b21fd81f983f407bb7110ca766cda::agg_price::max_interval_of(v3) * 1000);
        let v6 = 0xf7fade57462e56e2eff1d7adef32e4fd285b21fd81f983f407bb7110ca766cda::agg_price::from_normalized_price(v2, &v4);
        let v7 = 0xf7fade57462e56e2eff1d7adef32e4fd285b21fd81f983f407bb7110ca766cda::agg_price::from_normalized_price(v3, &v5);
        let v8 = 0x2::clock::timestamp_ms(arg6) / 1000;
        let v9 = 0xf7fade57462e56e2eff1d7adef32e4fd285b21fd81f983f407bb7110ca766cda::pool::symbol_acc_funding_rate(v1, 0xf7fade57462e56e2eff1d7adef32e4fd285b21fd81f983f407bb7110ca766cda::pool::symbol_delta_funding_rate(v1, arg2, 0xf7fade57462e56e2eff1d7adef32e4fd285b21fd81f983f407bb7110ca766cda::pool::symbol_delta_size(v1, &v7, arg7), 0xf7fade57462e56e2eff1d7adef32e4fd285b21fd81f983f407bb7110ca766cda::pool::symbol_opening_size(v1), v8));
        let v10 = vector[];
        let v11 = 0;
        while (v11 < 0x1::vector::length<address>(&arg8)) {
            let v12 = 0xf7fade57462e56e2eff1d7adef32e4fd285b21fd81f983f407bb7110ca766cda::market::position<T0, T1, T2, T3>(arg0, 0x2::object::id_from_address(*0x1::vector::borrow<address>(&arg9, v11)), *0x1::vector::borrow<address>(&arg8, v11));
            let v13 = 0xf7fade57462e56e2eff1d7adef32e4fd285b21fd81f983f407bb7110ca766cda::sdecimal::sub(0xf7fade57462e56e2eff1d7adef32e4fd285b21fd81f983f407bb7110ca766cda::position::compute_delta_size<T1>(v12, &v7, arg7), 0xf7fade57462e56e2eff1d7adef32e4fd285b21fd81f983f407bb7110ca766cda::sdecimal::add_with_decimal(0xf7fade57462e56e2eff1d7adef32e4fd285b21fd81f983f407bb7110ca766cda::position::compute_funding_fee_value<T1>(v12, v9), 0xf7fade57462e56e2eff1d7adef32e4fd285b21fd81f983f407bb7110ca766cda::agg_price::coins_to_value(&v6, 0xf7fade57462e56e2eff1d7adef32e4fd285b21fd81f983f407bb7110ca766cda::decimal::ceil_u64(0xf7fade57462e56e2eff1d7adef32e4fd285b21fd81f983f407bb7110ca766cda::position::compute_reserving_fee_amount<T1>(v12, 0xf7fade57462e56e2eff1d7adef32e4fd285b21fd81f983f407bb7110ca766cda::pool::vault_acc_reserving_rate<T1>(v0, 0xf7fade57462e56e2eff1d7adef32e4fd285b21fd81f983f407bb7110ca766cda::pool::vault_delta_reserving_rate<T1>(v0, arg1, v8)))))));
            0x1::vector::push_back<bool>(&mut v10, 0xf7fade57462e56e2eff1d7adef32e4fd285b21fd81f983f407bb7110ca766cda::position::check_liquidation(0xf7fade57462e56e2eff1d7adef32e4fd285b21fd81f983f407bb7110ca766cda::position::position_config<T1>(v12), 0xf7fade57462e56e2eff1d7adef32e4fd285b21fd81f983f407bb7110ca766cda::agg_price::coins_to_value(&v6, 0xf7fade57462e56e2eff1d7adef32e4fd285b21fd81f983f407bb7110ca766cda::position::collateral_amount<T1>(v12)), &v13));
            v11 = v11 + 1;
        };
        v10
    }

    public fun liquidate_if_eligible_batch<T0, T1, T2, T3>(arg0: &mut 0xf7fade57462e56e2eff1d7adef32e4fd285b21fd81f983f407bb7110ca766cda::market::Market<T0>, arg1: &0xf7fade57462e56e2eff1d7adef32e4fd285b21fd81f983f407bb7110ca766cda::model::ReservingFeeModel, arg2: &0xf7fade57462e56e2eff1d7adef32e4fd285b21fd81f983f407bb7110ca766cda::model::FundingFeeModel, arg3: &0x460fe6da5e82b6633a57cbb17bb09e61252d2db836f133f9188b2835f9d2824::core::OracleRegistry, arg4: &0x7b502c8a7bcb3915892347f11086745570e759fe9708d03c03accf4c90bbf580::update_v2::Update, arg5: &0xbc96aa8e79e0831131f00e7d9568fb40f283e6b96c2516dd99aa26b67459b60a::state::StorkState, arg6: &0x2::clock::Clock, arg7: bool, arg8: vector<address>, arg9: vector<address>, arg10: &mut 0x2::tx_context::TxContext) {
        assert!(0x1::vector::length<address>(&arg8) == 0x1::vector::length<address>(&arg9), 1);
        let v0 = can_liquidate_batch<T0, T1, T2, T3>(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9);
        let v1 = 0;
        while (v1 < 0x1::vector::length<bool>(&v0)) {
            if (*0x1::vector::borrow<bool>(&v0, v1)) {
                0xf7fade57462e56e2eff1d7adef32e4fd285b21fd81f983f407bb7110ca766cda::market::liquidate_position_v3_1<T0, T1, T2, T3>(arg6, arg0, arg1, arg2, arg3, arg5, arg4, *0x1::vector::borrow<address>(&arg8, v1), *0x1::vector::borrow<address>(&arg9, v1), arg10);
            };
            v1 = v1 + 1;
        };
    }

    // decompiled from Move bytecode v7
}

