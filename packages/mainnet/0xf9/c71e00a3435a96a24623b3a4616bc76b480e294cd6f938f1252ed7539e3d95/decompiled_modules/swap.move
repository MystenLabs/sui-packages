module 0xf9c71e00a3435a96a24623b3a4616bc76b480e294cd6f938f1252ed7539e3d95::swap {
    public fun get_quantity_out<T0, T1>(arg0: &0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T0, T1>, arg1: u64, arg2: u64, arg3: &0x2::clock::Clock) : (u64, u64, u64) {
        let (v0, v1, v2) = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::get_quantity_out<T0, T1>(arg0, arg1, arg2, arg3);
        let v3 = v1;
        let v4 = v0;
        if (arg1 > 0) {
            v3 = v1 - 0xf9c71e00a3435a96a24623b3a4616bc76b480e294cd6f938f1252ed7539e3d95::fee::calculate_swap_fee(v1, 0xf9c71e00a3435a96a24623b3a4616bc76b480e294cd6f938f1252ed7539e3d95::helper::get_fee_bps<T0, T1>(arg0));
        } else if (arg2 > 0) {
            v4 = v0 - 0xf9c71e00a3435a96a24623b3a4616bc76b480e294cd6f938f1252ed7539e3d95::fee::calculate_swap_fee(v0, 0xf9c71e00a3435a96a24623b3a4616bc76b480e294cd6f938f1252ed7539e3d95::helper::get_fee_bps<T0, T1>(arg0));
        };
        (v4, v3, v2)
    }

    public fun swap_exact_base_for_quote<T0, T1>(arg0: &mut 0xf9c71e00a3435a96a24623b3a4616bc76b480e294cd6f938f1252ed7539e3d95::wrapper::Wrapper, arg1: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T0, T1>, arg2: 0x2::coin::Coin<T0>, arg3: u64, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T0>, 0x2::coin::Coin<T1>) {
        let v0 = if (0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::whitelisted<T0, T1>(arg1)) {
            0x2::coin::zero<0xdeeb7a4662eec9f2f3def03fb937a663dddaa2e215b8078a284d026b7946c270::deep::DEEP>(arg5)
        } else {
            0xf9c71e00a3435a96a24623b3a4616bc76b480e294cd6f938f1252ed7539e3d95::wrapper::split_deep_reserves(arg0, 0xf9c71e00a3435a96a24623b3a4616bc76b480e294cd6f938f1252ed7539e3d95::wrapper::get_deep_reserves_value(arg0), arg5)
        };
        let (v1, v2, v3) = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::swap_exact_quantity<T0, T1>(arg1, arg2, 0x2::coin::zero<T1>(arg5), v0, arg3, arg4, arg5);
        let v4 = v2;
        0xf9c71e00a3435a96a24623b3a4616bc76b480e294cd6f938f1252ed7539e3d95::wrapper::join(arg0, v3);
        0xf9c71e00a3435a96a24623b3a4616bc76b480e294cd6f938f1252ed7539e3d95::wrapper::join_deep_reserves_coverage_fee<T1>(arg0, 0xf9c71e00a3435a96a24623b3a4616bc76b480e294cd6f938f1252ed7539e3d95::fee::charge_swap_fee<T1>(&mut v4, 0xf9c71e00a3435a96a24623b3a4616bc76b480e294cd6f938f1252ed7539e3d95::helper::get_fee_bps<T0, T1>(arg1)));
        (v1, v4)
    }

    public fun swap_exact_quote_for_base<T0, T1>(arg0: &mut 0xf9c71e00a3435a96a24623b3a4616bc76b480e294cd6f938f1252ed7539e3d95::wrapper::Wrapper, arg1: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T0, T1>, arg2: 0x2::coin::Coin<T1>, arg3: u64, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T0>, 0x2::coin::Coin<T1>) {
        let v0 = if (0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::whitelisted<T0, T1>(arg1)) {
            0x2::coin::zero<0xdeeb7a4662eec9f2f3def03fb937a663dddaa2e215b8078a284d026b7946c270::deep::DEEP>(arg5)
        } else {
            0xf9c71e00a3435a96a24623b3a4616bc76b480e294cd6f938f1252ed7539e3d95::wrapper::split_deep_reserves(arg0, 0xf9c71e00a3435a96a24623b3a4616bc76b480e294cd6f938f1252ed7539e3d95::wrapper::get_deep_reserves_value(arg0), arg5)
        };
        let (v1, v2, v3) = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::swap_exact_quantity<T0, T1>(arg1, 0x2::coin::zero<T0>(arg5), arg2, v0, arg3, arg4, arg5);
        let v4 = v1;
        0xf9c71e00a3435a96a24623b3a4616bc76b480e294cd6f938f1252ed7539e3d95::wrapper::join(arg0, v3);
        0xf9c71e00a3435a96a24623b3a4616bc76b480e294cd6f938f1252ed7539e3d95::wrapper::join_deep_reserves_coverage_fee<T0>(arg0, 0xf9c71e00a3435a96a24623b3a4616bc76b480e294cd6f938f1252ed7539e3d95::fee::charge_swap_fee<T0>(&mut v4, 0xf9c71e00a3435a96a24623b3a4616bc76b480e294cd6f938f1252ed7539e3d95::helper::get_fee_bps<T0, T1>(arg1)));
        (v4, v2)
    }

    // decompiled from Move bytecode v6
}

