module 0x633994134f00dfc4ff9dd7bd7e5e35d168cefb4eac3dc078561cd80275db0f20::liquidator {
    public fun liquidate_obligation_with_cetus_pool<T0, T1>(arg0: &0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::version::Version, arg1: &mut 0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::obligation::Obligation, arg2: &mut 0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::market::Market, arg3: &0xca5a5a62f01c79a104bf4d31669e29daa387f325c241de4edbe30986a9bc8b0d::coin_decimals_registry::CoinDecimalsRegistry, arg4: &mut 0x1478a432123e4b3d61878b629f2c692969fdb375644f1251cd278a4b1e7d7cd6::x_oracle::XOracle, arg5: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg6: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg7: &0x2::clock::Clock, arg8: &mut 0x2::tx_context::TxContext) {
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
        0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::accrue_interest::accrue_interest_for_market_and_obligation(arg0, arg2, arg1, arg7);
        let (v5, v6) = 0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::liquidation_evaluator::max_liquidation_amounts<T0, T1>(arg1, arg2, arg3, arg4, arg7);
        if (0x633994134f00dfc4ff9dd7bd7e5e35d168cefb4eac3dc078561cd80275db0f20::cetus_util::is_liquidation_profitable<T0, T1>(arg6, false, v5, v6) == false) {
            return
        };
        let (v7, v8) = 0x8fe38370921172f5fc9b54b66e268516c402e84d11fb50ab3ba82cfcf778553c::cetus_flash_loan::borrow_a_repay_b_later<T0, T1>(arg5, arg6, v5, arg7, arg8);
        let v9 = v8;
        let (v10, v11) = 0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::liquidate::liquidate<T0, T1>(arg0, arg1, arg2, v7, arg3, arg4, arg7, arg8);
        let v12 = v11;
        0x8fe38370921172f5fc9b54b66e268516c402e84d11fb50ab3ba82cfcf778553c::cetus_flash_loan::repay_b<T0, T1>(arg5, arg6, 0x2::coin::split<T1>(&mut v12, 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::swap_pay_amount<T0, T1>(&v9), arg8), v9);
        0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(v12, 0x2::tx_context::sender(arg8));
        0x633994134f00dfc4ff9dd7bd7e5e35d168cefb4eac3dc078561cd80275db0f20::coin_util::destory_or_send_to_sender<T0>(v10, arg8);
    }

    public fun liquidate_obligation_with_cetus_pool_cross_1<T0, T1, T2>(arg0: &0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::version::Version, arg1: &mut 0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::obligation::Obligation, arg2: &mut 0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::market::Market, arg3: &0xca5a5a62f01c79a104bf4d31669e29daa387f325c241de4edbe30986a9bc8b0d::coin_decimals_registry::CoinDecimalsRegistry, arg4: &mut 0x1478a432123e4b3d61878b629f2c692969fdb375644f1251cd278a4b1e7d7cd6::x_oracle::XOracle, arg5: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg6: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T2>, arg7: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T1, T2>, arg8: &0x2::clock::Clock, arg9: &mut 0x2::tx_context::TxContext) {
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
        let (v5, v6) = 0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::liquidation_evaluator::max_liquidation_amounts<T0, T1>(arg1, arg2, arg3, arg4, arg8);
        if (0x633994134f00dfc4ff9dd7bd7e5e35d168cefb4eac3dc078561cd80275db0f20::cetus_util::calculate_swap_amount_in<T1, T2>(arg7, true, 0x633994134f00dfc4ff9dd7bd7e5e35d168cefb4eac3dc078561cd80275db0f20::cetus_util::calculate_swap_amount_in<T0, T2>(arg6, false, v5)) > v6) {
            return
        };
        let (v7, v8) = 0x8fe38370921172f5fc9b54b66e268516c402e84d11fb50ab3ba82cfcf778553c::cetus_flash_loan::borrow_a_repay_b_later<T0, T2>(arg5, arg6, v5, arg8, arg9);
        let v9 = v8;
        let (v10, v11) = 0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::liquidate::liquidate<T0, T1>(arg0, arg1, arg2, v7, arg3, arg4, arg8, arg9);
        let v12 = v11;
        let v13 = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::swap_pay_amount<T0, T2>(&v9);
        let (v14, v15) = 0x8fe38370921172f5fc9b54b66e268516c402e84d11fb50ab3ba82cfcf778553c::cetus_flash_loan::borrow_b_repay_a_later<T1, T2>(arg5, arg7, v13, arg8, arg9);
        let v16 = v15;
        let v17 = v14;
        0x8fe38370921172f5fc9b54b66e268516c402e84d11fb50ab3ba82cfcf778553c::cetus_flash_loan::repay_b<T0, T2>(arg5, arg6, 0x2::coin::split<T2>(&mut v17, v13, arg9), v9);
        0x8fe38370921172f5fc9b54b66e268516c402e84d11fb50ab3ba82cfcf778553c::cetus_flash_loan::repay_a<T1, T2>(arg5, arg7, 0x2::coin::split<T1>(&mut v12, 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::swap_pay_amount<T1, T2>(&v16), arg9), v16);
        0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(v12, 0x2::tx_context::sender(arg9));
        0x633994134f00dfc4ff9dd7bd7e5e35d168cefb4eac3dc078561cd80275db0f20::coin_util::destory_or_send_to_sender<T0>(v10, arg9);
        0x633994134f00dfc4ff9dd7bd7e5e35d168cefb4eac3dc078561cd80275db0f20::coin_util::destory_or_send_to_sender<T2>(v17, arg9);
    }

    public fun liquidate_obligation_with_cetus_pool_cross_2<T0, T1, T2>(arg0: &0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::version::Version, arg1: &mut 0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::obligation::Obligation, arg2: &mut 0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::market::Market, arg3: &0xca5a5a62f01c79a104bf4d31669e29daa387f325c241de4edbe30986a9bc8b0d::coin_decimals_registry::CoinDecimalsRegistry, arg4: &mut 0x1478a432123e4b3d61878b629f2c692969fdb375644f1251cd278a4b1e7d7cd6::x_oracle::XOracle, arg5: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg6: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T2>, arg7: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T2, T1>, arg8: &0x2::clock::Clock, arg9: &mut 0x2::tx_context::TxContext) {
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
        let (v5, v6) = 0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::liquidation_evaluator::max_liquidation_amounts<T0, T1>(arg1, arg2, arg3, arg4, arg8);
        if (0x633994134f00dfc4ff9dd7bd7e5e35d168cefb4eac3dc078561cd80275db0f20::cetus_util::calculate_swap_amount_in<T2, T1>(arg7, false, 0x633994134f00dfc4ff9dd7bd7e5e35d168cefb4eac3dc078561cd80275db0f20::cetus_util::calculate_swap_amount_in<T0, T2>(arg6, false, v5)) > v6) {
            return
        };
        let (v7, v8) = 0x8fe38370921172f5fc9b54b66e268516c402e84d11fb50ab3ba82cfcf778553c::cetus_flash_loan::borrow_a_repay_b_later<T0, T2>(arg5, arg6, v5, arg8, arg9);
        let v9 = v8;
        let (v10, v11) = 0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::liquidate::liquidate<T0, T1>(arg0, arg1, arg2, v7, arg3, arg4, arg8, arg9);
        let v12 = v11;
        let v13 = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::swap_pay_amount<T0, T2>(&v9);
        let (v14, v15) = 0x8fe38370921172f5fc9b54b66e268516c402e84d11fb50ab3ba82cfcf778553c::cetus_flash_loan::borrow_a_repay_b_later<T2, T1>(arg5, arg7, v13, arg8, arg9);
        let v16 = v15;
        let v17 = v14;
        0x8fe38370921172f5fc9b54b66e268516c402e84d11fb50ab3ba82cfcf778553c::cetus_flash_loan::repay_b<T0, T2>(arg5, arg6, 0x2::coin::split<T2>(&mut v17, v13, arg9), v9);
        0x8fe38370921172f5fc9b54b66e268516c402e84d11fb50ab3ba82cfcf778553c::cetus_flash_loan::repay_b<T2, T1>(arg5, arg7, 0x2::coin::split<T1>(&mut v12, 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::swap_pay_amount<T2, T1>(&v16), arg9), v16);
        0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(v12, 0x2::tx_context::sender(arg9));
        0x633994134f00dfc4ff9dd7bd7e5e35d168cefb4eac3dc078561cd80275db0f20::coin_util::destory_or_send_to_sender<T0>(v10, arg9);
        0x633994134f00dfc4ff9dd7bd7e5e35d168cefb4eac3dc078561cd80275db0f20::coin_util::destory_or_send_to_sender<T2>(v17, arg9);
    }

    public fun liquidate_obligation_with_cetus_pool_cross_3<T0, T1, T2>(arg0: &0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::version::Version, arg1: &mut 0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::obligation::Obligation, arg2: &mut 0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::market::Market, arg3: &0xca5a5a62f01c79a104bf4d31669e29daa387f325c241de4edbe30986a9bc8b0d::coin_decimals_registry::CoinDecimalsRegistry, arg4: &mut 0x1478a432123e4b3d61878b629f2c692969fdb375644f1251cd278a4b1e7d7cd6::x_oracle::XOracle, arg5: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg6: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T2, T0>, arg7: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T1, T2>, arg8: &0x2::clock::Clock, arg9: &mut 0x2::tx_context::TxContext) {
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
        let (v5, v6) = 0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::liquidation_evaluator::max_liquidation_amounts<T0, T1>(arg1, arg2, arg3, arg4, arg8);
        if (0x633994134f00dfc4ff9dd7bd7e5e35d168cefb4eac3dc078561cd80275db0f20::cetus_util::calculate_swap_amount_in<T1, T2>(arg7, true, 0x633994134f00dfc4ff9dd7bd7e5e35d168cefb4eac3dc078561cd80275db0f20::cetus_util::calculate_swap_amount_in<T2, T0>(arg6, true, v5)) > v6) {
            return
        };
        let (v7, v8) = 0x8fe38370921172f5fc9b54b66e268516c402e84d11fb50ab3ba82cfcf778553c::cetus_flash_loan::borrow_b_repay_a_later<T2, T0>(arg5, arg6, v5, arg8, arg9);
        let v9 = v8;
        let (v10, v11) = 0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::liquidate::liquidate<T0, T1>(arg0, arg1, arg2, v7, arg3, arg4, arg8, arg9);
        let v12 = v11;
        let v13 = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::swap_pay_amount<T2, T0>(&v9);
        let (v14, v15) = 0x8fe38370921172f5fc9b54b66e268516c402e84d11fb50ab3ba82cfcf778553c::cetus_flash_loan::borrow_b_repay_a_later<T1, T2>(arg5, arg7, v13, arg8, arg9);
        let v16 = v15;
        let v17 = v14;
        0x8fe38370921172f5fc9b54b66e268516c402e84d11fb50ab3ba82cfcf778553c::cetus_flash_loan::repay_a<T2, T0>(arg5, arg6, 0x2::coin::split<T2>(&mut v17, v13, arg9), v9);
        0x8fe38370921172f5fc9b54b66e268516c402e84d11fb50ab3ba82cfcf778553c::cetus_flash_loan::repay_a<T1, T2>(arg5, arg7, 0x2::coin::split<T1>(&mut v12, 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::swap_pay_amount<T1, T2>(&v16), arg9), v16);
        0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(v12, 0x2::tx_context::sender(arg9));
        0x633994134f00dfc4ff9dd7bd7e5e35d168cefb4eac3dc078561cd80275db0f20::coin_util::destory_or_send_to_sender<T0>(v10, arg9);
        0x633994134f00dfc4ff9dd7bd7e5e35d168cefb4eac3dc078561cd80275db0f20::coin_util::destory_or_send_to_sender<T2>(v17, arg9);
    }

    public fun liquidate_obligation_with_cetus_pool_cross_4<T0, T1, T2>(arg0: &0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::version::Version, arg1: &mut 0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::obligation::Obligation, arg2: &mut 0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::market::Market, arg3: &0xca5a5a62f01c79a104bf4d31669e29daa387f325c241de4edbe30986a9bc8b0d::coin_decimals_registry::CoinDecimalsRegistry, arg4: &mut 0x1478a432123e4b3d61878b629f2c692969fdb375644f1251cd278a4b1e7d7cd6::x_oracle::XOracle, arg5: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg6: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T2, T0>, arg7: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T2, T1>, arg8: &0x2::clock::Clock, arg9: &mut 0x2::tx_context::TxContext) {
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
        let (v5, v6) = 0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::liquidation_evaluator::max_liquidation_amounts<T0, T1>(arg1, arg2, arg3, arg4, arg8);
        if (0x633994134f00dfc4ff9dd7bd7e5e35d168cefb4eac3dc078561cd80275db0f20::cetus_util::calculate_swap_amount_in<T2, T1>(arg7, false, 0x633994134f00dfc4ff9dd7bd7e5e35d168cefb4eac3dc078561cd80275db0f20::cetus_util::calculate_swap_amount_in<T2, T0>(arg6, true, v5)) > v6) {
            return
        };
        let (v7, v8) = 0x8fe38370921172f5fc9b54b66e268516c402e84d11fb50ab3ba82cfcf778553c::cetus_flash_loan::borrow_b_repay_a_later<T2, T0>(arg5, arg6, v5, arg8, arg9);
        let v9 = v8;
        let (v10, v11) = 0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::liquidate::liquidate<T0, T1>(arg0, arg1, arg2, v7, arg3, arg4, arg8, arg9);
        let v12 = v11;
        let v13 = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::swap_pay_amount<T2, T0>(&v9);
        let (v14, v15) = 0x8fe38370921172f5fc9b54b66e268516c402e84d11fb50ab3ba82cfcf778553c::cetus_flash_loan::borrow_a_repay_b_later<T2, T1>(arg5, arg7, v13, arg8, arg9);
        let v16 = v15;
        let v17 = v14;
        0x8fe38370921172f5fc9b54b66e268516c402e84d11fb50ab3ba82cfcf778553c::cetus_flash_loan::repay_a<T2, T0>(arg5, arg6, 0x2::coin::split<T2>(&mut v17, v13, arg9), v9);
        0x8fe38370921172f5fc9b54b66e268516c402e84d11fb50ab3ba82cfcf778553c::cetus_flash_loan::repay_b<T2, T1>(arg5, arg7, 0x2::coin::split<T1>(&mut v12, 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::swap_pay_amount<T2, T1>(&v16), arg9), v16);
        0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(v12, 0x2::tx_context::sender(arg9));
        0x633994134f00dfc4ff9dd7bd7e5e35d168cefb4eac3dc078561cd80275db0f20::coin_util::destory_or_send_to_sender<T0>(v10, arg9);
        0x633994134f00dfc4ff9dd7bd7e5e35d168cefb4eac3dc078561cd80275db0f20::coin_util::destory_or_send_to_sender<T2>(v17, arg9);
    }

    public fun liquidate_obligation_with_cetus_pool_only_a<T0, T1>(arg0: &0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::version::Version, arg1: &mut 0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::obligation::Obligation, arg2: &mut 0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::market::Market, arg3: &0xca5a5a62f01c79a104bf4d31669e29daa387f325c241de4edbe30986a9bc8b0d::coin_decimals_registry::CoinDecimalsRegistry, arg4: &mut 0x1478a432123e4b3d61878b629f2c692969fdb375644f1251cd278a4b1e7d7cd6::x_oracle::XOracle, arg5: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg6: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg7: &0x2::clock::Clock, arg8: &mut 0x2::tx_context::TxContext) {
        let v0 = 0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::obligation::debt_types(arg1);
        let v1 = 0x1::type_name::get<T0>();
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
        let (v5, v6) = 0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::liquidation_evaluator::max_liquidation_amounts<T0, T0>(arg1, arg2, arg3, arg4, arg7);
        if (0x633994134f00dfc4ff9dd7bd7e5e35d168cefb4eac3dc078561cd80275db0f20::cetus_util::is_liquidation_profitable_with_double_swap<T0, T1>(arg6, v5, v6) == false) {
            return
        };
        let (v7, v8) = 0x8fe38370921172f5fc9b54b66e268516c402e84d11fb50ab3ba82cfcf778553c::cetus_flash_loan::borrow_a_repay_a_later<T0, T1>(arg5, arg6, v5, arg7, arg8);
        let v9 = v8;
        let (v10, v11) = 0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::liquidate::liquidate<T0, T0>(arg0, arg1, arg2, v7, arg3, arg4, arg7, arg8);
        let v12 = v11;
        0x8fe38370921172f5fc9b54b66e268516c402e84d11fb50ab3ba82cfcf778553c::cetus_flash_loan::repay_a<T0, T1>(arg5, arg6, 0x2::coin::split<T0>(&mut v12, 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::swap_pay_amount<T0, T1>(&v9), arg8), v9);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(v12, 0x2::tx_context::sender(arg8));
        0x633994134f00dfc4ff9dd7bd7e5e35d168cefb4eac3dc078561cd80275db0f20::coin_util::destory_or_send_to_sender<T0>(v10, arg8);
    }

    public fun liquidate_obligation_with_cetus_pool_only_b<T0, T1>(arg0: &0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::version::Version, arg1: &mut 0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::obligation::Obligation, arg2: &mut 0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::market::Market, arg3: &0xca5a5a62f01c79a104bf4d31669e29daa387f325c241de4edbe30986a9bc8b0d::coin_decimals_registry::CoinDecimalsRegistry, arg4: &mut 0x1478a432123e4b3d61878b629f2c692969fdb375644f1251cd278a4b1e7d7cd6::x_oracle::XOracle, arg5: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg6: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg7: &0x2::clock::Clock, arg8: &mut 0x2::tx_context::TxContext) {
        let v0 = 0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::obligation::debt_types(arg1);
        let v1 = 0x1::type_name::get<T1>();
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
        0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::accrue_interest::accrue_interest_for_market_and_obligation(arg0, arg2, arg1, arg7);
        let (v5, v6) = 0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::liquidation_evaluator::max_liquidation_amounts<T1, T1>(arg1, arg2, arg3, arg4, arg7);
        if (0x633994134f00dfc4ff9dd7bd7e5e35d168cefb4eac3dc078561cd80275db0f20::cetus_util::is_liquidation_profitable_with_double_swap<T0, T1>(arg6, v5, v6) == false) {
            return
        };
        let (v7, v8) = 0x8fe38370921172f5fc9b54b66e268516c402e84d11fb50ab3ba82cfcf778553c::cetus_flash_loan::borrow_b_repay_b_later<T0, T1>(arg5, arg6, v5, arg7, arg8);
        let v9 = v8;
        let (v10, v11) = 0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::liquidate::liquidate<T1, T1>(arg0, arg1, arg2, v7, arg3, arg4, arg7, arg8);
        let v12 = v11;
        0x8fe38370921172f5fc9b54b66e268516c402e84d11fb50ab3ba82cfcf778553c::cetus_flash_loan::repay_b<T0, T1>(arg5, arg6, 0x2::coin::split<T1>(&mut v12, 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::swap_pay_amount<T0, T1>(&v9), arg8), v9);
        0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(v12, 0x2::tx_context::sender(arg8));
        0x633994134f00dfc4ff9dd7bd7e5e35d168cefb4eac3dc078561cd80275db0f20::coin_util::destory_or_send_to_sender<T1>(v10, arg8);
    }

    public fun liquidate_obligation_with_reverse_cetus_pool<T0, T1>(arg0: &0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::version::Version, arg1: &mut 0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::obligation::Obligation, arg2: &mut 0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::market::Market, arg3: &0xca5a5a62f01c79a104bf4d31669e29daa387f325c241de4edbe30986a9bc8b0d::coin_decimals_registry::CoinDecimalsRegistry, arg4: &mut 0x1478a432123e4b3d61878b629f2c692969fdb375644f1251cd278a4b1e7d7cd6::x_oracle::XOracle, arg5: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg6: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T1, T0>, arg7: &0x2::clock::Clock, arg8: &mut 0x2::tx_context::TxContext) {
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
        0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::accrue_interest::accrue_interest_for_market_and_obligation(arg0, arg2, arg1, arg7);
        let (v5, v6) = 0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::liquidation_evaluator::max_liquidation_amounts<T0, T1>(arg1, arg2, arg3, arg4, arg7);
        if (0x633994134f00dfc4ff9dd7bd7e5e35d168cefb4eac3dc078561cd80275db0f20::cetus_util::is_liquidation_profitable<T1, T0>(arg6, true, v5, v6) == false) {
            return
        };
        let (v7, v8) = 0x8fe38370921172f5fc9b54b66e268516c402e84d11fb50ab3ba82cfcf778553c::cetus_flash_loan::borrow_b_repay_a_later<T1, T0>(arg5, arg6, v5, arg7, arg8);
        let v9 = v8;
        let (v10, v11) = 0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::liquidate::liquidate<T0, T1>(arg0, arg1, arg2, v7, arg3, arg4, arg7, arg8);
        let v12 = v11;
        0x8fe38370921172f5fc9b54b66e268516c402e84d11fb50ab3ba82cfcf778553c::cetus_flash_loan::repay_a<T1, T0>(arg5, arg6, 0x2::coin::split<T1>(&mut v12, 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::swap_pay_amount<T1, T0>(&v9), arg8), v9);
        0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(v12, 0x2::tx_context::sender(arg8));
        0x633994134f00dfc4ff9dd7bd7e5e35d168cefb4eac3dc078561cd80275db0f20::coin_util::destory_or_send_to_sender<T0>(v10, arg8);
    }

    // decompiled from Move bytecode v6
}

