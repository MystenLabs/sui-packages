module 0xb6cc84cbb4e8c2403fbd7a462490fa80a45ec4853d1f043b8fe148bdeef7df09::arb {
    public fun calculate_arb_size(arg0: &0xb6cc84cbb4e8c2403fbd7a462490fa80a45ec4853d1f043b8fe148bdeef7df09::config::GlobalConfig, arg1: u64, arg2: u64) : u64 {
        let v0 = 0xb6cc84cbb4e8c2403fbd7a462490fa80a45ec4853d1f043b8fe148bdeef7df09::config::min_arb_gap_bps(arg0);
        let v1 = if (arg1 > v0) {
            arg1 - v0
        } else {
            0
        };
        let v2 = 0xb6cc84cbb4e8c2403fbd7a462490fa80a45ec4853d1f043b8fe148bdeef7df09::config::min_order_size(arg0) + v1 * 0xb6cc84cbb4e8c2403fbd7a462490fa80a45ec4853d1f043b8fe148bdeef7df09::config::arb_size_factor(arg0);
        let v3 = v2;
        if (v2 > 0xb6cc84cbb4e8c2403fbd7a462490fa80a45ec4853d1f043b8fe148bdeef7df09::config::max_arb_size(arg0)) {
            v3 = 0xb6cc84cbb4e8c2403fbd7a462490fa80a45ec4853d1f043b8fe148bdeef7df09::config::max_arb_size(arg0);
        };
        if (v3 > arg2) {
            v3 = arg2;
        };
        v3
    }

    public fun cetus_buy_base<T0, T1>(arg0: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::BalanceManager, arg1: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg2: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg3: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::partner::Partner, arg4: u64, arg5: u128, arg6: &0x2::clock::Clock, arg7: &mut 0x2::tx_context::TxContext) : (u64, u64) {
        let (v0, v1, v2) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::flash_swap_with_partner<T0, T1>(arg2, arg1, arg3, true, true, arg4, arg5, arg6);
        let v3 = v1;
        0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::deposit<T1>(arg0, 0x2::coin::from_balance<T1>(v3, arg7), arg7);
        0x2::balance::destroy_zero<T0>(v0);
        0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::repay_flash_swap_with_partner<T0, T1>(arg2, arg1, arg3, 0x2::coin::into_balance<T0>(0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::withdraw<T0>(arg0, arg4, arg7)), 0x2::balance::zero<T1>(), v2);
        (0x2::balance::value<T1>(&v3), arg4)
    }

    public fun cetus_sell_base<T0, T1>(arg0: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::BalanceManager, arg1: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg2: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg3: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::partner::Partner, arg4: u64, arg5: u128, arg6: &0x2::clock::Clock, arg7: &mut 0x2::tx_context::TxContext) : (u64, u64) {
        let (v0, v1, v2) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::flash_swap_with_partner<T0, T1>(arg2, arg1, arg3, false, true, arg4, arg5, arg6);
        let v3 = v0;
        0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::deposit<T0>(arg0, 0x2::coin::from_balance<T0>(v3, arg7), arg7);
        0x2::balance::destroy_zero<T1>(v1);
        0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::repay_flash_swap_with_partner<T0, T1>(arg2, arg1, arg3, 0x2::balance::zero<T0>(), 0x2::coin::into_balance<T1>(0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::withdraw<T1>(arg0, arg4, arg7)), v2);
        (arg4, 0x2::balance::value<T0>(&v3))
    }

    public fun check_buy_arb(arg0: &0xb6cc84cbb4e8c2403fbd7a462490fa80a45ec4853d1f043b8fe148bdeef7df09::config::GlobalConfig, arg1: u64, arg2: u64) : (bool, u64) {
        if (arg1 >= arg2) {
            return (false, 0)
        };
        let v0 = (arg2 - arg1) * 10000 / arg2;
        if (v0 < 0xb6cc84cbb4e8c2403fbd7a462490fa80a45ec4853d1f043b8fe148bdeef7df09::config::min_arb_gap_bps(arg0)) {
            return (false, v0)
        };
        (true, v0)
    }

    public fun check_sell_arb(arg0: &0xb6cc84cbb4e8c2403fbd7a462490fa80a45ec4853d1f043b8fe148bdeef7df09::config::GlobalConfig, arg1: u64, arg2: u64) : (bool, u64) {
        if (arg1 <= arg2) {
            return (false, 0)
        };
        let v0 = (arg1 - arg2) * 10000 / arg2;
        if (v0 < 0xb6cc84cbb4e8c2403fbd7a462490fa80a45ec4853d1f043b8fe148bdeef7df09::config::min_arb_gap_bps(arg0)) {
            return (false, v0)
        };
        (true, v0)
    }

    public fun effective_buy_price(arg0: u64, arg1: u64) : u64 {
        arg0 + arg0 * arg1 / 1000000
    }

    public fun effective_sell_price(arg0: u64, arg1: u64) : u64 {
        arg0 - arg0 * arg1 / 1000000
    }

    public fun scan_and_arb_cetus<T0, T1>(arg0: &0xb6cc84cbb4e8c2403fbd7a462490fa80a45ec4853d1f043b8fe148bdeef7df09::config::GlobalConfig, arg1: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::BalanceManager, arg2: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg3: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg4: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::partner::Partner, arg5: u64, arg6: u64, arg7: &0x2::clock::Clock, arg8: &mut 0x2::tx_context::TxContext) : (bool, u64) {
        let v0 = 0x2::clock::timestamp_ms(arg7);
        if (v0 < arg6 + 0xb6cc84cbb4e8c2403fbd7a462490fa80a45ec4853d1f043b8fe148bdeef7df09::config::arb_cooldown_ms(arg0)) {
            return (false, arg6)
        };
        let v1 = sqrt_price_to_price(0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::current_sqrt_price<T0, T1>(arg2));
        let v2 = 0xb6cc84cbb4e8c2403fbd7a462490fa80a45ec4853d1f043b8fe148bdeef7df09::config::cetus_fee_rate(arg0);
        let v3 = effective_buy_price(v1, v2);
        let (v4, v5) = check_buy_arb(arg0, v3, arg5);
        if (v4) {
            let v6 = calculate_arb_size(arg0, v5, 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::balance<T0>(arg1));
            if (v6 > 0xb6cc84cbb4e8c2403fbd7a462490fa80a45ec4853d1f043b8fe148bdeef7df09::config::min_order_size(arg0)) {
                let (v7, v8) = cetus_buy_base<T0, T1>(arg1, arg2, arg3, arg4, v6, 0, arg7, arg8);
                0xb6cc84cbb4e8c2403fbd7a462490fa80a45ec4853d1f043b8fe148bdeef7df09::events::emit_arb_execution(b"cetus_partner", true, v7, v8, v3, arg5, v5 * v6 / 10000, v0);
                return (true, v0)
            };
        };
        let v9 = effective_sell_price(v1, v2);
        let (v10, v11) = check_sell_arb(arg0, v9, arg5);
        if (v10) {
            let v12 = calculate_arb_size(arg0, v11, 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::balance<T1>(arg1));
            if (v12 > 0xb6cc84cbb4e8c2403fbd7a462490fa80a45ec4853d1f043b8fe148bdeef7df09::config::min_order_size(arg0)) {
                let (v13, v14) = cetus_sell_base<T0, T1>(arg1, arg2, arg3, arg4, v12, 0, arg7, arg8);
                0xb6cc84cbb4e8c2403fbd7a462490fa80a45ec4853d1f043b8fe148bdeef7df09::events::emit_arb_execution(b"cetus_partner", false, v13, v14, v9, arg5, v11 * v12 / 10000, v0);
                return (true, v0)
            };
        };
        0xb6cc84cbb4e8c2403fbd7a462490fa80a45ec4853d1f043b8fe148bdeef7df09::events::emit_arb_opportunity(b"cetus", true, v1, arg5, 0, false, v0);
        (false, arg6)
    }

    public fun sqrt_price_to_price(arg0: u128) : u64 {
        let v0 = arg0 >> 64;
        ((v0 * v0 + 2 * v0 * (arg0 & 18446744073709551615) / 18446744073709551616) as u64)
    }

    // decompiled from Move bytecode v6
}

