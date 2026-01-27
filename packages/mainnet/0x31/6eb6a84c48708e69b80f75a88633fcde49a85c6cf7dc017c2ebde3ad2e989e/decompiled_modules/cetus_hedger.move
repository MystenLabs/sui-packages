module 0x316eb6a84c48708e69b80f75a88633fcde49a85c6cf7dc017c2ebde3ad2e989e::cetus_hedger {
    public fun analyze_hedge_opportunity<T0, T1>(arg0: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg1: u64, arg2: bool, arg3: u64) : (u64, u64, bool, u64) {
        let v0 = sqrt_price_to_price(read_cetus_sqrt_price<T0, T1>(arg0));
        let v1 = apply_cetus_fee(v0, read_cetus_fee_rate<T0, T1>(arg0), arg2);
        let v2 = arg2 && should_hedge_sell(v1, arg1, arg3) || should_hedge_buy(v1, arg1, arg3);
        (v0, v1, v2, calculate_hedge_profit_bps(v1, arg1, arg2))
    }

    public fun apply_cetus_fee(arg0: u64, arg1: u64, arg2: bool) : u64 {
        if (arg2) {
            arg0 - arg0 * arg1 / 1000000
        } else {
            arg0 + arg0 * arg1 / 1000000
        }
    }

    public fun calculate_hedge_amount(arg0: u64, arg1: u64, arg2: u64, arg3: u64) : (u64, bool) {
        let (v0, v1) = if (arg0 >= arg1) {
            (arg0 - arg1, true)
        } else {
            (arg1 - arg0, false)
        };
        let v2 = v0 * arg2 / 10000;
        if (v2 < arg3) {
            return (0, v1)
        };
        (v2, v1)
    }

    public fun calculate_hedge_profit_bps(arg0: u64, arg1: u64, arg2: bool) : u64 {
        if (arg2) {
            if (arg0 <= arg1) {
                0
            } else {
                (arg0 - arg1) * 10000 / arg1
            }
        } else if (arg1 <= arg0) {
            0
        } else {
            (arg1 - arg0) * 10000 / arg1
        }
    }

    public fun flash_swap_buy_sui<T0>(arg0: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::BalanceManager, arg1: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, 0x2::sui::SUI>, arg2: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg3: u64, arg4: u64, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) : (u64, u64) {
        let (v0, v1, v2) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::flash_swap<T0, 0x2::sui::SUI>(arg2, arg1, true, false, arg3, 79226673515401279992447579055, arg5);
        let v3 = v2;
        let v4 = v1;
        let v5 = v0;
        let v6 = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::swap_pay_amount<T0, 0x2::sui::SUI>(&v3) - 0x2::balance::value<T0>(&v5);
        assert!(v6 <= arg4, 1);
        0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::deposit<0x2::sui::SUI>(arg0, 0x2::coin::from_balance<0x2::sui::SUI>(v4, arg6), arg6);
        let v7 = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::withdraw<T0>(arg0, v6, arg6);
        0x2::coin::join<T0>(&mut v7, 0x2::coin::from_balance<T0>(v5, arg6));
        0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::repay_flash_swap<T0, 0x2::sui::SUI>(arg2, arg1, 0x2::coin::into_balance<T0>(v7), 0x2::balance::zero<0x2::sui::SUI>(), v3);
        (v6, 0x2::balance::value<0x2::sui::SUI>(&v4))
    }

    public fun flash_swap_sell_sui<T0>(arg0: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::BalanceManager, arg1: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, 0x2::sui::SUI>, arg2: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg3: u64, arg4: u64, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) : (u64, u64) {
        let (v0, v1, v2) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::flash_swap<T0, 0x2::sui::SUI>(arg2, arg1, false, true, arg3, 4295048016, arg5);
        let v3 = v2;
        let v4 = v1;
        let v5 = v0;
        let v6 = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::swap_pay_amount<T0, 0x2::sui::SUI>(&v3) - 0x2::balance::value<0x2::sui::SUI>(&v4);
        let v7 = 0x2::balance::value<T0>(&v5);
        assert!(v7 >= arg4, 1);
        0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::deposit<T0>(arg0, 0x2::coin::from_balance<T0>(v5, arg6), arg6);
        let v8 = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::withdraw<0x2::sui::SUI>(arg0, v6, arg6);
        0x2::coin::join<0x2::sui::SUI>(&mut v8, 0x2::coin::from_balance<0x2::sui::SUI>(v4, arg6));
        0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::repay_flash_swap<T0, 0x2::sui::SUI>(arg2, arg1, 0x2::balance::zero<T0>(), 0x2::coin::into_balance<0x2::sui::SUI>(v8), v3);
        (v6, v7)
    }

    public fun read_cetus_fee_rate<T0, T1>(arg0: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>) : u64 {
        0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::fee_rate<T0, T1>(arg0)
    }

    public fun read_cetus_sqrt_price<T0, T1>(arg0: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>) : u128 {
        0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::current_sqrt_price<T0, T1>(arg0)
    }

    public fun should_hedge_buy(arg0: u64, arg1: u64, arg2: u64) : bool {
        let v0 = arg1 * arg2 / 10000;
        if (v0 >= arg1) {
            return false
        };
        arg0 <= arg1 - v0
    }

    public fun should_hedge_sell(arg0: u64, arg1: u64, arg2: u64) : bool {
        arg0 >= arg1 + arg1 * arg2 / 10000
    }

    public fun sqrt_price_to_price(arg0: u128) : u64 {
        let v0 = (arg0 as u256);
        ((340282366920938463463374607431768211456000000000 / v0 / v0) as u64)
    }

    public fun sqrt_price_to_price_inverse(arg0: u128) : u64 {
        let v0 = (arg0 as u256);
        ((v0 * v0 / 340282366920938463463374607431768211456000000000 / 1000000000) as u64)
    }

    // decompiled from Move bytecode v6
}

