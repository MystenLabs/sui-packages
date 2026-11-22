module 0x13b56bacccc98e8393b28b07cb88442e720659aabd9a6a38e5db1b2c40d39b95::account {
    fun buy<T0, T1>(arg0: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T0, T1>, arg1: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::BalanceManager, arg2: 0x2::balance::Balance<T1>, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) : (0x2::balance::Balance<T0>, 0x2::balance::Balance<T1>) {
        let (v0, _, _) = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::get_quantity_out_input_fee<T0, T1>(arg0, 0, 0x2::balance::value<T1>(&arg2), arg3);
        trade<T0, T1>(arg0, arg1, 0x2::balance::zero<T0>(), arg2, v0, true, arg3, arg4)
    }

    fun return_dust<T0>(arg0: 0x2::coin::Coin<T0>, arg1: &0x2::tx_context::TxContext) {
        if (0x2::coin::value<T0>(&arg0) == 0) {
            0x2::coin::destroy_zero<T0>(arg0);
        } else {
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(arg0, 0x2::tx_context::sender(arg1));
        };
    }

    fun sell<T0, T1>(arg0: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T0, T1>, arg1: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::BalanceManager, arg2: 0x2::balance::Balance<T0>, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) : (0x2::balance::Balance<T0>, 0x2::balance::Balance<T1>) {
        let (v0, _, _) = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::pool_trade_params<T0, T1>(arg0);
        let v3 = (0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::constants::float_scaling() as u128);
        trade<T0, T1>(arg0, arg1, arg2, 0x2::balance::zero<T1>(), (((0x2::balance::value<T0>(&arg2) as u128) * v3 / (v3 + (v0 as u128) * (0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::constants::fee_penalty_multiplier() as u128) / v3)) as u64), false, arg3, arg4)
    }

    public fun swap_base_to_quote_or_skip<T0, T1>(arg0: &0xabb5100d490fd94c95c6e71e284a49c1de2fc3003702df216a8902a112b3bc7c::session::Session, arg1: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T0, T1>, arg2: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::BalanceManager, arg3: 0x2::balance::Balance<T0>, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) : 0x2::balance::Balance<T1> {
        if (!0xabb5100d490fd94c95c6e71e284a49c1de2fc3003702df216a8902a112b3bc7c::session::live(arg0)) {
            0x2::balance::destroy_zero<T0>(arg3);
            return 0x2::balance::zero<T1>()
        };
        let (v0, v1) = sell<T0, T1>(arg1, arg2, arg3, arg4, arg5);
        return_dust<T0>(0x2::coin::from_balance<T0>(v0, arg5), arg5);
        v1
    }

    public fun swap_base_to_quote_refunded_or_skip<T0, T1>(arg0: &0xabb5100d490fd94c95c6e71e284a49c1de2fc3003702df216a8902a112b3bc7c::session::Session, arg1: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T0, T1>, arg2: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::BalanceManager, arg3: 0x2::balance::Balance<T0>, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) : (0x2::balance::Balance<T1>, 0x2::balance::Balance<T0>) {
        if (!0xabb5100d490fd94c95c6e71e284a49c1de2fc3003702df216a8902a112b3bc7c::session::live(arg0)) {
            0x2::balance::destroy_zero<T0>(arg3);
            return (0x2::balance::zero<T1>(), 0x2::balance::zero<T0>())
        };
        let (v0, v1) = sell<T0, T1>(arg1, arg2, arg3, arg4, arg5);
        (v1, v0)
    }

    public fun swap_quote_to_base_or_skip<T0, T1>(arg0: &0xabb5100d490fd94c95c6e71e284a49c1de2fc3003702df216a8902a112b3bc7c::session::Session, arg1: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T0, T1>, arg2: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::BalanceManager, arg3: 0x2::balance::Balance<T1>, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) : 0x2::balance::Balance<T0> {
        if (!0xabb5100d490fd94c95c6e71e284a49c1de2fc3003702df216a8902a112b3bc7c::session::live(arg0)) {
            0x2::balance::destroy_zero<T1>(arg3);
            return 0x2::balance::zero<T0>()
        };
        let (v0, v1) = buy<T0, T1>(arg1, arg2, arg3, arg4, arg5);
        return_dust<T1>(0x2::coin::from_balance<T1>(v1, arg5), arg5);
        v0
    }

    public fun swap_quote_to_base_refunded_or_skip<T0, T1>(arg0: &0xabb5100d490fd94c95c6e71e284a49c1de2fc3003702df216a8902a112b3bc7c::session::Session, arg1: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T0, T1>, arg2: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::BalanceManager, arg3: 0x2::balance::Balance<T1>, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) : (0x2::balance::Balance<T0>, 0x2::balance::Balance<T1>) {
        if (!0xabb5100d490fd94c95c6e71e284a49c1de2fc3003702df216a8902a112b3bc7c::session::live(arg0)) {
            0x2::balance::destroy_zero<T1>(arg3);
            return (0x2::balance::zero<T0>(), 0x2::balance::zero<T1>())
        };
        buy<T0, T1>(arg1, arg2, arg3, arg4, arg5)
    }

    fun trade<T0, T1>(arg0: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T0, T1>, arg1: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::BalanceManager, arg2: 0x2::balance::Balance<T0>, arg3: 0x2::balance::Balance<T1>, arg4: u64, arg5: bool, arg6: &0x2::clock::Clock, arg7: &mut 0x2::tx_context::TxContext) : (0x2::balance::Balance<T0>, 0x2::balance::Balance<T1>) {
        let (_, v1, v2) = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::pool_book_params<T0, T1>(arg0);
        let v3 = arg4 - arg4 % v1;
        if (v3 < v2) {
            return (arg2, arg3)
        };
        0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::deposit<T0>(arg1, 0x2::coin::from_balance<T0>(arg2, arg7), arg7);
        0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::deposit<T1>(arg1, 0x2::coin::from_balance<T1>(arg3, arg7), arg7);
        let v4 = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::generate_proof_as_owner(arg1, arg7);
        0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::place_market_order<T0, T1>(arg0, arg1, &v4, 0, 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::constants::self_matching_allowed(), v3, arg5, false, arg6, arg7);
        (0x2::coin::into_balance<T0>(0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::withdraw_all<T0>(arg1, arg7)), 0x2::coin::into_balance<T1>(0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::withdraw_all<T1>(arg1, arg7)))
    }

    // decompiled from Move bytecode v7
}

