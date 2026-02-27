module 0xda32b3a45a9c5250435187226db7ab2f3105e22ffde135b0bcbcf3530f502bd5::two_hop {
    entry fun arb_cetus_to_aftermath<T0, T1, T2>(arg0: &0xda32b3a45a9c5250435187226db7ab2f3105e22ffde135b0bcbcf3530f502bd5::admin::AdminCap, arg1: &0xda32b3a45a9c5250435187226db7ab2f3105e22ffde135b0bcbcf3530f502bd5::admin::PauseFlag, arg2: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg3: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg4: &mut 0xefe170ec0be4d762196bedecd7a065816576198a6527c99282a2551aaa7da38c::pool::Pool<T2>, arg5: &0xefe170ec0be4d762196bedecd7a065816576198a6527c99282a2551aaa7da38c::pool_registry::PoolRegistry, arg6: &0x2d9316f1f1a95f6d7c85a4e690ef7c359e6649773ef2c37ad7d9857adb6bef06::vault::ProtocolFeeVault, arg7: &mut 0x64213b0e4a52bac468d4ac3f140242f70714381653a1919a6d57cd49c628207a::treasury::Treasury, arg8: &mut 0xa6baab1e668c7868991c1c3c11e144100f5734c407d020f72a01b9d1a8bcb97f::insurance_fund::InsuranceFund, arg9: &0xc66fabf1a9253e43c70f1cc02d40a1d18db183140ecaae2a3f58fa6b66c55acf::referral_vault::ReferralVault, arg10: u64, arg11: u64, arg12: &0x2::clock::Clock, arg13: &mut 0x2::tx_context::TxContext) {
        assert!(arg10 > 0, 1);
        0xda32b3a45a9c5250435187226db7ab2f3105e22ffde135b0bcbcf3530f502bd5::admin::assert_not_paused(arg1);
        let (v0, v1, v2) = 0xda32b3a45a9c5250435187226db7ab2f3105e22ffde135b0bcbcf3530f502bd5::cetus_adapter::flash_swap_a2b<T0, T1>(arg2, arg3, arg10, arg12);
        let v3 = v2;
        0x2::balance::destroy_zero<T0>(v0);
        let v4 = 0xda32b3a45a9c5250435187226db7ab2f3105e22ffde135b0bcbcf3530f502bd5::aftermath_adapter::swap_exact_in<T2, T1, T0>(arg4, arg5, arg6, arg7, arg8, arg9, 0x2::coin::from_balance<T1>(v1, arg13), 1, 18446744073709551615, arg13);
        let v5 = 0xda32b3a45a9c5250435187226db7ab2f3105e22ffde135b0bcbcf3530f502bd5::cetus_adapter::swap_pay_amount<T0, T1>(&v3);
        let v6 = 0x2::coin::value<T0>(&v4);
        0xda32b3a45a9c5250435187226db7ab2f3105e22ffde135b0bcbcf3530f502bd5::profit::assert_profit(v6, v5, arg11);
        0xda32b3a45a9c5250435187226db7ab2f3105e22ffde135b0bcbcf3530f502bd5::cetus_adapter::repay_flash_swap<T0, T1>(arg2, arg3, 0x2::coin::into_balance<T0>(0x2::coin::split<T0>(&mut v4, v5, arg13)), 0x2::balance::zero<T1>(), v3);
        0xda32b3a45a9c5250435187226db7ab2f3105e22ffde135b0bcbcf3530f502bd5::events::emit_arb_executed(b"cetus_to_aftermath", v5, v6);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(v4, 0x2::tx_context::sender(arg13));
    }

    entry fun arb_cetus_to_aftermath_rev<T0, T1, T2>(arg0: &0xda32b3a45a9c5250435187226db7ab2f3105e22ffde135b0bcbcf3530f502bd5::admin::AdminCap, arg1: &0xda32b3a45a9c5250435187226db7ab2f3105e22ffde135b0bcbcf3530f502bd5::admin::PauseFlag, arg2: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg3: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg4: &mut 0xefe170ec0be4d762196bedecd7a065816576198a6527c99282a2551aaa7da38c::pool::Pool<T2>, arg5: &0xefe170ec0be4d762196bedecd7a065816576198a6527c99282a2551aaa7da38c::pool_registry::PoolRegistry, arg6: &0x2d9316f1f1a95f6d7c85a4e690ef7c359e6649773ef2c37ad7d9857adb6bef06::vault::ProtocolFeeVault, arg7: &mut 0x64213b0e4a52bac468d4ac3f140242f70714381653a1919a6d57cd49c628207a::treasury::Treasury, arg8: &mut 0xa6baab1e668c7868991c1c3c11e144100f5734c407d020f72a01b9d1a8bcb97f::insurance_fund::InsuranceFund, arg9: &0xc66fabf1a9253e43c70f1cc02d40a1d18db183140ecaae2a3f58fa6b66c55acf::referral_vault::ReferralVault, arg10: u64, arg11: u64, arg12: &0x2::clock::Clock, arg13: &mut 0x2::tx_context::TxContext) {
        assert!(arg10 > 0, 1);
        0xda32b3a45a9c5250435187226db7ab2f3105e22ffde135b0bcbcf3530f502bd5::admin::assert_not_paused(arg1);
        let (v0, v1, v2) = 0xda32b3a45a9c5250435187226db7ab2f3105e22ffde135b0bcbcf3530f502bd5::cetus_adapter::flash_swap_b2a<T0, T1>(arg2, arg3, arg10, arg12);
        let v3 = v2;
        0x2::balance::destroy_zero<T1>(v1);
        let v4 = 0xda32b3a45a9c5250435187226db7ab2f3105e22ffde135b0bcbcf3530f502bd5::aftermath_adapter::swap_exact_in<T2, T0, T1>(arg4, arg5, arg6, arg7, arg8, arg9, 0x2::coin::from_balance<T0>(v0, arg13), 1, 18446744073709551615, arg13);
        let v5 = 0xda32b3a45a9c5250435187226db7ab2f3105e22ffde135b0bcbcf3530f502bd5::cetus_adapter::swap_pay_amount<T0, T1>(&v3);
        let v6 = 0x2::coin::value<T1>(&v4);
        0xda32b3a45a9c5250435187226db7ab2f3105e22ffde135b0bcbcf3530f502bd5::profit::assert_profit(v6, v5, arg11);
        0xda32b3a45a9c5250435187226db7ab2f3105e22ffde135b0bcbcf3530f502bd5::cetus_adapter::repay_flash_swap<T0, T1>(arg2, arg3, 0x2::balance::zero<T0>(), 0x2::coin::into_balance<T1>(0x2::coin::split<T1>(&mut v4, v5, arg13)), v3);
        0xda32b3a45a9c5250435187226db7ab2f3105e22ffde135b0bcbcf3530f502bd5::events::emit_arb_executed(b"cetus_to_aftermath_rev", v5, v6);
        0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(v4, 0x2::tx_context::sender(arg13));
    }

    entry fun arb_cetus_to_deepbook<T0, T1>(arg0: &0xda32b3a45a9c5250435187226db7ab2f3105e22ffde135b0bcbcf3530f502bd5::admin::AdminCap, arg1: &0xda32b3a45a9c5250435187226db7ab2f3105e22ffde135b0bcbcf3530f502bd5::admin::PauseFlag, arg2: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg3: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg4: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T0, T1>, arg5: 0x2::coin::Coin<0xdeeb7a4662eec9f2f3def03fb937a663dddaa2e215b8078a284d026b7946c270::deep::DEEP>, arg6: u64, arg7: u64, arg8: &0x2::clock::Clock, arg9: &mut 0x2::tx_context::TxContext) {
        assert!(arg6 > 0, 1);
        0xda32b3a45a9c5250435187226db7ab2f3105e22ffde135b0bcbcf3530f502bd5::admin::assert_not_paused(arg1);
        let (v0, v1, v2) = 0xda32b3a45a9c5250435187226db7ab2f3105e22ffde135b0bcbcf3530f502bd5::cetus_adapter::flash_swap_a2b<T0, T1>(arg2, arg3, arg6, arg8);
        let v3 = v2;
        0x2::balance::destroy_zero<T0>(v0);
        let v4 = 0xda32b3a45a9c5250435187226db7ab2f3105e22ffde135b0bcbcf3530f502bd5::deepbook_adapter::swap_quote_for_base_cleanup<T0, T1>(arg4, 0x2::coin::from_balance<T1>(v1, arg9), arg5, arg8, arg9);
        let v5 = 0xda32b3a45a9c5250435187226db7ab2f3105e22ffde135b0bcbcf3530f502bd5::cetus_adapter::swap_pay_amount<T0, T1>(&v3);
        let v6 = 0x2::coin::value<T0>(&v4);
        0xda32b3a45a9c5250435187226db7ab2f3105e22ffde135b0bcbcf3530f502bd5::profit::assert_profit(v6, v5, arg7);
        0xda32b3a45a9c5250435187226db7ab2f3105e22ffde135b0bcbcf3530f502bd5::cetus_adapter::repay_flash_swap<T0, T1>(arg2, arg3, 0x2::coin::into_balance<T0>(0x2::coin::split<T0>(&mut v4, v5, arg9)), 0x2::balance::zero<T1>(), v3);
        0xda32b3a45a9c5250435187226db7ab2f3105e22ffde135b0bcbcf3530f502bd5::events::emit_arb_executed(b"cetus_to_deepbook", v5, v6);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(v4, 0x2::tx_context::sender(arg9));
    }

    entry fun arb_cetus_to_flowx_clmm<T0, T1>(arg0: &0xda32b3a45a9c5250435187226db7ab2f3105e22ffde135b0bcbcf3530f502bd5::admin::AdminCap, arg1: &0xda32b3a45a9c5250435187226db7ab2f3105e22ffde135b0bcbcf3530f502bd5::admin::PauseFlag, arg2: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg3: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg4: &mut 0x25929e7f29e0a30eb4e692952ba1b5b65a3a4d65ab5f2a32e1ba3edcb587f26d::pool::Pool<T0, T1>, arg5: &0x25929e7f29e0a30eb4e692952ba1b5b65a3a4d65ab5f2a32e1ba3edcb587f26d::versioned::Versioned, arg6: u64, arg7: u64, arg8: &0x2::clock::Clock, arg9: &mut 0x2::tx_context::TxContext) {
        assert!(arg6 > 0, 1);
        0xda32b3a45a9c5250435187226db7ab2f3105e22ffde135b0bcbcf3530f502bd5::admin::assert_not_paused(arg1);
        let (v0, v1, v2) = 0xda32b3a45a9c5250435187226db7ab2f3105e22ffde135b0bcbcf3530f502bd5::cetus_adapter::flash_swap_a2b<T0, T1>(arg2, arg3, arg6, arg8);
        let v3 = v2;
        0x2::balance::destroy_zero<T0>(v0);
        let v4 = 0xda32b3a45a9c5250435187226db7ab2f3105e22ffde135b0bcbcf3530f502bd5::flowx_clmm_adapter::swap_coin_b2a<T0, T1>(arg4, 0x2::coin::from_balance<T1>(v1, arg9), arg5, arg8, arg9);
        let v5 = 0xda32b3a45a9c5250435187226db7ab2f3105e22ffde135b0bcbcf3530f502bd5::cetus_adapter::swap_pay_amount<T0, T1>(&v3);
        let v6 = 0x2::coin::value<T0>(&v4);
        0xda32b3a45a9c5250435187226db7ab2f3105e22ffde135b0bcbcf3530f502bd5::profit::assert_profit(v6, v5, arg7);
        0xda32b3a45a9c5250435187226db7ab2f3105e22ffde135b0bcbcf3530f502bd5::cetus_adapter::repay_flash_swap<T0, T1>(arg2, arg3, 0x2::coin::into_balance<T0>(0x2::coin::split<T0>(&mut v4, v5, arg9)), 0x2::balance::zero<T1>(), v3);
        0xda32b3a45a9c5250435187226db7ab2f3105e22ffde135b0bcbcf3530f502bd5::events::emit_arb_executed(b"cetus_to_flowx_clmm", v5, v6);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(v4, 0x2::tx_context::sender(arg9));
    }

    entry fun arb_cetus_to_turbos<T0, T1, T2>(arg0: &0xda32b3a45a9c5250435187226db7ab2f3105e22ffde135b0bcbcf3530f502bd5::admin::AdminCap, arg1: &0xda32b3a45a9c5250435187226db7ab2f3105e22ffde135b0bcbcf3530f502bd5::admin::PauseFlag, arg2: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg3: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg4: &mut 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Pool<T0, T1, T2>, arg5: &0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Versioned, arg6: u64, arg7: u64, arg8: &0x2::clock::Clock, arg9: &mut 0x2::tx_context::TxContext) {
        assert!(arg6 > 0, 1);
        0xda32b3a45a9c5250435187226db7ab2f3105e22ffde135b0bcbcf3530f502bd5::admin::assert_not_paused(arg1);
        let (v0, v1, v2) = 0xda32b3a45a9c5250435187226db7ab2f3105e22ffde135b0bcbcf3530f502bd5::cetus_adapter::flash_swap_a2b<T0, T1>(arg2, arg3, arg6, arg8);
        let v3 = v2;
        0x2::balance::destroy_zero<T0>(v0);
        let v4 = 0x2::coin::from_balance<T1>(v1, arg9);
        let v5 = 0xda32b3a45a9c5250435187226db7ab2f3105e22ffde135b0bcbcf3530f502bd5::turbos_adapter::swap_b_to_a<T0, T1, T2>(arg4, v4, 0x2::coin::value<T1>(&v4), arg8, arg5, arg9);
        let v6 = 0xda32b3a45a9c5250435187226db7ab2f3105e22ffde135b0bcbcf3530f502bd5::cetus_adapter::swap_pay_amount<T0, T1>(&v3);
        let v7 = 0x2::coin::value<T0>(&v5);
        0xda32b3a45a9c5250435187226db7ab2f3105e22ffde135b0bcbcf3530f502bd5::profit::assert_profit(v7, v6, arg7);
        0xda32b3a45a9c5250435187226db7ab2f3105e22ffde135b0bcbcf3530f502bd5::cetus_adapter::repay_flash_swap<T0, T1>(arg2, arg3, 0x2::coin::into_balance<T0>(0x2::coin::split<T0>(&mut v5, v6, arg9)), 0x2::balance::zero<T1>(), v3);
        0xda32b3a45a9c5250435187226db7ab2f3105e22ffde135b0bcbcf3530f502bd5::events::emit_arb_executed(b"cetus_to_turbos", v6, v7);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(v5, 0x2::tx_context::sender(arg9));
    }

    entry fun arb_cetus_to_turbos_reverse<T0, T1, T2>(arg0: &0xda32b3a45a9c5250435187226db7ab2f3105e22ffde135b0bcbcf3530f502bd5::admin::AdminCap, arg1: &0xda32b3a45a9c5250435187226db7ab2f3105e22ffde135b0bcbcf3530f502bd5::admin::PauseFlag, arg2: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg3: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg4: &mut 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Pool<T0, T1, T2>, arg5: &0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Versioned, arg6: u64, arg7: u64, arg8: &0x2::clock::Clock, arg9: &mut 0x2::tx_context::TxContext) {
        assert!(arg6 > 0, 1);
        0xda32b3a45a9c5250435187226db7ab2f3105e22ffde135b0bcbcf3530f502bd5::admin::assert_not_paused(arg1);
        let (v0, v1, v2) = 0xda32b3a45a9c5250435187226db7ab2f3105e22ffde135b0bcbcf3530f502bd5::cetus_adapter::flash_swap_b2a<T0, T1>(arg2, arg3, arg6, arg8);
        let v3 = v2;
        0x2::balance::destroy_zero<T1>(v1);
        let v4 = 0x2::coin::from_balance<T0>(v0, arg9);
        let v5 = 0xda32b3a45a9c5250435187226db7ab2f3105e22ffde135b0bcbcf3530f502bd5::turbos_adapter::swap_a_to_b<T0, T1, T2>(arg4, v4, 0x2::coin::value<T0>(&v4), arg8, arg5, arg9);
        let v6 = 0xda32b3a45a9c5250435187226db7ab2f3105e22ffde135b0bcbcf3530f502bd5::cetus_adapter::swap_pay_amount<T0, T1>(&v3);
        let v7 = 0x2::coin::value<T1>(&v5);
        0xda32b3a45a9c5250435187226db7ab2f3105e22ffde135b0bcbcf3530f502bd5::profit::assert_profit(v7, v6, arg7);
        0xda32b3a45a9c5250435187226db7ab2f3105e22ffde135b0bcbcf3530f502bd5::cetus_adapter::repay_flash_swap<T0, T1>(arg2, arg3, 0x2::balance::zero<T0>(), 0x2::coin::into_balance<T1>(0x2::coin::split<T1>(&mut v5, v6, arg9)), v3);
        0xda32b3a45a9c5250435187226db7ab2f3105e22ffde135b0bcbcf3530f502bd5::events::emit_arb_executed(b"cetus_to_turbos_rev", v6, v7);
        0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(v5, 0x2::tx_context::sender(arg9));
    }

    entry fun arb_deepbook_to_aftermath<T0, T1, T2>(arg0: &0xda32b3a45a9c5250435187226db7ab2f3105e22ffde135b0bcbcf3530f502bd5::admin::AdminCap, arg1: &0xda32b3a45a9c5250435187226db7ab2f3105e22ffde135b0bcbcf3530f502bd5::admin::PauseFlag, arg2: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T0, T1>, arg3: 0x2::coin::Coin<0xdeeb7a4662eec9f2f3def03fb937a663dddaa2e215b8078a284d026b7946c270::deep::DEEP>, arg4: &mut 0xefe170ec0be4d762196bedecd7a065816576198a6527c99282a2551aaa7da38c::pool::Pool<T2>, arg5: &0xefe170ec0be4d762196bedecd7a065816576198a6527c99282a2551aaa7da38c::pool_registry::PoolRegistry, arg6: &0x2d9316f1f1a95f6d7c85a4e690ef7c359e6649773ef2c37ad7d9857adb6bef06::vault::ProtocolFeeVault, arg7: &mut 0x64213b0e4a52bac468d4ac3f140242f70714381653a1919a6d57cd49c628207a::treasury::Treasury, arg8: &mut 0xa6baab1e668c7868991c1c3c11e144100f5734c407d020f72a01b9d1a8bcb97f::insurance_fund::InsuranceFund, arg9: &0xc66fabf1a9253e43c70f1cc02d40a1d18db183140ecaae2a3f58fa6b66c55acf::referral_vault::ReferralVault, arg10: u64, arg11: u64, arg12: &0x2::clock::Clock, arg13: &mut 0x2::tx_context::TxContext) {
        assert!(arg10 > 0, 1);
        0xda32b3a45a9c5250435187226db7ab2f3105e22ffde135b0bcbcf3530f502bd5::admin::assert_not_paused(arg1);
        let (v0, v1) = 0xda32b3a45a9c5250435187226db7ab2f3105e22ffde135b0bcbcf3530f502bd5::deepbook_adapter::flash_borrow_base<T0, T1>(arg2, arg10, arg13);
        let v2 = 0xda32b3a45a9c5250435187226db7ab2f3105e22ffde135b0bcbcf3530f502bd5::deepbook_adapter::swap_quote_for_base_cleanup<T0, T1>(arg2, 0xda32b3a45a9c5250435187226db7ab2f3105e22ffde135b0bcbcf3530f502bd5::aftermath_adapter::swap_exact_in<T2, T0, T1>(arg4, arg5, arg6, arg7, arg8, arg9, v0, 1, 18446744073709551615, arg13), arg3, arg12, arg13);
        let v3 = 0x2::coin::value<T0>(&v2);
        0xda32b3a45a9c5250435187226db7ab2f3105e22ffde135b0bcbcf3530f502bd5::profit::assert_profit(v3, arg10, arg11);
        0xda32b3a45a9c5250435187226db7ab2f3105e22ffde135b0bcbcf3530f502bd5::deepbook_adapter::flash_return_base<T0, T1>(arg2, 0x2::coin::split<T0>(&mut v2, arg10, arg13), v1);
        0xda32b3a45a9c5250435187226db7ab2f3105e22ffde135b0bcbcf3530f502bd5::events::emit_arb_executed(b"deepbook_to_aftermath", arg10, v3);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(v2, 0x2::tx_context::sender(arg13));
    }

    entry fun arb_deepbook_to_cetus<T0, T1>(arg0: &0xda32b3a45a9c5250435187226db7ab2f3105e22ffde135b0bcbcf3530f502bd5::admin::AdminCap, arg1: &0xda32b3a45a9c5250435187226db7ab2f3105e22ffde135b0bcbcf3530f502bd5::admin::PauseFlag, arg2: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg3: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg4: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T0, T1>, arg5: 0x2::coin::Coin<0xdeeb7a4662eec9f2f3def03fb937a663dddaa2e215b8078a284d026b7946c270::deep::DEEP>, arg6: u64, arg7: u64, arg8: &0x2::clock::Clock, arg9: &mut 0x2::tx_context::TxContext) {
        assert!(arg6 > 0, 1);
        0xda32b3a45a9c5250435187226db7ab2f3105e22ffde135b0bcbcf3530f502bd5::admin::assert_not_paused(arg1);
        let (v0, v1) = 0xda32b3a45a9c5250435187226db7ab2f3105e22ffde135b0bcbcf3530f502bd5::deepbook_adapter::flash_borrow_base<T0, T1>(arg4, arg6, arg9);
        let v2 = 0xda32b3a45a9c5250435187226db7ab2f3105e22ffde135b0bcbcf3530f502bd5::deepbook_adapter::swap_quote_for_base_cleanup<T0, T1>(arg4, 0xda32b3a45a9c5250435187226db7ab2f3105e22ffde135b0bcbcf3530f502bd5::cetus_adapter::swap_coin_a2b<T0, T1>(arg2, arg3, v0, arg8, arg9), arg5, arg8, arg9);
        let v3 = 0x2::coin::value<T0>(&v2);
        0xda32b3a45a9c5250435187226db7ab2f3105e22ffde135b0bcbcf3530f502bd5::profit::assert_profit(v3, arg6, arg7);
        0xda32b3a45a9c5250435187226db7ab2f3105e22ffde135b0bcbcf3530f502bd5::deepbook_adapter::flash_return_base<T0, T1>(arg4, 0x2::coin::split<T0>(&mut v2, arg6, arg9), v1);
        0xda32b3a45a9c5250435187226db7ab2f3105e22ffde135b0bcbcf3530f502bd5::events::emit_arb_executed(b"deepbook_to_cetus", arg6, v3);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(v2, 0x2::tx_context::sender(arg9));
    }

    entry fun arb_deepbook_to_flowx_clmm<T0, T1>(arg0: &0xda32b3a45a9c5250435187226db7ab2f3105e22ffde135b0bcbcf3530f502bd5::admin::AdminCap, arg1: &0xda32b3a45a9c5250435187226db7ab2f3105e22ffde135b0bcbcf3530f502bd5::admin::PauseFlag, arg2: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T0, T1>, arg3: 0x2::coin::Coin<0xdeeb7a4662eec9f2f3def03fb937a663dddaa2e215b8078a284d026b7946c270::deep::DEEP>, arg4: &mut 0x25929e7f29e0a30eb4e692952ba1b5b65a3a4d65ab5f2a32e1ba3edcb587f26d::pool::Pool<T0, T1>, arg5: &0x25929e7f29e0a30eb4e692952ba1b5b65a3a4d65ab5f2a32e1ba3edcb587f26d::versioned::Versioned, arg6: u64, arg7: u64, arg8: &0x2::clock::Clock, arg9: &mut 0x2::tx_context::TxContext) {
        assert!(arg6 > 0, 1);
        0xda32b3a45a9c5250435187226db7ab2f3105e22ffde135b0bcbcf3530f502bd5::admin::assert_not_paused(arg1);
        let (v0, v1) = 0xda32b3a45a9c5250435187226db7ab2f3105e22ffde135b0bcbcf3530f502bd5::deepbook_adapter::flash_borrow_base<T0, T1>(arg2, arg6, arg9);
        let v2 = 0xda32b3a45a9c5250435187226db7ab2f3105e22ffde135b0bcbcf3530f502bd5::deepbook_adapter::swap_quote_for_base_cleanup<T0, T1>(arg2, 0xda32b3a45a9c5250435187226db7ab2f3105e22ffde135b0bcbcf3530f502bd5::flowx_clmm_adapter::swap_coin_a2b<T0, T1>(arg4, v0, arg5, arg8, arg9), arg3, arg8, arg9);
        let v3 = 0x2::coin::value<T0>(&v2);
        0xda32b3a45a9c5250435187226db7ab2f3105e22ffde135b0bcbcf3530f502bd5::profit::assert_profit(v3, arg6, arg7);
        0xda32b3a45a9c5250435187226db7ab2f3105e22ffde135b0bcbcf3530f502bd5::deepbook_adapter::flash_return_base<T0, T1>(arg2, 0x2::coin::split<T0>(&mut v2, arg6, arg9), v1);
        0xda32b3a45a9c5250435187226db7ab2f3105e22ffde135b0bcbcf3530f502bd5::events::emit_arb_executed(b"deepbook_to_flowx_clmm", arg6, v3);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(v2, 0x2::tx_context::sender(arg9));
    }

    entry fun arb_deepbook_to_turbos<T0, T1, T2>(arg0: &0xda32b3a45a9c5250435187226db7ab2f3105e22ffde135b0bcbcf3530f502bd5::admin::AdminCap, arg1: &0xda32b3a45a9c5250435187226db7ab2f3105e22ffde135b0bcbcf3530f502bd5::admin::PauseFlag, arg2: &mut 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Pool<T0, T1, T2>, arg3: &0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Versioned, arg4: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T0, T1>, arg5: 0x2::coin::Coin<0xdeeb7a4662eec9f2f3def03fb937a663dddaa2e215b8078a284d026b7946c270::deep::DEEP>, arg6: u64, arg7: u64, arg8: &0x2::clock::Clock, arg9: &mut 0x2::tx_context::TxContext) {
        assert!(arg6 > 0, 1);
        0xda32b3a45a9c5250435187226db7ab2f3105e22ffde135b0bcbcf3530f502bd5::admin::assert_not_paused(arg1);
        let (v0, v1) = 0xda32b3a45a9c5250435187226db7ab2f3105e22ffde135b0bcbcf3530f502bd5::deepbook_adapter::flash_borrow_base<T0, T1>(arg4, arg6, arg9);
        let v2 = 0xda32b3a45a9c5250435187226db7ab2f3105e22ffde135b0bcbcf3530f502bd5::deepbook_adapter::swap_quote_for_base_cleanup<T0, T1>(arg4, 0xda32b3a45a9c5250435187226db7ab2f3105e22ffde135b0bcbcf3530f502bd5::turbos_adapter::swap_a_to_b<T0, T1, T2>(arg2, v0, arg6, arg8, arg3, arg9), arg5, arg8, arg9);
        let v3 = 0x2::coin::value<T0>(&v2);
        0xda32b3a45a9c5250435187226db7ab2f3105e22ffde135b0bcbcf3530f502bd5::profit::assert_profit(v3, arg6, arg7);
        0xda32b3a45a9c5250435187226db7ab2f3105e22ffde135b0bcbcf3530f502bd5::deepbook_adapter::flash_return_base<T0, T1>(arg4, 0x2::coin::split<T0>(&mut v2, arg6, arg9), v1);
        0xda32b3a45a9c5250435187226db7ab2f3105e22ffde135b0bcbcf3530f502bd5::events::emit_arb_executed(b"deepbook_to_turbos", arg6, v3);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(v2, 0x2::tx_context::sender(arg9));
    }

    entry fun arb_flowx_clmm_to_cetus<T0, T1>(arg0: &0xda32b3a45a9c5250435187226db7ab2f3105e22ffde135b0bcbcf3530f502bd5::admin::AdminCap, arg1: &0xda32b3a45a9c5250435187226db7ab2f3105e22ffde135b0bcbcf3530f502bd5::admin::PauseFlag, arg2: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg3: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg4: &mut 0x25929e7f29e0a30eb4e692952ba1b5b65a3a4d65ab5f2a32e1ba3edcb587f26d::pool::Pool<T0, T1>, arg5: &0x25929e7f29e0a30eb4e692952ba1b5b65a3a4d65ab5f2a32e1ba3edcb587f26d::versioned::Versioned, arg6: u64, arg7: u64, arg8: &0x2::clock::Clock, arg9: &mut 0x2::tx_context::TxContext) {
        assert!(arg6 > 0, 1);
        0xda32b3a45a9c5250435187226db7ab2f3105e22ffde135b0bcbcf3530f502bd5::admin::assert_not_paused(arg1);
        let (v0, v1, v2) = 0xda32b3a45a9c5250435187226db7ab2f3105e22ffde135b0bcbcf3530f502bd5::flowx_clmm_adapter::swap_a2b<T0, T1>(arg4, arg6, arg5, arg8, arg9);
        let v3 = v1;
        0x2::balance::destroy_zero<T0>(v0);
        let v4 = 0x2::coin::from_balance<T0>(0xda32b3a45a9c5250435187226db7ab2f3105e22ffde135b0bcbcf3530f502bd5::cetus_adapter::swap_b2a<T0, T1>(arg2, arg3, v3, 0x2::balance::value<T1>(&v3), arg8), arg9);
        let v5 = 0x2::coin::value<T0>(&v4);
        0xda32b3a45a9c5250435187226db7ab2f3105e22ffde135b0bcbcf3530f502bd5::profit::assert_profit(v5, arg6, arg7);
        0xda32b3a45a9c5250435187226db7ab2f3105e22ffde135b0bcbcf3530f502bd5::flowx_clmm_adapter::pay<T0, T1>(arg4, v2, 0x2::coin::into_balance<T0>(0x2::coin::split<T0>(&mut v4, arg6, arg9)), 0x2::balance::zero<T1>(), arg5, arg9);
        0xda32b3a45a9c5250435187226db7ab2f3105e22ffde135b0bcbcf3530f502bd5::events::emit_arb_executed(b"flowx_clmm_to_cetus", arg6, v5);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(v4, 0x2::tx_context::sender(arg9));
    }

    entry fun arb_flowx_clmm_to_deepbook<T0, T1>(arg0: &0xda32b3a45a9c5250435187226db7ab2f3105e22ffde135b0bcbcf3530f502bd5::admin::AdminCap, arg1: &0xda32b3a45a9c5250435187226db7ab2f3105e22ffde135b0bcbcf3530f502bd5::admin::PauseFlag, arg2: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T0, T1>, arg3: 0x2::coin::Coin<0xdeeb7a4662eec9f2f3def03fb937a663dddaa2e215b8078a284d026b7946c270::deep::DEEP>, arg4: &mut 0x25929e7f29e0a30eb4e692952ba1b5b65a3a4d65ab5f2a32e1ba3edcb587f26d::pool::Pool<T0, T1>, arg5: &0x25929e7f29e0a30eb4e692952ba1b5b65a3a4d65ab5f2a32e1ba3edcb587f26d::versioned::Versioned, arg6: u64, arg7: u64, arg8: &0x2::clock::Clock, arg9: &mut 0x2::tx_context::TxContext) {
        assert!(arg6 > 0, 1);
        0xda32b3a45a9c5250435187226db7ab2f3105e22ffde135b0bcbcf3530f502bd5::admin::assert_not_paused(arg1);
        let (v0, v1, v2) = 0xda32b3a45a9c5250435187226db7ab2f3105e22ffde135b0bcbcf3530f502bd5::flowx_clmm_adapter::swap_a2b<T0, T1>(arg4, arg6, arg5, arg8, arg9);
        0x2::balance::destroy_zero<T0>(v0);
        let v3 = 0xda32b3a45a9c5250435187226db7ab2f3105e22ffde135b0bcbcf3530f502bd5::deepbook_adapter::swap_quote_for_base_cleanup<T0, T1>(arg2, 0x2::coin::from_balance<T1>(v1, arg9), arg3, arg8, arg9);
        let v4 = 0x2::coin::value<T0>(&v3);
        0xda32b3a45a9c5250435187226db7ab2f3105e22ffde135b0bcbcf3530f502bd5::profit::assert_profit(v4, arg6, arg7);
        0xda32b3a45a9c5250435187226db7ab2f3105e22ffde135b0bcbcf3530f502bd5::flowx_clmm_adapter::pay<T0, T1>(arg4, v2, 0x2::coin::into_balance<T0>(0x2::coin::split<T0>(&mut v3, arg6, arg9)), 0x2::balance::zero<T1>(), arg5, arg9);
        0xda32b3a45a9c5250435187226db7ab2f3105e22ffde135b0bcbcf3530f502bd5::events::emit_arb_executed(b"flowx_clmm_to_deepbook", arg6, v4);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(v3, 0x2::tx_context::sender(arg9));
    }

    entry fun arb_flowx_clmm_to_turbos<T0, T1, T2>(arg0: &0xda32b3a45a9c5250435187226db7ab2f3105e22ffde135b0bcbcf3530f502bd5::admin::AdminCap, arg1: &0xda32b3a45a9c5250435187226db7ab2f3105e22ffde135b0bcbcf3530f502bd5::admin::PauseFlag, arg2: &mut 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Pool<T0, T1, T2>, arg3: &0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Versioned, arg4: &mut 0x25929e7f29e0a30eb4e692952ba1b5b65a3a4d65ab5f2a32e1ba3edcb587f26d::pool::Pool<T0, T1>, arg5: &0x25929e7f29e0a30eb4e692952ba1b5b65a3a4d65ab5f2a32e1ba3edcb587f26d::versioned::Versioned, arg6: u64, arg7: u64, arg8: &0x2::clock::Clock, arg9: &mut 0x2::tx_context::TxContext) {
        assert!(arg6 > 0, 1);
        0xda32b3a45a9c5250435187226db7ab2f3105e22ffde135b0bcbcf3530f502bd5::admin::assert_not_paused(arg1);
        let (v0, v1, v2) = 0xda32b3a45a9c5250435187226db7ab2f3105e22ffde135b0bcbcf3530f502bd5::flowx_clmm_adapter::swap_a2b<T0, T1>(arg4, arg6, arg5, arg8, arg9);
        0x2::balance::destroy_zero<T0>(v0);
        let v3 = 0x2::coin::from_balance<T1>(v1, arg9);
        let v4 = 0xda32b3a45a9c5250435187226db7ab2f3105e22ffde135b0bcbcf3530f502bd5::turbos_adapter::swap_b_to_a<T0, T1, T2>(arg2, v3, 0x2::coin::value<T1>(&v3), arg8, arg3, arg9);
        let v5 = 0x2::coin::value<T0>(&v4);
        0xda32b3a45a9c5250435187226db7ab2f3105e22ffde135b0bcbcf3530f502bd5::profit::assert_profit(v5, arg6, arg7);
        0xda32b3a45a9c5250435187226db7ab2f3105e22ffde135b0bcbcf3530f502bd5::flowx_clmm_adapter::pay<T0, T1>(arg4, v2, 0x2::coin::into_balance<T0>(0x2::coin::split<T0>(&mut v4, arg6, arg9)), 0x2::balance::zero<T1>(), arg5, arg9);
        0xda32b3a45a9c5250435187226db7ab2f3105e22ffde135b0bcbcf3530f502bd5::events::emit_arb_executed(b"flowx_clmm_to_turbos", arg6, v5);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(v4, 0x2::tx_context::sender(arg9));
    }

    entry fun arb_turbos_to_aftermath<T0, T1, T2, T3>(arg0: &0xda32b3a45a9c5250435187226db7ab2f3105e22ffde135b0bcbcf3530f502bd5::admin::AdminCap, arg1: &0xda32b3a45a9c5250435187226db7ab2f3105e22ffde135b0bcbcf3530f502bd5::admin::PauseFlag, arg2: &mut 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Pool<T0, T1, T2>, arg3: &0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Versioned, arg4: &mut 0xefe170ec0be4d762196bedecd7a065816576198a6527c99282a2551aaa7da38c::pool::Pool<T3>, arg5: &0xefe170ec0be4d762196bedecd7a065816576198a6527c99282a2551aaa7da38c::pool_registry::PoolRegistry, arg6: &0x2d9316f1f1a95f6d7c85a4e690ef7c359e6649773ef2c37ad7d9857adb6bef06::vault::ProtocolFeeVault, arg7: &mut 0x64213b0e4a52bac468d4ac3f140242f70714381653a1919a6d57cd49c628207a::treasury::Treasury, arg8: &mut 0xa6baab1e668c7868991c1c3c11e144100f5734c407d020f72a01b9d1a8bcb97f::insurance_fund::InsuranceFund, arg9: &0xc66fabf1a9253e43c70f1cc02d40a1d18db183140ecaae2a3f58fa6b66c55acf::referral_vault::ReferralVault, arg10: u64, arg11: u64, arg12: &0x2::clock::Clock, arg13: &mut 0x2::tx_context::TxContext) {
        assert!(arg10 > 0, 1);
        0xda32b3a45a9c5250435187226db7ab2f3105e22ffde135b0bcbcf3530f502bd5::admin::assert_not_paused(arg1);
        let (v0, v1, v2) = 0xda32b3a45a9c5250435187226db7ab2f3105e22ffde135b0bcbcf3530f502bd5::turbos_adapter::flash_swap_a2b<T0, T1, T2>(arg2, (arg10 as u128), arg12, arg3, arg13);
        0x2::coin::destroy_zero<T0>(v0);
        let v3 = 0xda32b3a45a9c5250435187226db7ab2f3105e22ffde135b0bcbcf3530f502bd5::aftermath_adapter::swap_exact_in<T3, T1, T0>(arg4, arg5, arg6, arg7, arg8, arg9, v1, 1, 18446744073709551615, arg13);
        let v4 = 0x2::coin::value<T0>(&v3);
        0xda32b3a45a9c5250435187226db7ab2f3105e22ffde135b0bcbcf3530f502bd5::profit::assert_profit(v4, arg10, arg11);
        0xda32b3a45a9c5250435187226db7ab2f3105e22ffde135b0bcbcf3530f502bd5::turbos_adapter::repay_flash_swap<T0, T1, T2>(arg2, 0x2::coin::split<T0>(&mut v3, arg10, arg13), 0x2::coin::zero<T1>(arg13), v2, arg3);
        0xda32b3a45a9c5250435187226db7ab2f3105e22ffde135b0bcbcf3530f502bd5::events::emit_arb_executed(b"turbos_to_aftermath", arg10, v4);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(v3, 0x2::tx_context::sender(arg13));
    }

    entry fun arb_turbos_to_cetus<T0, T1, T2>(arg0: &0xda32b3a45a9c5250435187226db7ab2f3105e22ffde135b0bcbcf3530f502bd5::admin::AdminCap, arg1: &0xda32b3a45a9c5250435187226db7ab2f3105e22ffde135b0bcbcf3530f502bd5::admin::PauseFlag, arg2: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg3: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg4: &mut 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Pool<T0, T1, T2>, arg5: &0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Versioned, arg6: u64, arg7: u64, arg8: &0x2::clock::Clock, arg9: &mut 0x2::tx_context::TxContext) {
        assert!(arg6 > 0, 1);
        0xda32b3a45a9c5250435187226db7ab2f3105e22ffde135b0bcbcf3530f502bd5::admin::assert_not_paused(arg1);
        let (v0, v1, v2) = 0xda32b3a45a9c5250435187226db7ab2f3105e22ffde135b0bcbcf3530f502bd5::turbos_adapter::flash_swap_a2b<T0, T1, T2>(arg4, (arg6 as u128), arg8, arg5, arg9);
        0x2::coin::destroy_zero<T0>(v0);
        let v3 = 0xda32b3a45a9c5250435187226db7ab2f3105e22ffde135b0bcbcf3530f502bd5::cetus_adapter::swap_coin_b2a<T0, T1>(arg2, arg3, v1, arg8, arg9);
        let v4 = 0x2::coin::value<T0>(&v3);
        0xda32b3a45a9c5250435187226db7ab2f3105e22ffde135b0bcbcf3530f502bd5::profit::assert_profit(v4, arg6, arg7);
        0xda32b3a45a9c5250435187226db7ab2f3105e22ffde135b0bcbcf3530f502bd5::turbos_adapter::repay_flash_swap<T0, T1, T2>(arg4, 0x2::coin::split<T0>(&mut v3, arg6, arg9), 0x2::coin::zero<T1>(arg9), v2, arg5);
        0xda32b3a45a9c5250435187226db7ab2f3105e22ffde135b0bcbcf3530f502bd5::events::emit_arb_executed(b"turbos_to_cetus", arg6, v4);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(v3, 0x2::tx_context::sender(arg9));
    }

    entry fun arb_turbos_to_deepbook<T0, T1, T2>(arg0: &0xda32b3a45a9c5250435187226db7ab2f3105e22ffde135b0bcbcf3530f502bd5::admin::AdminCap, arg1: &0xda32b3a45a9c5250435187226db7ab2f3105e22ffde135b0bcbcf3530f502bd5::admin::PauseFlag, arg2: &mut 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Pool<T0, T1, T2>, arg3: &0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Versioned, arg4: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T0, T1>, arg5: 0x2::coin::Coin<0xdeeb7a4662eec9f2f3def03fb937a663dddaa2e215b8078a284d026b7946c270::deep::DEEP>, arg6: u64, arg7: u64, arg8: &0x2::clock::Clock, arg9: &mut 0x2::tx_context::TxContext) {
        assert!(arg6 > 0, 1);
        0xda32b3a45a9c5250435187226db7ab2f3105e22ffde135b0bcbcf3530f502bd5::admin::assert_not_paused(arg1);
        let (v0, v1, v2) = 0xda32b3a45a9c5250435187226db7ab2f3105e22ffde135b0bcbcf3530f502bd5::turbos_adapter::flash_swap_a2b<T0, T1, T2>(arg2, (arg6 as u128), arg8, arg3, arg9);
        0x2::coin::destroy_zero<T0>(v0);
        let v3 = 0xda32b3a45a9c5250435187226db7ab2f3105e22ffde135b0bcbcf3530f502bd5::deepbook_adapter::swap_quote_for_base_cleanup<T0, T1>(arg4, v1, arg5, arg8, arg9);
        let v4 = 0x2::coin::value<T0>(&v3);
        0xda32b3a45a9c5250435187226db7ab2f3105e22ffde135b0bcbcf3530f502bd5::profit::assert_profit(v4, arg6, arg7);
        0xda32b3a45a9c5250435187226db7ab2f3105e22ffde135b0bcbcf3530f502bd5::turbos_adapter::repay_flash_swap<T0, T1, T2>(arg2, 0x2::coin::split<T0>(&mut v3, arg6, arg9), 0x2::coin::zero<T1>(arg9), v2, arg3);
        0xda32b3a45a9c5250435187226db7ab2f3105e22ffde135b0bcbcf3530f502bd5::events::emit_arb_executed(b"turbos_to_deepbook", arg6, v4);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(v3, 0x2::tx_context::sender(arg9));
    }

    entry fun arb_turbos_to_flowx_clmm<T0, T1, T2>(arg0: &0xda32b3a45a9c5250435187226db7ab2f3105e22ffde135b0bcbcf3530f502bd5::admin::AdminCap, arg1: &0xda32b3a45a9c5250435187226db7ab2f3105e22ffde135b0bcbcf3530f502bd5::admin::PauseFlag, arg2: &mut 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Pool<T0, T1, T2>, arg3: &0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Versioned, arg4: &mut 0x25929e7f29e0a30eb4e692952ba1b5b65a3a4d65ab5f2a32e1ba3edcb587f26d::pool::Pool<T0, T1>, arg5: &0x25929e7f29e0a30eb4e692952ba1b5b65a3a4d65ab5f2a32e1ba3edcb587f26d::versioned::Versioned, arg6: u64, arg7: u64, arg8: &0x2::clock::Clock, arg9: &mut 0x2::tx_context::TxContext) {
        assert!(arg6 > 0, 1);
        0xda32b3a45a9c5250435187226db7ab2f3105e22ffde135b0bcbcf3530f502bd5::admin::assert_not_paused(arg1);
        let (v0, v1, v2) = 0xda32b3a45a9c5250435187226db7ab2f3105e22ffde135b0bcbcf3530f502bd5::turbos_adapter::flash_swap_a2b<T0, T1, T2>(arg2, (arg6 as u128), arg8, arg3, arg9);
        0x2::coin::destroy_zero<T0>(v0);
        let v3 = 0xda32b3a45a9c5250435187226db7ab2f3105e22ffde135b0bcbcf3530f502bd5::flowx_clmm_adapter::swap_coin_b2a<T0, T1>(arg4, v1, arg5, arg8, arg9);
        let v4 = 0x2::coin::value<T0>(&v3);
        0xda32b3a45a9c5250435187226db7ab2f3105e22ffde135b0bcbcf3530f502bd5::profit::assert_profit(v4, arg6, arg7);
        0xda32b3a45a9c5250435187226db7ab2f3105e22ffde135b0bcbcf3530f502bd5::turbos_adapter::repay_flash_swap<T0, T1, T2>(arg2, 0x2::coin::split<T0>(&mut v3, arg6, arg9), 0x2::coin::zero<T1>(arg9), v2, arg3);
        0xda32b3a45a9c5250435187226db7ab2f3105e22ffde135b0bcbcf3530f502bd5::events::emit_arb_executed(b"turbos_to_flowx_clmm", arg6, v4);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(v3, 0x2::tx_context::sender(arg9));
    }

    // decompiled from Move bytecode v6
}

