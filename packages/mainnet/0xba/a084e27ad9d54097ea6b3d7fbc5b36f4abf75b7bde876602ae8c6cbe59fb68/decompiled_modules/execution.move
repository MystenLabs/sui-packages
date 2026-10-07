module 0xbaa084e27ad9d54097ea6b3d7fbc5b36f4abf75b7bde876602ae8c6cbe59fb68::execution {
    public fun maybe_a2b<T0, T1>(arg0: &mut 0xbf7915f9fb7f3ccd2df1058c53e6869bdaef64b569ba0c89cfc1fbf43a7f87df::orderbook::Pool<T0, T1>, arg1: &0xbf7915f9fb7f3ccd2df1058c53e6869bdaef64b569ba0c89cfc1fbf43a7f87df::market_maker::MarketMaker, arg2: &0xbf7915f9fb7f3ccd2df1058c53e6869bdaef64b569ba0c89cfc1fbf43a7f87df::config::GlobalConfig, arg3: &0xbf7915f9fb7f3ccd2df1058c53e6869bdaef64b569ba0c89cfc1fbf43a7f87df::versioned::Versioned, arg4: &0x2::clock::Clock, arg5: 0x1::option::Option<0x2::coin::Coin<T0>>, arg6: &0xbaa084e27ad9d54097ea6b3d7fbc5b36f4abf75b7bde876602ae8c6cbe59fb68::reader::Prepared, arg7: &mut 0x2::tx_context::TxContext) : 0x1::option::Option<0x2::coin::Coin<T1>> {
        if (0x1::option::is_none<0x2::coin::Coin<T0>>(&arg5)) {
            0x1::option::destroy_none<0x2::coin::Coin<T0>>(arg5);
            return 0x1::option::none<0x2::coin::Coin<T1>>()
        };
        0xbaa084e27ad9d54097ea6b3d7fbc5b36f4abf75b7bde876602ae8c6cbe59fb68::reader::assert_binding<T0, T1>(arg6, arg0, arg4, true);
        let v0 = 0x2::coin::into_balance<T0>(0x1::option::destroy_some<0x2::coin::Coin<T0>>(arg5));
        let v1 = 0x1::vector::empty<0xbf7915f9fb7f3ccd2df1058c53e6869bdaef64b569ba0c89cfc1fbf43a7f87df::orderbook::QuoteFill>();
        0x1::vector::push_back<0xbf7915f9fb7f3ccd2df1058c53e6869bdaef64b569ba0c89cfc1fbf43a7f87df::orderbook::QuoteFill>(&mut v1, 0xbf7915f9fb7f3ccd2df1058c53e6869bdaef64b569ba0c89cfc1fbf43a7f87df::orderbook::new_quote_fill(0xbaa084e27ad9d54097ea6b3d7fbc5b36f4abf75b7bde876602ae8c6cbe59fb68::reader::hash(arg6), 0x2::balance::value<T0>(&v0)));
        let (v2, v3) = 0xbf7915f9fb7f3ccd2df1058c53e6869bdaef64b569ba0c89cfc1fbf43a7f87df::orderbook::swap_exact_base_for_quote<T0, T1>(arg3, arg2, arg1, arg0, v1, v0, b"", arg4, arg7);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(v3, arg7), 0x2::tx_context::sender(arg7));
        0x1::option::some<0x2::coin::Coin<T1>>(0x2::coin::from_balance<T1>(v2, arg7))
    }

    public fun maybe_b2a<T0, T1>(arg0: &mut 0xbf7915f9fb7f3ccd2df1058c53e6869bdaef64b569ba0c89cfc1fbf43a7f87df::orderbook::Pool<T0, T1>, arg1: &0xbf7915f9fb7f3ccd2df1058c53e6869bdaef64b569ba0c89cfc1fbf43a7f87df::market_maker::MarketMaker, arg2: &0xbf7915f9fb7f3ccd2df1058c53e6869bdaef64b569ba0c89cfc1fbf43a7f87df::config::GlobalConfig, arg3: &0xbf7915f9fb7f3ccd2df1058c53e6869bdaef64b569ba0c89cfc1fbf43a7f87df::versioned::Versioned, arg4: &0x2::clock::Clock, arg5: 0x1::option::Option<0x2::coin::Coin<T1>>, arg6: &0xbaa084e27ad9d54097ea6b3d7fbc5b36f4abf75b7bde876602ae8c6cbe59fb68::reader::Prepared, arg7: &mut 0x2::tx_context::TxContext) : 0x1::option::Option<0x2::coin::Coin<T0>> {
        if (0x1::option::is_none<0x2::coin::Coin<T1>>(&arg5)) {
            0x1::option::destroy_none<0x2::coin::Coin<T1>>(arg5);
            return 0x1::option::none<0x2::coin::Coin<T0>>()
        };
        0xbaa084e27ad9d54097ea6b3d7fbc5b36f4abf75b7bde876602ae8c6cbe59fb68::reader::assert_binding<T0, T1>(arg6, arg0, arg4, false);
        let v0 = 0x2::coin::into_balance<T1>(0x1::option::destroy_some<0x2::coin::Coin<T1>>(arg5));
        let v1 = 0x1::vector::empty<0xbf7915f9fb7f3ccd2df1058c53e6869bdaef64b569ba0c89cfc1fbf43a7f87df::orderbook::QuoteFill>();
        0x1::vector::push_back<0xbf7915f9fb7f3ccd2df1058c53e6869bdaef64b569ba0c89cfc1fbf43a7f87df::orderbook::QuoteFill>(&mut v1, 0xbf7915f9fb7f3ccd2df1058c53e6869bdaef64b569ba0c89cfc1fbf43a7f87df::orderbook::new_quote_fill(0xbaa084e27ad9d54097ea6b3d7fbc5b36f4abf75b7bde876602ae8c6cbe59fb68::reader::hash(arg6), 0x2::balance::value<T1>(&v0)));
        let (v2, v3) = 0xbf7915f9fb7f3ccd2df1058c53e6869bdaef64b569ba0c89cfc1fbf43a7f87df::orderbook::swap_exact_quote_for_base<T0, T1>(arg3, arg2, arg1, arg0, v1, v0, b"", arg4, arg7);
        0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(0x2::coin::from_balance<T1>(v3, arg7), 0x2::tx_context::sender(arg7));
        0x1::option::some<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(v2, arg7))
    }

    // decompiled from Move bytecode v7
}

