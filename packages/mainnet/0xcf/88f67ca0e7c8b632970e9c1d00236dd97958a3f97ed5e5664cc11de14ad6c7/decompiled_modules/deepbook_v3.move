module 0xcf88f67ca0e7c8b632970e9c1d00236dd97958a3f97ed5e5664cc11de14ad6c7::deepbook_v3 {
    public(friend) fun fee_margin(arg0: u64, arg1: u64, arg2: u64) : u64 {
        if (arg0 == 0 || arg1 == 0) {
            return 0
        };
        (((arg0 as u128) * (arg2 as u128) / (arg1 as u128)) as u64) + arg0 / 10 + 1
    }

    public fun swap_a2b_sponsored<T0, T1>(arg0: &mut 0xcf88f67ca0e7c8b632970e9c1d00236dd97958a3f97ed5e5664cc11de14ad6c7::global_config::GlobalConfig, arg1: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T0, T1>, arg2: 0x2::coin::Coin<T0>, arg3: 0x2::coin::Coin<0xdeeb7a4662eec9f2f3def03fb937a663dddaa2e215b8078a284d026b7946c270::deep::DEEP>, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T0>, 0x2::coin::Coin<T1>, 0x2::coin::Coin<0xdeeb7a4662eec9f2f3def03fb937a663dddaa2e215b8078a284d026b7946c270::deep::DEEP>) {
        0xcf88f67ca0e7c8b632970e9c1d00236dd97958a3f97ed5e5664cc11de14ad6c7::global_config::checked_package_version(arg0);
        let (_, _, v2) = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::get_quote_quantity_out<T0, T1>(arg1, 0x2::coin::value<T0>(&arg2), arg4);
        let (v3, v4) = top_up_deep<T0, T1>(arg0, arg1, v2, arg3, arg5);
        let (v5, v6, v7) = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::swap_exact_base_for_quote<T0, T1>(arg1, arg2, v3, 0, arg4, arg5);
        let v8 = v7;
        0xcf88f67ca0e7c8b632970e9c1d00236dd97958a3f97ed5e5664cc11de14ad6c7::global_config::refund_sponsor_deep(arg0, &mut v8, v4, arg5);
        (v5, v6, v8)
    }

    public fun swap_a2b_with_referral<T0, T1>(arg0: &mut 0xcf88f67ca0e7c8b632970e9c1d00236dd97958a3f97ed5e5664cc11de14ad6c7::global_config::GlobalConfig, arg1: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T0, T1>, arg2: &0xcf88f67ca0e7c8b632970e9c1d00236dd97958a3f97ed5e5664cc11de14ad6c7::global_config::BalanceCaps, arg3: &0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::DeepBookPoolReferral, arg4: 0x2::coin::Coin<T0>, arg5: 0x2::coin::Coin<0xdeeb7a4662eec9f2f3def03fb937a663dddaa2e215b8078a284d026b7946c270::deep::DEEP>, arg6: &0x2::clock::Clock, arg7: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T0>, 0x2::coin::Coin<T1>, 0x2::coin::Coin<0xdeeb7a4662eec9f2f3def03fb937a663dddaa2e215b8078a284d026b7946c270::deep::DEEP>) {
        0xcf88f67ca0e7c8b632970e9c1d00236dd97958a3f97ed5e5664cc11de14ad6c7::global_config::checked_package_version(arg0);
        let (_, _, v2) = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::get_quote_quantity_out<T0, T1>(arg1, 0x2::coin::value<T0>(&arg4), arg6);
        let (v3, v4) = top_up_deep<T0, T1>(arg0, arg1, v2 + 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::math::mul(v2, 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::pool_referral_multiplier<T0, T1>(arg1, arg3)), arg5, arg7);
        let (v5, v6) = 0xcf88f67ca0e7c8b632970e9c1d00236dd97958a3f97ed5e5664cc11de14ad6c7::global_config::get_deposit_and_withdraw_caps(arg2);
        let (v7, v8) = 0xcf88f67ca0e7c8b632970e9c1d00236dd97958a3f97ed5e5664cc11de14ad6c7::global_config::get_mut_balance_manager_and_trade_cap(arg0);
        let v9 = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::balance<0xdeeb7a4662eec9f2f3def03fb937a663dddaa2e215b8078a284d026b7946c270::deep::DEEP>(v7);
        0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::deposit_with_cap<0xdeeb7a4662eec9f2f3def03fb937a663dddaa2e215b8078a284d026b7946c270::deep::DEEP>(v7, v5, v3, arg7);
        let (v10, v11) = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::swap_exact_base_for_quote_with_manager<T0, T1>(arg1, v7, v8, v5, v6, arg4, 0, arg6, arg7);
        let v12 = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::balance<0xdeeb7a4662eec9f2f3def03fb937a663dddaa2e215b8078a284d026b7946c270::deep::DEEP>(v7);
        assert!(v12 >= v9, 1);
        let v13 = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::withdraw_with_cap<0xdeeb7a4662eec9f2f3def03fb937a663dddaa2e215b8078a284d026b7946c270::deep::DEEP>(v7, v6, v12 - v9, arg7);
        assert!(0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::balance<T0>(v7) == 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::balance<T0>(v7), 1);
        assert!(0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::balance<T1>(v7) == 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::balance<T1>(v7), 1);
        0xcf88f67ca0e7c8b632970e9c1d00236dd97958a3f97ed5e5664cc11de14ad6c7::global_config::refund_sponsor_deep(arg0, &mut v13, v4, arg7);
        (v10, v11, v13)
    }

    public fun swap_b2a_sponsored<T0, T1>(arg0: &mut 0xcf88f67ca0e7c8b632970e9c1d00236dd97958a3f97ed5e5664cc11de14ad6c7::global_config::GlobalConfig, arg1: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T0, T1>, arg2: 0x2::coin::Coin<T1>, arg3: 0x2::coin::Coin<0xdeeb7a4662eec9f2f3def03fb937a663dddaa2e215b8078a284d026b7946c270::deep::DEEP>, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T0>, 0x2::coin::Coin<T1>, 0x2::coin::Coin<0xdeeb7a4662eec9f2f3def03fb937a663dddaa2e215b8078a284d026b7946c270::deep::DEEP>) {
        0xcf88f67ca0e7c8b632970e9c1d00236dd97958a3f97ed5e5664cc11de14ad6c7::global_config::checked_package_version(arg0);
        let (_, _, v2) = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::get_base_quantity_out<T0, T1>(arg1, 0x2::coin::value<T1>(&arg2), arg4);
        let (v3, v4) = top_up_deep<T0, T1>(arg0, arg1, v2, arg3, arg5);
        let (v5, v6, v7) = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::swap_exact_quote_for_base<T0, T1>(arg1, arg2, v3, 0, arg4, arg5);
        let v8 = v7;
        0xcf88f67ca0e7c8b632970e9c1d00236dd97958a3f97ed5e5664cc11de14ad6c7::global_config::refund_sponsor_deep(arg0, &mut v8, v4, arg5);
        (v5, v6, v8)
    }

    public fun swap_b2a_with_referral<T0, T1>(arg0: &mut 0xcf88f67ca0e7c8b632970e9c1d00236dd97958a3f97ed5e5664cc11de14ad6c7::global_config::GlobalConfig, arg1: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T0, T1>, arg2: &0xcf88f67ca0e7c8b632970e9c1d00236dd97958a3f97ed5e5664cc11de14ad6c7::global_config::BalanceCaps, arg3: &0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::DeepBookPoolReferral, arg4: 0x2::coin::Coin<T1>, arg5: 0x2::coin::Coin<0xdeeb7a4662eec9f2f3def03fb937a663dddaa2e215b8078a284d026b7946c270::deep::DEEP>, arg6: &0x2::clock::Clock, arg7: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T0>, 0x2::coin::Coin<T1>, 0x2::coin::Coin<0xdeeb7a4662eec9f2f3def03fb937a663dddaa2e215b8078a284d026b7946c270::deep::DEEP>) {
        0xcf88f67ca0e7c8b632970e9c1d00236dd97958a3f97ed5e5664cc11de14ad6c7::global_config::checked_package_version(arg0);
        let (_, _, v2) = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::get_base_quantity_out<T0, T1>(arg1, 0x2::coin::value<T1>(&arg4), arg6);
        let (v3, v4) = top_up_deep<T0, T1>(arg0, arg1, v2 + 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::math::mul(v2, 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::pool_referral_multiplier<T0, T1>(arg1, arg3)), arg5, arg7);
        let (v5, v6) = 0xcf88f67ca0e7c8b632970e9c1d00236dd97958a3f97ed5e5664cc11de14ad6c7::global_config::get_deposit_and_withdraw_caps(arg2);
        let (v7, v8) = 0xcf88f67ca0e7c8b632970e9c1d00236dd97958a3f97ed5e5664cc11de14ad6c7::global_config::get_mut_balance_manager_and_trade_cap(arg0);
        let v9 = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::balance<0xdeeb7a4662eec9f2f3def03fb937a663dddaa2e215b8078a284d026b7946c270::deep::DEEP>(v7);
        0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::deposit_with_cap<0xdeeb7a4662eec9f2f3def03fb937a663dddaa2e215b8078a284d026b7946c270::deep::DEEP>(v7, v5, v3, arg7);
        let (v10, v11) = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::swap_exact_quote_for_base_with_manager<T0, T1>(arg1, v7, v8, v5, v6, arg4, 0, arg6, arg7);
        let v12 = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::balance<0xdeeb7a4662eec9f2f3def03fb937a663dddaa2e215b8078a284d026b7946c270::deep::DEEP>(v7);
        assert!(v12 >= v9, 1);
        let v13 = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::withdraw_with_cap<0xdeeb7a4662eec9f2f3def03fb937a663dddaa2e215b8078a284d026b7946c270::deep::DEEP>(v7, v6, v12 - v9, arg7);
        assert!(0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::balance<T0>(v7) == 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::balance<T0>(v7), 1);
        assert!(0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::balance<T1>(v7) == 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::balance<T1>(v7), 1);
        0xcf88f67ca0e7c8b632970e9c1d00236dd97958a3f97ed5e5664cc11de14ad6c7::global_config::refund_sponsor_deep(arg0, &mut v13, v4, arg7);
        (v10, v11, v13)
    }

    fun top_up_deep<T0, T1>(arg0: &mut 0xcf88f67ca0e7c8b632970e9c1d00236dd97958a3f97ed5e5664cc11de14ad6c7::global_config::GlobalConfig, arg1: &0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T0, T1>, arg2: u64, arg3: 0x2::coin::Coin<0xdeeb7a4662eec9f2f3def03fb937a663dddaa2e215b8078a284d026b7946c270::deep::DEEP>, arg4: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<0xdeeb7a4662eec9f2f3def03fb937a663dddaa2e215b8078a284d026b7946c270::deep::DEEP>, u64) {
        let v0 = 0x2::coin::value<0xdeeb7a4662eec9f2f3def03fb937a663dddaa2e215b8078a284d026b7946c270::deep::DEEP>(&arg3);
        if (!0xcf88f67ca0e7c8b632970e9c1d00236dd97958a3f97ed5e5664cc11de14ad6c7::global_config::is_sponsored_pool(arg0, 0x2::object::id<0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T0, T1>>(arg1))) {
            return (arg3, 0)
        };
        let (v1, _, _) = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::pool_trade_params<T0, T1>(arg1);
        let v4 = arg2 + fee_margin(arg2, v1, 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::constants::max_additional_taker_fee());
        if (v4 <= v0) {
            return (arg3, 0)
        };
        let v5 = 0xcf88f67ca0e7c8b632970e9c1d00236dd97958a3f97ed5e5664cc11de14ad6c7::global_config::alternative_payment_deep(arg0, arg3, v4 - v0, arg4);
        if (0x2::coin::value<0xdeeb7a4662eec9f2f3def03fb937a663dddaa2e215b8078a284d026b7946c270::deep::DEEP>(&v5) == v0 && arg2 > v0) {
            let v6 = v5;
            v5 = 0xcf88f67ca0e7c8b632970e9c1d00236dd97958a3f97ed5e5664cc11de14ad6c7::global_config::alternative_payment_deep(arg0, v6, arg2 - v0, arg4);
        };
        (v5, 0x2::coin::value<0xdeeb7a4662eec9f2f3def03fb937a663dddaa2e215b8078a284d026b7946c270::deep::DEEP>(&v5) - v0)
    }

    // decompiled from Move bytecode v7
}

