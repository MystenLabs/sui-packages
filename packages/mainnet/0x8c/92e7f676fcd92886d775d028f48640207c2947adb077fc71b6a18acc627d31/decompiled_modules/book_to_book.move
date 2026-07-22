module 0xc84bc5ea056e8ab4cfce0ba8e87d1e3debc48d09d6b486dbda268f04479a4e03::book_to_book {
    public fun base_quote_base_v1<T0, T1>(arg0: &0x2::clock::Clock, arg1: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T0, T1>, arg2: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T0, T1>, arg3: 0x2::balance::Balance<T0>, arg4: 0x2::balance::Balance<0xdeeb7a4662eec9f2f3def03fb937a663dddaa2e215b8078a284d026b7946c270::deep::DEEP>, arg5: 0x2::balance::Balance<0xdeeb7a4662eec9f2f3def03fb937a663dddaa2e215b8078a284d026b7946c270::deep::DEEP>, arg6: u64, arg7: u64, arg8: u64, arg9: u64, arg10: u64, arg11: u64, arg12: u64, arg13: u64, arg14: &mut 0x2::tx_context::TxContext) : (0x2::balance::Balance<T0>, 0x2::balance::Balance<T1>, 0x2::balance::Balance<0xdeeb7a4662eec9f2f3def03fb937a663dddaa2e215b8078a284d026b7946c270::deep::DEEP>, 0x2::balance::Balance<0xdeeb7a4662eec9f2f3def03fb937a663dddaa2e215b8078a284d026b7946c270::deep::DEEP>, u64, u64, u64, u64, u64) {
        assert!(0x2::object::id<0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T0, T1>>(arg1) != 0x2::object::id<0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T0, T1>>(arg2), 500);
        let (v0, v1, v2, v3, v4) = 0xc84bc5ea056e8ab4cfce0ba8e87d1e3debc48d09d6b486dbda268f04479a4e03::router::deepbook_base_to_quote_guarded_v5<T0, T1>(arg0, arg1, arg3, arg4, arg6, arg7, arg8, arg13, arg14);
        let (v5, v6, v7, v8, v9) = 0xc84bc5ea056e8ab4cfce0ba8e87d1e3debc48d09d6b486dbda268f04479a4e03::router::deepbook_quote_to_base_guarded_v5<T0, T1>(arg0, arg2, v0, arg5, arg9, arg10, arg11, arg13, arg14);
        let v10 = v5;
        0x2::balance::join<T0>(&mut v10, v1);
        let v11 = 0x2::balance::value<T0>(&v10);
        assert!(v11 >= arg12, 501);
        (v10, v6, v2, v7, v3, v4, v8, v9, v11)
    }

    public fun quote_base_quote_v1<T0, T1>(arg0: &0x2::clock::Clock, arg1: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T0, T1>, arg2: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T0, T1>, arg3: 0x2::balance::Balance<T1>, arg4: 0x2::balance::Balance<0xdeeb7a4662eec9f2f3def03fb937a663dddaa2e215b8078a284d026b7946c270::deep::DEEP>, arg5: 0x2::balance::Balance<0xdeeb7a4662eec9f2f3def03fb937a663dddaa2e215b8078a284d026b7946c270::deep::DEEP>, arg6: u64, arg7: u64, arg8: u64, arg9: u64, arg10: u64, arg11: u64, arg12: u64, arg13: u64, arg14: &mut 0x2::tx_context::TxContext) : (0x2::balance::Balance<T1>, 0x2::balance::Balance<T0>, 0x2::balance::Balance<0xdeeb7a4662eec9f2f3def03fb937a663dddaa2e215b8078a284d026b7946c270::deep::DEEP>, 0x2::balance::Balance<0xdeeb7a4662eec9f2f3def03fb937a663dddaa2e215b8078a284d026b7946c270::deep::DEEP>, u64, u64, u64, u64, u64) {
        assert!(0x2::object::id<0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T0, T1>>(arg1) != 0x2::object::id<0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T0, T1>>(arg2), 500);
        let (v0, v1, v2, v3, v4) = 0xc84bc5ea056e8ab4cfce0ba8e87d1e3debc48d09d6b486dbda268f04479a4e03::router::deepbook_quote_to_base_guarded_v5<T0, T1>(arg0, arg1, arg3, arg4, arg6, arg7, arg8, arg13, arg14);
        let (v5, v6, v7, v8, v9) = 0xc84bc5ea056e8ab4cfce0ba8e87d1e3debc48d09d6b486dbda268f04479a4e03::router::deepbook_base_to_quote_guarded_v5<T0, T1>(arg0, arg2, v0, arg5, arg9, arg10, arg11, arg13, arg14);
        let v10 = v5;
        0x2::balance::join<T1>(&mut v10, v1);
        let v11 = 0x2::balance::value<T1>(&v10);
        assert!(v11 >= arg12, 501);
        (v10, v6, v2, v7, v3, v4, v8, v9, v11)
    }

    // decompiled from Move bytecode v7
}

