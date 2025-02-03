module 0x2929af9c3feca396beab1b842841a6ece4aa534c5fae7f482e244d9583aacfb9::deposit {
    public fun deposit_a<T0, T1>(arg0: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg1: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg2: &0x2929af9c3feca396beab1b842841a6ece4aa534c5fae7f482e244d9583aacfb9::vault::Vault<T0, T1>, arg3: &0x2929af9c3feca396beab1b842841a6ece4aa534c5fae7f482e244d9583aacfb9::vault::OwnerKey, arg4: 0x2::coin::Coin<T0>, arg5: &0x2929af9c3feca396beab1b842841a6ece4aa534c5fae7f482e244d9583aacfb9::version::Version, arg6: &mut 0x2929af9c3feca396beab1b842841a6ece4aa534c5fae7f482e244d9583aacfb9::obligation::Obligation, arg7: &mut 0x2929af9c3feca396beab1b842841a6ece4aa534c5fae7f482e244d9583aacfb9::market::Market, arg8: &0x2929af9c3feca396beab1b842841a6ece4aa534c5fae7f482e244d9583aacfb9::coin_decimals_registry::CoinDecimalsRegistry, arg9: &0x2929af9c3feca396beab1b842841a6ece4aa534c5fae7f482e244d9583aacfb9::x_oracle::XOracle, arg10: &0x2::clock::Clock, arg11: &mut 0x2::tx_context::TxContext) {
        0x2929af9c3feca396beab1b842841a6ece4aa534c5fae7f482e244d9583aacfb9::vault::assert_ownership<T0, T1>(arg3, arg2);
        let (v0, v1, v2) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::flash_swap<T0, T1>(arg1, arg0, false, true, 0x2929af9c3feca396beab1b842841a6ece4aa534c5fae7f482e244d9583aacfb9::vault::get_deposit_flash_swap_amount<T0, T1>(arg2, 0x2::coin::value<T0>(&arg4)), 79226673515401279992447579055, arg10);
        let v3 = v2;
        0x2::balance::destroy_zero<T1>(v1);
        0x2::coin::join<T0>(&mut arg4, 0x2::coin::from_balance<T0>(v0, arg11));
        0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::repay_flash_swap<T0, T1>(arg1, arg0, 0x2::balance::zero<T0>(), 0x2::coin::into_balance<T1>(0x2929af9c3feca396beab1b842841a6ece4aa534c5fae7f482e244d9583aacfb9::vault::deposit<T0, T1>(arg2, arg4, arg5, arg6, arg7, arg8, arg9, 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::swap_pay_amount<T0, T1>(&v3), arg10, arg11)), v3);
    }

    public fun deposit_b<T0, T1>(arg0: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T1, T0>, arg1: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg2: &0x2929af9c3feca396beab1b842841a6ece4aa534c5fae7f482e244d9583aacfb9::vault::Vault<T0, T1>, arg3: &0x2929af9c3feca396beab1b842841a6ece4aa534c5fae7f482e244d9583aacfb9::vault::OwnerKey, arg4: 0x2::coin::Coin<T0>, arg5: &0x2929af9c3feca396beab1b842841a6ece4aa534c5fae7f482e244d9583aacfb9::version::Version, arg6: &mut 0x2929af9c3feca396beab1b842841a6ece4aa534c5fae7f482e244d9583aacfb9::obligation::Obligation, arg7: &mut 0x2929af9c3feca396beab1b842841a6ece4aa534c5fae7f482e244d9583aacfb9::market::Market, arg8: &0x2929af9c3feca396beab1b842841a6ece4aa534c5fae7f482e244d9583aacfb9::coin_decimals_registry::CoinDecimalsRegistry, arg9: &0x2929af9c3feca396beab1b842841a6ece4aa534c5fae7f482e244d9583aacfb9::x_oracle::XOracle, arg10: &0x2::clock::Clock, arg11: &mut 0x2::tx_context::TxContext) {
        0x2929af9c3feca396beab1b842841a6ece4aa534c5fae7f482e244d9583aacfb9::vault::assert_ownership<T0, T1>(arg3, arg2);
        let (v0, v1, v2) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::flash_swap<T1, T0>(arg1, arg0, true, true, 0x2929af9c3feca396beab1b842841a6ece4aa534c5fae7f482e244d9583aacfb9::vault::get_deposit_flash_swap_amount<T0, T1>(arg2, 0x2::coin::value<T0>(&arg4)), 79226673515401279992447579055, arg10);
        let v3 = v2;
        0x2::balance::destroy_zero<T1>(v0);
        0x2::coin::join<T0>(&mut arg4, 0x2::coin::from_balance<T0>(v1, arg11));
        0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::repay_flash_swap<T1, T0>(arg1, arg0, 0x2::coin::into_balance<T1>(0x2929af9c3feca396beab1b842841a6ece4aa534c5fae7f482e244d9583aacfb9::vault::deposit<T0, T1>(arg2, arg4, arg5, arg6, arg7, arg8, arg9, 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::swap_pay_amount<T1, T0>(&v3), arg10, arg11)), 0x2::balance::zero<T0>(), v3);
    }

    // decompiled from Move bytecode v6
}

