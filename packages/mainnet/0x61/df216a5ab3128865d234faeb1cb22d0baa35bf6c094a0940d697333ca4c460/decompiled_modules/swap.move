module 0x61df216a5ab3128865d234faeb1cb22d0baa35bf6c094a0940d697333ca4c460::swap {
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
            let v0 = 0x61df216a5ab3128865d234faeb1cb22d0baa35bf6c094a0940d697333ca4c460::fee::calculate_fee_by_rate(arg2, 0x61df216a5ab3128865d234faeb1cb22d0baa35bf6c094a0940d697333ca4c460::helper::get_fee_bps<T0, T1>(arg0));
            arg2 = arg2 - v0;
        } else if (arg4 > 0) {
            let v1 = 0x61df216a5ab3128865d234faeb1cb22d0baa35bf6c094a0940d697333ca4c460::fee::calculate_fee_by_rate(arg1, 0x61df216a5ab3128865d234faeb1cb22d0baa35bf6c094a0940d697333ca4c460::helper::get_fee_bps<T0, T1>(arg0));
            arg1 = arg1 - v1;
        };
        (arg1, arg2)
    }

    public fun swap_exact_base_for_quote<T0, T1>(arg0: &mut 0x61df216a5ab3128865d234faeb1cb22d0baa35bf6c094a0940d697333ca4c460::wrapper::Wrapper, arg1: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T0, T1>, arg2: 0x2::coin::Coin<T0>, arg3: u64, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T0>, 0x2::coin::Coin<T1>) {
        let v0 = if (0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::whitelisted<T0, T1>(arg1)) {
            0x2::coin::zero<0xdeeb7a4662eec9f2f3def03fb937a663dddaa2e215b8078a284d026b7946c270::deep::DEEP>(arg5)
        } else {
            0x61df216a5ab3128865d234faeb1cb22d0baa35bf6c094a0940d697333ca4c460::wrapper::split_deep_reserves(arg0, 0x61df216a5ab3128865d234faeb1cb22d0baa35bf6c094a0940d697333ca4c460::wrapper::get_deep_reserves_value(arg0), arg5)
        };
        let (v1, v2, v3) = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::swap_exact_quantity<T0, T1>(arg1, arg2, 0x2::coin::zero<T1>(arg5), v0, arg3, arg4, arg5);
        let v4 = v2;
        0x61df216a5ab3128865d234faeb1cb22d0baa35bf6c094a0940d697333ca4c460::wrapper::join(arg0, v3);
        0x61df216a5ab3128865d234faeb1cb22d0baa35bf6c094a0940d697333ca4c460::wrapper::join_deep_reserves_coverage_fee<T1>(arg0, 0x61df216a5ab3128865d234faeb1cb22d0baa35bf6c094a0940d697333ca4c460::fee::charge_swap_fee<T1>(&mut v4, 0x61df216a5ab3128865d234faeb1cb22d0baa35bf6c094a0940d697333ca4c460::helper::get_fee_bps<T0, T1>(arg1)));
        (v1, v4)
    }

    public fun swap_exact_base_for_quote_input_fee<T0, T1>(arg0: &mut 0x61df216a5ab3128865d234faeb1cb22d0baa35bf6c094a0940d697333ca4c460::wrapper::Wrapper, arg1: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T0, T1>, arg2: 0x2::coin::Coin<T0>, arg3: u64, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T0>, 0x2::coin::Coin<T1>) {
        let (v0, v1, v2) = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::swap_exact_quantity<T0, T1>(arg1, arg2, 0x2::coin::zero<T1>(arg5), 0x2::coin::zero<0xdeeb7a4662eec9f2f3def03fb937a663dddaa2e215b8078a284d026b7946c270::deep::DEEP>(arg5), arg3, arg4, arg5);
        let v3 = v1;
        0x61df216a5ab3128865d234faeb1cb22d0baa35bf6c094a0940d697333ca4c460::wrapper::join(arg0, v2);
        0x61df216a5ab3128865d234faeb1cb22d0baa35bf6c094a0940d697333ca4c460::wrapper::join_deep_reserves_coverage_fee<T1>(arg0, 0x61df216a5ab3128865d234faeb1cb22d0baa35bf6c094a0940d697333ca4c460::fee::charge_swap_fee<T1>(&mut v3, 0x61df216a5ab3128865d234faeb1cb22d0baa35bf6c094a0940d697333ca4c460::helper::get_fee_bps<T0, T1>(arg1)));
        (v0, v3)
    }

    public fun swap_exact_quote_for_base<T0, T1>(arg0: &mut 0x61df216a5ab3128865d234faeb1cb22d0baa35bf6c094a0940d697333ca4c460::wrapper::Wrapper, arg1: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T0, T1>, arg2: 0x2::coin::Coin<T1>, arg3: u64, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T0>, 0x2::coin::Coin<T1>) {
        let v0 = if (0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::whitelisted<T0, T1>(arg1)) {
            0x2::coin::zero<0xdeeb7a4662eec9f2f3def03fb937a663dddaa2e215b8078a284d026b7946c270::deep::DEEP>(arg5)
        } else {
            0x61df216a5ab3128865d234faeb1cb22d0baa35bf6c094a0940d697333ca4c460::wrapper::split_deep_reserves(arg0, 0x61df216a5ab3128865d234faeb1cb22d0baa35bf6c094a0940d697333ca4c460::wrapper::get_deep_reserves_value(arg0), arg5)
        };
        let (v1, v2, v3) = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::swap_exact_quantity<T0, T1>(arg1, 0x2::coin::zero<T0>(arg5), arg2, v0, arg3, arg4, arg5);
        let v4 = v1;
        0x61df216a5ab3128865d234faeb1cb22d0baa35bf6c094a0940d697333ca4c460::wrapper::join(arg0, v3);
        0x61df216a5ab3128865d234faeb1cb22d0baa35bf6c094a0940d697333ca4c460::wrapper::join_deep_reserves_coverage_fee<T0>(arg0, 0x61df216a5ab3128865d234faeb1cb22d0baa35bf6c094a0940d697333ca4c460::fee::charge_swap_fee<T0>(&mut v4, 0x61df216a5ab3128865d234faeb1cb22d0baa35bf6c094a0940d697333ca4c460::helper::get_fee_bps<T0, T1>(arg1)));
        (v4, v2)
    }

    public fun swap_exact_quote_for_base_input_fee<T0, T1>(arg0: &mut 0x61df216a5ab3128865d234faeb1cb22d0baa35bf6c094a0940d697333ca4c460::wrapper::Wrapper, arg1: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T0, T1>, arg2: 0x2::coin::Coin<T1>, arg3: u64, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T0>, 0x2::coin::Coin<T1>) {
        let (v0, v1, v2) = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::swap_exact_quantity<T0, T1>(arg1, 0x2::coin::zero<T0>(arg5), arg2, 0x2::coin::zero<0xdeeb7a4662eec9f2f3def03fb937a663dddaa2e215b8078a284d026b7946c270::deep::DEEP>(arg5), arg3, arg4, arg5);
        let v3 = v0;
        0x61df216a5ab3128865d234faeb1cb22d0baa35bf6c094a0940d697333ca4c460::wrapper::join(arg0, v2);
        0x61df216a5ab3128865d234faeb1cb22d0baa35bf6c094a0940d697333ca4c460::wrapper::join_deep_reserves_coverage_fee<T0>(arg0, 0x61df216a5ab3128865d234faeb1cb22d0baa35bf6c094a0940d697333ca4c460::fee::charge_swap_fee<T0>(&mut v3, 0x61df216a5ab3128865d234faeb1cb22d0baa35bf6c094a0940d697333ca4c460::helper::get_fee_bps<T0, T1>(arg1)));
        (v3, v1)
    }

    // decompiled from Move bytecode v6
}

