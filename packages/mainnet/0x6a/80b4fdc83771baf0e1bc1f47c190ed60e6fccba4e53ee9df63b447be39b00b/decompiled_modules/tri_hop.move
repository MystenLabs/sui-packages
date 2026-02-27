module 0x6a80b4fdc83771baf0e1bc1f47c190ed60e6fccba4e53ee9df63b447be39b00b::tri_hop {
    entry fun tri_cetus_cetus_aftermath<T0, T1, T2, T3>(arg0: &0x6a80b4fdc83771baf0e1bc1f47c190ed60e6fccba4e53ee9df63b447be39b00b::admin::AdminCap, arg1: &0x6a80b4fdc83771baf0e1bc1f47c190ed60e6fccba4e53ee9df63b447be39b00b::admin::PauseFlag, arg2: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg3: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg4: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T1, T2>, arg5: &mut 0xefe170ec0be4d762196bedecd7a065816576198a6527c99282a2551aaa7da38c::pool::Pool<T3>, arg6: &0xefe170ec0be4d762196bedecd7a065816576198a6527c99282a2551aaa7da38c::pool_registry::PoolRegistry, arg7: &0x2d9316f1f1a95f6d7c85a4e690ef7c359e6649773ef2c37ad7d9857adb6bef06::vault::ProtocolFeeVault, arg8: &mut 0x64213b0e4a52bac468d4ac3f140242f70714381653a1919a6d57cd49c628207a::treasury::Treasury, arg9: &mut 0xa6baab1e668c7868991c1c3c11e144100f5734c407d020f72a01b9d1a8bcb97f::insurance_fund::InsuranceFund, arg10: &0xc66fabf1a9253e43c70f1cc02d40a1d18db183140ecaae2a3f58fa6b66c55acf::referral_vault::ReferralVault, arg11: u64, arg12: u64, arg13: &0x2::clock::Clock, arg14: &mut 0x2::tx_context::TxContext) {
        assert!(arg11 > 0, 1);
        0x6a80b4fdc83771baf0e1bc1f47c190ed60e6fccba4e53ee9df63b447be39b00b::admin::assert_not_paused(arg1);
        let (v0, v1, v2) = 0x6a80b4fdc83771baf0e1bc1f47c190ed60e6fccba4e53ee9df63b447be39b00b::cetus_adapter::flash_swap_a2b<T0, T1>(arg2, arg3, arg11, arg13);
        let v3 = v2;
        let v4 = v1;
        0x2::balance::destroy_zero<T0>(v0);
        let v5 = 0x6a80b4fdc83771baf0e1bc1f47c190ed60e6fccba4e53ee9df63b447be39b00b::aftermath_adapter::swap_exact_in<T3, T2, T0>(arg5, arg6, arg7, arg8, arg9, arg10, 0x2::coin::from_balance<T2>(0x6a80b4fdc83771baf0e1bc1f47c190ed60e6fccba4e53ee9df63b447be39b00b::cetus_adapter::swap_a2b<T1, T2>(arg2, arg4, v4, 0x2::balance::value<T1>(&v4), arg13), arg14), 1, 18446744073709551615, arg14);
        let v6 = 0x6a80b4fdc83771baf0e1bc1f47c190ed60e6fccba4e53ee9df63b447be39b00b::cetus_adapter::swap_pay_amount<T0, T1>(&v3);
        let v7 = 0x2::coin::value<T0>(&v5);
        0x6a80b4fdc83771baf0e1bc1f47c190ed60e6fccba4e53ee9df63b447be39b00b::profit::assert_profit(v7, v6, arg12);
        0x6a80b4fdc83771baf0e1bc1f47c190ed60e6fccba4e53ee9df63b447be39b00b::cetus_adapter::repay_flash_swap<T0, T1>(arg2, arg3, 0x2::coin::into_balance<T0>(0x2::coin::split<T0>(&mut v5, v6, arg14)), 0x2::balance::zero<T1>(), v3);
        0x6a80b4fdc83771baf0e1bc1f47c190ed60e6fccba4e53ee9df63b447be39b00b::events::emit_arb_executed(b"tri_cca", v6, v7);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(v5, 0x2::tx_context::sender(arg14));
    }

    entry fun tri_cetus_cetus_cetus<T0, T1, T2>(arg0: &0x6a80b4fdc83771baf0e1bc1f47c190ed60e6fccba4e53ee9df63b447be39b00b::admin::AdminCap, arg1: &0x6a80b4fdc83771baf0e1bc1f47c190ed60e6fccba4e53ee9df63b447be39b00b::admin::PauseFlag, arg2: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg3: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg4: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T1, T2>, arg5: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T2, T0>, arg6: u64, arg7: u64, arg8: &0x2::clock::Clock, arg9: &mut 0x2::tx_context::TxContext) {
        assert!(arg6 > 0, 1);
        0x6a80b4fdc83771baf0e1bc1f47c190ed60e6fccba4e53ee9df63b447be39b00b::admin::assert_not_paused(arg1);
        let (v0, v1, v2) = 0x6a80b4fdc83771baf0e1bc1f47c190ed60e6fccba4e53ee9df63b447be39b00b::cetus_adapter::flash_swap_a2b<T0, T1>(arg2, arg3, arg6, arg8);
        let v3 = v2;
        let v4 = v1;
        0x2::balance::destroy_zero<T0>(v0);
        let v5 = 0x6a80b4fdc83771baf0e1bc1f47c190ed60e6fccba4e53ee9df63b447be39b00b::cetus_adapter::swap_a2b<T1, T2>(arg2, arg4, v4, 0x2::balance::value<T1>(&v4), arg8);
        let v6 = 0x6a80b4fdc83771baf0e1bc1f47c190ed60e6fccba4e53ee9df63b447be39b00b::cetus_adapter::swap_pay_amount<T0, T1>(&v3);
        let v7 = 0x2::coin::from_balance<T0>(0x6a80b4fdc83771baf0e1bc1f47c190ed60e6fccba4e53ee9df63b447be39b00b::cetus_adapter::swap_a2b<T2, T0>(arg2, arg5, v5, 0x2::balance::value<T2>(&v5), arg8), arg9);
        let v8 = 0x2::coin::value<T0>(&v7);
        0x6a80b4fdc83771baf0e1bc1f47c190ed60e6fccba4e53ee9df63b447be39b00b::profit::assert_profit(v8, v6, arg7);
        0x6a80b4fdc83771baf0e1bc1f47c190ed60e6fccba4e53ee9df63b447be39b00b::cetus_adapter::repay_flash_swap<T0, T1>(arg2, arg3, 0x2::coin::into_balance<T0>(0x2::coin::split<T0>(&mut v7, v6, arg9)), 0x2::balance::zero<T1>(), v3);
        0x6a80b4fdc83771baf0e1bc1f47c190ed60e6fccba4e53ee9df63b447be39b00b::events::emit_arb_executed(b"tri_ccc", v6, v8);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(v7, 0x2::tx_context::sender(arg9));
    }

    entry fun tri_cetus_cetus_flowx_clmm<T0, T1, T2>(arg0: &0x6a80b4fdc83771baf0e1bc1f47c190ed60e6fccba4e53ee9df63b447be39b00b::admin::AdminCap, arg1: &0x6a80b4fdc83771baf0e1bc1f47c190ed60e6fccba4e53ee9df63b447be39b00b::admin::PauseFlag, arg2: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg3: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg4: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T1, T2>, arg5: &mut 0x25929e7f29e0a30eb4e692952ba1b5b65a3a4d65ab5f2a32e1ba3edcb587f26d::pool::Pool<T2, T0>, arg6: &0x25929e7f29e0a30eb4e692952ba1b5b65a3a4d65ab5f2a32e1ba3edcb587f26d::versioned::Versioned, arg7: u64, arg8: u64, arg9: &0x2::clock::Clock, arg10: &mut 0x2::tx_context::TxContext) {
        assert!(arg7 > 0, 1);
        0x6a80b4fdc83771baf0e1bc1f47c190ed60e6fccba4e53ee9df63b447be39b00b::admin::assert_not_paused(arg1);
        let (v0, v1, v2) = 0x6a80b4fdc83771baf0e1bc1f47c190ed60e6fccba4e53ee9df63b447be39b00b::cetus_adapter::flash_swap_a2b<T0, T1>(arg2, arg3, arg7, arg9);
        let v3 = v2;
        let v4 = v1;
        0x2::balance::destroy_zero<T0>(v0);
        let v5 = 0x6a80b4fdc83771baf0e1bc1f47c190ed60e6fccba4e53ee9df63b447be39b00b::flowx_clmm_adapter::swap_coin_a2b<T2, T0>(arg5, 0x2::coin::from_balance<T2>(0x6a80b4fdc83771baf0e1bc1f47c190ed60e6fccba4e53ee9df63b447be39b00b::cetus_adapter::swap_a2b<T1, T2>(arg2, arg4, v4, 0x2::balance::value<T1>(&v4), arg9), arg10), arg6, arg9, arg10);
        let v6 = 0x6a80b4fdc83771baf0e1bc1f47c190ed60e6fccba4e53ee9df63b447be39b00b::cetus_adapter::swap_pay_amount<T0, T1>(&v3);
        let v7 = 0x2::coin::value<T0>(&v5);
        0x6a80b4fdc83771baf0e1bc1f47c190ed60e6fccba4e53ee9df63b447be39b00b::profit::assert_profit(v7, v6, arg8);
        0x6a80b4fdc83771baf0e1bc1f47c190ed60e6fccba4e53ee9df63b447be39b00b::cetus_adapter::repay_flash_swap<T0, T1>(arg2, arg3, 0x2::coin::into_balance<T0>(0x2::coin::split<T0>(&mut v5, v6, arg10)), 0x2::balance::zero<T1>(), v3);
        0x6a80b4fdc83771baf0e1bc1f47c190ed60e6fccba4e53ee9df63b447be39b00b::events::emit_arb_executed(b"tri_ccf", v6, v7);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(v5, 0x2::tx_context::sender(arg10));
    }

    entry fun tri_cetus_cetus_turbos<T0, T1, T2, T3>(arg0: &0x6a80b4fdc83771baf0e1bc1f47c190ed60e6fccba4e53ee9df63b447be39b00b::admin::AdminCap, arg1: &0x6a80b4fdc83771baf0e1bc1f47c190ed60e6fccba4e53ee9df63b447be39b00b::admin::PauseFlag, arg2: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg3: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg4: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T1, T2>, arg5: &mut 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Pool<T2, T0, T3>, arg6: &0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Versioned, arg7: u64, arg8: u64, arg9: &0x2::clock::Clock, arg10: &mut 0x2::tx_context::TxContext) {
        assert!(arg7 > 0, 1);
        0x6a80b4fdc83771baf0e1bc1f47c190ed60e6fccba4e53ee9df63b447be39b00b::admin::assert_not_paused(arg1);
        let (v0, v1, v2) = 0x6a80b4fdc83771baf0e1bc1f47c190ed60e6fccba4e53ee9df63b447be39b00b::cetus_adapter::flash_swap_a2b<T0, T1>(arg2, arg3, arg7, arg9);
        let v3 = v2;
        let v4 = v1;
        0x2::balance::destroy_zero<T0>(v0);
        let v5 = 0x2::coin::from_balance<T2>(0x6a80b4fdc83771baf0e1bc1f47c190ed60e6fccba4e53ee9df63b447be39b00b::cetus_adapter::swap_a2b<T1, T2>(arg2, arg4, v4, 0x2::balance::value<T1>(&v4), arg9), arg10);
        let v6 = 0x6a80b4fdc83771baf0e1bc1f47c190ed60e6fccba4e53ee9df63b447be39b00b::turbos_adapter::swap_a_to_b<T2, T0, T3>(arg5, v5, 0x2::coin::value<T2>(&v5), arg9, arg6, arg10);
        let v7 = 0x6a80b4fdc83771baf0e1bc1f47c190ed60e6fccba4e53ee9df63b447be39b00b::cetus_adapter::swap_pay_amount<T0, T1>(&v3);
        let v8 = 0x2::coin::value<T0>(&v6);
        0x6a80b4fdc83771baf0e1bc1f47c190ed60e6fccba4e53ee9df63b447be39b00b::profit::assert_profit(v8, v7, arg8);
        0x6a80b4fdc83771baf0e1bc1f47c190ed60e6fccba4e53ee9df63b447be39b00b::cetus_adapter::repay_flash_swap<T0, T1>(arg2, arg3, 0x2::coin::into_balance<T0>(0x2::coin::split<T0>(&mut v6, v7, arg10)), 0x2::balance::zero<T1>(), v3);
        0x6a80b4fdc83771baf0e1bc1f47c190ed60e6fccba4e53ee9df63b447be39b00b::events::emit_arb_executed(b"tri_cct", v7, v8);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(v6, 0x2::tx_context::sender(arg10));
    }

    entry fun tri_cetus_deepbook_turbos<T0, T1, T2, T3>(arg0: &0x6a80b4fdc83771baf0e1bc1f47c190ed60e6fccba4e53ee9df63b447be39b00b::admin::AdminCap, arg1: &0x6a80b4fdc83771baf0e1bc1f47c190ed60e6fccba4e53ee9df63b447be39b00b::admin::PauseFlag, arg2: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg3: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg4: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T1, T2>, arg5: 0x2::coin::Coin<0xdeeb7a4662eec9f2f3def03fb937a663dddaa2e215b8078a284d026b7946c270::deep::DEEP>, arg6: &mut 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Pool<T2, T0, T3>, arg7: &0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Versioned, arg8: u64, arg9: u64, arg10: &0x2::clock::Clock, arg11: &mut 0x2::tx_context::TxContext) {
        assert!(arg8 > 0, 1);
        0x6a80b4fdc83771baf0e1bc1f47c190ed60e6fccba4e53ee9df63b447be39b00b::admin::assert_not_paused(arg1);
        let (v0, v1, v2) = 0x6a80b4fdc83771baf0e1bc1f47c190ed60e6fccba4e53ee9df63b447be39b00b::cetus_adapter::flash_swap_a2b<T0, T1>(arg2, arg3, arg8, arg10);
        let v3 = v2;
        0x2::balance::destroy_zero<T0>(v0);
        let v4 = 0x6a80b4fdc83771baf0e1bc1f47c190ed60e6fccba4e53ee9df63b447be39b00b::deepbook_adapter::swap_base_for_quote_cleanup<T1, T2>(arg4, 0x2::coin::from_balance<T1>(v1, arg11), arg5, arg10, arg11);
        let v5 = 0x6a80b4fdc83771baf0e1bc1f47c190ed60e6fccba4e53ee9df63b447be39b00b::turbos_adapter::swap_a_to_b<T2, T0, T3>(arg6, v4, 0x2::coin::value<T2>(&v4), arg10, arg7, arg11);
        let v6 = 0x6a80b4fdc83771baf0e1bc1f47c190ed60e6fccba4e53ee9df63b447be39b00b::cetus_adapter::swap_pay_amount<T0, T1>(&v3);
        let v7 = 0x2::coin::value<T0>(&v5);
        0x6a80b4fdc83771baf0e1bc1f47c190ed60e6fccba4e53ee9df63b447be39b00b::profit::assert_profit(v7, v6, arg9);
        0x6a80b4fdc83771baf0e1bc1f47c190ed60e6fccba4e53ee9df63b447be39b00b::cetus_adapter::repay_flash_swap<T0, T1>(arg2, arg3, 0x2::coin::into_balance<T0>(0x2::coin::split<T0>(&mut v5, v6, arg11)), 0x2::balance::zero<T1>(), v3);
        0x6a80b4fdc83771baf0e1bc1f47c190ed60e6fccba4e53ee9df63b447be39b00b::events::emit_arb_executed(b"tri_cdt", v6, v7);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(v5, 0x2::tx_context::sender(arg11));
    }

    entry fun tri_cetus_flowx_clmm_turbos<T0, T1, T2, T3>(arg0: &0x6a80b4fdc83771baf0e1bc1f47c190ed60e6fccba4e53ee9df63b447be39b00b::admin::AdminCap, arg1: &0x6a80b4fdc83771baf0e1bc1f47c190ed60e6fccba4e53ee9df63b447be39b00b::admin::PauseFlag, arg2: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg3: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg4: &mut 0x25929e7f29e0a30eb4e692952ba1b5b65a3a4d65ab5f2a32e1ba3edcb587f26d::pool::Pool<T1, T2>, arg5: &0x25929e7f29e0a30eb4e692952ba1b5b65a3a4d65ab5f2a32e1ba3edcb587f26d::versioned::Versioned, arg6: &mut 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Pool<T2, T0, T3>, arg7: &0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Versioned, arg8: u64, arg9: u64, arg10: &0x2::clock::Clock, arg11: &mut 0x2::tx_context::TxContext) {
        assert!(arg8 > 0, 1);
        0x6a80b4fdc83771baf0e1bc1f47c190ed60e6fccba4e53ee9df63b447be39b00b::admin::assert_not_paused(arg1);
        let (v0, v1, v2) = 0x6a80b4fdc83771baf0e1bc1f47c190ed60e6fccba4e53ee9df63b447be39b00b::cetus_adapter::flash_swap_a2b<T0, T1>(arg2, arg3, arg8, arg10);
        let v3 = v2;
        0x2::balance::destroy_zero<T0>(v0);
        let v4 = 0x6a80b4fdc83771baf0e1bc1f47c190ed60e6fccba4e53ee9df63b447be39b00b::flowx_clmm_adapter::swap_coin_a2b<T1, T2>(arg4, 0x2::coin::from_balance<T1>(v1, arg11), arg5, arg10, arg11);
        let v5 = 0x6a80b4fdc83771baf0e1bc1f47c190ed60e6fccba4e53ee9df63b447be39b00b::turbos_adapter::swap_a_to_b<T2, T0, T3>(arg6, v4, 0x2::coin::value<T2>(&v4), arg10, arg7, arg11);
        let v6 = 0x6a80b4fdc83771baf0e1bc1f47c190ed60e6fccba4e53ee9df63b447be39b00b::cetus_adapter::swap_pay_amount<T0, T1>(&v3);
        let v7 = 0x2::coin::value<T0>(&v5);
        0x6a80b4fdc83771baf0e1bc1f47c190ed60e6fccba4e53ee9df63b447be39b00b::profit::assert_profit(v7, v6, arg9);
        0x6a80b4fdc83771baf0e1bc1f47c190ed60e6fccba4e53ee9df63b447be39b00b::cetus_adapter::repay_flash_swap<T0, T1>(arg2, arg3, 0x2::coin::into_balance<T0>(0x2::coin::split<T0>(&mut v5, v6, arg11)), 0x2::balance::zero<T1>(), v3);
        0x6a80b4fdc83771baf0e1bc1f47c190ed60e6fccba4e53ee9df63b447be39b00b::events::emit_arb_executed(b"tri_cft", v6, v7);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(v5, 0x2::tx_context::sender(arg11));
    }

    entry fun tri_cetus_turbos_aftermath<T0, T1, T2, T3, T4>(arg0: &0x6a80b4fdc83771baf0e1bc1f47c190ed60e6fccba4e53ee9df63b447be39b00b::admin::AdminCap, arg1: &0x6a80b4fdc83771baf0e1bc1f47c190ed60e6fccba4e53ee9df63b447be39b00b::admin::PauseFlag, arg2: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg3: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg4: &mut 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Pool<T1, T2, T3>, arg5: &0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Versioned, arg6: &mut 0xefe170ec0be4d762196bedecd7a065816576198a6527c99282a2551aaa7da38c::pool::Pool<T4>, arg7: &0xefe170ec0be4d762196bedecd7a065816576198a6527c99282a2551aaa7da38c::pool_registry::PoolRegistry, arg8: &0x2d9316f1f1a95f6d7c85a4e690ef7c359e6649773ef2c37ad7d9857adb6bef06::vault::ProtocolFeeVault, arg9: &mut 0x64213b0e4a52bac468d4ac3f140242f70714381653a1919a6d57cd49c628207a::treasury::Treasury, arg10: &mut 0xa6baab1e668c7868991c1c3c11e144100f5734c407d020f72a01b9d1a8bcb97f::insurance_fund::InsuranceFund, arg11: &0xc66fabf1a9253e43c70f1cc02d40a1d18db183140ecaae2a3f58fa6b66c55acf::referral_vault::ReferralVault, arg12: u64, arg13: u64, arg14: &0x2::clock::Clock, arg15: &mut 0x2::tx_context::TxContext) {
        assert!(arg12 > 0, 1);
        0x6a80b4fdc83771baf0e1bc1f47c190ed60e6fccba4e53ee9df63b447be39b00b::admin::assert_not_paused(arg1);
        let (v0, v1, v2) = 0x6a80b4fdc83771baf0e1bc1f47c190ed60e6fccba4e53ee9df63b447be39b00b::cetus_adapter::flash_swap_a2b<T0, T1>(arg2, arg3, arg12, arg14);
        let v3 = v2;
        0x2::balance::destroy_zero<T0>(v0);
        let v4 = 0x2::coin::from_balance<T1>(v1, arg15);
        let v5 = 0x6a80b4fdc83771baf0e1bc1f47c190ed60e6fccba4e53ee9df63b447be39b00b::aftermath_adapter::swap_exact_in<T4, T2, T0>(arg6, arg7, arg8, arg9, arg10, arg11, 0x6a80b4fdc83771baf0e1bc1f47c190ed60e6fccba4e53ee9df63b447be39b00b::turbos_adapter::swap_a_to_b<T1, T2, T3>(arg4, v4, 0x2::coin::value<T1>(&v4), arg14, arg5, arg15), 1, 18446744073709551615, arg15);
        let v6 = 0x6a80b4fdc83771baf0e1bc1f47c190ed60e6fccba4e53ee9df63b447be39b00b::cetus_adapter::swap_pay_amount<T0, T1>(&v3);
        let v7 = 0x2::coin::value<T0>(&v5);
        0x6a80b4fdc83771baf0e1bc1f47c190ed60e6fccba4e53ee9df63b447be39b00b::profit::assert_profit(v7, v6, arg13);
        0x6a80b4fdc83771baf0e1bc1f47c190ed60e6fccba4e53ee9df63b447be39b00b::cetus_adapter::repay_flash_swap<T0, T1>(arg2, arg3, 0x2::coin::into_balance<T0>(0x2::coin::split<T0>(&mut v5, v6, arg15)), 0x2::balance::zero<T1>(), v3);
        0x6a80b4fdc83771baf0e1bc1f47c190ed60e6fccba4e53ee9df63b447be39b00b::events::emit_arb_executed(b"tri_cta", v6, v7);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(v5, 0x2::tx_context::sender(arg15));
    }

    entry fun tri_cetus_turbos_deepbook<T0, T1, T2, T3>(arg0: &0x6a80b4fdc83771baf0e1bc1f47c190ed60e6fccba4e53ee9df63b447be39b00b::admin::AdminCap, arg1: &0x6a80b4fdc83771baf0e1bc1f47c190ed60e6fccba4e53ee9df63b447be39b00b::admin::PauseFlag, arg2: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg3: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg4: &mut 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Pool<T1, T2, T3>, arg5: &0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Versioned, arg6: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T0, T2>, arg7: 0x2::coin::Coin<0xdeeb7a4662eec9f2f3def03fb937a663dddaa2e215b8078a284d026b7946c270::deep::DEEP>, arg8: u64, arg9: u64, arg10: &0x2::clock::Clock, arg11: &mut 0x2::tx_context::TxContext) {
        assert!(arg8 > 0, 1);
        0x6a80b4fdc83771baf0e1bc1f47c190ed60e6fccba4e53ee9df63b447be39b00b::admin::assert_not_paused(arg1);
        let (v0, v1, v2) = 0x6a80b4fdc83771baf0e1bc1f47c190ed60e6fccba4e53ee9df63b447be39b00b::cetus_adapter::flash_swap_a2b<T0, T1>(arg2, arg3, arg8, arg10);
        let v3 = v2;
        0x2::balance::destroy_zero<T0>(v0);
        let v4 = 0x2::coin::from_balance<T1>(v1, arg11);
        let v5 = 0x6a80b4fdc83771baf0e1bc1f47c190ed60e6fccba4e53ee9df63b447be39b00b::deepbook_adapter::swap_quote_for_base_cleanup<T0, T2>(arg6, 0x6a80b4fdc83771baf0e1bc1f47c190ed60e6fccba4e53ee9df63b447be39b00b::turbos_adapter::swap_a_to_b<T1, T2, T3>(arg4, v4, 0x2::coin::value<T1>(&v4), arg10, arg5, arg11), arg7, arg10, arg11);
        let v6 = 0x6a80b4fdc83771baf0e1bc1f47c190ed60e6fccba4e53ee9df63b447be39b00b::cetus_adapter::swap_pay_amount<T0, T1>(&v3);
        let v7 = 0x2::coin::value<T0>(&v5);
        0x6a80b4fdc83771baf0e1bc1f47c190ed60e6fccba4e53ee9df63b447be39b00b::profit::assert_profit(v7, v6, arg9);
        0x6a80b4fdc83771baf0e1bc1f47c190ed60e6fccba4e53ee9df63b447be39b00b::cetus_adapter::repay_flash_swap<T0, T1>(arg2, arg3, 0x2::coin::into_balance<T0>(0x2::coin::split<T0>(&mut v5, v6, arg11)), 0x2::balance::zero<T1>(), v3);
        0x6a80b4fdc83771baf0e1bc1f47c190ed60e6fccba4e53ee9df63b447be39b00b::events::emit_arb_executed(b"tri_ctd", v6, v7);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(v5, 0x2::tx_context::sender(arg11));
    }

    entry fun tri_deepbook_cetus_turbos<T0, T1, T2, T3>(arg0: &0x6a80b4fdc83771baf0e1bc1f47c190ed60e6fccba4e53ee9df63b447be39b00b::admin::AdminCap, arg1: &0x6a80b4fdc83771baf0e1bc1f47c190ed60e6fccba4e53ee9df63b447be39b00b::admin::PauseFlag, arg2: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg3: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T0, T2>, arg4: 0x2::coin::Coin<0xdeeb7a4662eec9f2f3def03fb937a663dddaa2e215b8078a284d026b7946c270::deep::DEEP>, arg5: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg6: &mut 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Pool<T1, T2, T3>, arg7: &0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Versioned, arg8: u64, arg9: u64, arg10: &0x2::clock::Clock, arg11: &mut 0x2::tx_context::TxContext) {
        assert!(arg8 > 0, 1);
        0x6a80b4fdc83771baf0e1bc1f47c190ed60e6fccba4e53ee9df63b447be39b00b::admin::assert_not_paused(arg1);
        let (v0, v1) = 0x6a80b4fdc83771baf0e1bc1f47c190ed60e6fccba4e53ee9df63b447be39b00b::deepbook_adapter::flash_borrow_base<T0, T2>(arg3, arg8, arg11);
        let v2 = 0x2::coin::from_balance<T1>(0x6a80b4fdc83771baf0e1bc1f47c190ed60e6fccba4e53ee9df63b447be39b00b::cetus_adapter::swap_a2b<T0, T1>(arg2, arg5, 0x2::coin::into_balance<T0>(v0), arg8, arg10), arg11);
        let v3 = 0x6a80b4fdc83771baf0e1bc1f47c190ed60e6fccba4e53ee9df63b447be39b00b::deepbook_adapter::swap_quote_for_base_cleanup<T0, T2>(arg3, 0x6a80b4fdc83771baf0e1bc1f47c190ed60e6fccba4e53ee9df63b447be39b00b::turbos_adapter::swap_a_to_b<T1, T2, T3>(arg6, v2, 0x2::coin::value<T1>(&v2), arg10, arg7, arg11), arg4, arg10, arg11);
        let v4 = 0x2::coin::value<T0>(&v3);
        0x6a80b4fdc83771baf0e1bc1f47c190ed60e6fccba4e53ee9df63b447be39b00b::profit::assert_profit(v4, arg8, arg9);
        0x6a80b4fdc83771baf0e1bc1f47c190ed60e6fccba4e53ee9df63b447be39b00b::deepbook_adapter::flash_return_base<T0, T2>(arg3, 0x2::coin::split<T0>(&mut v3, arg8, arg11), v1);
        0x6a80b4fdc83771baf0e1bc1f47c190ed60e6fccba4e53ee9df63b447be39b00b::events::emit_arb_executed(b"tri_dct", arg8, v4);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(v3, 0x2::tx_context::sender(arg11));
    }

    entry fun tri_flowx_clmm_cetus_turbos<T0, T1, T2, T3>(arg0: &0x6a80b4fdc83771baf0e1bc1f47c190ed60e6fccba4e53ee9df63b447be39b00b::admin::AdminCap, arg1: &0x6a80b4fdc83771baf0e1bc1f47c190ed60e6fccba4e53ee9df63b447be39b00b::admin::PauseFlag, arg2: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg3: &mut 0x25929e7f29e0a30eb4e692952ba1b5b65a3a4d65ab5f2a32e1ba3edcb587f26d::pool::Pool<T0, T1>, arg4: &0x25929e7f29e0a30eb4e692952ba1b5b65a3a4d65ab5f2a32e1ba3edcb587f26d::versioned::Versioned, arg5: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T1, T2>, arg6: &mut 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Pool<T2, T0, T3>, arg7: &0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Versioned, arg8: u64, arg9: u64, arg10: &0x2::clock::Clock, arg11: &mut 0x2::tx_context::TxContext) {
        assert!(arg8 > 0, 1);
        0x6a80b4fdc83771baf0e1bc1f47c190ed60e6fccba4e53ee9df63b447be39b00b::admin::assert_not_paused(arg1);
        let (v0, v1, v2) = 0x6a80b4fdc83771baf0e1bc1f47c190ed60e6fccba4e53ee9df63b447be39b00b::flowx_clmm_adapter::swap_a2b<T0, T1>(arg3, arg8, arg4, arg10, arg11);
        let v3 = v1;
        0x2::balance::destroy_zero<T0>(v0);
        let v4 = 0x2::coin::from_balance<T2>(0x6a80b4fdc83771baf0e1bc1f47c190ed60e6fccba4e53ee9df63b447be39b00b::cetus_adapter::swap_a2b<T1, T2>(arg2, arg5, v3, 0x2::balance::value<T1>(&v3), arg10), arg11);
        let v5 = 0x6a80b4fdc83771baf0e1bc1f47c190ed60e6fccba4e53ee9df63b447be39b00b::turbos_adapter::swap_a_to_b<T2, T0, T3>(arg6, v4, 0x2::coin::value<T2>(&v4), arg10, arg7, arg11);
        let v6 = 0x2::coin::value<T0>(&v5);
        0x6a80b4fdc83771baf0e1bc1f47c190ed60e6fccba4e53ee9df63b447be39b00b::profit::assert_profit(v6, arg8, arg9);
        0x6a80b4fdc83771baf0e1bc1f47c190ed60e6fccba4e53ee9df63b447be39b00b::flowx_clmm_adapter::pay<T0, T1>(arg3, v2, 0x2::coin::into_balance<T0>(0x2::coin::split<T0>(&mut v5, arg8, arg11)), 0x2::balance::zero<T1>(), arg4, arg11);
        0x6a80b4fdc83771baf0e1bc1f47c190ed60e6fccba4e53ee9df63b447be39b00b::events::emit_arb_executed(b"tri_fct", arg8, v6);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(v5, 0x2::tx_context::sender(arg11));
    }

    // decompiled from Move bytecode v6
}

