module 0x5ecbdacf23a93ba45b29d83fe0f01d76da51ee9e8c18dd819532b0804eab2600::swap {
    struct SwapExecuted<phantom T0, phantom T1> has copy, drop {
        treasury_id: 0x2::object::ID,
        pool_id: 0x2::object::ID,
        base_to_quote: bool,
        input_amount: u64,
        output_amount: u64,
        input_remainder: u64,
        fee_amount: u64,
        client_id: u64,
    }

    public fun get_quantity_out_input_fee<T0, T1>(arg0: &0x5ecbdacf23a93ba45b29d83fe0f01d76da51ee9e8c18dd819532b0804eab2600::fee::TradingFeeConfig, arg1: &0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T0, T1>, arg2: u64, arg3: u64, arg4: &0x2::clock::Clock) : (u64, u64, u64) {
        let (v0, v1, v2) = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::get_quantity_out_input_fee<T0, T1>(arg1, arg2, arg3, arg4);
        let (v3, _) = 0x5ecbdacf23a93ba45b29d83fe0f01d76da51ee9e8c18dd819532b0804eab2600::fee::input_coin_fee_type_rates(0x5ecbdacf23a93ba45b29d83fe0f01d76da51ee9e8c18dd819532b0804eab2600::fee::get_pool_fee_config<T0, T1>(arg0, arg1));
        let (v5, v6) = apply_treasury_fees(v3, v0, v1, arg2, arg3);
        (v5, v6, v2)
    }

    fun apply_treasury_fees(arg0: u64, arg1: u64, arg2: u64, arg3: u64, arg4: u64) : (u64, u64) {
        if (arg3 > 0) {
            let v0 = 0x5ecbdacf23a93ba45b29d83fe0f01d76da51ee9e8c18dd819532b0804eab2600::fee::calculate_fee_by_rate(arg2, arg0);
            arg2 = arg2 - v0;
        } else if (arg4 > 0) {
            let v1 = 0x5ecbdacf23a93ba45b29d83fe0f01d76da51ee9e8c18dd819532b0804eab2600::fee::calculate_fee_by_rate(arg1, arg0);
            arg1 = arg1 - v1;
        };
        (arg1, arg2)
    }

    public fun swap_exact_base_for_quote_input_fee<T0, T1>(arg0: &mut 0x5ecbdacf23a93ba45b29d83fe0f01d76da51ee9e8c18dd819532b0804eab2600::treasury::Treasury, arg1: &0x5ecbdacf23a93ba45b29d83fe0f01d76da51ee9e8c18dd819532b0804eab2600::fee::TradingFeeConfig, arg2: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T0, T1>, arg3: 0x2::coin::Coin<T0>, arg4: u64, arg5: u64, arg6: &0x2::clock::Clock, arg7: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T0>, 0x2::coin::Coin<T1>) {
        0x5ecbdacf23a93ba45b29d83fe0f01d76da51ee9e8c18dd819532b0804eab2600::treasury::verify_version(arg0);
        let (v0, v1, v2) = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::swap_exact_quantity<T0, T1>(arg2, arg3, 0x2::coin::zero<T1>(arg7), 0x2::coin::zero<0xdeeb7a4662eec9f2f3def03fb937a663dddaa2e215b8078a284d026b7946c270::deep::DEEP>(arg7), arg4, arg6, arg7);
        let v3 = v0;
        0x2::coin::destroy_zero<0xdeeb7a4662eec9f2f3def03fb937a663dddaa2e215b8078a284d026b7946c270::deep::DEEP>(v2);
        let v4 = v1;
        let (v5, _) = 0x5ecbdacf23a93ba45b29d83fe0f01d76da51ee9e8c18dd819532b0804eab2600::fee::input_coin_fee_type_rates(0x5ecbdacf23a93ba45b29d83fe0f01d76da51ee9e8c18dd819532b0804eab2600::fee::get_pool_fee_config<T0, T1>(arg1, arg2));
        let v7 = 0x5ecbdacf23a93ba45b29d83fe0f01d76da51ee9e8c18dd819532b0804eab2600::fee::charge_swap_fee<T1>(&mut v4, v5);
        0x5ecbdacf23a93ba45b29d83fe0f01d76da51ee9e8c18dd819532b0804eab2600::treasury::join_protocol_fee<T1>(arg0, v7);
        validate_minimum_output<T1>(&v4, arg4);
        let v8 = SwapExecuted<T0, T1>{
            treasury_id     : 0x2::object::id<0x5ecbdacf23a93ba45b29d83fe0f01d76da51ee9e8c18dd819532b0804eab2600::treasury::Treasury>(arg0),
            pool_id         : 0x2::object::id<0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T0, T1>>(arg2),
            base_to_quote   : true,
            input_amount    : 0x2::coin::value<T0>(&arg3),
            output_amount   : 0x2::coin::value<T1>(&v4),
            input_remainder : 0x2::coin::value<T0>(&v3),
            fee_amount      : 0x2::balance::value<T1>(&v7),
            client_id       : arg5,
        };
        0x2::event::emit<SwapExecuted<T0, T1>>(v8);
        (v3, v4)
    }

    public fun swap_exact_quote_for_base_input_fee<T0, T1>(arg0: &mut 0x5ecbdacf23a93ba45b29d83fe0f01d76da51ee9e8c18dd819532b0804eab2600::treasury::Treasury, arg1: &0x5ecbdacf23a93ba45b29d83fe0f01d76da51ee9e8c18dd819532b0804eab2600::fee::TradingFeeConfig, arg2: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T0, T1>, arg3: 0x2::coin::Coin<T1>, arg4: u64, arg5: u64, arg6: &0x2::clock::Clock, arg7: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T0>, 0x2::coin::Coin<T1>) {
        0x5ecbdacf23a93ba45b29d83fe0f01d76da51ee9e8c18dd819532b0804eab2600::treasury::verify_version(arg0);
        let (v0, v1, v2) = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::swap_exact_quantity<T0, T1>(arg2, 0x2::coin::zero<T0>(arg7), arg3, 0x2::coin::zero<0xdeeb7a4662eec9f2f3def03fb937a663dddaa2e215b8078a284d026b7946c270::deep::DEEP>(arg7), arg4, arg6, arg7);
        let v3 = v1;
        0x2::coin::destroy_zero<0xdeeb7a4662eec9f2f3def03fb937a663dddaa2e215b8078a284d026b7946c270::deep::DEEP>(v2);
        let v4 = v0;
        let (v5, _) = 0x5ecbdacf23a93ba45b29d83fe0f01d76da51ee9e8c18dd819532b0804eab2600::fee::input_coin_fee_type_rates(0x5ecbdacf23a93ba45b29d83fe0f01d76da51ee9e8c18dd819532b0804eab2600::fee::get_pool_fee_config<T0, T1>(arg1, arg2));
        let v7 = 0x5ecbdacf23a93ba45b29d83fe0f01d76da51ee9e8c18dd819532b0804eab2600::fee::charge_swap_fee<T0>(&mut v4, v5);
        0x5ecbdacf23a93ba45b29d83fe0f01d76da51ee9e8c18dd819532b0804eab2600::treasury::join_protocol_fee<T0>(arg0, v7);
        validate_minimum_output<T0>(&v4, arg4);
        let v8 = SwapExecuted<T0, T1>{
            treasury_id     : 0x2::object::id<0x5ecbdacf23a93ba45b29d83fe0f01d76da51ee9e8c18dd819532b0804eab2600::treasury::Treasury>(arg0),
            pool_id         : 0x2::object::id<0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T0, T1>>(arg2),
            base_to_quote   : false,
            input_amount    : 0x2::coin::value<T1>(&arg3),
            output_amount   : 0x2::coin::value<T0>(&v4),
            input_remainder : 0x2::coin::value<T1>(&v3),
            fee_amount      : 0x2::balance::value<T0>(&v7),
            client_id       : arg5,
        };
        0x2::event::emit<SwapExecuted<T0, T1>>(v8);
        (v4, v3)
    }

    fun validate_minimum_output<T0>(arg0: &0x2::coin::Coin<T0>, arg1: u64) {
        assert!(0x2::coin::value<T0>(arg0) >= arg1, 1);
    }

    // decompiled from Move bytecode v6
}

