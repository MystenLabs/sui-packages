module 0x8c19b250602803796214ae8f3833c1fbec330277e14bb00625e8ce4d8ac931ad::router {
    struct OrderRecord has copy, drop {
        order_id: u64,
        decimal: u8,
        out_amount: u64,
    }

    struct CommissionRecord has copy, drop {
        commission_amount: u64,
        referral_address: address,
    }

    struct HopRecord has copy, drop {
        out_amount: u64,
    }

    public fun afsui_swap_a2b_with_return(arg0: &mut 0x7f6ce7ade63857c4fd16ef7783fed2dfc4d7fb7e40615abdb653030b76aef0c6::staked_sui_vault::StakedSuiVault, arg1: &mut 0xb572349baf4526c92c4e5242306e07a1658fa329ae93d1b9db0fc38b8a592bb::safe::Safe<0x2::coin::TreasuryCap<0xf325ce1300e8dac124071d3152c5c5ee6174914f8bc2161e88329cf579246efc::afsui::AFSUI>>, arg2: &mut 0x3::sui_system::SuiSystemState, arg3: &0xb196672db3293fdebdbd4cbea950823ff84805547c7345710a1cf9d0db52938f::referral_vault::ReferralVault, arg4: 0x2::coin::Coin<0x2::sui::SUI>, arg5: address, arg6: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<0xf325ce1300e8dac124071d3152c5c5ee6174914f8bc2161e88329cf579246efc::afsui::AFSUI>, u64) {
        let v0 = 0x7f6ce7ade63857c4fd16ef7783fed2dfc4d7fb7e40615abdb653030b76aef0c6::staked_sui_vault::request_stake(arg0, arg1, arg2, arg3, arg4, arg5, arg6);
        let v1 = 0x2::coin::value<0xf325ce1300e8dac124071d3152c5c5ee6174914f8bc2161e88329cf579246efc::afsui::AFSUI>(&v0);
        let v2 = HopRecord{out_amount: v1};
        0x2::event::emit<HopRecord>(v2);
        (v0, v1)
    }

    public fun afsui_swap_b2a_with_return(arg0: &mut 0x7f6ce7ade63857c4fd16ef7783fed2dfc4d7fb7e40615abdb653030b76aef0c6::staked_sui_vault::StakedSuiVault, arg1: &0xb572349baf4526c92c4e5242306e07a1658fa329ae93d1b9db0fc38b8a592bb::safe::Safe<0x2::coin::TreasuryCap<0xf325ce1300e8dac124071d3152c5c5ee6174914f8bc2161e88329cf579246efc::afsui::AFSUI>>, arg2: &0xb196672db3293fdebdbd4cbea950823ff84805547c7345710a1cf9d0db52938f::referral_vault::ReferralVault, arg3: &mut 0xceb3b6f35b71dbd0296cd96f8c00959c230854c7797294148b413094b9621b0e::treasury::Treasury, arg4: 0x2::coin::Coin<0xf325ce1300e8dac124071d3152c5c5ee6174914f8bc2161e88329cf579246efc::afsui::AFSUI>, arg5: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<0x2::sui::SUI>, u64) {
        let v0 = 0x7f6ce7ade63857c4fd16ef7783fed2dfc4d7fb7e40615abdb653030b76aef0c6::staked_sui_vault::request_unstake_atomic(arg0, arg1, arg2, arg3, arg4, arg5);
        let v1 = 0x2::coin::value<0x2::sui::SUI>(&v0);
        let v2 = HopRecord{out_amount: v1};
        0x2::event::emit<HopRecord>(v2);
        (v0, v1)
    }

    public fun aftermath_swap_exact_in_with_return<T0, T1, T2>(arg0: &mut 0xefe170ec0be4d762196bedecd7a065816576198a6527c99282a2551aaa7da38c::pool::Pool<T0>, arg1: &0xefe170ec0be4d762196bedecd7a065816576198a6527c99282a2551aaa7da38c::pool_registry::PoolRegistry, arg2: &0x2d9316f1f1a95f6d7c85a4e690ef7c359e6649773ef2c37ad7d9857adb6bef06::vault::ProtocolFeeVault, arg3: &mut 0x64213b0e4a52bac468d4ac3f140242f70714381653a1919a6d57cd49c628207a::treasury::Treasury, arg4: &mut 0xa6baab1e668c7868991c1c3c11e144100f5734c407d020f72a01b9d1a8bcb97f::insurance_fund::InsuranceFund, arg5: &0xc66fabf1a9253e43c70f1cc02d40a1d18db183140ecaae2a3f58fa6b66c55acf::referral_vault::ReferralVault, arg6: 0x2::coin::Coin<T1>, arg7: u64, arg8: u64, arg9: u64, arg10: u64, arg11: u8, arg12: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T2>, u64) {
        assert!(0x2::coin::value<T1>(&arg6) == arg7, 6);
        let v0 = 0xefe170ec0be4d762196bedecd7a065816576198a6527c99282a2551aaa7da38c::swap::swap_exact_in<T0, T1, T2>(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg8, arg9, arg12);
        let v1 = 0x2::coin::value<T2>(&v0);
        let v2 = HopRecord{out_amount: v1};
        0x2::event::emit<HopRecord>(v2);
        (v0, v1)
    }

    public fun bluemove_stable_swap_exact_input_with_return<T0, T1>(arg0: 0x2::coin::Coin<T0>, arg1: u64, arg2: u64, arg3: &mut 0xb24b6789e088b876afabca733bed2299fbc9e2d6369be4d1acfa17d8145454d9::stable_swap::Dex_Stable_Info, arg4: &0x2::clock::Clock, arg5: u64, arg6: u8, arg7: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T1>, u64) {
        let v0 = 0xb24b6789e088b876afabca733bed2299fbc9e2d6369be4d1acfa17d8145454d9::stable_router::swap_exact_input_<T0, T1>(arg0, arg1, arg2, arg3, arg4, arg7);
        let v1 = 0x2::coin::value<T1>(&v0);
        let v2 = HopRecord{out_amount: v1};
        0x2::event::emit<HopRecord>(v2);
        (v0, v1)
    }

    public fun bluemove_swap_exact_input_with_return<T0, T1>(arg0: u64, arg1: 0x2::coin::Coin<T0>, arg2: u64, arg3: &mut 0xb24b6789e088b876afabca733bed2299fbc9e2d6369be4d1acfa17d8145454d9::swap::Dex_Info, arg4: u64, arg5: u8, arg6: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T1>, u64) {
        let v0 = 0xb24b6789e088b876afabca733bed2299fbc9e2d6369be4d1acfa17d8145454d9::router::swap_exact_input_<T0, T1>(arg0, arg1, arg2, arg3, arg6);
        let v1 = 0x2::coin::value<T1>(&v0);
        let v2 = HopRecord{out_amount: v1};
        0x2::event::emit<HopRecord>(v2);
        (v0, v1)
    }

    public fun cetus_swap_a2b_with_return<T0, T1>(arg0: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg1: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg2: vector<0x2::coin::Coin<T0>>, arg3: bool, arg4: u64, arg5: u64, arg6: u128, arg7: &0x2::clock::Clock, arg8: u64, arg9: u8, arg10: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T1>, u64) {
        let (v0, v1) = swapWithReturn<T0, T1>(arg0, arg1, arg2, 0x1::vector::empty<0x2::coin::Coin<T1>>(), true, arg3, arg4, arg5, arg6, arg7, arg10);
        let v2 = v1;
        destroy_or_transfer<T0>(v0, arg10);
        let v3 = 0x2::coin::value<T1>(&v2);
        let v4 = HopRecord{out_amount: v3};
        0x2::event::emit<HopRecord>(v4);
        (v2, v3)
    }

    public fun cetus_swap_b2a_with_return<T0, T1>(arg0: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg1: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg2: vector<0x2::coin::Coin<T1>>, arg3: bool, arg4: u64, arg5: u64, arg6: u128, arg7: &0x2::clock::Clock, arg8: u64, arg9: u8, arg10: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T0>, u64) {
        let (v0, v1) = swapWithReturn<T0, T1>(arg0, arg1, 0x1::vector::empty<0x2::coin::Coin<T0>>(), arg2, false, arg3, arg4, arg5, arg6, arg7, arg10);
        let v2 = v0;
        destroy_or_transfer<T1>(v1, arg10);
        let v3 = 0x2::coin::value<T0>(&v2);
        let v4 = HopRecord{out_amount: v3};
        0x2::event::emit<HopRecord>(v4);
        (v2, v3)
    }

    public fun deepbook_swap_base_to_quote_with_return<T0, T1>(arg0: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T0, T1>, arg1: 0x2::coin::Coin<T0>, arg2: u64, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T1>, u64) {
        let (v0, v1, v2) = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::swap_exact_base_for_quote<T0, T1>(arg0, arg1, 0x2::coin::zero<0xdeeb7a4662eec9f2f3def03fb937a663dddaa2e215b8078a284d026b7946c270::deep::DEEP>(arg4), arg2, arg3, arg4);
        let v3 = v1;
        destroy_or_transfer<0xdeeb7a4662eec9f2f3def03fb937a663dddaa2e215b8078a284d026b7946c270::deep::DEEP>(v2, arg4);
        destroy_or_transfer<T0>(v0, arg4);
        let v4 = 0x2::coin::value<T1>(&v3);
        let v5 = HopRecord{out_amount: v4};
        0x2::event::emit<HopRecord>(v5);
        (v3, v4)
    }

    public fun deepbook_swap_quote_to_base_with_return<T0, T1>(arg0: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T0, T1>, arg1: 0x2::coin::Coin<T1>, arg2: u64, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T0>, u64) {
        let (v0, v1, v2) = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::swap_exact_quote_for_base<T0, T1>(arg0, arg1, 0x2::coin::zero<0xdeeb7a4662eec9f2f3def03fb937a663dddaa2e215b8078a284d026b7946c270::deep::DEEP>(arg4), arg2, arg3, arg4);
        let v3 = v0;
        destroy_or_transfer<0xdeeb7a4662eec9f2f3def03fb937a663dddaa2e215b8078a284d026b7946c270::deep::DEEP>(v2, arg4);
        destroy_or_transfer<T1>(v1, arg4);
        let v4 = 0x2::coin::value<T0>(&v3);
        let v5 = HopRecord{out_amount: v4};
        0x2::event::emit<HopRecord>(v5);
        (v3, v4)
    }

    fun destroy_or_transfer<T0>(arg0: 0x2::coin::Coin<T0>, arg1: &0x2::tx_context::TxContext) {
        if (0x2::coin::value<T0>(&arg0) == 0) {
            0x2::coin::destroy_zero<T0>(arg0);
        } else {
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(arg0, 0x2::tx_context::sender(arg1));
        };
    }

    public fun finalize<T0>(arg0: 0x2::coin::Coin<T0>, arg1: u64, arg2: u64, arg3: address, arg4: address, arg5: u64, arg6: u8, arg7: &mut 0x2::tx_context::TxContext) {
        assert!(arg1 > 0, 8);
        assert!(arg2 == 0 || arg2 > 0 && arg3 != @0x0, 5);
        let v0 = 0x2::coin::value<T0>(&arg0);
        let v1 = if (arg4 != @0x0) {
            arg4
        } else {
            0x2::tx_context::sender(arg7)
        };
        if (v0 < arg1) {
            abort 1
        };
        if (arg2 > 0) {
            let v2 = &mut arg0;
            let (v3, _) = split_with_percentage_for_commission<T0>(v2, arg2, arg3, arg7);
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(v3, v1);
            destroy_or_transfer<T0>(arg0, arg7);
        } else {
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(arg0, v1);
        };
        let v5 = OrderRecord{
            order_id   : arg5,
            decimal    : arg6,
            out_amount : v0,
        };
        0x2::event::emit<OrderRecord>(v5);
    }

    public fun finalize_without_transfer<T0>(arg0: 0x2::coin::Coin<T0>, arg1: u64, arg2: u8, arg3: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T0>, u64) {
        let v0 = 0x2::coin::value<T0>(&arg0);
        let v1 = OrderRecord{
            order_id   : arg1,
            decimal    : arg2,
            out_amount : v0,
        };
        0x2::event::emit<OrderRecord>(v1);
        (arg0, v0)
    }

    public fun flowx_swap_exact_input_direct_with_return<T0, T1>(arg0: &mut 0xba153169476e8c3114962261d1edc70de5ad9781b83cc617ecc8c1923191cae0::factory::Container, arg1: 0x2::coin::Coin<T0>, arg2: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T1>, u64) {
        let v0 = 0xba153169476e8c3114962261d1edc70de5ad9781b83cc617ecc8c1923191cae0::router::swap_exact_input_direct<T0, T1>(arg0, arg1, arg2);
        let v1 = 0x2::coin::value<T1>(&v0);
        let v2 = HopRecord{out_amount: v1};
        0x2::event::emit<HopRecord>(v2);
        (v0, v1)
    }

    public fun flowxv3_swap_a2b_with_return<T0, T1>(arg0: &0x2::clock::Clock, arg1: &0x25929e7f29e0a30eb4e692952ba1b5b65a3a4d65ab5f2a32e1ba3edcb587f26d::versioned::Versioned, arg2: &mut 0x25929e7f29e0a30eb4e692952ba1b5b65a3a4d65ab5f2a32e1ba3edcb587f26d::pool_manager::PoolRegistry, arg3: u64, arg4: 0x2::coin::Coin<T0>, arg5: bool, arg6: u128, arg7: u64, arg8: u8, arg9: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T1>, u64) {
        let v0 = 0x25929e7f29e0a30eb4e692952ba1b5b65a3a4d65ab5f2a32e1ba3edcb587f26d::pool_manager::borrow_mut_pool<T0, T1>(arg2, arg3);
        let (v1, v2, v3) = 0x25929e7f29e0a30eb4e692952ba1b5b65a3a4d65ab5f2a32e1ba3edcb587f26d::pool::swap<T0, T1>(v0, true, arg5, 0x2::coin::value<T0>(&arg4), arg6, arg1, arg0, arg9);
        let v4 = v3;
        let v5 = v2;
        0x2::balance::destroy_zero<T0>(v1);
        let (v6, _) = 0x25929e7f29e0a30eb4e692952ba1b5b65a3a4d65ab5f2a32e1ba3edcb587f26d::pool::swap_receipt_debts(&v4);
        0x25929e7f29e0a30eb4e692952ba1b5b65a3a4d65ab5f2a32e1ba3edcb587f26d::pool::pay<T0, T1>(v0, v4, 0x2::balance::split<T0>(0x2::coin::balance_mut<T0>(&mut arg4), v6), 0x2::balance::zero<T1>(), arg1, arg9);
        let v8 = 0x2::balance::value<T1>(&v5);
        destroy_or_transfer<T0>(arg4, arg9);
        let v9 = HopRecord{out_amount: v8};
        0x2::event::emit<HopRecord>(v9);
        (0x2::coin::from_balance<T1>(v5, arg9), v8)
    }

    public fun flowxv3_swap_b2a_with_return<T0, T1>(arg0: &0x2::clock::Clock, arg1: &0x25929e7f29e0a30eb4e692952ba1b5b65a3a4d65ab5f2a32e1ba3edcb587f26d::versioned::Versioned, arg2: &mut 0x25929e7f29e0a30eb4e692952ba1b5b65a3a4d65ab5f2a32e1ba3edcb587f26d::pool_manager::PoolRegistry, arg3: u64, arg4: 0x2::coin::Coin<T1>, arg5: bool, arg6: u128, arg7: u64, arg8: u8, arg9: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T0>, u64) {
        let v0 = 0x25929e7f29e0a30eb4e692952ba1b5b65a3a4d65ab5f2a32e1ba3edcb587f26d::pool_manager::borrow_mut_pool<T0, T1>(arg2, arg3);
        let (v1, v2, v3) = 0x25929e7f29e0a30eb4e692952ba1b5b65a3a4d65ab5f2a32e1ba3edcb587f26d::pool::swap<T0, T1>(v0, false, arg5, 0x2::coin::value<T1>(&arg4), arg6, arg1, arg0, arg9);
        let v4 = v3;
        let v5 = v1;
        0x2::balance::destroy_zero<T1>(v2);
        let (_, v7) = 0x25929e7f29e0a30eb4e692952ba1b5b65a3a4d65ab5f2a32e1ba3edcb587f26d::pool::swap_receipt_debts(&v4);
        0x25929e7f29e0a30eb4e692952ba1b5b65a3a4d65ab5f2a32e1ba3edcb587f26d::pool::pay<T0, T1>(v0, v4, 0x2::balance::zero<T0>(), 0x2::balance::split<T1>(0x2::coin::balance_mut<T1>(&mut arg4), v7), arg1, arg9);
        let v8 = 0x2::balance::value<T0>(&v5);
        destroy_or_transfer<T1>(arg4, arg9);
        let v9 = HopRecord{out_amount: v8};
        0x2::event::emit<HopRecord>(v9);
        (0x2::coin::from_balance<T0>(v5, arg9), v8)
    }

    public fun kriya_amm_swap_token_x_with_return<T0, T1>(arg0: &mut 0xa0eba10b173538c8fecca1dff298e488402cc9ff374f8a12ca7758eebe830b66::spot_dex::Pool<T0, T1>, arg1: 0x2::coin::Coin<T0>, arg2: u64, arg3: u64, arg4: u64, arg5: u8, arg6: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T1>, u64) {
        let v0 = 0xa0eba10b173538c8fecca1dff298e488402cc9ff374f8a12ca7758eebe830b66::spot_dex::swap_token_x<T0, T1>(arg0, arg1, arg2, arg3, arg6);
        let v1 = 0x2::coin::value<T1>(&v0);
        let v2 = HopRecord{out_amount: v1};
        0x2::event::emit<HopRecord>(v2);
        (v0, v1)
    }

    public fun kriya_amm_swap_token_y_with_return<T0, T1>(arg0: &mut 0xa0eba10b173538c8fecca1dff298e488402cc9ff374f8a12ca7758eebe830b66::spot_dex::Pool<T0, T1>, arg1: 0x2::coin::Coin<T1>, arg2: u64, arg3: u64, arg4: u64, arg5: u8, arg6: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T0>, u64) {
        let v0 = 0xa0eba10b173538c8fecca1dff298e488402cc9ff374f8a12ca7758eebe830b66::spot_dex::swap_token_y<T0, T1>(arg0, arg1, arg2, arg3, arg6);
        let v1 = 0x2::coin::value<T0>(&v0);
        let v2 = HopRecord{out_amount: v1};
        0x2::event::emit<HopRecord>(v2);
        (v0, v1)
    }

    public fun kriya_clmm_swap_token_x_with_return<T0, T1>(arg0: &mut 0xf6c05e2d9301e6e91dc6ab6c3ca918f7d55896e1f1edd64adc0e615cde27ebf1::pool::Pool<T0, T1>, arg1: 0x2::coin::Coin<T0>, arg2: u64, arg3: u64, arg4: &0x2::clock::Clock, arg5: &0xf6c05e2d9301e6e91dc6ab6c3ca918f7d55896e1f1edd64adc0e615cde27ebf1::version::Version, arg6: u64, arg7: u8, arg8: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T1>, u64) {
        assert!(0x2::coin::value<T0>(&arg1) == arg2, 10);
        let (v0, v1, v2) = 0xf6c05e2d9301e6e91dc6ab6c3ca918f7d55896e1f1edd64adc0e615cde27ebf1::trade::flash_swap<T0, T1>(arg0, true, true, arg2, 0xf6c05e2d9301e6e91dc6ab6c3ca918f7d55896e1f1edd64adc0e615cde27ebf1::tick_math::min_sqrt_price(), arg4, arg5, arg8);
        let v3 = v2;
        let v4 = v1;
        let v5 = 0x2::balance::value<T1>(&v4);
        assert!(v5 >= arg3, 7);
        0x2::balance::destroy_zero<T0>(v0);
        let (v6, _) = 0xf6c05e2d9301e6e91dc6ab6c3ca918f7d55896e1f1edd64adc0e615cde27ebf1::trade::swap_receipt_debts(&v3);
        0xf6c05e2d9301e6e91dc6ab6c3ca918f7d55896e1f1edd64adc0e615cde27ebf1::trade::repay_flash_swap<T0, T1>(arg0, v3, 0x2::coin::into_balance<T0>(0x2::coin::split<T0>(&mut arg1, v6, arg8)), 0x2::balance::zero<T1>(), arg5, arg8);
        destroy_or_transfer<T0>(arg1, arg8);
        let v8 = HopRecord{out_amount: v5};
        0x2::event::emit<HopRecord>(v8);
        (0x2::coin::from_balance<T1>(v4, arg8), v5)
    }

    public fun kriya_clmm_swap_token_y_with_return<T0, T1>(arg0: &mut 0xf6c05e2d9301e6e91dc6ab6c3ca918f7d55896e1f1edd64adc0e615cde27ebf1::pool::Pool<T0, T1>, arg1: 0x2::coin::Coin<T1>, arg2: u64, arg3: u64, arg4: &0x2::clock::Clock, arg5: &0xf6c05e2d9301e6e91dc6ab6c3ca918f7d55896e1f1edd64adc0e615cde27ebf1::version::Version, arg6: u64, arg7: u8, arg8: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T0>, u64) {
        assert!(0x2::coin::value<T1>(&arg1) == arg2, 10);
        let (v0, v1, v2) = 0xf6c05e2d9301e6e91dc6ab6c3ca918f7d55896e1f1edd64adc0e615cde27ebf1::trade::flash_swap<T0, T1>(arg0, false, true, arg2, 0xf6c05e2d9301e6e91dc6ab6c3ca918f7d55896e1f1edd64adc0e615cde27ebf1::tick_math::max_sqrt_price(), arg4, arg5, arg8);
        let v3 = v2;
        let v4 = v0;
        let v5 = 0x2::balance::value<T0>(&v4);
        assert!(v5 >= arg3, 7);
        0x2::balance::destroy_zero<T1>(v1);
        let (_, v7) = 0xf6c05e2d9301e6e91dc6ab6c3ca918f7d55896e1f1edd64adc0e615cde27ebf1::trade::swap_receipt_debts(&v3);
        0xf6c05e2d9301e6e91dc6ab6c3ca918f7d55896e1f1edd64adc0e615cde27ebf1::trade::repay_flash_swap<T0, T1>(arg0, v3, 0x2::balance::zero<T0>(), 0x2::coin::into_balance<T1>(0x2::coin::split<T1>(&mut arg1, v7, arg8)), arg5, arg8);
        destroy_or_transfer<T1>(arg1, arg8);
        let v8 = HopRecord{out_amount: v5};
        0x2::event::emit<HopRecord>(v8);
        (0x2::coin::from_balance<T0>(v4, arg8), v5)
    }

    fun merge_coins<T0>(arg0: vector<0x2::coin::Coin<T0>>, arg1: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        if (0x1::vector::is_empty<0x2::coin::Coin<T0>>(&arg0)) {
            0x1::vector::destroy_empty<0x2::coin::Coin<T0>>(arg0);
            0x2::coin::zero<T0>(arg1)
        } else {
            let v1 = 0x1::vector::pop_back<0x2::coin::Coin<T0>>(&mut arg0);
            0x2::pay::join_vec<T0>(&mut v1, arg0);
            v1
        }
    }

    public fun movepump_buy_returns<T0>(arg0: &mut 0x92fecee99603c0628ced2fbd37f85c05f6c0049c183eb6b1b58db24764c6c7bc::move_pump::Configuration, arg1: 0x2::coin::Coin<0x2::sui::SUI>, arg2: &mut 0xb24b6789e088b876afabca733bed2299fbc9e2d6369be4d1acfa17d8145454d9::swap::Dex_Info, arg3: u64, arg4: &0x2::clock::Clock, arg5: u64, arg6: u8, arg7: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T0>, u64) {
        let (v0, v1) = 0x92fecee99603c0628ced2fbd37f85c05f6c0049c183eb6b1b58db24764c6c7bc::move_pump::buy_returns<T0>(arg0, arg1, arg2, arg3, arg4, arg7);
        let v2 = v1;
        destroy_or_transfer<0x2::sui::SUI>(v0, arg7);
        let v3 = 0x2::coin::value<T0>(&v2);
        let v4 = HopRecord{out_amount: v3};
        0x2::event::emit<HopRecord>(v4);
        (v2, v3)
    }

    public fun movepump_sell_returns<T0>(arg0: &mut 0x92fecee99603c0628ced2fbd37f85c05f6c0049c183eb6b1b58db24764c6c7bc::move_pump::Configuration, arg1: 0x2::coin::Coin<T0>, arg2: u64, arg3: &0x2::clock::Clock, arg4: u64, arg5: u8, arg6: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<0x2::sui::SUI>, u64) {
        let (v0, v1) = 0x92fecee99603c0628ced2fbd37f85c05f6c0049c183eb6b1b58db24764c6c7bc::move_pump::sell_returns<T0>(arg0, arg1, arg2, arg3, arg6);
        let v2 = v0;
        destroy_or_transfer<T0>(v1, arg6);
        let v3 = 0x2::coin::value<0x2::sui::SUI>(&v2);
        let v4 = HopRecord{out_amount: v3};
        0x2::event::emit<HopRecord>(v4);
        (v2, v3)
    }

    public fun split_with_percentage<T0>(arg0: &mut 0x2::coin::Coin<T0>, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T0>, u64, 0x2::coin::Coin<T0>, u64) {
        assert!(arg1 <= 10000, 2);
        let v0 = 0x2::coin::value<T0>(arg0);
        let v1 = (((v0 as u128) * (arg1 as u128) / (10000 as u128)) as u64);
        (0x2::coin::split<T0>(arg0, v1, arg2), v1, 0x2::coin::split<T0>(arg0, v0 - v1, arg2), v0 - v1)
    }

    public fun split_with_percentage_for_commission<T0>(arg0: &mut 0x2::coin::Coin<T0>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T0>, u64) {
        assert!(arg1 <= 300, 3);
        assert!(arg1 == 0 || arg1 > 0 && arg2 != @0x0, 5);
        let (v0, v1, v2, v3) = split_with_percentage<T0>(arg0, arg1, arg3);
        if (v1 == 0) {
            0x2::coin::destroy_zero<T0>(v0);
        } else {
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(v0, arg2);
            let v4 = CommissionRecord{
                commission_amount : v1,
                referral_address  : arg2,
            };
            0x2::event::emit<CommissionRecord>(v4);
        };
        (v2, v3)
    }

    public fun suiswap_x_2_y_with_return<T0, T1>(arg0: &mut 0x361dd589b98e8fcda9a7ee53b85efabef3569d00416640d2faa516e3801d7ffc::pool::Pool<T0, T1>, arg1: vector<0x2::coin::Coin<T0>>, arg2: u64, arg3: u64, arg4: &0x2::clock::Clock, arg5: u64, arg6: u8, arg7: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T1>, u64) {
        let (v0, v1) = 0x361dd589b98e8fcda9a7ee53b85efabef3569d00416640d2faa516e3801d7ffc::pool::do_swap_x_to_y_direct<T0, T1>(arg0, arg1, arg2, arg4, arg7);
        let v2 = v1;
        assert!(0x2::coin::value<T1>(&v2) >= arg3, 4);
        destroy_or_transfer<T0>(v0, arg7);
        let v3 = 0x2::coin::value<T1>(&v2);
        let v4 = HopRecord{out_amount: v3};
        0x2::event::emit<HopRecord>(v4);
        (v2, v3)
    }

    public fun suiswap_y_2_x_with_return<T0, T1>(arg0: &mut 0x361dd589b98e8fcda9a7ee53b85efabef3569d00416640d2faa516e3801d7ffc::pool::Pool<T0, T1>, arg1: vector<0x2::coin::Coin<T1>>, arg2: u64, arg3: u64, arg4: &0x2::clock::Clock, arg5: u64, arg6: u8, arg7: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T0>, u64) {
        let (v0, v1) = 0x361dd589b98e8fcda9a7ee53b85efabef3569d00416640d2faa516e3801d7ffc::pool::do_swap_y_to_x_direct<T0, T1>(arg0, arg1, arg2, arg4, arg7);
        let v2 = v1;
        assert!(0x2::coin::value<T0>(&v2) >= arg3, 4);
        destroy_or_transfer<T1>(v0, arg7);
        let v3 = 0x2::coin::value<T0>(&v2);
        let v4 = HopRecord{out_amount: v3};
        0x2::event::emit<HopRecord>(v4);
        (v2, v3)
    }

    fun swapWithReturn<T0, T1>(arg0: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg1: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg2: vector<0x2::coin::Coin<T0>>, arg3: vector<0x2::coin::Coin<T1>>, arg4: bool, arg5: bool, arg6: u64, arg7: u64, arg8: u128, arg9: &0x2::clock::Clock, arg10: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T0>, 0x2::coin::Coin<T1>) {
        let v0 = merge_coins<T0>(arg2, arg10);
        let v1 = merge_coins<T1>(arg3, arg10);
        let (v2, v3, v4) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::flash_swap<T0, T1>(arg0, arg1, arg4, arg5, arg6, arg8, arg9);
        let v5 = v4;
        let v6 = v3;
        let v7 = v2;
        if (arg4) {
        };
        let (v8, v9) = if (arg4) {
            (0x2::coin::into_balance<T0>(0x2::coin::split<T0>(&mut v0, 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::swap_pay_amount<T0, T1>(&v5), arg10)), 0x2::balance::zero<T1>())
        } else {
            (0x2::balance::zero<T0>(), 0x2::coin::into_balance<T1>(0x2::coin::split<T1>(&mut v1, 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::swap_pay_amount<T0, T1>(&v5), arg10)))
        };
        0x2::coin::join<T1>(&mut v1, 0x2::coin::from_balance<T1>(v6, arg10));
        0x2::coin::join<T0>(&mut v0, 0x2::coin::from_balance<T0>(v7, arg10));
        0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::repay_flash_swap<T0, T1>(arg0, arg1, v8, v9, v5);
        if (arg4) {
            if (0x2::coin::value<T1>(&v1) < arg7) {
                abort 9
            };
        } else if (0x2::coin::value<T0>(&v0) < arg7) {
            abort 9
        };
        (v0, v1)
    }

    public fun turbos_swap_a_b_with_return<T0, T1, T2>(arg0: &mut 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Pool<T0, T1, T2>, arg1: vector<0x2::coin::Coin<T0>>, arg2: u64, arg3: u64, arg4: u128, arg5: bool, arg6: address, arg7: u64, arg8: &0x2::clock::Clock, arg9: &0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Versioned, arg10: u64, arg11: u8, arg12: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T1>, u64) {
        0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::check_version(arg9);
        let (v0, v1) = 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::swap_router::swap_a_b_with_return_<T0, T1, T2>(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg12);
        let v2 = v0;
        destroy_or_transfer<T0>(v1, arg12);
        let v3 = 0x2::coin::value<T1>(&v2);
        let v4 = HopRecord{out_amount: v3};
        0x2::event::emit<HopRecord>(v4);
        (v2, v3)
    }

    public fun turbos_swap_b_a_with_return<T0, T1, T2>(arg0: &mut 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Pool<T0, T1, T2>, arg1: vector<0x2::coin::Coin<T1>>, arg2: u64, arg3: u64, arg4: u128, arg5: bool, arg6: address, arg7: u64, arg8: &0x2::clock::Clock, arg9: &0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Versioned, arg10: u64, arg11: u8, arg12: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T0>, u64) {
        0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::check_version(arg9);
        let (v0, v1) = 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::swap_router::swap_b_a_with_return_<T0, T1, T2>(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg12);
        let v2 = v0;
        destroy_or_transfer<T1>(v1, arg12);
        let v3 = 0x2::coin::value<T0>(&v2);
        let v4 = HopRecord{out_amount: v3};
        0x2::event::emit<HopRecord>(v4);
        (v2, v3)
    }

    // decompiled from Move bytecode v6
}

