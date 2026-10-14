module 0x3ef20df3c56afea13ec04afed64260f01a92b9066ce2ad517caa136274692a85::deepbook {
    public fun buy_base<T0, T1, T2>(arg0: &mut 0x6c088e567321dbcf28a9d24d6c75d3dc66e13b3d371fdc6a66a12ec444a99842::session::Session<T2>, arg1: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T0, T1>, arg2: 0x2::balance::Balance<T1>, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) : 0x2::balance::Balance<T0> {
        0x6c088e567321dbcf28a9d24d6c75d3dc66e13b3d371fdc6a66a12ec444a99842::session::record_leg<T2>(arg0, 0x2::object::id<0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T0, T1>>(arg1), false, 0);
        let (v0, v1, v2) = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::swap_exact_quantity<T0, T1>(arg1, 0x2::coin::zero<T0>(arg4), 0x2::coin::from_balance<T1>(arg2, arg4), 0x2::coin::zero<0xdeeb7a4662eec9f2f3def03fb937a663dddaa2e215b8078a284d026b7946c270::deep::DEEP>(arg4), 0, arg3, arg4);
        0x2::coin::destroy_zero<0xdeeb7a4662eec9f2f3def03fb937a663dddaa2e215b8078a284d026b7946c270::deep::DEEP>(v2);
        refund<T1>(v1, arg4);
        0x2::coin::into_balance<T0>(v0)
    }

    public fun buy_base_deep<T0, T1, T2>(arg0: &mut 0x6c088e567321dbcf28a9d24d6c75d3dc66e13b3d371fdc6a66a12ec444a99842::session::Session<T2>, arg1: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T0, T1>, arg2: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::BalanceManager, arg3: &0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::TradeCap, arg4: &0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::DepositCap, arg5: &0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::WithdrawCap, arg6: 0x2::balance::Balance<T1>, arg7: u64, arg8: &0x2::clock::Clock, arg9: &mut 0x2::tx_context::TxContext) : 0x2::balance::Balance<T0> {
        let (_, v1) = simulate_deep<T0, T1>(arg1, false, 0x2::balance::value<T1>(&arg6), arg8);
        0x6c088e567321dbcf28a9d24d6c75d3dc66e13b3d371fdc6a66a12ec444a99842::session::record_leg<T2>(arg0, 0x2::object::id<0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T0, T1>>(arg1), false, deep_cost(v1, arg7));
        let (v2, v3) = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::swap_exact_quantity_with_manager<T0, T1>(arg1, arg2, arg3, arg4, arg5, 0x2::coin::zero<T0>(arg9), 0x2::coin::from_balance<T1>(arg6, arg9), 0, arg8, arg9);
        refund<T1>(v3, arg9);
        0x2::coin::into_balance<T0>(v2)
    }

    fun deep_cost(arg0: u64, arg1: u64) : u64 {
        ((((arg0 as u128) * (arg1 as u128) + 1000000 - 1) / 1000000) as u64)
    }

    public fun quote<T0, T1, T2>(arg0: &mut 0x6c088e567321dbcf28a9d24d6c75d3dc66e13b3d371fdc6a66a12ec444a99842::session::Session<T2>, arg1: &0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T0, T1>, arg2: bool, arg3: &0x2::clock::Clock) {
        let v0 = vector[];
        let v1 = 0x6c088e567321dbcf28a9d24d6c75d3dc66e13b3d371fdc6a66a12ec444a99842::session::amounts<T2>(arg0);
        0x1::vector::reverse<u64>(&mut v1);
        let v2 = 0;
        while (v2 < 0x1::vector::length<u64>(&v1)) {
            let v3 = 0x1::vector::pop_back<u64>(&mut v1);
            let v4 = if (v3 == 0) {
                0
            } else if (arg2) {
                let (_, v6, _) = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::get_quote_quantity_out_input_fee<T0, T1>(arg1, v3, arg3);
                v6
            } else {
                let (v8, _, _) = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::get_base_quantity_out_input_fee<T0, T1>(arg1, v3, arg3);
                v8
            };
            0x1::vector::push_back<u64>(&mut v0, v4);
            v2 = v2 + 1;
        };
        0x1::vector::destroy_empty<u64>(v1);
        let v11 = &v0;
        let v12 = vector[];
        let v13 = 0;
        while (v13 < 0x1::vector::length<u64>(v11)) {
            0x1::vector::push_back<u64>(&mut v12, 0);
            v13 = v13 + 1;
        };
        0x6c088e567321dbcf28a9d24d6c75d3dc66e13b3d371fdc6a66a12ec444a99842::session::record_quote<T2>(arg0, 0x2::object::id<0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T0, T1>>(arg1), arg2, v0, v12);
    }

    public fun quote_deep<T0, T1, T2>(arg0: &mut 0x6c088e567321dbcf28a9d24d6c75d3dc66e13b3d371fdc6a66a12ec444a99842::session::Session<T2>, arg1: &0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T0, T1>, arg2: bool, arg3: u64, arg4: &0x2::clock::Clock) {
        let v0 = vector[];
        let v1 = vector[];
        let v2 = 0x6c088e567321dbcf28a9d24d6c75d3dc66e13b3d371fdc6a66a12ec444a99842::session::amounts<T2>(arg0);
        0x1::vector::reverse<u64>(&mut v2);
        let v3 = 0;
        while (v3 < 0x1::vector::length<u64>(&v2)) {
            let (v4, v5) = simulate_deep<T0, T1>(arg1, arg2, 0x1::vector::pop_back<u64>(&mut v2), arg4);
            0x1::vector::push_back<u64>(&mut v0, deep_cost(v5, arg3));
            0x1::vector::push_back<u64>(&mut v1, v4);
            v3 = v3 + 1;
        };
        0x1::vector::destroy_empty<u64>(v2);
        0x6c088e567321dbcf28a9d24d6c75d3dc66e13b3d371fdc6a66a12ec444a99842::session::record_quote<T2>(arg0, 0x2::object::id<0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T0, T1>>(arg1), arg2, v1, v0);
    }

    fun refund<T0>(arg0: 0x2::coin::Coin<T0>, arg1: &0x2::tx_context::TxContext) {
        if (0x2::coin::value<T0>(&arg0) == 0) {
            0x2::coin::destroy_zero<T0>(arg0);
        } else {
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(arg0, 0x2::tx_context::sender(arg1));
        };
    }

    public fun sell_base<T0, T1, T2>(arg0: &mut 0x6c088e567321dbcf28a9d24d6c75d3dc66e13b3d371fdc6a66a12ec444a99842::session::Session<T2>, arg1: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T0, T1>, arg2: 0x2::balance::Balance<T0>, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) : 0x2::balance::Balance<T1> {
        0x6c088e567321dbcf28a9d24d6c75d3dc66e13b3d371fdc6a66a12ec444a99842::session::record_leg<T2>(arg0, 0x2::object::id<0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T0, T1>>(arg1), true, 0);
        let (v0, v1, v2) = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::swap_exact_quantity<T0, T1>(arg1, 0x2::coin::from_balance<T0>(arg2, arg4), 0x2::coin::zero<T1>(arg4), 0x2::coin::zero<0xdeeb7a4662eec9f2f3def03fb937a663dddaa2e215b8078a284d026b7946c270::deep::DEEP>(arg4), 0, arg3, arg4);
        0x2::coin::destroy_zero<0xdeeb7a4662eec9f2f3def03fb937a663dddaa2e215b8078a284d026b7946c270::deep::DEEP>(v2);
        refund<T0>(v0, arg4);
        0x2::coin::into_balance<T1>(v1)
    }

    public fun sell_base_deep<T0, T1, T2>(arg0: &mut 0x6c088e567321dbcf28a9d24d6c75d3dc66e13b3d371fdc6a66a12ec444a99842::session::Session<T2>, arg1: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T0, T1>, arg2: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::BalanceManager, arg3: &0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::TradeCap, arg4: &0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::DepositCap, arg5: &0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::WithdrawCap, arg6: 0x2::balance::Balance<T0>, arg7: u64, arg8: &0x2::clock::Clock, arg9: &mut 0x2::tx_context::TxContext) : 0x2::balance::Balance<T1> {
        let (_, v1) = simulate_deep<T0, T1>(arg1, true, 0x2::balance::value<T0>(&arg6), arg8);
        0x6c088e567321dbcf28a9d24d6c75d3dc66e13b3d371fdc6a66a12ec444a99842::session::record_leg<T2>(arg0, 0x2::object::id<0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T0, T1>>(arg1), true, deep_cost(v1, arg7));
        let (v2, v3) = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::swap_exact_quantity_with_manager<T0, T1>(arg1, arg2, arg3, arg4, arg5, 0x2::coin::from_balance<T0>(arg6, arg9), 0x2::coin::zero<T1>(arg9), 0, arg8, arg9);
        refund<T0>(v2, arg9);
        0x2::coin::into_balance<T1>(v3)
    }

    fun simulate_deep<T0, T1>(arg0: &0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T0, T1>, arg1: bool, arg2: u64, arg3: &0x2::clock::Clock) : (u64, u64) {
        if (arg2 == 0) {
            (0, 0)
        } else if (arg1) {
            let (_, v3, v4) = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::get_quote_quantity_out<T0, T1>(arg0, arg2, arg3);
            (v3, v4)
        } else {
            let (v5, _, v7) = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::get_base_quantity_out<T0, T1>(arg0, arg2, arg3);
            (v5, v7)
        }
    }

    // decompiled from Move bytecode v7
}

