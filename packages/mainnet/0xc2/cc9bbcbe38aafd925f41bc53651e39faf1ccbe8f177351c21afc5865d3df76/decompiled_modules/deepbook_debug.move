module 0xc2cc9bbcbe38aafd925f41bc53651e39faf1ccbe8f177351c21afc5865d3df76::deepbook_debug {
    struct Swap has copy, drop {
        base_asset: 0x1::ascii::String,
        quote_asset: 0x1::ascii::String,
        quantity: u64,
        base_to_quote: bool,
        ret_base_amount: u64,
        ret_quote_amount: u64,
    }

    public fun swap_a2b<T0, T1>(arg0: &mut 0xdee9::clob_v2::Pool<T0, T1>, arg1: u64, arg2: 0x2::coin::Coin<T0>, arg3: 0x2::coin::Coin<T1>, arg4: &0xdee9::custodian_v2::AccountCap, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T1> {
        let v0 = 0x2::coin::value<T0>(&arg2) / arg1 * arg1;
        let v1 = 0x2::coin::split<T0>(&mut arg2, v0, arg6);
        let v2 = Swap{
            base_asset       : 0x1::type_name::into_string(0x1::type_name::get<T0>()),
            quote_asset      : 0x1::type_name::into_string(0x1::type_name::get<T1>()),
            quantity         : v0,
            base_to_quote    : true,
            ret_base_amount  : 0,
            ret_quote_amount : 0,
        };
        0x2::event::emit<Swap>(v2);
        if (0x2::coin::value<T0>(&arg2) == 0) {
            0x2::coin::destroy_zero<T0>(arg2);
        } else {
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(arg2, 0x2::tx_context::sender(arg6));
        };
        if (0x2::coin::value<T0>(&v1) == 0) {
            0x2::coin::destroy_zero<T0>(v1);
        } else {
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(v1, 0x2::tx_context::sender(arg6));
        };
        arg3
    }

    public fun swap_b2a<T0, T1>(arg0: &mut 0xdee9::clob_v2::Pool<T0, T1>, arg1: 0x2::coin::Coin<T1>, arg2: &0xdee9::custodian_v2::AccountCap, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        let v0 = 0x2::coin::value<T1>(&arg1);
        let (v1, v2, _) = 0xdee9::clob_v2::swap_exact_quote_for_base<T0, T1>(arg0, 0, arg2, v0, arg3, arg1, arg4);
        let v4 = v2;
        let v5 = v1;
        let v6 = Swap{
            base_asset       : 0x1::type_name::into_string(0x1::type_name::get<T0>()),
            quote_asset      : 0x1::type_name::into_string(0x1::type_name::get<T1>()),
            quantity         : v0,
            base_to_quote    : false,
            ret_base_amount  : 0x2::coin::value<T0>(&v5),
            ret_quote_amount : 0x2::coin::value<T1>(&v4),
        };
        0x2::event::emit<Swap>(v6);
        if (0x2::coin::value<T1>(&v4) == 0) {
            0x2::coin::destroy_zero<T1>(v4);
        } else {
            0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(v4, 0x2::tx_context::sender(arg4));
        };
        v5
    }

    // decompiled from Move bytecode v6
}

