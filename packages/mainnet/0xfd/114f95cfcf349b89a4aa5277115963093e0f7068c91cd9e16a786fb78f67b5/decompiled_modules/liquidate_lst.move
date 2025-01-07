module 0xfd114f95cfcf349b89a4aa5277115963093e0f7068c91cd9e16a786fb78f67b5::liquidate_lst {
    public fun liquidate_obligation_with_lst_as_collateral_1<T0, T1, T2>(arg0: &0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::version::Version, arg1: &mut 0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::obligation::Obligation, arg2: &mut 0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::market::Market, arg3: &0xca5a5a62f01c79a104bf4d31669e29daa387f325c241de4edbe30986a9bc8b0d::coin_decimals_registry::CoinDecimalsRegistry, arg4: &mut 0x1478a432123e4b3d61878b629f2c692969fdb375644f1251cd278a4b1e7d7cd6::x_oracle::XOracle, arg5: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg6: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, 0x2::sui::SUI>, arg7: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T2, T1>, arg8: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T2, 0x2::sui::SUI>, arg9: &0x2::clock::Clock, arg10: &mut 0x2::tx_context::TxContext) {
        let v0 = 0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::obligation::debt_types(arg1);
        let v1 = 0x1::type_name::get<T1>();
        let v2 = if (0x1::vector::contains<0x1::type_name::TypeName>(&v0, &v1) == false) {
            true
        } else {
            let v3 = 0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::obligation::collateral_types(arg1);
            let v4 = 0x1::type_name::get<T0>();
            0x1::vector::contains<0x1::type_name::TypeName>(&v3, &v4) == false
        };
        if (v2) {
            return
        };
        0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::accrue_interest::accrue_interest_for_market_and_obligation(arg0, arg2, arg1, arg9);
        if (!0xfd114f95cfcf349b89a4aa5277115963093e0f7068c91cd9e16a786fb78f67b5::liquidator::is_eligible_to_be_liquidated(arg1, arg2, arg3, arg4, arg9)) {
            return
        };
        let (v5, v6) = 0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::liquidation_evaluator::max_liquidation_amounts<T1, T0>(arg1, arg2, arg3, arg4, arg9);
        if (0xfd114f95cfcf349b89a4aa5277115963093e0f7068c91cd9e16a786fb78f67b5::cetus_util::calculate_swap_amount_in<T2, 0x2::sui::SUI>(arg8, false, 0xfd114f95cfcf349b89a4aa5277115963093e0f7068c91cd9e16a786fb78f67b5::cetus_util::calculate_swap_amount_in<T2, T1>(arg7, true, v5)) > v6) {
            return
        };
        let (v7, v8) = 0xe79c178a9d6ba44b3541402de089a36a92063ce8c5ee31aaec68577ca05e3b3a::cetus_flash_loan::borrow_b_repay_a_later<T2, T1>(arg5, arg7, v5, arg9, arg10);
        let v9 = v8;
        let (v10, v11) = 0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::liquidate::liquidate<T1, T0>(arg0, arg1, arg2, v7, arg3, arg4, arg9, arg10);
        let v12 = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::swap_pay_amount<T2, T1>(&v9);
        let (v13, v14) = 0xe79c178a9d6ba44b3541402de089a36a92063ce8c5ee31aaec68577ca05e3b3a::cetus_flash_loan::borrow_a_repay_b_later<T2, 0x2::sui::SUI>(arg5, arg8, v12, arg9, arg10);
        let v15 = v14;
        let v16 = v13;
        0xe79c178a9d6ba44b3541402de089a36a92063ce8c5ee31aaec68577ca05e3b3a::cetus_flash_loan::repay_a<T2, T1>(arg5, arg7, 0x2::coin::split<T2>(&mut v16, v12, arg10), v9);
        let v17 = 0xfd114f95cfcf349b89a4aa5277115963093e0f7068c91cd9e16a786fb78f67b5::cetus_util::swap_a_to_b<T0, 0x2::sui::SUI>(arg5, arg6, v11, arg9, arg10);
        0xe79c178a9d6ba44b3541402de089a36a92063ce8c5ee31aaec68577ca05e3b3a::cetus_flash_loan::repay_b<T2, 0x2::sui::SUI>(arg5, arg8, 0x2::coin::split<0x2::sui::SUI>(&mut v17, 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::swap_pay_amount<T2, 0x2::sui::SUI>(&v15), arg10), v15);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(v17, 0x2::tx_context::sender(arg10));
        0xfd114f95cfcf349b89a4aa5277115963093e0f7068c91cd9e16a786fb78f67b5::coin_util::destory_or_send_to_sender<T1>(v10, arg10);
        0xfd114f95cfcf349b89a4aa5277115963093e0f7068c91cd9e16a786fb78f67b5::coin_util::destory_or_send_to_sender<T2>(v16, arg10);
    }

    public fun liquidate_obligation_with_lst_as_collateral_2<T0, T1, T2>(arg0: &0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::version::Version, arg1: &mut 0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::obligation::Obligation, arg2: &mut 0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::market::Market, arg3: &0xca5a5a62f01c79a104bf4d31669e29daa387f325c241de4edbe30986a9bc8b0d::coin_decimals_registry::CoinDecimalsRegistry, arg4: &mut 0x1478a432123e4b3d61878b629f2c692969fdb375644f1251cd278a4b1e7d7cd6::x_oracle::XOracle, arg5: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg6: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, 0x2::sui::SUI>, arg7: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T1, T2>, arg8: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T2, 0x2::sui::SUI>, arg9: &0x2::clock::Clock, arg10: &mut 0x2::tx_context::TxContext) {
        let v0 = 0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::obligation::debt_types(arg1);
        let v1 = 0x1::type_name::get<T1>();
        let v2 = if (0x1::vector::contains<0x1::type_name::TypeName>(&v0, &v1) == false) {
            true
        } else {
            let v3 = 0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::obligation::collateral_types(arg1);
            let v4 = 0x1::type_name::get<T0>();
            0x1::vector::contains<0x1::type_name::TypeName>(&v3, &v4) == false
        };
        if (v2) {
            return
        };
        0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::accrue_interest::accrue_interest_for_market_and_obligation(arg0, arg2, arg1, arg9);
        if (!0xfd114f95cfcf349b89a4aa5277115963093e0f7068c91cd9e16a786fb78f67b5::liquidator::is_eligible_to_be_liquidated(arg1, arg2, arg3, arg4, arg9)) {
            return
        };
        let (v5, v6) = 0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::liquidation_evaluator::max_liquidation_amounts<T1, T0>(arg1, arg2, arg3, arg4, arg9);
        if (0xfd114f95cfcf349b89a4aa5277115963093e0f7068c91cd9e16a786fb78f67b5::cetus_util::calculate_swap_amount_in<T2, 0x2::sui::SUI>(arg8, false, 0xfd114f95cfcf349b89a4aa5277115963093e0f7068c91cd9e16a786fb78f67b5::cetus_util::calculate_swap_amount_in<T1, T2>(arg7, false, v5)) > v6) {
            return
        };
        let (v7, v8) = 0xe79c178a9d6ba44b3541402de089a36a92063ce8c5ee31aaec68577ca05e3b3a::cetus_flash_loan::borrow_a_repay_b_later<T1, T2>(arg5, arg7, v5, arg9, arg10);
        let v9 = v8;
        let (v10, v11) = 0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::liquidate::liquidate<T1, T0>(arg0, arg1, arg2, v7, arg3, arg4, arg9, arg10);
        let v12 = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::swap_pay_amount<T1, T2>(&v9);
        let (v13, v14) = 0xe79c178a9d6ba44b3541402de089a36a92063ce8c5ee31aaec68577ca05e3b3a::cetus_flash_loan::borrow_a_repay_b_later<T2, 0x2::sui::SUI>(arg5, arg8, v12, arg9, arg10);
        let v15 = v14;
        let v16 = v13;
        0xe79c178a9d6ba44b3541402de089a36a92063ce8c5ee31aaec68577ca05e3b3a::cetus_flash_loan::repay_b<T1, T2>(arg5, arg7, 0x2::coin::split<T2>(&mut v16, v12, arg10), v9);
        let v17 = 0xfd114f95cfcf349b89a4aa5277115963093e0f7068c91cd9e16a786fb78f67b5::cetus_util::swap_a_to_b<T0, 0x2::sui::SUI>(arg5, arg6, v11, arg9, arg10);
        0xe79c178a9d6ba44b3541402de089a36a92063ce8c5ee31aaec68577ca05e3b3a::cetus_flash_loan::repay_b<T2, 0x2::sui::SUI>(arg5, arg8, 0x2::coin::split<0x2::sui::SUI>(&mut v17, 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::swap_pay_amount<T2, 0x2::sui::SUI>(&v15), arg10), v15);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(v17, 0x2::tx_context::sender(arg10));
        0xfd114f95cfcf349b89a4aa5277115963093e0f7068c91cd9e16a786fb78f67b5::coin_util::destory_or_send_to_sender<T1>(v10, arg10);
        0xfd114f95cfcf349b89a4aa5277115963093e0f7068c91cd9e16a786fb78f67b5::coin_util::destory_or_send_to_sender<T2>(v16, arg10);
    }

    public fun liquidate_obligation_with_lst_as_collateral_and_sui_as_debt<T0>(arg0: &0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::version::Version, arg1: &mut 0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::obligation::Obligation, arg2: &mut 0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::market::Market, arg3: &0xca5a5a62f01c79a104bf4d31669e29daa387f325c241de4edbe30986a9bc8b0d::coin_decimals_registry::CoinDecimalsRegistry, arg4: &mut 0x1478a432123e4b3d61878b629f2c692969fdb375644f1251cd278a4b1e7d7cd6::x_oracle::XOracle, arg5: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg6: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, 0x2::sui::SUI>, arg7: &0x2::clock::Clock, arg8: &mut 0x2::tx_context::TxContext) {
        let v0 = 0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::obligation::debt_types(arg1);
        let v1 = 0x1::type_name::get<0x2::sui::SUI>();
        let v2 = if (0x1::vector::contains<0x1::type_name::TypeName>(&v0, &v1) == false) {
            true
        } else {
            let v3 = 0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::obligation::collateral_types(arg1);
            let v4 = 0x1::type_name::get<T0>();
            0x1::vector::contains<0x1::type_name::TypeName>(&v3, &v4) == false
        };
        if (v2) {
            return
        };
        0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::accrue_interest::accrue_interest_for_market_and_obligation(arg0, arg2, arg1, arg7);
        if (!0xfd114f95cfcf349b89a4aa5277115963093e0f7068c91cd9e16a786fb78f67b5::liquidator::is_eligible_to_be_liquidated(arg1, arg2, arg3, arg4, arg7)) {
            return
        };
        let (v5, _) = 0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::liquidation_evaluator::max_liquidation_amounts<0x2::sui::SUI, T0>(arg1, arg2, arg3, arg4, arg7);
        let (v7, v8) = 0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::flash_loan::borrow_flash_loan<0x2::sui::SUI>(arg0, arg2, v5, arg8);
        let v9 = v8;
        let (v10, v11) = 0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::liquidate::liquidate<0x2::sui::SUI, T0>(arg0, arg1, arg2, v7, arg3, arg4, arg7, arg8);
        let v12 = 0xfd114f95cfcf349b89a4aa5277115963093e0f7068c91cd9e16a786fb78f67b5::cetus_util::swap_a_to_b<T0, 0x2::sui::SUI>(arg5, arg6, v11, arg7, arg8);
        0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::flash_loan::repay_flash_loan<0x2::sui::SUI>(arg0, arg2, 0x2::coin::split<0x2::sui::SUI>(&mut v12, 0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::reserve::flash_loan_fee<0x2::sui::SUI>(&v9) + 0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::reserve::flash_loan_loan_amount<0x2::sui::SUI>(&v9), arg8), v9, arg8);
        0xfd114f95cfcf349b89a4aa5277115963093e0f7068c91cd9e16a786fb78f67b5::coin_util::destory_or_send_to_sender<0x2::sui::SUI>(v10, arg8);
        0xfd114f95cfcf349b89a4aa5277115963093e0f7068c91cd9e16a786fb78f67b5::coin_util::destory_or_send_to_sender<0x2::sui::SUI>(v12, arg8);
    }

    public fun liquidate_obligation_with_lst_as_collateral_and_usdc_as_debt<T0, T1>(arg0: &0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::version::Version, arg1: &mut 0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::obligation::Obligation, arg2: &mut 0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::market::Market, arg3: &0xca5a5a62f01c79a104bf4d31669e29daa387f325c241de4edbe30986a9bc8b0d::coin_decimals_registry::CoinDecimalsRegistry, arg4: &mut 0x1478a432123e4b3d61878b629f2c692969fdb375644f1251cd278a4b1e7d7cd6::x_oracle::XOracle, arg5: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg6: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, 0x2::sui::SUI>, arg7: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T1, 0x2::sui::SUI>, arg8: &0x2::clock::Clock, arg9: &mut 0x2::tx_context::TxContext) {
        let v0 = 0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::obligation::debt_types(arg1);
        let v1 = 0x1::type_name::get<T1>();
        let v2 = if (0x1::vector::contains<0x1::type_name::TypeName>(&v0, &v1) == false) {
            true
        } else {
            let v3 = 0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::obligation::collateral_types(arg1);
            let v4 = 0x1::type_name::get<T0>();
            0x1::vector::contains<0x1::type_name::TypeName>(&v3, &v4) == false
        };
        if (v2) {
            return
        };
        0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::accrue_interest::accrue_interest_for_market_and_obligation(arg0, arg2, arg1, arg8);
        if (!0xfd114f95cfcf349b89a4aa5277115963093e0f7068c91cd9e16a786fb78f67b5::liquidator::is_eligible_to_be_liquidated(arg1, arg2, arg3, arg4, arg8)) {
            return
        };
        let (v5, _) = 0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::liquidation_evaluator::max_liquidation_amounts<T1, T0>(arg1, arg2, arg3, arg4, arg8);
        let (v7, v8) = 0xe79c178a9d6ba44b3541402de089a36a92063ce8c5ee31aaec68577ca05e3b3a::cetus_flash_loan::borrow_a_repay_b_later<T1, 0x2::sui::SUI>(arg5, arg7, v5, arg8, arg9);
        let v9 = v8;
        let (v10, v11) = 0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::liquidate::liquidate<T1, T0>(arg0, arg1, arg2, v7, arg3, arg4, arg8, arg9);
        let v12 = 0xfd114f95cfcf349b89a4aa5277115963093e0f7068c91cd9e16a786fb78f67b5::cetus_util::swap_a_to_b<T0, 0x2::sui::SUI>(arg5, arg6, v11, arg8, arg9);
        0xe79c178a9d6ba44b3541402de089a36a92063ce8c5ee31aaec68577ca05e3b3a::cetus_flash_loan::repay_b<T1, 0x2::sui::SUI>(arg5, arg7, 0x2::coin::split<0x2::sui::SUI>(&mut v12, 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::swap_pay_amount<T1, 0x2::sui::SUI>(&v9), arg9), v9);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(v12, 0x2::tx_context::sender(arg9));
        0xfd114f95cfcf349b89a4aa5277115963093e0f7068c91cd9e16a786fb78f67b5::coin_util::destory_or_send_to_sender<T1>(v10, arg9);
    }

    public fun liquidate_obligation_with_lst_as_debt_1<T0, T1, T2>(arg0: &0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::version::Version, arg1: &mut 0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::obligation::Obligation, arg2: &mut 0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::market::Market, arg3: &0xca5a5a62f01c79a104bf4d31669e29daa387f325c241de4edbe30986a9bc8b0d::coin_decimals_registry::CoinDecimalsRegistry, arg4: &mut 0x1478a432123e4b3d61878b629f2c692969fdb375644f1251cd278a4b1e7d7cd6::x_oracle::XOracle, arg5: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg6: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, 0x2::sui::SUI>, arg7: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T2, 0x2::sui::SUI>, arg8: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T1, T2>, arg9: &0x2::clock::Clock, arg10: &mut 0x2::tx_context::TxContext) {
        let v0 = 0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::obligation::debt_types(arg1);
        let v1 = 0x1::type_name::get<T0>();
        let v2 = if (0x1::vector::contains<0x1::type_name::TypeName>(&v0, &v1) == false) {
            true
        } else {
            let v3 = 0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::obligation::collateral_types(arg1);
            let v4 = 0x1::type_name::get<T1>();
            0x1::vector::contains<0x1::type_name::TypeName>(&v3, &v4) == false
        };
        if (v2) {
            return
        };
        0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::accrue_interest::accrue_interest_for_market_and_obligation(arg0, arg2, arg1, arg9);
        if (!0xfd114f95cfcf349b89a4aa5277115963093e0f7068c91cd9e16a786fb78f67b5::liquidator::is_eligible_to_be_liquidated(arg1, arg2, arg3, arg4, arg9)) {
            return
        };
        let (v5, v6) = 0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::liquidation_evaluator::max_liquidation_amounts<T0, T1>(arg1, arg2, arg3, arg4, arg9);
        let v7 = 0xfd114f95cfcf349b89a4aa5277115963093e0f7068c91cd9e16a786fb78f67b5::cetus_util::calculate_swap_amount_in<T0, 0x2::sui::SUI>(arg6, false, v5);
        if (0xfd114f95cfcf349b89a4aa5277115963093e0f7068c91cd9e16a786fb78f67b5::cetus_util::calculate_swap_amount_in<T1, T2>(arg8, true, 0xfd114f95cfcf349b89a4aa5277115963093e0f7068c91cd9e16a786fb78f67b5::cetus_util::calculate_swap_amount_in<T2, 0x2::sui::SUI>(arg7, true, v7)) > v6) {
            return
        };
        let (v8, v9) = 0xe79c178a9d6ba44b3541402de089a36a92063ce8c5ee31aaec68577ca05e3b3a::cetus_flash_loan::borrow_b_repay_a_later<T2, 0x2::sui::SUI>(arg5, arg7, v7, arg9, arg10);
        let v10 = v9;
        let (v11, v12) = 0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::liquidate::liquidate<T0, T1>(arg0, arg1, arg2, 0xfd114f95cfcf349b89a4aa5277115963093e0f7068c91cd9e16a786fb78f67b5::cetus_util::swap_b_to_a<T0, 0x2::sui::SUI>(arg5, arg6, v8, arg9, arg10), arg3, arg4, arg9, arg10);
        let v13 = v12;
        let v14 = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::swap_pay_amount<T2, 0x2::sui::SUI>(&v10);
        let (v15, v16) = 0xe79c178a9d6ba44b3541402de089a36a92063ce8c5ee31aaec68577ca05e3b3a::cetus_flash_loan::borrow_b_repay_a_later<T1, T2>(arg5, arg8, v14, arg9, arg10);
        let v17 = v16;
        let v18 = v15;
        0xe79c178a9d6ba44b3541402de089a36a92063ce8c5ee31aaec68577ca05e3b3a::cetus_flash_loan::repay_a<T2, 0x2::sui::SUI>(arg5, arg7, 0x2::coin::split<T2>(&mut v18, v14, arg10), v10);
        0xe79c178a9d6ba44b3541402de089a36a92063ce8c5ee31aaec68577ca05e3b3a::cetus_flash_loan::repay_a<T1, T2>(arg5, arg8, 0x2::coin::split<T1>(&mut v13, 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::swap_pay_amount<T1, T2>(&v17), arg10), v17);
        0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(v13, 0x2::tx_context::sender(arg10));
        0xfd114f95cfcf349b89a4aa5277115963093e0f7068c91cd9e16a786fb78f67b5::coin_util::destory_or_send_to_sender<T0>(v11, arg10);
        0xfd114f95cfcf349b89a4aa5277115963093e0f7068c91cd9e16a786fb78f67b5::coin_util::destory_or_send_to_sender<T2>(v18, arg10);
    }

    public fun liquidate_obligation_with_lst_as_debt_2<T0, T1, T2>(arg0: &0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::version::Version, arg1: &mut 0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::obligation::Obligation, arg2: &mut 0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::market::Market, arg3: &0xca5a5a62f01c79a104bf4d31669e29daa387f325c241de4edbe30986a9bc8b0d::coin_decimals_registry::CoinDecimalsRegistry, arg4: &mut 0x1478a432123e4b3d61878b629f2c692969fdb375644f1251cd278a4b1e7d7cd6::x_oracle::XOracle, arg5: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg6: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, 0x2::sui::SUI>, arg7: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T2, 0x2::sui::SUI>, arg8: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T2, T1>, arg9: &0x2::clock::Clock, arg10: &mut 0x2::tx_context::TxContext) {
        let v0 = 0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::obligation::debt_types(arg1);
        let v1 = 0x1::type_name::get<T0>();
        let v2 = if (0x1::vector::contains<0x1::type_name::TypeName>(&v0, &v1) == false) {
            true
        } else {
            let v3 = 0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::obligation::collateral_types(arg1);
            let v4 = 0x1::type_name::get<T1>();
            0x1::vector::contains<0x1::type_name::TypeName>(&v3, &v4) == false
        };
        if (v2) {
            return
        };
        0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::accrue_interest::accrue_interest_for_market_and_obligation(arg0, arg2, arg1, arg9);
        if (!0xfd114f95cfcf349b89a4aa5277115963093e0f7068c91cd9e16a786fb78f67b5::liquidator::is_eligible_to_be_liquidated(arg1, arg2, arg3, arg4, arg9)) {
            return
        };
        let (v5, v6) = 0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::liquidation_evaluator::max_liquidation_amounts<T0, T1>(arg1, arg2, arg3, arg4, arg9);
        let v7 = 0xfd114f95cfcf349b89a4aa5277115963093e0f7068c91cd9e16a786fb78f67b5::cetus_util::calculate_swap_amount_in<T0, 0x2::sui::SUI>(arg6, false, v5);
        if (0xfd114f95cfcf349b89a4aa5277115963093e0f7068c91cd9e16a786fb78f67b5::cetus_util::calculate_swap_amount_in<T2, T1>(arg8, false, 0xfd114f95cfcf349b89a4aa5277115963093e0f7068c91cd9e16a786fb78f67b5::cetus_util::calculate_swap_amount_in<T2, 0x2::sui::SUI>(arg7, true, v7)) > v6) {
            return
        };
        let (v8, v9) = 0xe79c178a9d6ba44b3541402de089a36a92063ce8c5ee31aaec68577ca05e3b3a::cetus_flash_loan::borrow_b_repay_a_later<T2, 0x2::sui::SUI>(arg5, arg7, v7, arg9, arg10);
        let v10 = v9;
        let (v11, v12) = 0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::liquidate::liquidate<T0, T1>(arg0, arg1, arg2, 0xfd114f95cfcf349b89a4aa5277115963093e0f7068c91cd9e16a786fb78f67b5::cetus_util::swap_b_to_a<T0, 0x2::sui::SUI>(arg5, arg6, v8, arg9, arg10), arg3, arg4, arg9, arg10);
        let v13 = v12;
        let v14 = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::swap_pay_amount<T2, 0x2::sui::SUI>(&v10);
        let (v15, v16) = 0xe79c178a9d6ba44b3541402de089a36a92063ce8c5ee31aaec68577ca05e3b3a::cetus_flash_loan::borrow_a_repay_b_later<T2, T1>(arg5, arg8, v14, arg9, arg10);
        let v17 = v16;
        let v18 = v15;
        0xe79c178a9d6ba44b3541402de089a36a92063ce8c5ee31aaec68577ca05e3b3a::cetus_flash_loan::repay_a<T2, 0x2::sui::SUI>(arg5, arg7, 0x2::coin::split<T2>(&mut v18, v14, arg10), v10);
        0xe79c178a9d6ba44b3541402de089a36a92063ce8c5ee31aaec68577ca05e3b3a::cetus_flash_loan::repay_b<T2, T1>(arg5, arg8, 0x2::coin::split<T1>(&mut v13, 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::swap_pay_amount<T2, T1>(&v17), arg10), v17);
        0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(v13, 0x2::tx_context::sender(arg10));
        0xfd114f95cfcf349b89a4aa5277115963093e0f7068c91cd9e16a786fb78f67b5::coin_util::destory_or_send_to_sender<T0>(v11, arg10);
        0xfd114f95cfcf349b89a4aa5277115963093e0f7068c91cd9e16a786fb78f67b5::coin_util::destory_or_send_to_sender<T2>(v18, arg10);
    }

    public fun liquidate_obligation_with_lst_as_debt_and_sui_as_collateral<T0>(arg0: &0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::version::Version, arg1: &mut 0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::obligation::Obligation, arg2: &mut 0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::market::Market, arg3: &0xca5a5a62f01c79a104bf4d31669e29daa387f325c241de4edbe30986a9bc8b0d::coin_decimals_registry::CoinDecimalsRegistry, arg4: &mut 0x1478a432123e4b3d61878b629f2c692969fdb375644f1251cd278a4b1e7d7cd6::x_oracle::XOracle, arg5: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg6: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, 0x2::sui::SUI>, arg7: &0x2::clock::Clock, arg8: &mut 0x2::tx_context::TxContext) {
        let v0 = 0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::obligation::debt_types(arg1);
        let v1 = 0x1::type_name::get<T0>();
        let v2 = if (0x1::vector::contains<0x1::type_name::TypeName>(&v0, &v1) == false) {
            true
        } else {
            let v3 = 0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::obligation::collateral_types(arg1);
            let v4 = 0x1::type_name::get<0x2::sui::SUI>();
            0x1::vector::contains<0x1::type_name::TypeName>(&v3, &v4) == false
        };
        if (v2) {
            return
        };
        0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::accrue_interest::accrue_interest_for_market_and_obligation(arg0, arg2, arg1, arg7);
        if (!0xfd114f95cfcf349b89a4aa5277115963093e0f7068c91cd9e16a786fb78f67b5::liquidator::is_eligible_to_be_liquidated(arg1, arg2, arg3, arg4, arg7)) {
            return
        };
        let (v5, _) = 0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::liquidation_evaluator::max_liquidation_amounts<T0, 0x2::sui::SUI>(arg1, arg2, arg3, arg4, arg7);
        let (v7, v8) = 0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::flash_loan::borrow_flash_loan<T0>(arg0, arg2, v5, arg8);
        let v9 = v8;
        let (v10, v11) = 0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::liquidate::liquidate<T0, 0x2::sui::SUI>(arg0, arg1, arg2, v7, arg3, arg4, arg7, arg8);
        let v12 = 0xfd114f95cfcf349b89a4aa5277115963093e0f7068c91cd9e16a786fb78f67b5::cetus_util::swap_b_to_a<T0, 0x2::sui::SUI>(arg5, arg6, v11, arg7, arg8);
        0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::flash_loan::repay_flash_loan<T0>(arg0, arg2, 0x2::coin::split<T0>(&mut v12, 0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::reserve::flash_loan_fee<T0>(&v9) + 0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::reserve::flash_loan_loan_amount<T0>(&v9), arg8), v9, arg8);
        0xfd114f95cfcf349b89a4aa5277115963093e0f7068c91cd9e16a786fb78f67b5::coin_util::destory_or_send_to_sender<T0>(v10, arg8);
        0xfd114f95cfcf349b89a4aa5277115963093e0f7068c91cd9e16a786fb78f67b5::coin_util::destory_or_send_to_sender<T0>(v12, arg8);
    }

    public fun liquidate_obligation_with_lst_as_debt_and_usdc_as_collateral<T0, T1>(arg0: &0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::version::Version, arg1: &mut 0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::obligation::Obligation, arg2: &mut 0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::market::Market, arg3: &0xca5a5a62f01c79a104bf4d31669e29daa387f325c241de4edbe30986a9bc8b0d::coin_decimals_registry::CoinDecimalsRegistry, arg4: &mut 0x1478a432123e4b3d61878b629f2c692969fdb375644f1251cd278a4b1e7d7cd6::x_oracle::XOracle, arg5: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg6: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T1, 0x2::sui::SUI>, arg7: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, 0x2::sui::SUI>, arg8: &0x2::clock::Clock, arg9: &mut 0x2::tx_context::TxContext) {
        let v0 = 0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::obligation::debt_types(arg1);
        let v1 = 0x1::type_name::get<T0>();
        let v2 = if (0x1::vector::contains<0x1::type_name::TypeName>(&v0, &v1) == false) {
            true
        } else {
            let v3 = 0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::obligation::collateral_types(arg1);
            let v4 = 0x1::type_name::get<T1>();
            0x1::vector::contains<0x1::type_name::TypeName>(&v3, &v4) == false
        };
        if (v2) {
            return
        };
        0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::accrue_interest::accrue_interest_for_market_and_obligation(arg0, arg2, arg1, arg8);
        if (!0xfd114f95cfcf349b89a4aa5277115963093e0f7068c91cd9e16a786fb78f67b5::liquidator::is_eligible_to_be_liquidated(arg1, arg2, arg3, arg4, arg8)) {
            return
        };
        let (v5, v6) = 0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::liquidation_evaluator::max_liquidation_amounts<T0, T1>(arg1, arg2, arg3, arg4, arg8);
        let v7 = 0xfd114f95cfcf349b89a4aa5277115963093e0f7068c91cd9e16a786fb78f67b5::cetus_util::calculate_swap_amount_in<T0, 0x2::sui::SUI>(arg7, false, v5);
        if (0xfd114f95cfcf349b89a4aa5277115963093e0f7068c91cd9e16a786fb78f67b5::cetus_util::calculate_swap_amount_in<T1, 0x2::sui::SUI>(arg6, true, v7) > v6) {
            return
        };
        let (v8, v9) = 0xe79c178a9d6ba44b3541402de089a36a92063ce8c5ee31aaec68577ca05e3b3a::cetus_flash_loan::borrow_b_repay_a_later<T1, 0x2::sui::SUI>(arg5, arg6, v7, arg8, arg9);
        let v10 = v9;
        let (v11, v12) = 0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::liquidate::liquidate<T0, T1>(arg0, arg1, arg2, 0xfd114f95cfcf349b89a4aa5277115963093e0f7068c91cd9e16a786fb78f67b5::cetus_util::swap_b_to_a<T0, 0x2::sui::SUI>(arg5, arg7, v8, arg8, arg9), arg3, arg4, arg8, arg9);
        let v13 = v12;
        0xe79c178a9d6ba44b3541402de089a36a92063ce8c5ee31aaec68577ca05e3b3a::cetus_flash_loan::repay_a<T1, 0x2::sui::SUI>(arg5, arg6, 0x2::coin::split<T1>(&mut v13, 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::swap_pay_amount<T1, 0x2::sui::SUI>(&v10), arg9), v10);
        0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(v13, 0x2::tx_context::sender(arg9));
        0xfd114f95cfcf349b89a4aa5277115963093e0f7068c91cd9e16a786fb78f67b5::coin_util::destory_or_send_to_sender<T0>(v11, arg9);
    }

    // decompiled from Move bytecode v6
}

