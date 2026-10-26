module 0xea55ff28c5c8d111890542b5dcf648df3d2dd2bfc49aa5de44f05d0082d7207::deepbook {
    fun swap<T0, T1>(arg0: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T0, T1>, arg1: &mut 0x2::coin::Coin<T0>, arg2: &mut 0x2::coin::Coin<T1>, arg3: &mut 0x2::coin::Coin<0xdeeb7a4662eec9f2f3def03fb937a663dddaa2e215b8078a284d026b7946c270::deep::DEEP>, arg4: bool, arg5: bool, arg6: u64, arg7: u64, arg8: &0x2::clock::Clock, arg9: &mut 0x2::tx_context::TxContext) {
        if (arg5) {
            let v0 = if (arg4) {
                let (_, _, v3) = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::get_quote_quantity_out<T0, T1>(arg0, arg6, arg8);
                0x2::coin::split<0xdeeb7a4662eec9f2f3def03fb937a663dddaa2e215b8078a284d026b7946c270::deep::DEEP>(arg3, v3, arg9)
            } else {
                0x2::coin::zero<0xdeeb7a4662eec9f2f3def03fb937a663dddaa2e215b8078a284d026b7946c270::deep::DEEP>(arg9)
            };
            let (v4, v5, v6) = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::swap_exact_base_for_quote<T0, T1>(arg0, 0x2::coin::split<T0>(arg1, arg6, arg9), v0, arg7, arg8, arg9);
            let v7 = v4;
            assert!(arg6 > 0x2::coin::value<T0>(&v7), 0xea55ff28c5c8d111890542b5dcf648df3d2dd2bfc49aa5de44f05d0082d7207::error::insufficient_liquidity());
            0x2::coin::join<T0>(arg1, v7);
            0x2::coin::join<T1>(arg2, v5);
            if (arg4) {
                0x2::coin::join<0xdeeb7a4662eec9f2f3def03fb937a663dddaa2e215b8078a284d026b7946c270::deep::DEEP>(arg3, v6);
            } else {
                0x2::coin::destroy_zero<0xdeeb7a4662eec9f2f3def03fb937a663dddaa2e215b8078a284d026b7946c270::deep::DEEP>(v6);
            };
        } else {
            let v8 = if (arg4) {
                let (_, _, v11) = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::get_base_quantity_out<T0, T1>(arg0, arg6, arg8);
                0x2::coin::split<0xdeeb7a4662eec9f2f3def03fb937a663dddaa2e215b8078a284d026b7946c270::deep::DEEP>(arg3, v11, arg9)
            } else {
                0x2::coin::zero<0xdeeb7a4662eec9f2f3def03fb937a663dddaa2e215b8078a284d026b7946c270::deep::DEEP>(arg9)
            };
            let (v12, v13, v14) = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::swap_exact_quote_for_base<T0, T1>(arg0, 0x2::coin::split<T1>(arg2, arg6, arg9), v8, arg7, arg8, arg9);
            let v15 = v13;
            assert!(arg6 > 0x2::coin::value<T1>(&v15), 0xea55ff28c5c8d111890542b5dcf648df3d2dd2bfc49aa5de44f05d0082d7207::error::insufficient_liquidity());
            0x2::coin::join<T0>(arg1, v12);
            0x2::coin::join<T1>(arg2, v15);
            if (arg4) {
                0x2::coin::join<0xdeeb7a4662eec9f2f3def03fb937a663dddaa2e215b8078a284d026b7946c270::deep::DEEP>(arg3, v14);
            } else {
                0x2::coin::destroy_zero<0xdeeb7a4662eec9f2f3def03fb937a663dddaa2e215b8078a284d026b7946c270::deep::DEEP>(v14);
            };
        };
    }

    public(friend) fun calculate<T0, T1>(arg0: &0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T0, T1>, arg1: bool, arg2: bool, arg3: u64, arg4: &0x2::clock::Clock) : (u64, u64, bool) {
        assert!(arg3 > 0, 0xea55ff28c5c8d111890542b5dcf648df3d2dd2bfc49aa5de44f05d0082d7207::error::zero_amount());
        let (v0, v1) = if (arg2) {
            let (v2, v3) = if (arg1) {
                let (v4, v5, _) = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::get_quote_quantity_out_input_fee<T0, T1>(arg0, arg3, arg4);
                (v5, v4)
            } else {
                let (v7, v8, _) = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::get_base_quantity_out_input_fee<T0, T1>(arg0, arg3, arg4);
                (v7, v8)
            };
            (arg3 - v3, v2)
        } else if (arg1) {
            let (v10, v11, _) = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::get_base_quantity_in<T0, T1>(arg0, arg3, false, arg4);
            (v10, v11)
        } else {
            let (v13, v14, _) = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::get_quote_quantity_in<T0, T1>(arg0, arg3, false, arg4);
            (v14, v13)
        };
        let v16 = v0 == 0 || v1 == 0;
        (v0, v1, v16)
    }

    public fun quote<T0, T1>(arg0: &0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T0, T1>, arg1: bool, arg2: bool, arg3: u64, arg4: &0x2::clock::Clock) {
        let (v0, v1, v2) = calculate<T0, T1>(arg0, arg1, arg2, arg3, arg4);
        0xea55ff28c5c8d111890542b5dcf648df3d2dd2bfc49aa5de44f05d0082d7207::events::emit_swap_quote(0xea55ff28c5c8d111890542b5dcf648df3d2dd2bfc49aa5de44f05d0082d7207::events::source_deepbook(), 0x2::object::id<0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T0, T1>>(arg0), arg1, arg2, arg3, v0, v1, 0, v2);
    }

    public fun swap_a_to_b<T0, T1>(arg0: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T0, T1>, arg1: 0x2::coin::Coin<T0>, arg2: u64, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T0>, 0x2::coin::Coin<T1>, 0x2::coin::Coin<0xdeeb7a4662eec9f2f3def03fb937a663dddaa2e215b8078a284d026b7946c270::deep::DEEP>) {
        let v0 = 0x2::coin::zero<T1>(arg4);
        swap_entry<T0, T1>(arg0, arg1, v0, arg2, arg3, true, arg4)
    }

    public fun swap_a_to_b_v2<T0, T1>(arg0: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T0, T1>, arg1: 0x2::coin::Coin<T0>, arg2: u64, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T0>, 0x2::coin::Coin<T1>) {
        let v0 = 0x2::coin::zero<T1>(arg4);
        let (v1, v2, v3) = swap_entry<T0, T1>(arg0, arg1, v0, arg2, arg3, true, arg4);
        0x2::coin::destroy_zero<0xdeeb7a4662eec9f2f3def03fb937a663dddaa2e215b8078a284d026b7946c270::deep::DEEP>(v3);
        (v1, v2)
    }

    public fun swap_b_to_a<T0, T1>(arg0: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T0, T1>, arg1: 0x2::coin::Coin<T1>, arg2: u64, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T0>, 0x2::coin::Coin<T1>, 0x2::coin::Coin<0xdeeb7a4662eec9f2f3def03fb937a663dddaa2e215b8078a284d026b7946c270::deep::DEEP>) {
        let v0 = 0x2::coin::zero<T0>(arg4);
        swap_entry<T0, T1>(arg0, v0, arg1, arg2, arg3, false, arg4)
    }

    public fun swap_b_to_a_v2<T0, T1>(arg0: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T0, T1>, arg1: 0x2::coin::Coin<T1>, arg2: u64, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T0>, 0x2::coin::Coin<T1>) {
        let v0 = 0x2::coin::zero<T0>(arg4);
        let (v1, v2, v3) = swap_entry<T0, T1>(arg0, v0, arg1, arg2, arg3, false, arg4);
        0x2::coin::destroy_zero<0xdeeb7a4662eec9f2f3def03fb937a663dddaa2e215b8078a284d026b7946c270::deep::DEEP>(v3);
        (v1, v2)
    }

    fun swap_entry<T0, T1>(arg0: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T0, T1>, arg1: 0x2::coin::Coin<T0>, arg2: 0x2::coin::Coin<T1>, arg3: u64, arg4: &0x2::clock::Clock, arg5: bool, arg6: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T0>, 0x2::coin::Coin<T1>, 0x2::coin::Coin<0xdeeb7a4662eec9f2f3def03fb937a663dddaa2e215b8078a284d026b7946c270::deep::DEEP>) {
        let v0 = if (arg5) {
            0x2::coin::value<T0>(&arg1)
        } else {
            0x2::coin::value<T1>(&arg2)
        };
        assert!(v0 > 0, 0xea55ff28c5c8d111890542b5dcf648df3d2dd2bfc49aa5de44f05d0082d7207::error::zero_amount());
        let v1 = 0x2::coin::zero<0xdeeb7a4662eec9f2f3def03fb937a663dddaa2e215b8078a284d026b7946c270::deep::DEEP>(arg6);
        let v2 = &mut arg1;
        let v3 = &mut arg2;
        let v4 = &mut v1;
        swap<T0, T1>(arg0, v2, v3, v4, false, arg5, v0, arg3, arg4, arg6);
        (arg1, arg2, v1)
    }

    // decompiled from Move bytecode v7
}

