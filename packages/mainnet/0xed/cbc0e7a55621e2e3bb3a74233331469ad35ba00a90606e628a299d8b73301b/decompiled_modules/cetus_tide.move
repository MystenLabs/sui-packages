module 0xedcbc0e7a55621e2e3bb3a74233331469ad35ba00a90606e628a299d8b73301b::cetus_tide {
    public fun swap_a2b<T0, T1, T2>(arg0: &mut 0x50073087118545d6414016ed2652566b783cfb5c35dcae7751165d087a74324::session::Session<T0>, arg1: &mut 0xbf7915f9fb7f3ccd2df1058c53e6869bdaef64b569ba0c89cfc1fbf43a7f87df::orderbook::Pool<T1, T2>, arg2: &0x2::clock::Clock, arg3: &0xbf7915f9fb7f3ccd2df1058c53e6869bdaef64b569ba0c89cfc1fbf43a7f87df::versioned::Versioned, arg4: &0xbf7915f9fb7f3ccd2df1058c53e6869bdaef64b569ba0c89cfc1fbf43a7f87df::config::GlobalConfig, arg5: &0xbf7915f9fb7f3ccd2df1058c53e6869bdaef64b569ba0c89cfc1fbf43a7f87df::market_maker::MarketMaker, arg6: 0x2::balance::Balance<T1>, arg7: vector<u8>, arg8: vector<u8>, arg9: vector<u8>, arg10: &mut 0x2::tx_context::TxContext) : (0x2::balance::Balance<T2>, 0x2::balance::Balance<T1>) {
        if (!0x1::vector::is_empty<u8>(&arg7)) {
            0xbf7915f9fb7f3ccd2df1058c53e6869bdaef64b569ba0c89cfc1fbf43a7f87df::orderbook::update_quote_envelope<T1, T2>(arg3, arg4, arg5, arg1, arg7, arg8, arg2, arg10);
        };
        let v0 = 0x1::vector::empty<0xbf7915f9fb7f3ccd2df1058c53e6869bdaef64b569ba0c89cfc1fbf43a7f87df::orderbook::QuoteFill>();
        0x1::vector::push_back<0xbf7915f9fb7f3ccd2df1058c53e6869bdaef64b569ba0c89cfc1fbf43a7f87df::orderbook::QuoteFill>(&mut v0, 0xbf7915f9fb7f3ccd2df1058c53e6869bdaef64b569ba0c89cfc1fbf43a7f87df::orderbook::new_quote_fill(b"", 0x2::balance::value<T1>(&arg6)));
        let (v1, v2) = 0xbf7915f9fb7f3ccd2df1058c53e6869bdaef64b569ba0c89cfc1fbf43a7f87df::orderbook::swap_exact_base_for_quote<T1, T2>(arg3, arg4, arg5, arg1, v0, arg6, arg9, arg2, arg10);
        let v3 = v2;
        let v4 = v1;
        assert!(0x2::balance::value<T1>(&v3) == 0, 0);
        0x50073087118545d6414016ed2652566b783cfb5c35dcae7751165d087a74324::session::record_leg<T0>(arg0, 0x2::object::id<0xbf7915f9fb7f3ccd2df1058c53e6869bdaef64b569ba0c89cfc1fbf43a7f87df::orderbook::Pool<T1, T2>>(arg1), true, 0x2::balance::value<T2>(&v4));
        (v4, v3)
    }

    public fun swap_b2a<T0, T1, T2>(arg0: &mut 0x50073087118545d6414016ed2652566b783cfb5c35dcae7751165d087a74324::session::Session<T0>, arg1: &mut 0xbf7915f9fb7f3ccd2df1058c53e6869bdaef64b569ba0c89cfc1fbf43a7f87df::orderbook::Pool<T1, T2>, arg2: &0x2::clock::Clock, arg3: &0xbf7915f9fb7f3ccd2df1058c53e6869bdaef64b569ba0c89cfc1fbf43a7f87df::versioned::Versioned, arg4: &0xbf7915f9fb7f3ccd2df1058c53e6869bdaef64b569ba0c89cfc1fbf43a7f87df::config::GlobalConfig, arg5: &0xbf7915f9fb7f3ccd2df1058c53e6869bdaef64b569ba0c89cfc1fbf43a7f87df::market_maker::MarketMaker, arg6: 0x2::balance::Balance<T2>, arg7: vector<u8>, arg8: vector<u8>, arg9: vector<u8>, arg10: &mut 0x2::tx_context::TxContext) : (0x2::balance::Balance<T1>, 0x2::balance::Balance<T2>) {
        if (!0x1::vector::is_empty<u8>(&arg7)) {
            0xbf7915f9fb7f3ccd2df1058c53e6869bdaef64b569ba0c89cfc1fbf43a7f87df::orderbook::update_quote_envelope<T1, T2>(arg3, arg4, arg5, arg1, arg7, arg8, arg2, arg10);
        };
        let v0 = 0x1::vector::empty<0xbf7915f9fb7f3ccd2df1058c53e6869bdaef64b569ba0c89cfc1fbf43a7f87df::orderbook::QuoteFill>();
        0x1::vector::push_back<0xbf7915f9fb7f3ccd2df1058c53e6869bdaef64b569ba0c89cfc1fbf43a7f87df::orderbook::QuoteFill>(&mut v0, 0xbf7915f9fb7f3ccd2df1058c53e6869bdaef64b569ba0c89cfc1fbf43a7f87df::orderbook::new_quote_fill(b"", 0x2::balance::value<T2>(&arg6)));
        let (v1, v2) = 0xbf7915f9fb7f3ccd2df1058c53e6869bdaef64b569ba0c89cfc1fbf43a7f87df::orderbook::swap_exact_quote_for_base<T1, T2>(arg3, arg4, arg5, arg1, v0, arg6, arg9, arg2, arg10);
        let v3 = v2;
        let v4 = v1;
        assert!(0x2::balance::value<T2>(&v3) == 0, 0);
        0x50073087118545d6414016ed2652566b783cfb5c35dcae7751165d087a74324::session::record_leg<T0>(arg0, 0x2::object::id<0xbf7915f9fb7f3ccd2df1058c53e6869bdaef64b569ba0c89cfc1fbf43a7f87df::orderbook::Pool<T1, T2>>(arg1), false, 0x2::balance::value<T1>(&v4));
        (v4, v3)
    }

    // decompiled from Move bytecode v7
}

