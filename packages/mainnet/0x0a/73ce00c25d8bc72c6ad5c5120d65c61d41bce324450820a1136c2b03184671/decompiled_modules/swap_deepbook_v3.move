module 0xa73ce00c25d8bc72c6ad5c5120d65c61d41bce324450820a1136c2b03184671::swap_deepbook_v3 {
    public fun swap<T0, T1, T2, T3>(arg0: 0x1::option::Option<0x2::coin::Coin<T0>>, arg1: 0x1::option::Option<0x2::coin::Coin<T1>>, arg2: 0x1::option::Option<0x2::coin::Coin<0xdeeb7a4662eec9f2f3def03fb937a663dddaa2e215b8078a284d026b7946c270::deep::DEEP>>, arg3: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T0, T1>, arg4: u64, arg5: &0x2::clock::Clock, arg6: &0x1a830340e1caed73881c51f13fd3c1409153879493b56688118012c25b658512::swap_transaction::SwapTransaction<T2, T3>, arg7: &0x1a830340e1caed73881c51f13fd3c1409153879493b56688118012c25b658512::state::State, arg8: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T0>, 0x2::coin::Coin<T1>, 0x2::coin::Coin<0xdeeb7a4662eec9f2f3def03fb937a663dddaa2e215b8078a284d026b7946c270::deep::DEEP>) {
        let (v0, v1) = 0x1a830340e1caed73881c51f13fd3c1409153879493b56688118012c25b658512::utils::parse_amount_and_direction<T0, T1>(&arg0, &arg1);
        let (v2, v3, v4) = if (v1) {
            0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::swap_exact_base_for_quote<T0, T1>(arg3, 0x1::option::extract<0x2::coin::Coin<T0>>(&mut arg0), 0x1::option::extract<0x2::coin::Coin<0xdeeb7a4662eec9f2f3def03fb937a663dddaa2e215b8078a284d026b7946c270::deep::DEEP>>(&mut arg2), arg4, arg5, arg8)
        } else {
            0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::swap_exact_quote_for_base<T0, T1>(arg3, 0x1::option::extract<0x2::coin::Coin<T1>>(&mut arg1), 0x1::option::extract<0x2::coin::Coin<0xdeeb7a4662eec9f2f3def03fb937a663dddaa2e215b8078a284d026b7946c270::deep::DEEP>>(&mut arg2), arg4, arg5, arg8)
        };
        let v5 = v3;
        let v6 = v2;
        0x1::option::destroy_none<0x2::coin::Coin<T0>>(arg0);
        0x1::option::destroy_none<0x2::coin::Coin<T1>>(arg1);
        0x1::option::destroy_none<0x2::coin::Coin<0xdeeb7a4662eec9f2f3def03fb937a663dddaa2e215b8078a284d026b7946c270::deep::DEEP>>(arg2);
        let v7 = if (v1) {
            0x2::coin::value<T1>(&v5)
        } else {
            0x2::coin::value<T0>(&v6)
        };
        let v8 = 0x2::object::id<0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T0, T1>>(arg3);
        0xa73ce00c25d8bc72c6ad5c5120d65c61d41bce324450820a1136c2b03184671::swap_event::emit_common_swap<T0, T1>(0x1a830340e1caed73881c51f13fd3c1409153879493b56688118012c25b658512::consts::DEX_DEEPBOOK_V3(), 0x2::object::id_to_address(&v8), v1, v0, v7, true);
        (v6, v5, v4)
    }

    public fun swap_a2b<T0, T1, T2, T3>(arg0: 0x2::coin::Coin<T0>, arg1: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T0, T1>, arg2: u64, arg3: &0x2::clock::Clock, arg4: &0x1a830340e1caed73881c51f13fd3c1409153879493b56688118012c25b658512::swap_transaction::SwapTransaction<T2, T3>, arg5: &0x1a830340e1caed73881c51f13fd3c1409153879493b56688118012c25b658512::state::State, arg6: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T1> {
        let (v0, v1, v2) = swap<T0, T1, T2, T3>(0x1::option::some<0x2::coin::Coin<T0>>(arg0), 0x1::option::none<0x2::coin::Coin<T1>>(), 0x1::option::none<0x2::coin::Coin<0xdeeb7a4662eec9f2f3def03fb937a663dddaa2e215b8078a284d026b7946c270::deep::DEEP>>(), arg1, arg2, arg3, arg4, arg5, arg6);
        0x1a830340e1caed73881c51f13fd3c1409153879493b56688118012c25b658512::utils::transfer_or_destroy<T0>(v0, arg6);
        0x1a830340e1caed73881c51f13fd3c1409153879493b56688118012c25b658512::utils::transfer_or_destroy<0xdeeb7a4662eec9f2f3def03fb937a663dddaa2e215b8078a284d026b7946c270::deep::DEEP>(v2, arg6);
        v1
    }

    public fun swap_a2b_with_deep<T0, T1, T2, T3>(arg0: 0x2::coin::Coin<T0>, arg1: 0x2::coin::Coin<0xdeeb7a4662eec9f2f3def03fb937a663dddaa2e215b8078a284d026b7946c270::deep::DEEP>, arg2: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T0, T1>, arg3: u64, arg4: &0x2::clock::Clock, arg5: &0x1a830340e1caed73881c51f13fd3c1409153879493b56688118012c25b658512::swap_transaction::SwapTransaction<T2, T3>, arg6: &0x1a830340e1caed73881c51f13fd3c1409153879493b56688118012c25b658512::state::State, arg7: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T1> {
        let (v0, v1, v2) = swap<T0, T1, T2, T3>(0x1::option::some<0x2::coin::Coin<T0>>(arg0), 0x1::option::none<0x2::coin::Coin<T1>>(), 0x1::option::some<0x2::coin::Coin<0xdeeb7a4662eec9f2f3def03fb937a663dddaa2e215b8078a284d026b7946c270::deep::DEEP>>(arg1), arg2, arg3, arg4, arg5, arg6, arg7);
        0x1a830340e1caed73881c51f13fd3c1409153879493b56688118012c25b658512::utils::transfer_or_destroy<T0>(v0, arg7);
        0x1a830340e1caed73881c51f13fd3c1409153879493b56688118012c25b658512::utils::transfer_or_destroy<0xdeeb7a4662eec9f2f3def03fb937a663dddaa2e215b8078a284d026b7946c270::deep::DEEP>(v2, arg7);
        v1
    }

    public fun swap_b2a<T0, T1, T2, T3>(arg0: 0x2::coin::Coin<T0>, arg1: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T0, T1>, arg2: u64, arg3: &0x2::clock::Clock, arg4: &0x1a830340e1caed73881c51f13fd3c1409153879493b56688118012c25b658512::swap_transaction::SwapTransaction<T2, T3>, arg5: &0x1a830340e1caed73881c51f13fd3c1409153879493b56688118012c25b658512::state::State, arg6: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        let (v0, v1, v2) = swap<T0, T1, T2, T3>(0x1::option::some<0x2::coin::Coin<T0>>(arg0), 0x1::option::none<0x2::coin::Coin<T1>>(), 0x1::option::none<0x2::coin::Coin<0xdeeb7a4662eec9f2f3def03fb937a663dddaa2e215b8078a284d026b7946c270::deep::DEEP>>(), arg1, arg2, arg3, arg4, arg5, arg6);
        0x1a830340e1caed73881c51f13fd3c1409153879493b56688118012c25b658512::utils::transfer_or_destroy<T1>(v1, arg6);
        0x1a830340e1caed73881c51f13fd3c1409153879493b56688118012c25b658512::utils::transfer_or_destroy<0xdeeb7a4662eec9f2f3def03fb937a663dddaa2e215b8078a284d026b7946c270::deep::DEEP>(v2, arg6);
        v0
    }

    public fun swap_b2a_with_deep<T0, T1, T2, T3>(arg0: 0x2::coin::Coin<T0>, arg1: 0x2::coin::Coin<0xdeeb7a4662eec9f2f3def03fb937a663dddaa2e215b8078a284d026b7946c270::deep::DEEP>, arg2: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T0, T1>, arg3: u64, arg4: &0x2::clock::Clock, arg5: &0x1a830340e1caed73881c51f13fd3c1409153879493b56688118012c25b658512::swap_transaction::SwapTransaction<T2, T3>, arg6: &0x1a830340e1caed73881c51f13fd3c1409153879493b56688118012c25b658512::state::State, arg7: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        let (v0, v1, v2) = swap<T0, T1, T2, T3>(0x1::option::some<0x2::coin::Coin<T0>>(arg0), 0x1::option::none<0x2::coin::Coin<T1>>(), 0x1::option::some<0x2::coin::Coin<0xdeeb7a4662eec9f2f3def03fb937a663dddaa2e215b8078a284d026b7946c270::deep::DEEP>>(arg1), arg2, arg3, arg4, arg5, arg6, arg7);
        0x1a830340e1caed73881c51f13fd3c1409153879493b56688118012c25b658512::utils::transfer_or_destroy<T1>(v1, arg7);
        0x1a830340e1caed73881c51f13fd3c1409153879493b56688118012c25b658512::utils::transfer_or_destroy<0xdeeb7a4662eec9f2f3def03fb937a663dddaa2e215b8078a284d026b7946c270::deep::DEEP>(v2, arg7);
        v0
    }

    // decompiled from Move bytecode v6
}

