module 0x37678debdaa6a1acfaa94aaa649fe1a8f320a02c1661f0fe001a0441c2c0c6d1::deepbookv3_agg {
    public fun swap<T0, T1, T2>(arg0: &mut 0x37678debdaa6a1acfaa94aaa649fe1a8f320a02c1661f0fe001a0441c2c0c6d1::custom_liquidate::CustomLiquidateReceipt<T0>, arg1: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T1, T2>, arg2: 0x2::coin::Coin<0xdeeb7a4662eec9f2f3def03fb937a663dddaa2e215b8078a284d026b7946c270::deep::DEEP>, arg3: bool, arg4: u64, arg5: u64, arg6: &0x2::clock::Clock, arg7: &mut 0x2::tx_context::TxContext) {
        let (v0, v1, v2) = if (arg3) {
            swap_a2b<T1, T2>(arg1, 0x37678debdaa6a1acfaa94aaa649fe1a8f320a02c1661f0fe001a0441c2c0c6d1::custom_liquidate::take_balance<T0, T1>(arg0, arg4), arg2, arg5, arg6, arg7)
        } else {
            swap_b2a<T1, T2>(arg1, 0x37678debdaa6a1acfaa94aaa649fe1a8f320a02c1661f0fe001a0441c2c0c6d1::custom_liquidate::take_balance<T0, T2>(arg0, arg4), arg2, arg5, arg6, arg7)
        };
        let v3 = v2;
        let v4 = v1;
        let v5 = v0;
        if (0x2::balance::value<T1>(&v5) > 0) {
            0x37678debdaa6a1acfaa94aaa649fe1a8f320a02c1661f0fe001a0441c2c0c6d1::custom_liquidate::put_balance<T0, T1>(arg0, v5);
        } else {
            0x2::balance::destroy_zero<T1>(v5);
        };
        if (0x2::balance::value<T2>(&v4) > 0) {
            0x37678debdaa6a1acfaa94aaa649fe1a8f320a02c1661f0fe001a0441c2c0c6d1::custom_liquidate::put_balance<T0, T2>(arg0, v4);
        } else {
            0x2::balance::destroy_zero<T2>(v4);
        };
        if (0x2::coin::value<0xdeeb7a4662eec9f2f3def03fb937a663dddaa2e215b8078a284d026b7946c270::deep::DEEP>(&v3) > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<0xdeeb7a4662eec9f2f3def03fb937a663dddaa2e215b8078a284d026b7946c270::deep::DEEP>>(v3, 0x2::tx_context::sender(arg7));
        } else {
            0x2::coin::destroy_zero<0xdeeb7a4662eec9f2f3def03fb937a663dddaa2e215b8078a284d026b7946c270::deep::DEEP>(v3);
        };
    }

    fun swap_a2b<T0, T1>(arg0: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T0, T1>, arg1: 0x2::balance::Balance<T0>, arg2: 0x2::coin::Coin<0xdeeb7a4662eec9f2f3def03fb937a663dddaa2e215b8078a284d026b7946c270::deep::DEEP>, arg3: u64, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) : (0x2::balance::Balance<T0>, 0x2::balance::Balance<T1>, 0x2::coin::Coin<0xdeeb7a4662eec9f2f3def03fb937a663dddaa2e215b8078a284d026b7946c270::deep::DEEP>) {
        if (0x2::balance::value<T0>(&arg1) == 0) {
            0x2::balance::destroy_zero<T0>(arg1);
            return (0x2::balance::zero<T0>(), 0x2::balance::zero<T1>(), arg2)
        };
        let (v0, v1, v2) = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::swap_exact_base_for_quote<T0, T1>(arg0, 0x2::coin::from_balance<T0>(arg1, arg5), arg2, arg3, arg4, arg5);
        (0x2::coin::into_balance<T0>(v0), 0x2::coin::into_balance<T1>(v1), v2)
    }

    fun swap_b2a<T0, T1>(arg0: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T0, T1>, arg1: 0x2::balance::Balance<T1>, arg2: 0x2::coin::Coin<0xdeeb7a4662eec9f2f3def03fb937a663dddaa2e215b8078a284d026b7946c270::deep::DEEP>, arg3: u64, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) : (0x2::balance::Balance<T0>, 0x2::balance::Balance<T1>, 0x2::coin::Coin<0xdeeb7a4662eec9f2f3def03fb937a663dddaa2e215b8078a284d026b7946c270::deep::DEEP>) {
        if (0x2::balance::value<T1>(&arg1) == 0) {
            0x2::balance::destroy_zero<T1>(arg1);
            return (0x2::balance::zero<T0>(), 0x2::balance::zero<T1>(), arg2)
        };
        let (v0, v1, v2) = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::swap_exact_quote_for_base<T0, T1>(arg0, 0x2::coin::from_balance<T1>(arg1, arg5), arg2, arg3, arg4, arg5);
        (0x2::coin::into_balance<T0>(v0), 0x2::coin::into_balance<T1>(v1), v2)
    }

    // decompiled from Move bytecode v6
}

