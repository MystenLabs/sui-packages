module 0x2929af9c3feca396beab1b842841a6ece4aa534c5fae7f482e244d9583aacfb9::withdraw {
    public fun withdraw_a<T0, T1>(arg0: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg1: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg2: &0x2929af9c3feca396beab1b842841a6ece4aa534c5fae7f482e244d9583aacfb9::vault::Vault<T0, T1>, arg3: &0x2929af9c3feca396beab1b842841a6ece4aa534c5fae7f482e244d9583aacfb9::vault::OwnerKey, arg4: &0x2929af9c3feca396beab1b842841a6ece4aa534c5fae7f482e244d9583aacfb9::version::Version, arg5: &mut 0x2929af9c3feca396beab1b842841a6ece4aa534c5fae7f482e244d9583aacfb9::obligation::Obligation, arg6: &mut 0x2929af9c3feca396beab1b842841a6ece4aa534c5fae7f482e244d9583aacfb9::market::Market, arg7: &0x2929af9c3feca396beab1b842841a6ece4aa534c5fae7f482e244d9583aacfb9::coin_decimals_registry::CoinDecimalsRegistry, arg8: &0x2929af9c3feca396beab1b842841a6ece4aa534c5fae7f482e244d9583aacfb9::x_oracle::XOracle, arg9: &0x2::clock::Clock, arg10: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        0x2929af9c3feca396beab1b842841a6ece4aa534c5fae7f482e244d9583aacfb9::vault::assert_ownership<T0, T1>(arg3, arg2);
        let (v0, v1, v2) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::flash_swap<T0, T1>(arg1, arg0, true, false, 0x2929af9c3feca396beab1b842841a6ece4aa534c5fae7f482e244d9583aacfb9::vault::get_withdraw_flash_swap_amount<T0, T1>(arg2, arg5), 79226673515401279992447579055, arg9);
        let v3 = v2;
        0x2::balance::destroy_zero<T0>(v0);
        let v4 = 0x2929af9c3feca396beab1b842841a6ece4aa534c5fae7f482e244d9583aacfb9::vault::withdraw<T0, T1>(arg2, 0x2::coin::from_balance<T1>(v1, arg10), arg4, arg5, arg6, arg7, arg8, arg9, arg10);
        0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::repay_flash_swap<T0, T1>(arg1, arg0, 0x2::coin::into_balance<T0>(0x2::coin::split<T0>(&mut v4, 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::swap_pay_amount<T0, T1>(&v3), arg10)), 0x2::balance::zero<T1>(), v3);
        v4
    }

    public fun withdraw_b<T0, T1>(arg0: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T1, T0>, arg1: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg2: &0x2929af9c3feca396beab1b842841a6ece4aa534c5fae7f482e244d9583aacfb9::vault::Vault<T0, T1>, arg3: &0x2929af9c3feca396beab1b842841a6ece4aa534c5fae7f482e244d9583aacfb9::vault::OwnerKey, arg4: &0x2929af9c3feca396beab1b842841a6ece4aa534c5fae7f482e244d9583aacfb9::version::Version, arg5: &mut 0x2929af9c3feca396beab1b842841a6ece4aa534c5fae7f482e244d9583aacfb9::obligation::Obligation, arg6: &mut 0x2929af9c3feca396beab1b842841a6ece4aa534c5fae7f482e244d9583aacfb9::market::Market, arg7: &0x2929af9c3feca396beab1b842841a6ece4aa534c5fae7f482e244d9583aacfb9::coin_decimals_registry::CoinDecimalsRegistry, arg8: &0x2929af9c3feca396beab1b842841a6ece4aa534c5fae7f482e244d9583aacfb9::x_oracle::XOracle, arg9: &0x2::clock::Clock, arg10: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        0x2929af9c3feca396beab1b842841a6ece4aa534c5fae7f482e244d9583aacfb9::vault::assert_ownership<T0, T1>(arg3, arg2);
        let (v0, v1, v2) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::flash_swap<T1, T0>(arg1, arg0, false, false, 0x2929af9c3feca396beab1b842841a6ece4aa534c5fae7f482e244d9583aacfb9::vault::get_withdraw_flash_swap_amount<T0, T1>(arg2, arg5), 79226673515401279992447579055, arg9);
        let v3 = v2;
        0x2::balance::destroy_zero<T0>(v1);
        let v4 = 0x2929af9c3feca396beab1b842841a6ece4aa534c5fae7f482e244d9583aacfb9::vault::withdraw<T0, T1>(arg2, 0x2::coin::from_balance<T1>(v0, arg10), arg4, arg5, arg6, arg7, arg8, arg9, arg10);
        0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::repay_flash_swap<T1, T0>(arg1, arg0, 0x2::balance::zero<T1>(), 0x2::coin::into_balance<T0>(0x2::coin::split<T0>(&mut v4, 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::swap_pay_amount<T1, T0>(&v3), arg10)), v3);
        v4
    }

    // decompiled from Move bytecode v6
}

