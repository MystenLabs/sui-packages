module 0x90de9a12e1b10d3ff28c57b231c28c1740dff4bb1c1781b951f5ed560a3779f9::swap {
    struct SwapExecuted<phantom T0, phantom T1> has copy, drop {
        fee_manager_id: 0x2::object::ID,
        pool_id: 0x2::object::ID,
        base_to_quote: bool,
        input_amount: u64,
        output_amount: u64,
        input_remainder: u64,
        fee_amount: u64,
        client_id: u64,
    }

    public fun get_quantity_out_input_fee<T0, T1>(arg0: &0x90de9a12e1b10d3ff28c57b231c28c1740dff4bb1c1781b951f5ed560a3779f9::fee::TradingFeeConfig, arg1: &0x90de9a12e1b10d3ff28c57b231c28c1740dff4bb1c1781b951f5ed560a3779f9::loyalty::LoyaltyProgram, arg2: &0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T0, T1>, arg3: u64, arg4: u64, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) : (u64, u64, u64) {
        let (v0, v1, v2) = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::get_quantity_out_input_fee<T0, T1>(arg2, arg3, arg4, arg5);
        let (v3, _) = 0x90de9a12e1b10d3ff28c57b231c28c1740dff4bb1c1781b951f5ed560a3779f9::fee::input_coin_fee_type_rates(0x90de9a12e1b10d3ff28c57b231c28c1740dff4bb1c1781b951f5ed560a3779f9::fee::get_pool_fee_config<T0, T1>(arg0, arg2));
        let (v5, v6) = apply_protocol_swap_fee(v3, 0x90de9a12e1b10d3ff28c57b231c28c1740dff4bb1c1781b951f5ed560a3779f9::loyalty::get_user_discount_rate(arg1, 0x2::tx_context::sender(arg6)), v0, v1, arg3, arg4);
        (v5, v6, v2)
    }

    fun apply_protocol_swap_fee(arg0: u64, arg1: u64, arg2: u64, arg3: u64, arg4: u64, arg5: u64) : (u64, u64) {
        if (arg4 > 0) {
            let v0 = 0x90de9a12e1b10d3ff28c57b231c28c1740dff4bb1c1781b951f5ed560a3779f9::helper::apply_discount(0x90de9a12e1b10d3ff28c57b231c28c1740dff4bb1c1781b951f5ed560a3779f9::fee::calculate_fee_by_rate(arg3, arg0), arg1);
            arg3 = arg3 - v0;
        } else if (arg5 > 0) {
            let v1 = 0x90de9a12e1b10d3ff28c57b231c28c1740dff4bb1c1781b951f5ed560a3779f9::helper::apply_discount(0x90de9a12e1b10d3ff28c57b231c28c1740dff4bb1c1781b951f5ed560a3779f9::fee::calculate_fee_by_rate(arg2, arg0), arg1);
            arg2 = arg2 - v1;
        };
        (arg2, arg3)
    }

    fun charge_protocol_swap_fee<T0>(arg0: &mut 0x2::coin::Coin<T0>, arg1: u64, arg2: u64) : 0x2::balance::Balance<T0> {
        let v0 = 0x2::coin::balance_mut<T0>(arg0);
        let v1 = 0x2::balance::value<T0>(v0);
        let v2 = 0x90de9a12e1b10d3ff28c57b231c28c1740dff4bb1c1781b951f5ed560a3779f9::helper::apply_discount(0x90de9a12e1b10d3ff28c57b231c28c1740dff4bb1c1781b951f5ed560a3779f9::fee::calculate_fee_by_rate(v1, arg1), arg2);
        assert!(v1 >= v2, 2);
        0x2::balance::split<T0>(v0, v2)
    }

    public fun swap_exact_base_for_quote_input_fee<T0, T1>(arg0: &0x90de9a12e1b10d3ff28c57b231c28c1740dff4bb1c1781b951f5ed560a3779f9::treasury::Treasury, arg1: &mut 0x90de9a12e1b10d3ff28c57b231c28c1740dff4bb1c1781b951f5ed560a3779f9::fee_manager::FeeManager, arg2: &0x90de9a12e1b10d3ff28c57b231c28c1740dff4bb1c1781b951f5ed560a3779f9::fee::TradingFeeConfig, arg3: &0x90de9a12e1b10d3ff28c57b231c28c1740dff4bb1c1781b951f5ed560a3779f9::loyalty::LoyaltyProgram, arg4: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T0, T1>, arg5: 0x2::coin::Coin<T0>, arg6: u64, arg7: u64, arg8: &0x2::clock::Clock, arg9: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T0>, 0x2::coin::Coin<T1>) {
        0x90de9a12e1b10d3ff28c57b231c28c1740dff4bb1c1781b951f5ed560a3779f9::treasury::verify_version(arg0);
        let (v0, v1, v2) = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::swap_exact_quantity<T0, T1>(arg4, arg5, 0x2::coin::zero<T1>(arg9), 0x2::coin::zero<0xdeeb7a4662eec9f2f3def03fb937a663dddaa2e215b8078a284d026b7946c270::deep::DEEP>(arg9), arg6, arg8, arg9);
        let v3 = v0;
        0x2::coin::destroy_zero<0xdeeb7a4662eec9f2f3def03fb937a663dddaa2e215b8078a284d026b7946c270::deep::DEEP>(v2);
        let v4 = v1;
        let (v5, _) = 0x90de9a12e1b10d3ff28c57b231c28c1740dff4bb1c1781b951f5ed560a3779f9::fee::input_coin_fee_type_rates(0x90de9a12e1b10d3ff28c57b231c28c1740dff4bb1c1781b951f5ed560a3779f9::fee::get_pool_fee_config<T0, T1>(arg2, arg4));
        let v7 = &mut v4;
        let v8 = charge_protocol_swap_fee<T1>(v7, v5, 0x90de9a12e1b10d3ff28c57b231c28c1740dff4bb1c1781b951f5ed560a3779f9::loyalty::get_user_discount_rate(arg3, 0x2::tx_context::sender(arg9)));
        0x90de9a12e1b10d3ff28c57b231c28c1740dff4bb1c1781b951f5ed560a3779f9::fee_manager::add_to_protocol_unsettled_fees<T1>(arg1, v8, arg9);
        validate_minimum_output<T1>(&v4, arg6);
        let v9 = SwapExecuted<T0, T1>{
            fee_manager_id  : 0x2::object::id<0x90de9a12e1b10d3ff28c57b231c28c1740dff4bb1c1781b951f5ed560a3779f9::fee_manager::FeeManager>(arg1),
            pool_id         : 0x2::object::id<0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T0, T1>>(arg4),
            base_to_quote   : true,
            input_amount    : 0x2::coin::value<T0>(&arg5),
            output_amount   : 0x2::coin::value<T1>(&v4),
            input_remainder : 0x2::coin::value<T0>(&v3),
            fee_amount      : 0x2::balance::value<T1>(&v8),
            client_id       : arg7,
        };
        0x2::event::emit<SwapExecuted<T0, T1>>(v9);
        (v3, v4)
    }

    public fun swap_exact_quote_for_base_input_fee<T0, T1>(arg0: &0x90de9a12e1b10d3ff28c57b231c28c1740dff4bb1c1781b951f5ed560a3779f9::treasury::Treasury, arg1: &mut 0x90de9a12e1b10d3ff28c57b231c28c1740dff4bb1c1781b951f5ed560a3779f9::fee_manager::FeeManager, arg2: &0x90de9a12e1b10d3ff28c57b231c28c1740dff4bb1c1781b951f5ed560a3779f9::fee::TradingFeeConfig, arg3: &0x90de9a12e1b10d3ff28c57b231c28c1740dff4bb1c1781b951f5ed560a3779f9::loyalty::LoyaltyProgram, arg4: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T0, T1>, arg5: 0x2::coin::Coin<T1>, arg6: u64, arg7: u64, arg8: &0x2::clock::Clock, arg9: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T0>, 0x2::coin::Coin<T1>) {
        0x90de9a12e1b10d3ff28c57b231c28c1740dff4bb1c1781b951f5ed560a3779f9::treasury::verify_version(arg0);
        let (v0, v1, v2) = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::swap_exact_quantity<T0, T1>(arg4, 0x2::coin::zero<T0>(arg9), arg5, 0x2::coin::zero<0xdeeb7a4662eec9f2f3def03fb937a663dddaa2e215b8078a284d026b7946c270::deep::DEEP>(arg9), arg6, arg8, arg9);
        let v3 = v1;
        0x2::coin::destroy_zero<0xdeeb7a4662eec9f2f3def03fb937a663dddaa2e215b8078a284d026b7946c270::deep::DEEP>(v2);
        let v4 = v0;
        let (v5, _) = 0x90de9a12e1b10d3ff28c57b231c28c1740dff4bb1c1781b951f5ed560a3779f9::fee::input_coin_fee_type_rates(0x90de9a12e1b10d3ff28c57b231c28c1740dff4bb1c1781b951f5ed560a3779f9::fee::get_pool_fee_config<T0, T1>(arg2, arg4));
        let v7 = &mut v4;
        let v8 = charge_protocol_swap_fee<T0>(v7, v5, 0x90de9a12e1b10d3ff28c57b231c28c1740dff4bb1c1781b951f5ed560a3779f9::loyalty::get_user_discount_rate(arg3, 0x2::tx_context::sender(arg9)));
        0x90de9a12e1b10d3ff28c57b231c28c1740dff4bb1c1781b951f5ed560a3779f9::fee_manager::add_to_protocol_unsettled_fees<T0>(arg1, v8, arg9);
        validate_minimum_output<T0>(&v4, arg6);
        let v9 = SwapExecuted<T0, T1>{
            fee_manager_id  : 0x2::object::id<0x90de9a12e1b10d3ff28c57b231c28c1740dff4bb1c1781b951f5ed560a3779f9::fee_manager::FeeManager>(arg1),
            pool_id         : 0x2::object::id<0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T0, T1>>(arg4),
            base_to_quote   : false,
            input_amount    : 0x2::coin::value<T1>(&arg5),
            output_amount   : 0x2::coin::value<T0>(&v4),
            input_remainder : 0x2::coin::value<T1>(&v3),
            fee_amount      : 0x2::balance::value<T0>(&v8),
            client_id       : arg7,
        };
        0x2::event::emit<SwapExecuted<T0, T1>>(v9);
        (v4, v3)
    }

    fun validate_minimum_output<T0>(arg0: &0x2::coin::Coin<T0>, arg1: u64) {
        assert!(0x2::coin::value<T0>(arg0) >= arg1, 1);
    }

    // decompiled from Move bytecode v6
}

