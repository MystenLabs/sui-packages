module 0x295996598f9c02e39ba8cdd7a2cdb1a75dadcedc5634efd073c8a39f4d1ffb04::swap {
    fun assert_within(arg0: u64, arg1: u64, arg2: bool) {
        if (arg2) {
            assert!(arg0 >= arg1, 101);
        } else {
            assert!(arg0 <= arg1, 101);
        };
    }

    fun discard_zero_deep(arg0: 0x2::coin::Coin<0xdeeb7a4662eec9f2f3def03fb937a663dddaa2e215b8078a284d026b7946c270::deep::DEEP>) {
        assert!(0x2::coin::value<0xdeeb7a4662eec9f2f3def03fb937a663dddaa2e215b8078a284d026b7946c270::deep::DEEP>(&arg0) == 0, 105);
        0x2::coin::destroy_zero<0xdeeb7a4662eec9f2f3def03fb937a663dddaa2e215b8078a284d026b7946c270::deep::DEEP>(arg0);
    }

    public fun guard<T0, T1>(arg0: &0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T0, T1>, arg1: &0x2::clock::Clock, arg2: u64, arg3: bool) {
        assert_within(0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::mid_price<T0, T1>(arg0, arg1), arg2, arg3);
    }

    public fun swap_base_for_quote<T0, T1>(arg0: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T0, T1>, arg1: 0x2::balance::Balance<T0>, arg2: u64, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) : (0x2::balance::Balance<T1>, 0x2::balance::Balance<T0>) {
        let (v0, v1, v2) = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::swap_exact_base_for_quote<T0, T1>(arg0, 0x2::coin::from_balance<T0>(arg1, arg4), 0x2::coin::zero<0xdeeb7a4662eec9f2f3def03fb937a663dddaa2e215b8078a284d026b7946c270::deep::DEEP>(arg4), arg2, arg3, arg4);
        discard_zero_deep(v2);
        let v3 = 0x2::coin::into_balance<T1>(v1);
        assert!(0x2::balance::value<T1>(&v3) > 0, 104);
        (v3, 0x2::coin::into_balance<T0>(v0))
    }

    public fun swap_quote_for_base<T0, T1>(arg0: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T0, T1>, arg1: 0x2::balance::Balance<T1>, arg2: u64, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) : (0x2::balance::Balance<T0>, 0x2::balance::Balance<T1>) {
        let (v0, v1, v2) = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::swap_exact_quote_for_base<T0, T1>(arg0, 0x2::coin::from_balance<T1>(arg1, arg4), 0x2::coin::zero<0xdeeb7a4662eec9f2f3def03fb937a663dddaa2e215b8078a284d026b7946c270::deep::DEEP>(arg4), arg2, arg3, arg4);
        discard_zero_deep(v2);
        let v3 = 0x2::coin::into_balance<T0>(v0);
        assert!(0x2::balance::value<T0>(&v3) > 0, 104);
        (v3, 0x2::coin::into_balance<T1>(v1))
    }

    // decompiled from Move bytecode v7
}

