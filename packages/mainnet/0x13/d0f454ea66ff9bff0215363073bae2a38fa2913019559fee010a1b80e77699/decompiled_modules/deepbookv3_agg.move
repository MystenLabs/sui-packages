module 0x13d0f454ea66ff9bff0215363073bae2a38fa2913019559fee010a1b80e77699::deepbookv3_agg {
    struct DeepbookV3Agg has drop {
        dummy_field: bool,
    }

    public fun swap<T0, T1>(arg0: &0xcf2a17c05abf1dd0ee09be8d91e5f76124ef135002b4ffeb947e6d6cf13df726::router::Router, arg1: &mut 0xcf2a17c05abf1dd0ee09be8d91e5f76124ef135002b4ffeb947e6d6cf13df726::swap::SwapContext, arg2: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T0, T1>, arg3: 0x2::coin::Coin<0xdeeb7a4662eec9f2f3def03fb937a663dddaa2e215b8078a284d026b7946c270::deep::DEEP>, arg4: bool, arg5: u64, arg6: u64, arg7: &0x2::clock::Clock, arg8: &mut 0x2::tx_context::TxContext) {
        let (v0, v1, v2) = if (arg4) {
            let v3 = DeepbookV3Agg{dummy_field: false};
            swap_a2b<T0, T1>(arg2, 0xcf2a17c05abf1dd0ee09be8d91e5f76124ef135002b4ffeb947e6d6cf13df726::swap::take_balance<DeepbookV3Agg, T0>(arg1, arg0, v3, arg5), arg3, arg6, arg7, arg8)
        } else {
            let v4 = DeepbookV3Agg{dummy_field: false};
            swap_b2a<T0, T1>(arg2, 0xcf2a17c05abf1dd0ee09be8d91e5f76124ef135002b4ffeb947e6d6cf13df726::swap::take_balance<DeepbookV3Agg, T1>(arg1, arg0, v4, arg5), arg3, arg6, arg7, arg8)
        };
        let v5 = v2;
        let v6 = v1;
        let v7 = v0;
        if (0x2::balance::value<T0>(&v7) > 0) {
            0xcf2a17c05abf1dd0ee09be8d91e5f76124ef135002b4ffeb947e6d6cf13df726::swap::put_balance<T0>(arg1, v7);
        } else {
            0x2::balance::destroy_zero<T0>(v7);
        };
        if (0x2::balance::value<T1>(&v6) > 0) {
            0xcf2a17c05abf1dd0ee09be8d91e5f76124ef135002b4ffeb947e6d6cf13df726::swap::put_balance<T1>(arg1, v6);
        } else {
            0x2::balance::destroy_zero<T1>(v6);
        };
        if (0x2::coin::value<0xdeeb7a4662eec9f2f3def03fb937a663dddaa2e215b8078a284d026b7946c270::deep::DEEP>(&v5) > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<0xdeeb7a4662eec9f2f3def03fb937a663dddaa2e215b8078a284d026b7946c270::deep::DEEP>>(v5, 0x2::tx_context::sender(arg8));
        } else {
            0x2::coin::destroy_zero<0xdeeb7a4662eec9f2f3def03fb937a663dddaa2e215b8078a284d026b7946c270::deep::DEEP>(v5);
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

