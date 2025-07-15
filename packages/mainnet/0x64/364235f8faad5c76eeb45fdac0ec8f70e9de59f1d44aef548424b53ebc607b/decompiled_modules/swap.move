module 0x64364235f8faad5c76eeb45fdac0ec8f70e9de59f1d44aef548424b53ebc607b::swap {
    public fun get_quantity_out<T0, T1>(arg0: &0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T0, T1>, arg1: u64, arg2: u64, arg3: &0x2::clock::Clock) : (u64, u64, u64) {
        let (v0, v1, v2) = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::get_quantity_out<T0, T1>(arg0, arg1, arg2, arg3);
        let (v3, v4) = apply_wrapper_fees<T0, T1>(arg0, v0, v1, arg1, arg2);
        (v3, v4, v2)
    }

    public fun get_quantity_out_input_fee<T0, T1>(arg0: &0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T0, T1>, arg1: u64, arg2: u64, arg3: &0x2::clock::Clock) : (u64, u64, u64) {
        let (v0, v1, v2) = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::get_quantity_out_input_fee<T0, T1>(arg0, arg1, arg2, arg3);
        let (v3, v4) = apply_wrapper_fees<T0, T1>(arg0, v0, v1, arg1, arg2);
        (v3, v4, v2)
    }

    fun apply_wrapper_fees<T0, T1>(arg0: &0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T0, T1>, arg1: u64, arg2: u64, arg3: u64, arg4: u64) : (u64, u64) {
        if (arg3 > 0) {
            let v0 = 0x64364235f8faad5c76eeb45fdac0ec8f70e9de59f1d44aef548424b53ebc607b::fee::calculate_fee_by_rate(arg2, 0x64364235f8faad5c76eeb45fdac0ec8f70e9de59f1d44aef548424b53ebc607b::helper::get_fee_bps<T0, T1>(arg0));
            arg2 = arg2 - v0;
        } else if (arg4 > 0) {
            let v1 = 0x64364235f8faad5c76eeb45fdac0ec8f70e9de59f1d44aef548424b53ebc607b::fee::calculate_fee_by_rate(arg1, 0x64364235f8faad5c76eeb45fdac0ec8f70e9de59f1d44aef548424b53ebc607b::helper::get_fee_bps<T0, T1>(arg0));
            arg1 = arg1 - v1;
        };
        (arg1, arg2)
    }

    public fun swap_exact_base_for_quote<T0, T1>(arg0: &mut 0x64364235f8faad5c76eeb45fdac0ec8f70e9de59f1d44aef548424b53ebc607b::wrapper::Wrapper, arg1: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T0, T1>, arg2: 0x2::coin::Coin<T0>, arg3: u64, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T0>, 0x2::coin::Coin<T1>) {
        0x64364235f8faad5c76eeb45fdac0ec8f70e9de59f1d44aef548424b53ebc607b::wrapper::verify_version(arg0);
        let v0 = if (0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::whitelisted<T0, T1>(arg1)) {
            0x2::coin::zero<0xdeeb7a4662eec9f2f3def03fb937a663dddaa2e215b8078a284d026b7946c270::deep::DEEP>(arg5)
        } else {
            let (_, _, v3) = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::get_quote_quantity_out<T0, T1>(arg1, 0x2::coin::value<T0>(&arg2), arg4);
            0x64364235f8faad5c76eeb45fdac0ec8f70e9de59f1d44aef548424b53ebc607b::wrapper::split_deep_reserves(arg0, v3, arg5)
        };
        let (v4, v5, v6) = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::swap_exact_quantity<T0, T1>(arg1, arg2, 0x2::coin::zero<T1>(arg5), v0, arg3, arg4, arg5);
        let v7 = v5;
        0x64364235f8faad5c76eeb45fdac0ec8f70e9de59f1d44aef548424b53ebc607b::wrapper::join(arg0, v6);
        0x64364235f8faad5c76eeb45fdac0ec8f70e9de59f1d44aef548424b53ebc607b::wrapper::join_deep_reserves_coverage_fee<T1>(arg0, 0x64364235f8faad5c76eeb45fdac0ec8f70e9de59f1d44aef548424b53ebc607b::fee::charge_swap_fee<T1>(&mut v7, 0x64364235f8faad5c76eeb45fdac0ec8f70e9de59f1d44aef548424b53ebc607b::helper::get_fee_bps<T0, T1>(arg1)));
        validate_minimum_output<T1>(&v7, arg3);
        (v4, v7)
    }

    public fun swap_exact_base_for_quote_input_fee<T0, T1>(arg0: &mut 0x64364235f8faad5c76eeb45fdac0ec8f70e9de59f1d44aef548424b53ebc607b::wrapper::Wrapper, arg1: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T0, T1>, arg2: 0x2::coin::Coin<T0>, arg3: u64, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T0>, 0x2::coin::Coin<T1>) {
        0x64364235f8faad5c76eeb45fdac0ec8f70e9de59f1d44aef548424b53ebc607b::wrapper::verify_version(arg0);
        let (v0, v1, v2) = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::swap_exact_quantity<T0, T1>(arg1, arg2, 0x2::coin::zero<T1>(arg5), 0x2::coin::zero<0xdeeb7a4662eec9f2f3def03fb937a663dddaa2e215b8078a284d026b7946c270::deep::DEEP>(arg5), arg3, arg4, arg5);
        let v3 = v1;
        0x64364235f8faad5c76eeb45fdac0ec8f70e9de59f1d44aef548424b53ebc607b::wrapper::join(arg0, v2);
        0x64364235f8faad5c76eeb45fdac0ec8f70e9de59f1d44aef548424b53ebc607b::wrapper::join_protocol_fee<T1>(arg0, 0x64364235f8faad5c76eeb45fdac0ec8f70e9de59f1d44aef548424b53ebc607b::fee::charge_swap_fee<T1>(&mut v3, 0x64364235f8faad5c76eeb45fdac0ec8f70e9de59f1d44aef548424b53ebc607b::helper::get_fee_bps<T0, T1>(arg1)));
        validate_minimum_output<T1>(&v3, arg3);
        (v0, v3)
    }

    public fun swap_exact_quote_for_base<T0, T1>(arg0: &mut 0x64364235f8faad5c76eeb45fdac0ec8f70e9de59f1d44aef548424b53ebc607b::wrapper::Wrapper, arg1: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T0, T1>, arg2: 0x2::coin::Coin<T1>, arg3: u64, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T0>, 0x2::coin::Coin<T1>) {
        0x64364235f8faad5c76eeb45fdac0ec8f70e9de59f1d44aef548424b53ebc607b::wrapper::verify_version(arg0);
        let v0 = if (0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::whitelisted<T0, T1>(arg1)) {
            0x2::coin::zero<0xdeeb7a4662eec9f2f3def03fb937a663dddaa2e215b8078a284d026b7946c270::deep::DEEP>(arg5)
        } else {
            let (_, _, v3) = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::get_base_quantity_out<T0, T1>(arg1, 0x2::coin::value<T1>(&arg2), arg4);
            0x64364235f8faad5c76eeb45fdac0ec8f70e9de59f1d44aef548424b53ebc607b::wrapper::split_deep_reserves(arg0, v3, arg5)
        };
        let (v4, v5, v6) = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::swap_exact_quantity<T0, T1>(arg1, 0x2::coin::zero<T0>(arg5), arg2, v0, arg3, arg4, arg5);
        let v7 = v4;
        0x64364235f8faad5c76eeb45fdac0ec8f70e9de59f1d44aef548424b53ebc607b::wrapper::join(arg0, v6);
        0x64364235f8faad5c76eeb45fdac0ec8f70e9de59f1d44aef548424b53ebc607b::wrapper::join_deep_reserves_coverage_fee<T0>(arg0, 0x64364235f8faad5c76eeb45fdac0ec8f70e9de59f1d44aef548424b53ebc607b::fee::charge_swap_fee<T0>(&mut v7, 0x64364235f8faad5c76eeb45fdac0ec8f70e9de59f1d44aef548424b53ebc607b::helper::get_fee_bps<T0, T1>(arg1)));
        validate_minimum_output<T0>(&v7, arg3);
        (v7, v5)
    }

    public fun swap_exact_quote_for_base_input_fee<T0, T1>(arg0: &mut 0x64364235f8faad5c76eeb45fdac0ec8f70e9de59f1d44aef548424b53ebc607b::wrapper::Wrapper, arg1: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T0, T1>, arg2: 0x2::coin::Coin<T1>, arg3: u64, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T0>, 0x2::coin::Coin<T1>) {
        0x64364235f8faad5c76eeb45fdac0ec8f70e9de59f1d44aef548424b53ebc607b::wrapper::verify_version(arg0);
        let (v0, v1, v2) = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::swap_exact_quantity<T0, T1>(arg1, 0x2::coin::zero<T0>(arg5), arg2, 0x2::coin::zero<0xdeeb7a4662eec9f2f3def03fb937a663dddaa2e215b8078a284d026b7946c270::deep::DEEP>(arg5), arg3, arg4, arg5);
        let v3 = v0;
        0x64364235f8faad5c76eeb45fdac0ec8f70e9de59f1d44aef548424b53ebc607b::wrapper::join(arg0, v2);
        0x64364235f8faad5c76eeb45fdac0ec8f70e9de59f1d44aef548424b53ebc607b::wrapper::join_protocol_fee<T0>(arg0, 0x64364235f8faad5c76eeb45fdac0ec8f70e9de59f1d44aef548424b53ebc607b::fee::charge_swap_fee<T0>(&mut v3, 0x64364235f8faad5c76eeb45fdac0ec8f70e9de59f1d44aef548424b53ebc607b::helper::get_fee_bps<T0, T1>(arg1)));
        validate_minimum_output<T0>(&v3, arg3);
        (v3, v1)
    }

    fun validate_minimum_output<T0>(arg0: &0x2::coin::Coin<T0>, arg1: u64) {
        assert!(0x2::coin::value<T0>(arg0) >= arg1, 1);
    }

    // decompiled from Move bytecode v6
}

