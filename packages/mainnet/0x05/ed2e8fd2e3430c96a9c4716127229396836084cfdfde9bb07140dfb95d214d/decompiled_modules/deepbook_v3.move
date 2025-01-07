module 0x5ed2e8fd2e3430c96a9c4716127229396836084cfdfde9bb07140dfb95d214d::deepbook_v3 {
    struct Swap has copy, drop {
        base_asset: 0x1::ascii::String,
        quote_asset: 0x1::ascii::String,
        quantity: u64,
        base_to_quote: bool,
        ret_base_amount: u64,
        ret_quote_amount: u64,
    }

    public fun swap_a2b<T0, T1>(arg0: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T0, T1>, arg1: 0x2::coin::Coin<T0>, arg2: &mut 0x2::coin::Coin<0xdeeb7a4662eec9f2f3def03fb937a663dddaa2e215b8078a284d026b7946c270::deep::DEEP>, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T1> {
        let (v0, v1, v2) = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::swap_exact_quantity<T0, T1>(arg0, arg1, 0x2::coin::zero<T1>(arg4), 0x2::coin::zero<0xdeeb7a4662eec9f2f3def03fb937a663dddaa2e215b8078a284d026b7946c270::deep::DEEP>(arg4), 0, arg3, arg4);
        let v3 = v1;
        let v4 = v0;
        let v5 = Swap{
            base_asset       : 0x1::type_name::into_string(0x1::type_name::get<T0>()),
            quote_asset      : 0x1::type_name::into_string(0x1::type_name::get<T1>()),
            quantity         : 0x2::coin::value<T0>(&arg1),
            base_to_quote    : true,
            ret_base_amount  : 0x2::coin::value<T0>(&v4),
            ret_quote_amount : 0x2::coin::value<T1>(&v3),
        };
        0x2::event::emit<Swap>(v5);
        if (0x2::coin::value<T0>(&v4) == 0) {
            0x2::coin::destroy_zero<T0>(v4);
        } else {
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(v4, 0x2::tx_context::sender(arg4));
        };
        0x2::coin::join<0xdeeb7a4662eec9f2f3def03fb937a663dddaa2e215b8078a284d026b7946c270::deep::DEEP>(arg2, v2);
        v3
    }

    public fun swap_b2a<T0, T1>(arg0: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T0, T1>, arg1: 0x2::coin::Coin<T1>, arg2: &mut 0x2::coin::Coin<0xdeeb7a4662eec9f2f3def03fb937a663dddaa2e215b8078a284d026b7946c270::deep::DEEP>, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        let (v0, v1, v2) = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::swap_exact_quantity<T0, T1>(arg0, 0x2::coin::zero<T0>(arg4), arg1, 0x2::coin::zero<0xdeeb7a4662eec9f2f3def03fb937a663dddaa2e215b8078a284d026b7946c270::deep::DEEP>(arg4), 0, arg3, arg4);
        let v3 = v1;
        let v4 = v0;
        let v5 = Swap{
            base_asset       : 0x1::type_name::into_string(0x1::type_name::get<T0>()),
            quote_asset      : 0x1::type_name::into_string(0x1::type_name::get<T1>()),
            quantity         : 0x2::coin::value<T1>(&arg1),
            base_to_quote    : false,
            ret_base_amount  : 0x2::coin::value<T0>(&v4),
            ret_quote_amount : 0x2::coin::value<T1>(&v3),
        };
        0x2::event::emit<Swap>(v5);
        if (0x2::coin::value<T1>(&v3) == 0) {
            0x2::coin::destroy_zero<T1>(v3);
        } else {
            0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(v3, 0x2::tx_context::sender(arg4));
        };
        0x2::coin::join<0xdeeb7a4662eec9f2f3def03fb937a663dddaa2e215b8078a284d026b7946c270::deep::DEEP>(arg2, v2);
        v4
    }

    // decompiled from Move bytecode v6
}

