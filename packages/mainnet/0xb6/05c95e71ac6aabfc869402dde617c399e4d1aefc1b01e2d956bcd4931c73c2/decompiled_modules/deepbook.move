module 0x7452c8ce8db1991fe41e500a4778b04f5b1d8891528b0376988f966cbdae5409::deepbook {
    fun charge_deep<T0>(arg0: &mut 0x7452c8ce8db1991fe41e500a4778b04f5b1d8891528b0376988f966cbdae5409::plan::Plan<T0>, arg1: &mut 0x2::coin::Coin<0xdeeb7a4662eec9f2f3def03fb937a663dddaa2e215b8078a284d026b7946c270::deep::DEEP>, arg2: u64, arg3: 0x2::coin::Coin<0xdeeb7a4662eec9f2f3def03fb937a663dddaa2e215b8078a284d026b7946c270::deep::DEEP>, arg4: u64) {
        0x2::coin::join<0xdeeb7a4662eec9f2f3def03fb937a663dddaa2e215b8078a284d026b7946c270::deep::DEEP>(arg1, arg3);
        0x7452c8ce8db1991fe41e500a4778b04f5b1d8891528b0376988f966cbdae5409::plan::add_required<T0>(arg0, deep_cost_in_t(arg2 - 0x2::coin::value<0xdeeb7a4662eec9f2f3def03fb937a663dddaa2e215b8078a284d026b7946c270::deep::DEEP>(&arg3), arg4));
    }

    fun deep_cost_in_t(arg0: u64, arg1: u64) : u64 {
        if (arg0 == 0 || arg1 == 0) {
            return 0
        };
        (0x1::u128::div_ceil((arg0 as u128) * (arg1 as u128), 1000000000) as u64)
    }

    public fun eval_base_to_quote<T0, T1, T2>(arg0: &mut 0x7452c8ce8db1991fe41e500a4778b04f5b1d8891528b0376988f966cbdae5409::plan::Plan<T0>, arg1: &0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T1, T2>, arg2: u64, arg3: u64, arg4: &0x2::clock::Clock) {
        let v0 = 0x7452c8ce8db1991fe41e500a4778b04f5b1d8891528b0376988f966cbdae5409::plan::hop_inputs<T0>(arg0, arg2);
        let v1 = vector[];
        let v2 = vector[];
        let v3 = 0;
        while (v3 < 0x1::vector::length<u64>(&v0)) {
            let v4 = *0x1::vector::borrow<u64>(&v0, v3);
            if (v4 == 0) {
                0x1::vector::push_back<u64>(&mut v1, 0);
                0x1::vector::push_back<u64>(&mut v2, 0);
            } else {
                let (_, v6, v7) = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::get_quote_quantity_out<T1, T2>(arg1, v4, arg4);
                0x1::vector::push_back<u64>(&mut v1, v6);
                0x1::vector::push_back<u64>(&mut v2, deep_cost_in_t(v7, arg3));
            };
            v3 = v3 + 1;
        };
        0x7452c8ce8db1991fe41e500a4778b04f5b1d8891528b0376988f966cbdae5409::plan::record_hop<T0>(arg0, arg2, 0x2::object::id<0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T1, T2>>(arg1), v1);
        0x7452c8ce8db1991fe41e500a4778b04f5b1d8891528b0376988f966cbdae5409::plan::add_external_cost<T0>(arg0, arg2, v2);
    }

    public fun eval_quote_to_base<T0, T1, T2>(arg0: &mut 0x7452c8ce8db1991fe41e500a4778b04f5b1d8891528b0376988f966cbdae5409::plan::Plan<T0>, arg1: &0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T1, T2>, arg2: u64, arg3: u64, arg4: &0x2::clock::Clock) {
        let v0 = 0x7452c8ce8db1991fe41e500a4778b04f5b1d8891528b0376988f966cbdae5409::plan::hop_inputs<T0>(arg0, arg2);
        let v1 = vector[];
        let v2 = vector[];
        let v3 = 0;
        while (v3 < 0x1::vector::length<u64>(&v0)) {
            let v4 = *0x1::vector::borrow<u64>(&v0, v3);
            if (v4 == 0) {
                0x1::vector::push_back<u64>(&mut v1, 0);
                0x1::vector::push_back<u64>(&mut v2, 0);
            } else {
                let (v5, _, v7) = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::get_base_quantity_out<T1, T2>(arg1, v4, arg4);
                0x1::vector::push_back<u64>(&mut v1, v5);
                0x1::vector::push_back<u64>(&mut v2, deep_cost_in_t(v7, arg3));
            };
            v3 = v3 + 1;
        };
        0x7452c8ce8db1991fe41e500a4778b04f5b1d8891528b0376988f966cbdae5409::plan::record_hop<T0>(arg0, arg2, 0x2::object::id<0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T1, T2>>(arg1), v1);
        0x7452c8ce8db1991fe41e500a4778b04f5b1d8891528b0376988f966cbdae5409::plan::add_external_cost<T0>(arg0, arg2, v2);
    }

    public fun swap_base_for_quote<T0, T1, T2>(arg0: &mut 0x7452c8ce8db1991fe41e500a4778b04f5b1d8891528b0376988f966cbdae5409::plan::Plan<T0>, arg1: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T1, T2>, arg2: u64, arg3: 0x2::balance::Balance<T1>, arg4: &mut 0x2::coin::Coin<0xdeeb7a4662eec9f2f3def03fb937a663dddaa2e215b8078a284d026b7946c270::deep::DEEP>, arg5: u64, arg6: &0x2::clock::Clock, arg7: &mut 0x2::tx_context::TxContext) : (0x2::balance::Balance<T2>, 0x2::balance::Balance<T1>) {
        if (!0x7452c8ce8db1991fe41e500a4778b04f5b1d8891528b0376988f966cbdae5409::plan::is_selected<T0>(arg0, arg2)) {
            return (0x2::balance::zero<T2>(), arg3)
        };
        0x7452c8ce8db1991fe41e500a4778b04f5b1d8891528b0376988f966cbdae5409::plan::advance<T0>(arg0, arg2, 0x2::object::id<0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T1, T2>>(arg1));
        let (_, _, v2) = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::get_quote_quantity_out<T1, T2>(arg1, 0x2::balance::value<T1>(&arg3), arg6);
        let (v3, v4, v5) = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::swap_exact_base_for_quote<T1, T2>(arg1, 0x2::coin::from_balance<T1>(arg3, arg7), 0x2::coin::split<0xdeeb7a4662eec9f2f3def03fb937a663dddaa2e215b8078a284d026b7946c270::deep::DEEP>(arg4, v2, arg7), 0, arg6, arg7);
        charge_deep<T0>(arg0, arg4, v2, v5, arg5);
        (0x2::coin::into_balance<T2>(v4), 0x2::coin::into_balance<T1>(v3))
    }

    public fun swap_quote_for_base<T0, T1, T2>(arg0: &mut 0x7452c8ce8db1991fe41e500a4778b04f5b1d8891528b0376988f966cbdae5409::plan::Plan<T0>, arg1: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T1, T2>, arg2: u64, arg3: 0x2::balance::Balance<T2>, arg4: &mut 0x2::coin::Coin<0xdeeb7a4662eec9f2f3def03fb937a663dddaa2e215b8078a284d026b7946c270::deep::DEEP>, arg5: u64, arg6: &0x2::clock::Clock, arg7: &mut 0x2::tx_context::TxContext) : (0x2::balance::Balance<T1>, 0x2::balance::Balance<T2>) {
        if (!0x7452c8ce8db1991fe41e500a4778b04f5b1d8891528b0376988f966cbdae5409::plan::is_selected<T0>(arg0, arg2)) {
            return (0x2::balance::zero<T1>(), arg3)
        };
        0x7452c8ce8db1991fe41e500a4778b04f5b1d8891528b0376988f966cbdae5409::plan::advance<T0>(arg0, arg2, 0x2::object::id<0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T1, T2>>(arg1));
        let (_, _, v2) = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::get_base_quantity_out<T1, T2>(arg1, 0x2::balance::value<T2>(&arg3), arg6);
        let (v3, v4, v5) = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::swap_exact_quote_for_base<T1, T2>(arg1, 0x2::coin::from_balance<T2>(arg3, arg7), 0x2::coin::split<0xdeeb7a4662eec9f2f3def03fb937a663dddaa2e215b8078a284d026b7946c270::deep::DEEP>(arg4, v2, arg7), 0, arg6, arg7);
        charge_deep<T0>(arg0, arg4, v2, v5, arg5);
        (0x2::coin::into_balance<T1>(v3), 0x2::coin::into_balance<T2>(v4))
    }

    // decompiled from Move bytecode v7
}

