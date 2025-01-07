module 0x44ff6d248fe619bab9a36e15487a706da196d1311848b0b9e2f1fcfa044230e0::liquidator {
    public fun force_unstake_if_unhealthy<T0>(arg0: &mut 0x41c0788f4ab64cf36dc882174f467634c033bf68c3c1b5ef9819507825eb510b::incentive_pool::IncentivePools<T0>, arg1: &mut 0x41c0788f4ab64cf36dc882174f467634c033bf68c3c1b5ef9819507825eb510b::incentive_account::IncentiveAccounts, arg2: &mut 0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::obligation::Obligation, arg3: &mut 0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::market::Market, arg4: &0xca5a5a62f01c79a104bf4d31669e29daa387f325c241de4edbe30986a9bc8b0d::coin_decimals_registry::CoinDecimalsRegistry, arg5: &mut 0x1478a432123e4b3d61878b629f2c692969fdb375644f1251cd278a4b1e7d7cd6::x_oracle::XOracle, arg6: &0x2::clock::Clock, arg7: &mut 0x2::tx_context::TxContext) {
        if (!is_eligible_to_be_liquidated(arg2, arg3, arg4, arg5, arg6)) {
            return
        };
        let v0 = 0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::obligation::lock_key(arg2);
        if (0x1::option::is_none<0x1::type_name::TypeName>(&v0)) {
            return
        };
        0x41c0788f4ab64cf36dc882174f467634c033bf68c3c1b5ef9819507825eb510b::user::force_unstake_unhealthy<T0>(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7);
    }

    public fun is_eligible_to_be_liquidated(arg0: &0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::obligation::Obligation, arg1: &0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::market::Market, arg2: &0xca5a5a62f01c79a104bf4d31669e29daa387f325c241de4edbe30986a9bc8b0d::coin_decimals_registry::CoinDecimalsRegistry, arg3: &0x1478a432123e4b3d61878b629f2c692969fdb375644f1251cd278a4b1e7d7cd6::x_oracle::XOracle, arg4: &0x2::clock::Clock) : bool {
        0xad013d5fde39e15eabda32b3dbdafd67dac32b798ce63237c27a8f73339b9b6f::fixed_point32_empower::gt(0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::debt_value::debts_value_usd_with_weight(arg0, arg2, arg1, arg3, arg4), 0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::collateral_value::collaterals_value_usd_for_liquidation(arg0, arg1, arg2, arg3, arg4))
    }

    public fun liquidate_obligation_same_assets<T0>(arg0: &0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::version::Version, arg1: &mut 0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::obligation::Obligation, arg2: &mut 0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::market::Market, arg3: &0xca5a5a62f01c79a104bf4d31669e29daa387f325c241de4edbe30986a9bc8b0d::coin_decimals_registry::CoinDecimalsRegistry, arg4: &mut 0x1478a432123e4b3d61878b629f2c692969fdb375644f1251cd278a4b1e7d7cd6::x_oracle::XOracle, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) {
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
        0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::accrue_interest::accrue_interest_for_market_and_obligation(arg0, arg2, arg1, arg5);
        if (!is_eligible_to_be_liquidated(arg1, arg2, arg3, arg4, arg5)) {
            return
        };
        let (v5, _) = 0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::liquidation_evaluator::max_liquidation_amounts<T0, T0>(arg1, arg2, arg3, arg4, arg5);
        let (v7, v8) = 0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::flash_loan::borrow_flash_loan<T0>(arg0, arg2, v5, arg6);
        let (v9, v10) = 0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::liquidate::liquidate<T0, T0>(arg0, arg1, arg2, v7, arg3, arg4, arg5, arg6);
        let v11 = v10;
        0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::flash_loan::repay_flash_loan<T0>(arg0, arg2, 0x2::coin::split<T0>(&mut v11, v5, arg6), v8, arg6);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(v11, 0x2::tx_context::sender(arg6));
        0x44ff6d248fe619bab9a36e15487a706da196d1311848b0b9e2f1fcfa044230e0::coin_util::destory_or_send_to_sender<T0>(v9, arg6);
    }

    public fun liquidate_obligation_with_af_sui_as_collateral_1<T0, T1, T2>(arg0: &0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::version::Version, arg1: &mut 0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::obligation::Obligation, arg2: &mut 0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::market::Market, arg3: &0xca5a5a62f01c79a104bf4d31669e29daa387f325c241de4edbe30986a9bc8b0d::coin_decimals_registry::CoinDecimalsRegistry, arg4: &mut 0x1478a432123e4b3d61878b629f2c692969fdb375644f1251cd278a4b1e7d7cd6::x_oracle::XOracle, arg5: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg6: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T2, T1>, arg7: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T2, 0x2::sui::SUI>, arg8: &mut 0xefe170ec0be4d762196bedecd7a065816576198a6527c99282a2551aaa7da38c::pool::Pool<T0>, arg9: &0xefe170ec0be4d762196bedecd7a065816576198a6527c99282a2551aaa7da38c::pool_registry::PoolRegistry, arg10: &0x2d9316f1f1a95f6d7c85a4e690ef7c359e6649773ef2c37ad7d9857adb6bef06::vault::ProtocolFeeVault, arg11: &mut 0x64213b0e4a52bac468d4ac3f140242f70714381653a1919a6d57cd49c628207a::treasury::Treasury, arg12: &mut 0xa6baab1e668c7868991c1c3c11e144100f5734c407d020f72a01b9d1a8bcb97f::insurance_fund::InsuranceFund, arg13: &0xc66fabf1a9253e43c70f1cc02d40a1d18db183140ecaae2a3f58fa6b66c55acf::referral_vault::ReferralVault, arg14: &0x2::clock::Clock, arg15: &mut 0x2::tx_context::TxContext) {
        let v0 = 0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::obligation::debt_types(arg1);
        let v1 = 0x1::type_name::get<T1>();
        let v2 = if (0x1::vector::contains<0x1::type_name::TypeName>(&v0, &v1) == false) {
            true
        } else {
            let v3 = 0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::obligation::collateral_types(arg1);
            let v4 = 0x1::type_name::get<0xf325ce1300e8dac124071d3152c5c5ee6174914f8bc2161e88329cf579246efc::afsui::AFSUI>();
            0x1::vector::contains<0x1::type_name::TypeName>(&v3, &v4) == false
        };
        if (v2) {
            return
        };
        0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::accrue_interest::accrue_interest_for_market_and_obligation(arg0, arg2, arg1, arg14);
        if (!is_eligible_to_be_liquidated(arg1, arg2, arg3, arg4, arg14)) {
            return
        };
        let (v5, v6) = 0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::liquidation_evaluator::max_liquidation_amounts<T1, 0xf325ce1300e8dac124071d3152c5c5ee6174914f8bc2161e88329cf579246efc::afsui::AFSUI>(arg1, arg2, arg3, arg4, arg14);
        if (0x44ff6d248fe619bab9a36e15487a706da196d1311848b0b9e2f1fcfa044230e0::cetus_util::calculate_swap_amount_in<T2, 0x2::sui::SUI>(arg7, false, 0x44ff6d248fe619bab9a36e15487a706da196d1311848b0b9e2f1fcfa044230e0::cetus_util::calculate_swap_amount_in<T2, T1>(arg6, true, v5)) > v6) {
            return
        };
        let (v7, v8) = 0x2e8f9df2200c24bbee4a58fc8872034dbb5e3b4ae939b23b77509a86a593c35c::cetus_flash_loan::borrow_b_repay_a_later<T2, T1>(arg5, arg6, v5, arg14, arg15);
        let v9 = v8;
        let (v10, v11) = 0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::liquidate::liquidate<T1, 0xf325ce1300e8dac124071d3152c5c5ee6174914f8bc2161e88329cf579246efc::afsui::AFSUI>(arg0, arg1, arg2, v7, arg3, arg4, arg14, arg15);
        let v12 = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::swap_pay_amount<T2, T1>(&v9);
        let (v13, v14) = 0x2e8f9df2200c24bbee4a58fc8872034dbb5e3b4ae939b23b77509a86a593c35c::cetus_flash_loan::borrow_a_repay_b_later<T2, 0x2::sui::SUI>(arg5, arg7, v12, arg14, arg15);
        let v15 = v14;
        let v16 = v13;
        0x2e8f9df2200c24bbee4a58fc8872034dbb5e3b4ae939b23b77509a86a593c35c::cetus_flash_loan::repay_a<T2, T1>(arg5, arg6, 0x2::coin::split<T2>(&mut v16, v12, arg15), v9);
        let v17 = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::swap_pay_amount<T2, 0x2::sui::SUI>(&v15);
        let v18 = 0xefe170ec0be4d762196bedecd7a065816576198a6527c99282a2551aaa7da38c::swap::swap_exact_in<T0, 0xf325ce1300e8dac124071d3152c5c5ee6174914f8bc2161e88329cf579246efc::afsui::AFSUI, 0x2::sui::SUI>(arg8, arg9, arg10, arg11, arg12, arg13, v11, v17, 100000000000000000, arg15);
        0x2e8f9df2200c24bbee4a58fc8872034dbb5e3b4ae939b23b77509a86a593c35c::cetus_flash_loan::repay_b<T2, 0x2::sui::SUI>(arg5, arg7, 0x2::coin::split<0x2::sui::SUI>(&mut v18, v17, arg15), v15);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(v18, 0x2::tx_context::sender(arg15));
        0x44ff6d248fe619bab9a36e15487a706da196d1311848b0b9e2f1fcfa044230e0::coin_util::destory_or_send_to_sender<T1>(v10, arg15);
        0x44ff6d248fe619bab9a36e15487a706da196d1311848b0b9e2f1fcfa044230e0::coin_util::destory_or_send_to_sender<T2>(v16, arg15);
    }

    public fun liquidate_obligation_with_af_sui_as_collateral_2<T0, T1, T2>(arg0: &0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::version::Version, arg1: &mut 0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::obligation::Obligation, arg2: &mut 0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::market::Market, arg3: &0xca5a5a62f01c79a104bf4d31669e29daa387f325c241de4edbe30986a9bc8b0d::coin_decimals_registry::CoinDecimalsRegistry, arg4: &mut 0x1478a432123e4b3d61878b629f2c692969fdb375644f1251cd278a4b1e7d7cd6::x_oracle::XOracle, arg5: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg6: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T1, T2>, arg7: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T2, 0x2::sui::SUI>, arg8: &mut 0xefe170ec0be4d762196bedecd7a065816576198a6527c99282a2551aaa7da38c::pool::Pool<T0>, arg9: &0xefe170ec0be4d762196bedecd7a065816576198a6527c99282a2551aaa7da38c::pool_registry::PoolRegistry, arg10: &0x2d9316f1f1a95f6d7c85a4e690ef7c359e6649773ef2c37ad7d9857adb6bef06::vault::ProtocolFeeVault, arg11: &mut 0x64213b0e4a52bac468d4ac3f140242f70714381653a1919a6d57cd49c628207a::treasury::Treasury, arg12: &mut 0xa6baab1e668c7868991c1c3c11e144100f5734c407d020f72a01b9d1a8bcb97f::insurance_fund::InsuranceFund, arg13: &0xc66fabf1a9253e43c70f1cc02d40a1d18db183140ecaae2a3f58fa6b66c55acf::referral_vault::ReferralVault, arg14: &0x2::clock::Clock, arg15: &mut 0x2::tx_context::TxContext) {
        let v0 = 0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::obligation::debt_types(arg1);
        let v1 = 0x1::type_name::get<T1>();
        let v2 = if (0x1::vector::contains<0x1::type_name::TypeName>(&v0, &v1) == false) {
            true
        } else {
            let v3 = 0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::obligation::collateral_types(arg1);
            let v4 = 0x1::type_name::get<0xf325ce1300e8dac124071d3152c5c5ee6174914f8bc2161e88329cf579246efc::afsui::AFSUI>();
            0x1::vector::contains<0x1::type_name::TypeName>(&v3, &v4) == false
        };
        if (v2) {
            return
        };
        0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::accrue_interest::accrue_interest_for_market_and_obligation(arg0, arg2, arg1, arg14);
        if (!is_eligible_to_be_liquidated(arg1, arg2, arg3, arg4, arg14)) {
            return
        };
        let (v5, v6) = 0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::liquidation_evaluator::max_liquidation_amounts<T1, 0xf325ce1300e8dac124071d3152c5c5ee6174914f8bc2161e88329cf579246efc::afsui::AFSUI>(arg1, arg2, arg3, arg4, arg14);
        if (0x44ff6d248fe619bab9a36e15487a706da196d1311848b0b9e2f1fcfa044230e0::cetus_util::calculate_swap_amount_in<T2, 0x2::sui::SUI>(arg7, false, 0x44ff6d248fe619bab9a36e15487a706da196d1311848b0b9e2f1fcfa044230e0::cetus_util::calculate_swap_amount_in<T1, T2>(arg6, false, v5)) > v6) {
            return
        };
        let (v7, v8) = 0x2e8f9df2200c24bbee4a58fc8872034dbb5e3b4ae939b23b77509a86a593c35c::cetus_flash_loan::borrow_a_repay_b_later<T1, T2>(arg5, arg6, v5, arg14, arg15);
        let v9 = v8;
        let (v10, v11) = 0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::liquidate::liquidate<T1, 0xf325ce1300e8dac124071d3152c5c5ee6174914f8bc2161e88329cf579246efc::afsui::AFSUI>(arg0, arg1, arg2, v7, arg3, arg4, arg14, arg15);
        let v12 = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::swap_pay_amount<T1, T2>(&v9);
        let (v13, v14) = 0x2e8f9df2200c24bbee4a58fc8872034dbb5e3b4ae939b23b77509a86a593c35c::cetus_flash_loan::borrow_a_repay_b_later<T2, 0x2::sui::SUI>(arg5, arg7, v12, arg14, arg15);
        let v15 = v14;
        let v16 = v13;
        0x2e8f9df2200c24bbee4a58fc8872034dbb5e3b4ae939b23b77509a86a593c35c::cetus_flash_loan::repay_b<T1, T2>(arg5, arg6, 0x2::coin::split<T2>(&mut v16, v12, arg15), v9);
        let v17 = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::swap_pay_amount<T2, 0x2::sui::SUI>(&v15);
        let v18 = 0xefe170ec0be4d762196bedecd7a065816576198a6527c99282a2551aaa7da38c::swap::swap_exact_in<T0, 0xf325ce1300e8dac124071d3152c5c5ee6174914f8bc2161e88329cf579246efc::afsui::AFSUI, 0x2::sui::SUI>(arg8, arg9, arg10, arg11, arg12, arg13, v11, v17, 100000000000000000, arg15);
        0x2e8f9df2200c24bbee4a58fc8872034dbb5e3b4ae939b23b77509a86a593c35c::cetus_flash_loan::repay_b<T2, 0x2::sui::SUI>(arg5, arg7, 0x2::coin::split<0x2::sui::SUI>(&mut v18, v17, arg15), v15);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(v18, 0x2::tx_context::sender(arg15));
        0x44ff6d248fe619bab9a36e15487a706da196d1311848b0b9e2f1fcfa044230e0::coin_util::destory_or_send_to_sender<T1>(v10, arg15);
        0x44ff6d248fe619bab9a36e15487a706da196d1311848b0b9e2f1fcfa044230e0::coin_util::destory_or_send_to_sender<T2>(v16, arg15);
    }

    public fun liquidate_obligation_with_af_sui_as_collateral_and_usdc_as_debt<T0, T1>(arg0: &0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::version::Version, arg1: &mut 0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::obligation::Obligation, arg2: &mut 0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::market::Market, arg3: &0xca5a5a62f01c79a104bf4d31669e29daa387f325c241de4edbe30986a9bc8b0d::coin_decimals_registry::CoinDecimalsRegistry, arg4: &mut 0x1478a432123e4b3d61878b629f2c692969fdb375644f1251cd278a4b1e7d7cd6::x_oracle::XOracle, arg5: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg6: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T1, 0x2::sui::SUI>, arg7: &mut 0xefe170ec0be4d762196bedecd7a065816576198a6527c99282a2551aaa7da38c::pool::Pool<T0>, arg8: &0xefe170ec0be4d762196bedecd7a065816576198a6527c99282a2551aaa7da38c::pool_registry::PoolRegistry, arg9: &0x2d9316f1f1a95f6d7c85a4e690ef7c359e6649773ef2c37ad7d9857adb6bef06::vault::ProtocolFeeVault, arg10: &mut 0x64213b0e4a52bac468d4ac3f140242f70714381653a1919a6d57cd49c628207a::treasury::Treasury, arg11: &mut 0xa6baab1e668c7868991c1c3c11e144100f5734c407d020f72a01b9d1a8bcb97f::insurance_fund::InsuranceFund, arg12: &0xc66fabf1a9253e43c70f1cc02d40a1d18db183140ecaae2a3f58fa6b66c55acf::referral_vault::ReferralVault, arg13: &0x2::clock::Clock, arg14: &mut 0x2::tx_context::TxContext) {
        let v0 = 0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::obligation::debt_types(arg1);
        let v1 = 0x1::type_name::get<T1>();
        let v2 = if (0x1::vector::contains<0x1::type_name::TypeName>(&v0, &v1) == false) {
            true
        } else {
            let v3 = 0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::obligation::collateral_types(arg1);
            let v4 = 0x1::type_name::get<0xf325ce1300e8dac124071d3152c5c5ee6174914f8bc2161e88329cf579246efc::afsui::AFSUI>();
            0x1::vector::contains<0x1::type_name::TypeName>(&v3, &v4) == false
        };
        if (v2) {
            return
        };
        0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::accrue_interest::accrue_interest_for_market_and_obligation(arg0, arg2, arg1, arg13);
        if (!is_eligible_to_be_liquidated(arg1, arg2, arg3, arg4, arg13)) {
            return
        };
        let (v5, _) = 0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::liquidation_evaluator::max_liquidation_amounts<T1, 0xf325ce1300e8dac124071d3152c5c5ee6174914f8bc2161e88329cf579246efc::afsui::AFSUI>(arg1, arg2, arg3, arg4, arg13);
        let (v7, v8) = 0x2e8f9df2200c24bbee4a58fc8872034dbb5e3b4ae939b23b77509a86a593c35c::cetus_flash_loan::borrow_a_repay_b_later<T1, 0x2::sui::SUI>(arg5, arg6, v5, arg13, arg14);
        let v9 = v8;
        let (v10, v11) = 0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::liquidate::liquidate<T1, 0xf325ce1300e8dac124071d3152c5c5ee6174914f8bc2161e88329cf579246efc::afsui::AFSUI>(arg0, arg1, arg2, v7, arg3, arg4, arg13, arg14);
        let v12 = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::swap_pay_amount<T1, 0x2::sui::SUI>(&v9);
        let v13 = 0xefe170ec0be4d762196bedecd7a065816576198a6527c99282a2551aaa7da38c::swap::swap_exact_in<T0, 0xf325ce1300e8dac124071d3152c5c5ee6174914f8bc2161e88329cf579246efc::afsui::AFSUI, 0x2::sui::SUI>(arg7, arg8, arg9, arg10, arg11, arg12, v11, v12, 500000000000000000, arg14);
        0x2e8f9df2200c24bbee4a58fc8872034dbb5e3b4ae939b23b77509a86a593c35c::cetus_flash_loan::repay_b<T1, 0x2::sui::SUI>(arg5, arg6, 0x2::coin::split<0x2::sui::SUI>(&mut v13, v12, arg14), v9);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(v13, 0x2::tx_context::sender(arg14));
        0x44ff6d248fe619bab9a36e15487a706da196d1311848b0b9e2f1fcfa044230e0::coin_util::destory_or_send_to_sender<T1>(v10, arg14);
    }

    public fun liquidate_obligation_with_af_sui_as_debt_1<T0, T1>(arg0: &0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::version::Version, arg1: &mut 0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::obligation::Obligation, arg2: &mut 0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::market::Market, arg3: &0xca5a5a62f01c79a104bf4d31669e29daa387f325c241de4edbe30986a9bc8b0d::coin_decimals_registry::CoinDecimalsRegistry, arg4: &mut 0x1478a432123e4b3d61878b629f2c692969fdb375644f1251cd278a4b1e7d7cd6::x_oracle::XOracle, arg5: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg6: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T1, 0x2::sui::SUI>, arg7: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg8: &mut 0x7f6ce7ade63857c4fd16ef7783fed2dfc4d7fb7e40615abdb653030b76aef0c6::staked_sui_vault::StakedSuiVault, arg9: &mut 0xb572349baf4526c92c4e5242306e07a1658fa329ae93d1b9db0fc38b8a592bb::safe::Safe<0x2::coin::TreasuryCap<0xf325ce1300e8dac124071d3152c5c5ee6174914f8bc2161e88329cf579246efc::afsui::AFSUI>>, arg10: &0xb196672db3293fdebdbd4cbea950823ff84805547c7345710a1cf9d0db52938f::referral_vault::ReferralVault, arg11: address, arg12: &mut 0x3::sui_system::SuiSystemState, arg13: &0x2::clock::Clock, arg14: &mut 0x2::tx_context::TxContext) {
        let v0 = 0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::obligation::debt_types(arg1);
        let v1 = 0x1::type_name::get<0xf325ce1300e8dac124071d3152c5c5ee6174914f8bc2161e88329cf579246efc::afsui::AFSUI>();
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
        0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::accrue_interest::accrue_interest_for_market_and_obligation(arg0, arg2, arg1, arg13);
        if (!is_eligible_to_be_liquidated(arg1, arg2, arg3, arg4, arg13)) {
            return
        };
        let (v5, v6) = 0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::liquidation_evaluator::max_liquidation_amounts<0xf325ce1300e8dac124071d3152c5c5ee6174914f8bc2161e88329cf579246efc::afsui::AFSUI, T0>(arg1, arg2, arg3, arg4, arg13);
        let v7 = 0x7f6ce7ade63857c4fd16ef7783fed2dfc4d7fb7e40615abdb653030b76aef0c6::staked_sui_vault::afsui_to_sui(arg8, arg9, v5);
        if (0x44ff6d248fe619bab9a36e15487a706da196d1311848b0b9e2f1fcfa044230e0::cetus_util::calculate_swap_amount_in<T0, T1>(arg7, true, 0x44ff6d248fe619bab9a36e15487a706da196d1311848b0b9e2f1fcfa044230e0::cetus_util::calculate_swap_amount_in<T1, 0x2::sui::SUI>(arg6, true, v7)) > v6) {
            return
        };
        let (v8, v9) = 0x2e8f9df2200c24bbee4a58fc8872034dbb5e3b4ae939b23b77509a86a593c35c::cetus_flash_loan::borrow_b_repay_a_later<T1, 0x2::sui::SUI>(arg5, arg6, v7, arg13, arg14);
        let v10 = v9;
        let (v11, v12) = 0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::liquidate::liquidate<0xf325ce1300e8dac124071d3152c5c5ee6174914f8bc2161e88329cf579246efc::afsui::AFSUI, T0>(arg0, arg1, arg2, 0x7f6ce7ade63857c4fd16ef7783fed2dfc4d7fb7e40615abdb653030b76aef0c6::staked_sui_vault::request_stake(arg8, arg9, arg12, arg10, v8, arg11, arg14), arg3, arg4, arg13, arg14);
        let v13 = v12;
        let v14 = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::swap_pay_amount<T1, 0x2::sui::SUI>(&v10);
        let (v15, v16) = 0x2e8f9df2200c24bbee4a58fc8872034dbb5e3b4ae939b23b77509a86a593c35c::cetus_flash_loan::borrow_b_repay_a_later<T0, T1>(arg5, arg7, v14, arg13, arg14);
        let v17 = v16;
        let v18 = v15;
        0x2e8f9df2200c24bbee4a58fc8872034dbb5e3b4ae939b23b77509a86a593c35c::cetus_flash_loan::repay_a<T1, 0x2::sui::SUI>(arg5, arg6, 0x2::coin::split<T1>(&mut v18, v14, arg14), v10);
        0x2e8f9df2200c24bbee4a58fc8872034dbb5e3b4ae939b23b77509a86a593c35c::cetus_flash_loan::repay_a<T0, T1>(arg5, arg7, 0x2::coin::split<T0>(&mut v13, 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::swap_pay_amount<T0, T1>(&v17), arg14), v17);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(v13, 0x2::tx_context::sender(arg14));
        0x44ff6d248fe619bab9a36e15487a706da196d1311848b0b9e2f1fcfa044230e0::coin_util::destory_or_send_to_sender<0xf325ce1300e8dac124071d3152c5c5ee6174914f8bc2161e88329cf579246efc::afsui::AFSUI>(v11, arg14);
        0x44ff6d248fe619bab9a36e15487a706da196d1311848b0b9e2f1fcfa044230e0::coin_util::destory_or_send_to_sender<T1>(v18, arg14);
    }

    public fun liquidate_obligation_with_af_sui_as_debt_2<T0, T1>(arg0: &0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::version::Version, arg1: &mut 0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::obligation::Obligation, arg2: &mut 0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::market::Market, arg3: &0xca5a5a62f01c79a104bf4d31669e29daa387f325c241de4edbe30986a9bc8b0d::coin_decimals_registry::CoinDecimalsRegistry, arg4: &mut 0x1478a432123e4b3d61878b629f2c692969fdb375644f1251cd278a4b1e7d7cd6::x_oracle::XOracle, arg5: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg6: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T1, 0x2::sui::SUI>, arg7: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T1, T0>, arg8: &mut 0x7f6ce7ade63857c4fd16ef7783fed2dfc4d7fb7e40615abdb653030b76aef0c6::staked_sui_vault::StakedSuiVault, arg9: &mut 0xb572349baf4526c92c4e5242306e07a1658fa329ae93d1b9db0fc38b8a592bb::safe::Safe<0x2::coin::TreasuryCap<0xf325ce1300e8dac124071d3152c5c5ee6174914f8bc2161e88329cf579246efc::afsui::AFSUI>>, arg10: &0xb196672db3293fdebdbd4cbea950823ff84805547c7345710a1cf9d0db52938f::referral_vault::ReferralVault, arg11: address, arg12: &mut 0x3::sui_system::SuiSystemState, arg13: &0x2::clock::Clock, arg14: &mut 0x2::tx_context::TxContext) {
        let v0 = 0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::obligation::debt_types(arg1);
        let v1 = 0x1::type_name::get<0xf325ce1300e8dac124071d3152c5c5ee6174914f8bc2161e88329cf579246efc::afsui::AFSUI>();
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
        0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::accrue_interest::accrue_interest_for_market_and_obligation(arg0, arg2, arg1, arg13);
        if (!is_eligible_to_be_liquidated(arg1, arg2, arg3, arg4, arg13)) {
            return
        };
        let (v5, v6) = 0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::liquidation_evaluator::max_liquidation_amounts<0xf325ce1300e8dac124071d3152c5c5ee6174914f8bc2161e88329cf579246efc::afsui::AFSUI, T0>(arg1, arg2, arg3, arg4, arg13);
        let v7 = 0x7f6ce7ade63857c4fd16ef7783fed2dfc4d7fb7e40615abdb653030b76aef0c6::staked_sui_vault::afsui_to_sui(arg8, arg9, v5);
        if (0x44ff6d248fe619bab9a36e15487a706da196d1311848b0b9e2f1fcfa044230e0::cetus_util::calculate_swap_amount_in<T1, T0>(arg7, false, 0x44ff6d248fe619bab9a36e15487a706da196d1311848b0b9e2f1fcfa044230e0::cetus_util::calculate_swap_amount_in<T1, 0x2::sui::SUI>(arg6, true, v7)) > v6) {
            return
        };
        let (v8, v9) = 0x2e8f9df2200c24bbee4a58fc8872034dbb5e3b4ae939b23b77509a86a593c35c::cetus_flash_loan::borrow_b_repay_a_later<T1, 0x2::sui::SUI>(arg5, arg6, v7, arg13, arg14);
        let v10 = v9;
        let (v11, v12) = 0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::liquidate::liquidate<0xf325ce1300e8dac124071d3152c5c5ee6174914f8bc2161e88329cf579246efc::afsui::AFSUI, T0>(arg0, arg1, arg2, 0x7f6ce7ade63857c4fd16ef7783fed2dfc4d7fb7e40615abdb653030b76aef0c6::staked_sui_vault::request_stake(arg8, arg9, arg12, arg10, v8, arg11, arg14), arg3, arg4, arg13, arg14);
        let v13 = v12;
        let v14 = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::swap_pay_amount<T1, 0x2::sui::SUI>(&v10);
        let (v15, v16) = 0x2e8f9df2200c24bbee4a58fc8872034dbb5e3b4ae939b23b77509a86a593c35c::cetus_flash_loan::borrow_a_repay_b_later<T1, T0>(arg5, arg7, v14, arg13, arg14);
        let v17 = v16;
        let v18 = v15;
        0x2e8f9df2200c24bbee4a58fc8872034dbb5e3b4ae939b23b77509a86a593c35c::cetus_flash_loan::repay_a<T1, 0x2::sui::SUI>(arg5, arg6, 0x2::coin::split<T1>(&mut v18, v14, arg14), v10);
        0x2e8f9df2200c24bbee4a58fc8872034dbb5e3b4ae939b23b77509a86a593c35c::cetus_flash_loan::repay_b<T1, T0>(arg5, arg7, 0x2::coin::split<T0>(&mut v13, 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::swap_pay_amount<T1, T0>(&v17), arg14), v17);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(v13, 0x2::tx_context::sender(arg14));
        0x44ff6d248fe619bab9a36e15487a706da196d1311848b0b9e2f1fcfa044230e0::coin_util::destory_or_send_to_sender<0xf325ce1300e8dac124071d3152c5c5ee6174914f8bc2161e88329cf579246efc::afsui::AFSUI>(v11, arg14);
        0x44ff6d248fe619bab9a36e15487a706da196d1311848b0b9e2f1fcfa044230e0::coin_util::destory_or_send_to_sender<T1>(v18, arg14);
    }

    public fun liquidate_obligation_with_af_sui_as_debt_and_usdc_as_collateral<T0>(arg0: &0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::version::Version, arg1: &mut 0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::obligation::Obligation, arg2: &mut 0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::market::Market, arg3: &0xca5a5a62f01c79a104bf4d31669e29daa387f325c241de4edbe30986a9bc8b0d::coin_decimals_registry::CoinDecimalsRegistry, arg4: &mut 0x1478a432123e4b3d61878b629f2c692969fdb375644f1251cd278a4b1e7d7cd6::x_oracle::XOracle, arg5: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg6: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, 0x2::sui::SUI>, arg7: &mut 0x7f6ce7ade63857c4fd16ef7783fed2dfc4d7fb7e40615abdb653030b76aef0c6::staked_sui_vault::StakedSuiVault, arg8: &mut 0xb572349baf4526c92c4e5242306e07a1658fa329ae93d1b9db0fc38b8a592bb::safe::Safe<0x2::coin::TreasuryCap<0xf325ce1300e8dac124071d3152c5c5ee6174914f8bc2161e88329cf579246efc::afsui::AFSUI>>, arg9: &0xb196672db3293fdebdbd4cbea950823ff84805547c7345710a1cf9d0db52938f::referral_vault::ReferralVault, arg10: address, arg11: &mut 0x3::sui_system::SuiSystemState, arg12: &0x2::clock::Clock, arg13: &mut 0x2::tx_context::TxContext) {
        let v0 = 0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::obligation::debt_types(arg1);
        let v1 = 0x1::type_name::get<0xf325ce1300e8dac124071d3152c5c5ee6174914f8bc2161e88329cf579246efc::afsui::AFSUI>();
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
        0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::accrue_interest::accrue_interest_for_market_and_obligation(arg0, arg2, arg1, arg12);
        if (!is_eligible_to_be_liquidated(arg1, arg2, arg3, arg4, arg12)) {
            return
        };
        let (v5, v6) = 0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::liquidation_evaluator::max_liquidation_amounts<0xf325ce1300e8dac124071d3152c5c5ee6174914f8bc2161e88329cf579246efc::afsui::AFSUI, T0>(arg1, arg2, arg3, arg4, arg12);
        let v7 = 0x7f6ce7ade63857c4fd16ef7783fed2dfc4d7fb7e40615abdb653030b76aef0c6::staked_sui_vault::afsui_to_sui(arg7, arg8, v5);
        if (0x44ff6d248fe619bab9a36e15487a706da196d1311848b0b9e2f1fcfa044230e0::cetus_util::calculate_swap_amount_in<T0, 0x2::sui::SUI>(arg6, true, v7) > v6) {
            return
        };
        let (v8, v9) = 0x2e8f9df2200c24bbee4a58fc8872034dbb5e3b4ae939b23b77509a86a593c35c::cetus_flash_loan::borrow_b_repay_a_later<T0, 0x2::sui::SUI>(arg5, arg6, v7, arg12, arg13);
        let v10 = v9;
        let (v11, v12) = 0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::liquidate::liquidate<0xf325ce1300e8dac124071d3152c5c5ee6174914f8bc2161e88329cf579246efc::afsui::AFSUI, T0>(arg0, arg1, arg2, 0x7f6ce7ade63857c4fd16ef7783fed2dfc4d7fb7e40615abdb653030b76aef0c6::staked_sui_vault::request_stake(arg7, arg8, arg11, arg9, v8, arg10, arg13), arg3, arg4, arg12, arg13);
        let v13 = v12;
        0x2e8f9df2200c24bbee4a58fc8872034dbb5e3b4ae939b23b77509a86a593c35c::cetus_flash_loan::repay_a<T0, 0x2::sui::SUI>(arg5, arg6, 0x2::coin::split<T0>(&mut v13, 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::swap_pay_amount<T0, 0x2::sui::SUI>(&v10), arg13), v10);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(v13, 0x2::tx_context::sender(arg13));
        0x44ff6d248fe619bab9a36e15487a706da196d1311848b0b9e2f1fcfa044230e0::coin_util::destory_or_send_to_sender<0xf325ce1300e8dac124071d3152c5c5ee6174914f8bc2161e88329cf579246efc::afsui::AFSUI>(v11, arg13);
    }

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
        if (!is_eligible_to_be_liquidated(arg1, arg2, arg3, arg4, arg7)) {
            return
        };
        let (v5, v6) = 0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::liquidation_evaluator::max_liquidation_amounts<T0, T1>(arg1, arg2, arg3, arg4, arg7);
        if (0x44ff6d248fe619bab9a36e15487a706da196d1311848b0b9e2f1fcfa044230e0::cetus_util::is_liquidation_profitable<T0, T1>(arg6, false, v5, v6) == false) {
            return
        };
        let (v7, v8) = 0x2e8f9df2200c24bbee4a58fc8872034dbb5e3b4ae939b23b77509a86a593c35c::cetus_flash_loan::borrow_a_repay_b_later<T0, T1>(arg5, arg6, v5, arg7, arg8);
        let v9 = v8;
        let (v10, v11) = 0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::liquidate::liquidate<T0, T1>(arg0, arg1, arg2, v7, arg3, arg4, arg7, arg8);
        let v12 = v11;
        0x2e8f9df2200c24bbee4a58fc8872034dbb5e3b4ae939b23b77509a86a593c35c::cetus_flash_loan::repay_b<T0, T1>(arg5, arg6, 0x2::coin::split<T1>(&mut v12, 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::swap_pay_amount<T0, T1>(&v9), arg8), v9);
        0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(v12, 0x2::tx_context::sender(arg8));
        0x44ff6d248fe619bab9a36e15487a706da196d1311848b0b9e2f1fcfa044230e0::coin_util::destory_or_send_to_sender<T0>(v10, arg8);
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
        if (!is_eligible_to_be_liquidated(arg1, arg2, arg3, arg4, arg8)) {
            return
        };
        let (v5, v6) = 0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::liquidation_evaluator::max_liquidation_amounts<T0, T1>(arg1, arg2, arg3, arg4, arg8);
        if (0x44ff6d248fe619bab9a36e15487a706da196d1311848b0b9e2f1fcfa044230e0::cetus_util::calculate_swap_amount_in<T1, T2>(arg7, true, 0x44ff6d248fe619bab9a36e15487a706da196d1311848b0b9e2f1fcfa044230e0::cetus_util::calculate_swap_amount_in<T0, T2>(arg6, false, v5)) > v6) {
            return
        };
        let (v7, v8) = 0x2e8f9df2200c24bbee4a58fc8872034dbb5e3b4ae939b23b77509a86a593c35c::cetus_flash_loan::borrow_a_repay_b_later<T0, T2>(arg5, arg6, v5, arg8, arg9);
        let v9 = v8;
        let (v10, v11) = 0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::liquidate::liquidate<T0, T1>(arg0, arg1, arg2, v7, arg3, arg4, arg8, arg9);
        let v12 = v11;
        let v13 = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::swap_pay_amount<T0, T2>(&v9);
        let (v14, v15) = 0x2e8f9df2200c24bbee4a58fc8872034dbb5e3b4ae939b23b77509a86a593c35c::cetus_flash_loan::borrow_b_repay_a_later<T1, T2>(arg5, arg7, v13, arg8, arg9);
        let v16 = v15;
        let v17 = v14;
        0x2e8f9df2200c24bbee4a58fc8872034dbb5e3b4ae939b23b77509a86a593c35c::cetus_flash_loan::repay_b<T0, T2>(arg5, arg6, 0x2::coin::split<T2>(&mut v17, v13, arg9), v9);
        0x2e8f9df2200c24bbee4a58fc8872034dbb5e3b4ae939b23b77509a86a593c35c::cetus_flash_loan::repay_a<T1, T2>(arg5, arg7, 0x2::coin::split<T1>(&mut v12, 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::swap_pay_amount<T1, T2>(&v16), arg9), v16);
        0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(v12, 0x2::tx_context::sender(arg9));
        0x44ff6d248fe619bab9a36e15487a706da196d1311848b0b9e2f1fcfa044230e0::coin_util::destory_or_send_to_sender<T0>(v10, arg9);
        0x44ff6d248fe619bab9a36e15487a706da196d1311848b0b9e2f1fcfa044230e0::coin_util::destory_or_send_to_sender<T2>(v17, arg9);
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
        if (!is_eligible_to_be_liquidated(arg1, arg2, arg3, arg4, arg8)) {
            return
        };
        let (v5, v6) = 0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::liquidation_evaluator::max_liquidation_amounts<T0, T1>(arg1, arg2, arg3, arg4, arg8);
        if (0x44ff6d248fe619bab9a36e15487a706da196d1311848b0b9e2f1fcfa044230e0::cetus_util::calculate_swap_amount_in<T2, T1>(arg7, false, 0x44ff6d248fe619bab9a36e15487a706da196d1311848b0b9e2f1fcfa044230e0::cetus_util::calculate_swap_amount_in<T0, T2>(arg6, false, v5)) > v6) {
            return
        };
        let (v7, v8) = 0x2e8f9df2200c24bbee4a58fc8872034dbb5e3b4ae939b23b77509a86a593c35c::cetus_flash_loan::borrow_a_repay_b_later<T0, T2>(arg5, arg6, v5, arg8, arg9);
        let v9 = v8;
        let (v10, v11) = 0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::liquidate::liquidate<T0, T1>(arg0, arg1, arg2, v7, arg3, arg4, arg8, arg9);
        let v12 = v11;
        let v13 = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::swap_pay_amount<T0, T2>(&v9);
        let (v14, v15) = 0x2e8f9df2200c24bbee4a58fc8872034dbb5e3b4ae939b23b77509a86a593c35c::cetus_flash_loan::borrow_a_repay_b_later<T2, T1>(arg5, arg7, v13, arg8, arg9);
        let v16 = v15;
        let v17 = v14;
        0x2e8f9df2200c24bbee4a58fc8872034dbb5e3b4ae939b23b77509a86a593c35c::cetus_flash_loan::repay_b<T0, T2>(arg5, arg6, 0x2::coin::split<T2>(&mut v17, v13, arg9), v9);
        0x2e8f9df2200c24bbee4a58fc8872034dbb5e3b4ae939b23b77509a86a593c35c::cetus_flash_loan::repay_b<T2, T1>(arg5, arg7, 0x2::coin::split<T1>(&mut v12, 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::swap_pay_amount<T2, T1>(&v16), arg9), v16);
        0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(v12, 0x2::tx_context::sender(arg9));
        0x44ff6d248fe619bab9a36e15487a706da196d1311848b0b9e2f1fcfa044230e0::coin_util::destory_or_send_to_sender<T0>(v10, arg9);
        0x44ff6d248fe619bab9a36e15487a706da196d1311848b0b9e2f1fcfa044230e0::coin_util::destory_or_send_to_sender<T2>(v17, arg9);
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
        if (!is_eligible_to_be_liquidated(arg1, arg2, arg3, arg4, arg8)) {
            return
        };
        let (v5, v6) = 0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::liquidation_evaluator::max_liquidation_amounts<T0, T1>(arg1, arg2, arg3, arg4, arg8);
        if (0x44ff6d248fe619bab9a36e15487a706da196d1311848b0b9e2f1fcfa044230e0::cetus_util::calculate_swap_amount_in<T1, T2>(arg7, true, 0x44ff6d248fe619bab9a36e15487a706da196d1311848b0b9e2f1fcfa044230e0::cetus_util::calculate_swap_amount_in<T2, T0>(arg6, true, v5)) > v6) {
            return
        };
        let (v7, v8) = 0x2e8f9df2200c24bbee4a58fc8872034dbb5e3b4ae939b23b77509a86a593c35c::cetus_flash_loan::borrow_b_repay_a_later<T2, T0>(arg5, arg6, v5, arg8, arg9);
        let v9 = v8;
        let (v10, v11) = 0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::liquidate::liquidate<T0, T1>(arg0, arg1, arg2, v7, arg3, arg4, arg8, arg9);
        let v12 = v11;
        let v13 = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::swap_pay_amount<T2, T0>(&v9);
        let (v14, v15) = 0x2e8f9df2200c24bbee4a58fc8872034dbb5e3b4ae939b23b77509a86a593c35c::cetus_flash_loan::borrow_b_repay_a_later<T1, T2>(arg5, arg7, v13, arg8, arg9);
        let v16 = v15;
        let v17 = v14;
        0x2e8f9df2200c24bbee4a58fc8872034dbb5e3b4ae939b23b77509a86a593c35c::cetus_flash_loan::repay_a<T2, T0>(arg5, arg6, 0x2::coin::split<T2>(&mut v17, v13, arg9), v9);
        0x2e8f9df2200c24bbee4a58fc8872034dbb5e3b4ae939b23b77509a86a593c35c::cetus_flash_loan::repay_a<T1, T2>(arg5, arg7, 0x2::coin::split<T1>(&mut v12, 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::swap_pay_amount<T1, T2>(&v16), arg9), v16);
        0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(v12, 0x2::tx_context::sender(arg9));
        0x44ff6d248fe619bab9a36e15487a706da196d1311848b0b9e2f1fcfa044230e0::coin_util::destory_or_send_to_sender<T0>(v10, arg9);
        0x44ff6d248fe619bab9a36e15487a706da196d1311848b0b9e2f1fcfa044230e0::coin_util::destory_or_send_to_sender<T2>(v17, arg9);
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
        if (!is_eligible_to_be_liquidated(arg1, arg2, arg3, arg4, arg8)) {
            return
        };
        let (v5, v6) = 0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::liquidation_evaluator::max_liquidation_amounts<T0, T1>(arg1, arg2, arg3, arg4, arg8);
        if (0x44ff6d248fe619bab9a36e15487a706da196d1311848b0b9e2f1fcfa044230e0::cetus_util::calculate_swap_amount_in<T2, T1>(arg7, false, 0x44ff6d248fe619bab9a36e15487a706da196d1311848b0b9e2f1fcfa044230e0::cetus_util::calculate_swap_amount_in<T2, T0>(arg6, true, v5)) > v6) {
            return
        };
        let (v7, v8) = 0x2e8f9df2200c24bbee4a58fc8872034dbb5e3b4ae939b23b77509a86a593c35c::cetus_flash_loan::borrow_b_repay_a_later<T2, T0>(arg5, arg6, v5, arg8, arg9);
        let v9 = v8;
        let (v10, v11) = 0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::liquidate::liquidate<T0, T1>(arg0, arg1, arg2, v7, arg3, arg4, arg8, arg9);
        let v12 = v11;
        let v13 = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::swap_pay_amount<T2, T0>(&v9);
        let (v14, v15) = 0x2e8f9df2200c24bbee4a58fc8872034dbb5e3b4ae939b23b77509a86a593c35c::cetus_flash_loan::borrow_a_repay_b_later<T2, T1>(arg5, arg7, v13, arg8, arg9);
        let v16 = v15;
        let v17 = v14;
        0x2e8f9df2200c24bbee4a58fc8872034dbb5e3b4ae939b23b77509a86a593c35c::cetus_flash_loan::repay_a<T2, T0>(arg5, arg6, 0x2::coin::split<T2>(&mut v17, v13, arg9), v9);
        0x2e8f9df2200c24bbee4a58fc8872034dbb5e3b4ae939b23b77509a86a593c35c::cetus_flash_loan::repay_b<T2, T1>(arg5, arg7, 0x2::coin::split<T1>(&mut v12, 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::swap_pay_amount<T2, T1>(&v16), arg9), v16);
        0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(v12, 0x2::tx_context::sender(arg9));
        0x44ff6d248fe619bab9a36e15487a706da196d1311848b0b9e2f1fcfa044230e0::coin_util::destory_or_send_to_sender<T0>(v10, arg9);
        0x44ff6d248fe619bab9a36e15487a706da196d1311848b0b9e2f1fcfa044230e0::coin_util::destory_or_send_to_sender<T2>(v17, arg9);
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
        if (!is_eligible_to_be_liquidated(arg1, arg2, arg3, arg4, arg7)) {
            return
        };
        let (v5, v6) = 0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::liquidation_evaluator::max_liquidation_amounts<T0, T0>(arg1, arg2, arg3, arg4, arg7);
        if (0x44ff6d248fe619bab9a36e15487a706da196d1311848b0b9e2f1fcfa044230e0::cetus_util::is_liquidation_profitable_with_double_swap<T0, T1>(arg6, v5, v6) == false) {
            return
        };
        let (v7, v8) = 0x2e8f9df2200c24bbee4a58fc8872034dbb5e3b4ae939b23b77509a86a593c35c::cetus_flash_loan::borrow_a_repay_a_later<T0, T1>(arg5, arg6, v5, arg7, arg8);
        let v9 = v8;
        let (v10, v11) = 0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::liquidate::liquidate<T0, T0>(arg0, arg1, arg2, v7, arg3, arg4, arg7, arg8);
        let v12 = v11;
        0x2e8f9df2200c24bbee4a58fc8872034dbb5e3b4ae939b23b77509a86a593c35c::cetus_flash_loan::repay_a<T0, T1>(arg5, arg6, 0x2::coin::split<T0>(&mut v12, 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::swap_pay_amount<T0, T1>(&v9), arg8), v9);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(v12, 0x2::tx_context::sender(arg8));
        0x44ff6d248fe619bab9a36e15487a706da196d1311848b0b9e2f1fcfa044230e0::coin_util::destory_or_send_to_sender<T0>(v10, arg8);
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
        if (!is_eligible_to_be_liquidated(arg1, arg2, arg3, arg4, arg7)) {
            return
        };
        let (v5, v6) = 0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::liquidation_evaluator::max_liquidation_amounts<T1, T1>(arg1, arg2, arg3, arg4, arg7);
        if (0x44ff6d248fe619bab9a36e15487a706da196d1311848b0b9e2f1fcfa044230e0::cetus_util::is_liquidation_profitable_with_double_swap<T0, T1>(arg6, v5, v6) == false) {
            return
        };
        let (v7, v8) = 0x2e8f9df2200c24bbee4a58fc8872034dbb5e3b4ae939b23b77509a86a593c35c::cetus_flash_loan::borrow_b_repay_b_later<T0, T1>(arg5, arg6, v5, arg7, arg8);
        let v9 = v8;
        let (v10, v11) = 0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::liquidate::liquidate<T1, T1>(arg0, arg1, arg2, v7, arg3, arg4, arg7, arg8);
        let v12 = v11;
        0x2e8f9df2200c24bbee4a58fc8872034dbb5e3b4ae939b23b77509a86a593c35c::cetus_flash_loan::repay_b<T0, T1>(arg5, arg6, 0x2::coin::split<T1>(&mut v12, 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::swap_pay_amount<T0, T1>(&v9), arg8), v9);
        0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(v12, 0x2::tx_context::sender(arg8));
        0x44ff6d248fe619bab9a36e15487a706da196d1311848b0b9e2f1fcfa044230e0::coin_util::destory_or_send_to_sender<T1>(v10, arg8);
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
        if (!is_eligible_to_be_liquidated(arg1, arg2, arg3, arg4, arg7)) {
            return
        };
        let (v5, v6) = 0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::liquidation_evaluator::max_liquidation_amounts<T0, T1>(arg1, arg2, arg3, arg4, arg7);
        if (0x44ff6d248fe619bab9a36e15487a706da196d1311848b0b9e2f1fcfa044230e0::cetus_util::is_liquidation_profitable<T1, T0>(arg6, true, v5, v6) == false) {
            return
        };
        let (v7, v8) = 0x2e8f9df2200c24bbee4a58fc8872034dbb5e3b4ae939b23b77509a86a593c35c::cetus_flash_loan::borrow_b_repay_a_later<T1, T0>(arg5, arg6, v5, arg7, arg8);
        let v9 = v8;
        let (v10, v11) = 0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::liquidate::liquidate<T0, T1>(arg0, arg1, arg2, v7, arg3, arg4, arg7, arg8);
        let v12 = v11;
        0x2e8f9df2200c24bbee4a58fc8872034dbb5e3b4ae939b23b77509a86a593c35c::cetus_flash_loan::repay_a<T1, T0>(arg5, arg6, 0x2::coin::split<T1>(&mut v12, 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::swap_pay_amount<T1, T0>(&v9), arg8), v9);
        0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(v12, 0x2::tx_context::sender(arg8));
        0x44ff6d248fe619bab9a36e15487a706da196d1311848b0b9e2f1fcfa044230e0::coin_util::destory_or_send_to_sender<T0>(v10, arg8);
    }

    // decompiled from Move bytecode v6
}

