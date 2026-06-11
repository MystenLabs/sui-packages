module 0xe565f7de4e7bb089556ad4b813a378df4611fc349c6b0bc68223387919212bc2::deepbook_v3 {
    public fun send_or_destroy_zero_coin<T0>(arg0: 0x2::coin::Coin<T0>, arg1: &0x2::tx_context::TxContext) {
        if (0x2::coin::value<T0>(&arg0) > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(arg0, 0x2::tx_context::sender(arg1));
        } else {
            0x2::coin::destroy_zero<T0>(arg0);
        };
    }

    public fun swap_a2b_<T0, T1>(arg0: &mut 0xe565f7de4e7bb089556ad4b813a378df4611fc349c6b0bc68223387919212bc2::global_config::GlobalConfig, arg1: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T0, T1>, arg2: 0x2::coin::Coin<T0>, arg3: 0x2::coin::Coin<0xdeeb7a4662eec9f2f3def03fb937a663dddaa2e215b8078a284d026b7946c270::deep::DEEP>, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T0>, 0x2::coin::Coin<T1>, 0x2::coin::Coin<0xdeeb7a4662eec9f2f3def03fb937a663dddaa2e215b8078a284d026b7946c270::deep::DEEP>) {
        0xe565f7de4e7bb089556ad4b813a378df4611fc349c6b0bc68223387919212bc2::global_config::checked_package_version(arg0);
        let (_, _, v2) = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::get_quote_quantity_out<T0, T1>(arg1, 0x2::coin::value<T0>(&arg2), arg4);
        let v3 = 0x2::coin::value<0xdeeb7a4662eec9f2f3def03fb937a663dddaa2e215b8078a284d026b7946c270::deep::DEEP>(&arg3);
        let v4 = if (v2 > v3 && 0xe565f7de4e7bb089556ad4b813a378df4611fc349c6b0bc68223387919212bc2::global_config::is_whitelisted(arg0, 0x2::object::id<0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T0, T1>>(arg1))) {
            0xe565f7de4e7bb089556ad4b813a378df4611fc349c6b0bc68223387919212bc2::global_config::alternative_payment_deep(arg0, arg3, v2 - v3, arg5)
        } else {
            arg3
        };
        0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::swap_exact_base_for_quote<T0, T1>(arg1, arg2, v4, 0, arg4, arg5)
    }

    public fun swap_a2b_with_referral<T0, T1>(arg0: &mut 0xe565f7de4e7bb089556ad4b813a378df4611fc349c6b0bc68223387919212bc2::global_config::GlobalConfig, arg1: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T0, T1>, arg2: &0xe565f7de4e7bb089556ad4b813a378df4611fc349c6b0bc68223387919212bc2::global_config::BalanceCaps, arg3: &0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::DeepBookPoolReferral, arg4: 0x2::coin::Coin<T0>, arg5: 0x2::coin::Coin<0xdeeb7a4662eec9f2f3def03fb937a663dddaa2e215b8078a284d026b7946c270::deep::DEEP>, arg6: &0x2::clock::Clock, arg7: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T0>, 0x2::coin::Coin<T1>, 0x2::coin::Coin<0xdeeb7a4662eec9f2f3def03fb937a663dddaa2e215b8078a284d026b7946c270::deep::DEEP>) {
        0xe565f7de4e7bb089556ad4b813a378df4611fc349c6b0bc68223387919212bc2::global_config::checked_package_version(arg0);
        let (_, _, v2) = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::get_quote_quantity_out<T0, T1>(arg1, 0x2::coin::value<T0>(&arg4), arg6);
        let v3 = v2 + 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::math::mul(v2, 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::pool_referral_multiplier<T0, T1>(arg1, arg3));
        let v4 = 0x2::coin::value<0xdeeb7a4662eec9f2f3def03fb937a663dddaa2e215b8078a284d026b7946c270::deep::DEEP>(&arg5);
        let (v5, v6) = if (v3 > v4 && 0xe565f7de4e7bb089556ad4b813a378df4611fc349c6b0bc68223387919212bc2::global_config::is_whitelisted(arg0, 0x2::object::id<0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T0, T1>>(arg1))) {
            (0xe565f7de4e7bb089556ad4b813a378df4611fc349c6b0bc68223387919212bc2::global_config::alternative_payment_deep(arg0, arg5, v3 - v4, arg7), 0)
        } else if (v3 > v4) {
            (arg5, 0)
        } else {
            (arg5, v4 - v3)
        };
        let (v7, v8) = 0xe565f7de4e7bb089556ad4b813a378df4611fc349c6b0bc68223387919212bc2::global_config::get_deposit_and_withdraw_caps(arg2);
        let (v9, v10) = 0xe565f7de4e7bb089556ad4b813a378df4611fc349c6b0bc68223387919212bc2::global_config::get_mut_balance_manager_and_trade_cap(arg0);
        0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::deposit_with_cap<0xdeeb7a4662eec9f2f3def03fb937a663dddaa2e215b8078a284d026b7946c270::deep::DEEP>(v9, v7, v5, arg7);
        let (v11, v12) = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::swap_exact_base_for_quote_with_manager<T0, T1>(arg1, v9, v10, v7, v8, arg4, 0, arg6, arg7);
        assert!(0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::balance<0xdeeb7a4662eec9f2f3def03fb937a663dddaa2e215b8078a284d026b7946c270::deep::DEEP>(v9) == 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::balance<0xdeeb7a4662eec9f2f3def03fb937a663dddaa2e215b8078a284d026b7946c270::deep::DEEP>(v9), 1);
        assert!(0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::balance<T0>(v9) == 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::balance<T0>(v9), 1);
        assert!(0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::balance<T1>(v9) == 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::balance<T1>(v9), 1);
        (v11, v12, 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::withdraw_with_cap<0xdeeb7a4662eec9f2f3def03fb937a663dddaa2e215b8078a284d026b7946c270::deep::DEEP>(v9, v8, v6, arg7))
    }

    public fun swap_b2a_<T0, T1>(arg0: &mut 0xe565f7de4e7bb089556ad4b813a378df4611fc349c6b0bc68223387919212bc2::global_config::GlobalConfig, arg1: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T0, T1>, arg2: 0x2::coin::Coin<T1>, arg3: 0x2::coin::Coin<0xdeeb7a4662eec9f2f3def03fb937a663dddaa2e215b8078a284d026b7946c270::deep::DEEP>, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T0>, 0x2::coin::Coin<T1>, 0x2::coin::Coin<0xdeeb7a4662eec9f2f3def03fb937a663dddaa2e215b8078a284d026b7946c270::deep::DEEP>) {
        0xe565f7de4e7bb089556ad4b813a378df4611fc349c6b0bc68223387919212bc2::global_config::checked_package_version(arg0);
        let (_, _, v2) = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::get_base_quantity_out<T0, T1>(arg1, 0x2::coin::value<T1>(&arg2), arg4);
        let v3 = 0x2::coin::value<0xdeeb7a4662eec9f2f3def03fb937a663dddaa2e215b8078a284d026b7946c270::deep::DEEP>(&arg3);
        let v4 = if (v2 > v3 && 0xe565f7de4e7bb089556ad4b813a378df4611fc349c6b0bc68223387919212bc2::global_config::is_whitelisted(arg0, 0x2::object::id<0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T0, T1>>(arg1))) {
            0xe565f7de4e7bb089556ad4b813a378df4611fc349c6b0bc68223387919212bc2::global_config::alternative_payment_deep(arg0, arg3, v2 - v3, arg5)
        } else {
            arg3
        };
        0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::swap_exact_quote_for_base<T0, T1>(arg1, arg2, v4, 0, arg4, arg5)
    }

    public fun swap_b2a_with_referral<T0, T1>(arg0: &mut 0xe565f7de4e7bb089556ad4b813a378df4611fc349c6b0bc68223387919212bc2::global_config::GlobalConfig, arg1: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T0, T1>, arg2: &0xe565f7de4e7bb089556ad4b813a378df4611fc349c6b0bc68223387919212bc2::global_config::BalanceCaps, arg3: &0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::DeepBookPoolReferral, arg4: 0x2::coin::Coin<T1>, arg5: 0x2::coin::Coin<0xdeeb7a4662eec9f2f3def03fb937a663dddaa2e215b8078a284d026b7946c270::deep::DEEP>, arg6: &0x2::clock::Clock, arg7: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T0>, 0x2::coin::Coin<T1>, 0x2::coin::Coin<0xdeeb7a4662eec9f2f3def03fb937a663dddaa2e215b8078a284d026b7946c270::deep::DEEP>) {
        0xe565f7de4e7bb089556ad4b813a378df4611fc349c6b0bc68223387919212bc2::global_config::checked_package_version(arg0);
        let (_, _, v2) = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::get_base_quantity_out<T0, T1>(arg1, 0x2::coin::value<T1>(&arg4), arg6);
        let v3 = v2 + 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::math::mul(v2, 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::pool_referral_multiplier<T0, T1>(arg1, arg3));
        let v4 = 0x2::coin::value<0xdeeb7a4662eec9f2f3def03fb937a663dddaa2e215b8078a284d026b7946c270::deep::DEEP>(&arg5);
        let (v5, v6) = if (v3 > v4 && 0xe565f7de4e7bb089556ad4b813a378df4611fc349c6b0bc68223387919212bc2::global_config::is_whitelisted(arg0, 0x2::object::id<0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T0, T1>>(arg1))) {
            (0xe565f7de4e7bb089556ad4b813a378df4611fc349c6b0bc68223387919212bc2::global_config::alternative_payment_deep(arg0, arg5, v3 - v4, arg7), 0)
        } else if (v3 > v4) {
            (arg5, 0)
        } else {
            (arg5, v4 - v3)
        };
        let (v7, v8) = 0xe565f7de4e7bb089556ad4b813a378df4611fc349c6b0bc68223387919212bc2::global_config::get_deposit_and_withdraw_caps(arg2);
        let (v9, v10) = 0xe565f7de4e7bb089556ad4b813a378df4611fc349c6b0bc68223387919212bc2::global_config::get_mut_balance_manager_and_trade_cap(arg0);
        0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::deposit_with_cap<0xdeeb7a4662eec9f2f3def03fb937a663dddaa2e215b8078a284d026b7946c270::deep::DEEP>(v9, v7, v5, arg7);
        let (v11, v12) = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::swap_exact_quote_for_base_with_manager<T0, T1>(arg1, v9, v10, v7, v8, arg4, 0, arg6, arg7);
        assert!(0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::balance<0xdeeb7a4662eec9f2f3def03fb937a663dddaa2e215b8078a284d026b7946c270::deep::DEEP>(v9) == 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::balance<0xdeeb7a4662eec9f2f3def03fb937a663dddaa2e215b8078a284d026b7946c270::deep::DEEP>(v9), 1);
        assert!(0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::balance<T0>(v9) == 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::balance<T0>(v9), 1);
        assert!(0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::balance<T1>(v9) == 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::balance<T1>(v9), 1);
        (v11, v12, 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::withdraw_with_cap<0xdeeb7a4662eec9f2f3def03fb937a663dddaa2e215b8078a284d026b7946c270::deep::DEEP>(v9, v8, v6, arg7))
    }

    // decompiled from Move bytecode v7
}

