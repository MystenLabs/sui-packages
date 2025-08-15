module 0x8a321af90ddca139ffc387073b02ded868478ffd42659d1c0aed990162900617::deepbook_v3 {
    struct DeepbookV3SwapEvent has copy, drop {
        pool_id: 0x2::object::ID,
        a2b: bool,
        amount_in: u64,
        amount_out: u64,
        by_amount_in: bool,
        coin_a: 0x1::type_name::TypeName,
        coin_b: 0x1::type_name::TypeName,
    }

    public fun swap<T0, T1>(arg0: 0x1::option::Option<0x2::coin::Coin<T0>>, arg1: 0x1::option::Option<0x2::coin::Coin<T1>>, arg2: 0x1::option::Option<0x2::coin::Coin<0xdeeb7a4662eec9f2f3def03fb937a663dddaa2e215b8078a284d026b7946c270::deep::DEEP>>, arg3: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T0, T1>, arg4: u64, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T0>, 0x2::coin::Coin<T1>, 0x2::coin::Coin<0xdeeb7a4662eec9f2f3def03fb937a663dddaa2e215b8078a284d026b7946c270::deep::DEEP>) {
        let (v0, v1) = 0x93dc806c0a848a19b5aaec200373a1eba5706c574ebc3297e5842bed5acce92d::utils::parse_amount_and_direction<T0, T1>(&arg0, &arg1);
        let v2 = if (0x1::option::is_some<0x2::coin::Coin<0xdeeb7a4662eec9f2f3def03fb937a663dddaa2e215b8078a284d026b7946c270::deep::DEEP>>(&arg2)) {
            0x1::option::extract<0x2::coin::Coin<0xdeeb7a4662eec9f2f3def03fb937a663dddaa2e215b8078a284d026b7946c270::deep::DEEP>>(&mut arg2)
        } else {
            0x2::coin::zero<0xdeeb7a4662eec9f2f3def03fb937a663dddaa2e215b8078a284d026b7946c270::deep::DEEP>(arg6)
        };
        let (v3, v4, v5) = if (v1) {
            0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::swap_exact_base_for_quote<T0, T1>(arg3, 0x1::option::extract<0x2::coin::Coin<T0>>(&mut arg0), v2, arg4, arg5, arg6)
        } else {
            0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::swap_exact_quote_for_base<T0, T1>(arg3, 0x1::option::extract<0x2::coin::Coin<T1>>(&mut arg1), v2, arg4, arg5, arg6)
        };
        let v6 = v4;
        let v7 = v3;
        0x1::option::destroy_none<0x2::coin::Coin<T0>>(arg0);
        0x1::option::destroy_none<0x2::coin::Coin<T1>>(arg1);
        0x1::option::destroy_none<0x2::coin::Coin<0xdeeb7a4662eec9f2f3def03fb937a663dddaa2e215b8078a284d026b7946c270::deep::DEEP>>(arg2);
        let v8 = if (v1) {
            0x2::coin::value<T1>(&v6)
        } else {
            0x2::coin::value<T0>(&v7)
        };
        let v9 = DeepbookV3SwapEvent{
            pool_id      : 0x2::object::id<0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T0, T1>>(arg3),
            a2b          : v1,
            amount_in    : v0,
            amount_out   : v8,
            by_amount_in : true,
            coin_a       : 0x1::type_name::get<T0>(),
            coin_b       : 0x1::type_name::get<T1>(),
        };
        0x2::event::emit<DeepbookV3SwapEvent>(v9);
        (v7, v6, v5)
    }

    public fun swap_a2b<T0, T1>(arg0: 0x2::coin::Coin<T0>, arg1: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T0, T1>, arg2: u64, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T1> {
        let (v0, v1, v2) = swap<T0, T1>(0x1::option::some<0x2::coin::Coin<T0>>(arg0), 0x1::option::none<0x2::coin::Coin<T1>>(), 0x1::option::none<0x2::coin::Coin<0xdeeb7a4662eec9f2f3def03fb937a663dddaa2e215b8078a284d026b7946c270::deep::DEEP>>(), arg1, arg2, arg3, arg4);
        0x93dc806c0a848a19b5aaec200373a1eba5706c574ebc3297e5842bed5acce92d::utils::transfer_or_destroy<T0>(v0, arg4);
        0x93dc806c0a848a19b5aaec200373a1eba5706c574ebc3297e5842bed5acce92d::utils::transfer_or_destroy<0xdeeb7a4662eec9f2f3def03fb937a663dddaa2e215b8078a284d026b7946c270::deep::DEEP>(v2, arg4);
        v1
    }

    public fun swap_a2b_with_deep<T0, T1>(arg0: 0x2::coin::Coin<T0>, arg1: 0x2::coin::Coin<0xdeeb7a4662eec9f2f3def03fb937a663dddaa2e215b8078a284d026b7946c270::deep::DEEP>, arg2: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T0, T1>, arg3: u64, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T1> {
        let (v0, v1, v2) = swap<T0, T1>(0x1::option::some<0x2::coin::Coin<T0>>(arg0), 0x1::option::none<0x2::coin::Coin<T1>>(), 0x1::option::some<0x2::coin::Coin<0xdeeb7a4662eec9f2f3def03fb937a663dddaa2e215b8078a284d026b7946c270::deep::DEEP>>(arg1), arg2, arg3, arg4, arg5);
        0x93dc806c0a848a19b5aaec200373a1eba5706c574ebc3297e5842bed5acce92d::utils::transfer_or_destroy<T0>(v0, arg5);
        0x93dc806c0a848a19b5aaec200373a1eba5706c574ebc3297e5842bed5acce92d::utils::transfer_or_destroy<0xdeeb7a4662eec9f2f3def03fb937a663dddaa2e215b8078a284d026b7946c270::deep::DEEP>(v2, arg5);
        v1
    }

    public fun swap_b2a<T0, T1>(arg0: 0x2::coin::Coin<T1>, arg1: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T0, T1>, arg2: u64, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        let (v0, v1, v2) = swap<T0, T1>(0x1::option::none<0x2::coin::Coin<T0>>(), 0x1::option::some<0x2::coin::Coin<T1>>(arg0), 0x1::option::none<0x2::coin::Coin<0xdeeb7a4662eec9f2f3def03fb937a663dddaa2e215b8078a284d026b7946c270::deep::DEEP>>(), arg1, arg2, arg3, arg4);
        0x93dc806c0a848a19b5aaec200373a1eba5706c574ebc3297e5842bed5acce92d::utils::transfer_or_destroy<T1>(v1, arg4);
        0x93dc806c0a848a19b5aaec200373a1eba5706c574ebc3297e5842bed5acce92d::utils::transfer_or_destroy<0xdeeb7a4662eec9f2f3def03fb937a663dddaa2e215b8078a284d026b7946c270::deep::DEEP>(v2, arg4);
        v0
    }

    public fun swap_b2a_with_deep<T0, T1>(arg0: 0x2::coin::Coin<T1>, arg1: 0x2::coin::Coin<0xdeeb7a4662eec9f2f3def03fb937a663dddaa2e215b8078a284d026b7946c270::deep::DEEP>, arg2: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T0, T1>, arg3: u64, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        let (v0, v1, v2) = swap<T0, T1>(0x1::option::none<0x2::coin::Coin<T0>>(), 0x1::option::some<0x2::coin::Coin<T1>>(arg0), 0x1::option::some<0x2::coin::Coin<0xdeeb7a4662eec9f2f3def03fb937a663dddaa2e215b8078a284d026b7946c270::deep::DEEP>>(arg1), arg2, arg3, arg4, arg5);
        0x93dc806c0a848a19b5aaec200373a1eba5706c574ebc3297e5842bed5acce92d::utils::transfer_or_destroy<T1>(v1, arg5);
        0x93dc806c0a848a19b5aaec200373a1eba5706c574ebc3297e5842bed5acce92d::utils::transfer_or_destroy<0xdeeb7a4662eec9f2f3def03fb937a663dddaa2e215b8078a284d026b7946c270::deep::DEEP>(v2, arg5);
        v0
    }

    // decompiled from Move bytecode v6
}

