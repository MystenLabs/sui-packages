module 0xf3d8960a519bb04b64e2f207f653e6598f554bd4bca9c6891e6dab8e0312d299::swap {
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

    public fun get_quantity_out_input_fee<T0, T1>(arg0: &0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T0, T1>, arg1: u64, arg2: u64, arg3: &0x2::clock::Clock) : (u64, u64, u64) {
        let (v0, v1, v2) = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::get_quantity_out_input_fee<T0, T1>(arg0, arg1, arg2, arg3);
        let (v3, v4) = apply_treasury_fees<T0, T1>(arg0, v0, v1, arg1, arg2);
        (v3, v4, v2)
    }

    fun apply_treasury_fees<T0, T1>(arg0: &0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T0, T1>, arg1: u64, arg2: u64, arg3: u64, arg4: u64) : (u64, u64) {
        let (v0, _, _) = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::pool_trade_params<T0, T1>(arg0);
        if (arg3 > 0) {
            let v3 = 0xf3d8960a519bb04b64e2f207f653e6598f554bd4bca9c6891e6dab8e0312d299::fee::calculate_fee_by_rate(arg2, v0);
            arg2 = arg2 - v3;
        } else if (arg4 > 0) {
            let v4 = 0xf3d8960a519bb04b64e2f207f653e6598f554bd4bca9c6891e6dab8e0312d299::fee::calculate_fee_by_rate(arg1, v0);
            arg1 = arg1 - v4;
        };
        (arg1, arg2)
    }

    public fun swap_exact_base_for_quote_input_fee<T0, T1>(arg0: &mut 0xf3d8960a519bb04b64e2f207f653e6598f554bd4bca9c6891e6dab8e0312d299::treasury::Treasury, arg1: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T0, T1>, arg2: 0x2::coin::Coin<T0>, arg3: u64, arg4: u64, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T0>, 0x2::coin::Coin<T1>) {
        0xf3d8960a519bb04b64e2f207f653e6598f554bd4bca9c6891e6dab8e0312d299::treasury::verify_version(arg0);
        let (v0, v1, v2) = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::swap_exact_quantity<T0, T1>(arg1, arg2, 0x2::coin::zero<T1>(arg6), 0x2::coin::zero<0xdeeb7a4662eec9f2f3def03fb937a663dddaa2e215b8078a284d026b7946c270::deep::DEEP>(arg6), arg3, arg5, arg6);
        let v3 = v0;
        0x2::coin::destroy_zero<0xdeeb7a4662eec9f2f3def03fb937a663dddaa2e215b8078a284d026b7946c270::deep::DEEP>(v2);
        let v4 = v1;
        let (v5, _, _) = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::pool_trade_params<T0, T1>(arg1);
        let v8 = 0xf3d8960a519bb04b64e2f207f653e6598f554bd4bca9c6891e6dab8e0312d299::fee::charge_swap_fee<T1>(&mut v4, v5);
        0xf3d8960a519bb04b64e2f207f653e6598f554bd4bca9c6891e6dab8e0312d299::treasury::join_protocol_fee<T1>(arg0, v8);
        validate_minimum_output<T1>(&v4, arg3);
        let v9 = SwapExecuted<T0, T1>{
            treasury_id     : 0x2::object::id<0xf3d8960a519bb04b64e2f207f653e6598f554bd4bca9c6891e6dab8e0312d299::treasury::Treasury>(arg0),
            pool_id         : 0x2::object::id<0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T0, T1>>(arg1),
            base_to_quote   : true,
            input_amount    : 0x2::coin::value<T0>(&arg2),
            output_amount   : 0x2::coin::value<T1>(&v4),
            input_remainder : 0x2::coin::value<T0>(&v3),
            fee_amount      : 0x2::balance::value<T1>(&v8),
            client_id       : arg4,
        };
        0x2::event::emit<SwapExecuted<T0, T1>>(v9);
        (v3, v4)
    }

    public fun swap_exact_quote_for_base_input_fee<T0, T1>(arg0: &mut 0xf3d8960a519bb04b64e2f207f653e6598f554bd4bca9c6891e6dab8e0312d299::treasury::Treasury, arg1: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T0, T1>, arg2: 0x2::coin::Coin<T1>, arg3: u64, arg4: u64, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T0>, 0x2::coin::Coin<T1>) {
        0xf3d8960a519bb04b64e2f207f653e6598f554bd4bca9c6891e6dab8e0312d299::treasury::verify_version(arg0);
        let (v0, v1, v2) = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::swap_exact_quantity<T0, T1>(arg1, 0x2::coin::zero<T0>(arg6), arg2, 0x2::coin::zero<0xdeeb7a4662eec9f2f3def03fb937a663dddaa2e215b8078a284d026b7946c270::deep::DEEP>(arg6), arg3, arg5, arg6);
        let v3 = v1;
        0x2::coin::destroy_zero<0xdeeb7a4662eec9f2f3def03fb937a663dddaa2e215b8078a284d026b7946c270::deep::DEEP>(v2);
        let v4 = v0;
        let (v5, _, _) = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::pool_trade_params<T0, T1>(arg1);
        let v8 = 0xf3d8960a519bb04b64e2f207f653e6598f554bd4bca9c6891e6dab8e0312d299::fee::charge_swap_fee<T0>(&mut v4, v5);
        0xf3d8960a519bb04b64e2f207f653e6598f554bd4bca9c6891e6dab8e0312d299::treasury::join_protocol_fee<T0>(arg0, v8);
        validate_minimum_output<T0>(&v4, arg3);
        let v9 = SwapExecuted<T0, T1>{
            treasury_id     : 0x2::object::id<0xf3d8960a519bb04b64e2f207f653e6598f554bd4bca9c6891e6dab8e0312d299::treasury::Treasury>(arg0),
            pool_id         : 0x2::object::id<0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T0, T1>>(arg1),
            base_to_quote   : false,
            input_amount    : 0x2::coin::value<T1>(&arg2),
            output_amount   : 0x2::coin::value<T0>(&v4),
            input_remainder : 0x2::coin::value<T1>(&v3),
            fee_amount      : 0x2::balance::value<T0>(&v8),
            client_id       : arg4,
        };
        0x2::event::emit<SwapExecuted<T0, T1>>(v9);
        (v4, v3)
    }

    fun validate_minimum_output<T0>(arg0: &0x2::coin::Coin<T0>, arg1: u64) {
        assert!(0x2::coin::value<T0>(arg0) >= arg1, 1);
    }

    // decompiled from Move bytecode v6
}

