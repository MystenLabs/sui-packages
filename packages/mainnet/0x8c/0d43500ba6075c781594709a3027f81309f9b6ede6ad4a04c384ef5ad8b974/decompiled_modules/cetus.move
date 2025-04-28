module 0xb84e63d22ea4822a0a333c250e790f69bf5c2ef0c63f4e120e05a6415991368f::cetus {
    entry fun trade_borrow_x<T0, T1>(arg0: &0xb84e63d22ea4822a0a333c250e790f69bf5c2ef0c63f4e120e05a6415991368f::v2::TraderList, arg1: u64, arg2: &mut 0xb84e63d22ea4822a0a333c250e790f69bf5c2ef0c63f4e120e05a6415991368f::v2::TradingPair<T0, T1>, arg3: u64, arg4: u64, arg5: u64, arg6: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg7: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg8: &0x2::clock::Clock, arg9: &mut 0x2::tx_context::TxContext) {
        let (v0, v1, v2) = 0xb84e63d22ea4822a0a333c250e790f69bf5c2ef0c63f4e120e05a6415991368f::v2::trader_borrow<T0, T1>(arg0, arg1, arg2, true, arg5, arg9);
        0x1::option::destroy_none<0x2::coin::Coin<T1>>(v1);
        let v3 = 0x1::option::destroy_some<0x2::coin::Coin<T0>>(v0);
        let (v4, v5, v6) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::flash_swap<T0, T1>(arg6, arg7, true, true, 0x2::coin::value<T0>(&v3), 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::tick_math::min_sqrt_price(), arg8);
        0x2::balance::destroy_zero<T0>(v4);
        0xb84e63d22ea4822a0a333c250e790f69bf5c2ef0c63f4e120e05a6415991368f::v2::trader_swap_and_repay<T0, T1>(arg2, arg3, arg4, v2, 0x1::option::none<0x2::coin::Coin<T0>>(), 0x1::option::some<0x2::coin::Coin<T1>>(0x2::coin::from_balance<T1>(v5, arg9)), arg8);
        0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::repay_flash_swap<T0, T1>(arg6, arg7, 0x2::coin::into_balance<T0>(v3), 0x2::balance::zero<T1>(), v6);
    }

    entry fun trade_borrow_y<T0, T1>(arg0: &0xb84e63d22ea4822a0a333c250e790f69bf5c2ef0c63f4e120e05a6415991368f::v2::TraderList, arg1: u64, arg2: &mut 0xb84e63d22ea4822a0a333c250e790f69bf5c2ef0c63f4e120e05a6415991368f::v2::TradingPair<T0, T1>, arg3: u64, arg4: u64, arg5: u64, arg6: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg7: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg8: &0x2::clock::Clock, arg9: &mut 0x2::tx_context::TxContext) {
        let (v0, v1, v2) = 0xb84e63d22ea4822a0a333c250e790f69bf5c2ef0c63f4e120e05a6415991368f::v2::trader_borrow<T0, T1>(arg0, arg1, arg2, false, arg5, arg9);
        0x1::option::destroy_none<0x2::coin::Coin<T0>>(v0);
        let v3 = 0x1::option::destroy_some<0x2::coin::Coin<T1>>(v1);
        let (v4, v5, v6) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::flash_swap<T0, T1>(arg6, arg7, false, true, 0x2::coin::value<T1>(&v3), 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::tick_math::max_sqrt_price(), arg8);
        0x2::balance::destroy_zero<T1>(v5);
        0xb84e63d22ea4822a0a333c250e790f69bf5c2ef0c63f4e120e05a6415991368f::v2::trader_swap_and_repay<T0, T1>(arg2, arg3, arg4, v2, 0x1::option::some<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(v4, arg9)), 0x1::option::none<0x2::coin::Coin<T1>>(), arg8);
        0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::repay_flash_swap<T0, T1>(arg6, arg7, 0x2::balance::zero<T0>(), 0x2::coin::into_balance<T1>(v3), v6);
    }

    // decompiled from Move bytecode v6
}

