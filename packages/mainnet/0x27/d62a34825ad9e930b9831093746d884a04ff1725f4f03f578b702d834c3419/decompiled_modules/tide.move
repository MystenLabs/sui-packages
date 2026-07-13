module 0x27d62a34825ad9e930b9831093746d884a04ff1725f4f03f578b702d834c3419::tide {
    public fun swap<T0, T1>(arg0: &mut 0x908d14a365b07c0576ff3d6b662df3673667da4951eaf72e9f67cba843963e84::router::SwapContext, arg1: &0xbf7915f9fb7f3ccd2df1058c53e6869bdaef64b569ba0c89cfc1fbf43a7f87df::versioned::Versioned, arg2: &0xbf7915f9fb7f3ccd2df1058c53e6869bdaef64b569ba0c89cfc1fbf43a7f87df::config::GlobalConfig, arg3: &0xbf7915f9fb7f3ccd2df1058c53e6869bdaef64b569ba0c89cfc1fbf43a7f87df::market_maker::MarketMaker, arg4: &mut 0xbf7915f9fb7f3ccd2df1058c53e6869bdaef64b569ba0c89cfc1fbf43a7f87df::orderbook::Pool<T0, T1>, arg5: vector<u8>, arg6: vector<u8>, arg7: vector<u8>, arg8: u64, arg9: bool, arg10: &0x2::clock::Clock, arg11: &mut 0x2::tx_context::TxContext) {
        if (arg9) {
            swap_a2b<T0, T1>(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg10, arg11);
        } else {
            swap_b2a<T0, T1>(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg10, arg11);
        };
    }

    fun swap_a2b<T0, T1>(arg0: &mut 0x908d14a365b07c0576ff3d6b662df3673667da4951eaf72e9f67cba843963e84::router::SwapContext, arg1: &0xbf7915f9fb7f3ccd2df1058c53e6869bdaef64b569ba0c89cfc1fbf43a7f87df::versioned::Versioned, arg2: &0xbf7915f9fb7f3ccd2df1058c53e6869bdaef64b569ba0c89cfc1fbf43a7f87df::config::GlobalConfig, arg3: &0xbf7915f9fb7f3ccd2df1058c53e6869bdaef64b569ba0c89cfc1fbf43a7f87df::market_maker::MarketMaker, arg4: &mut 0xbf7915f9fb7f3ccd2df1058c53e6869bdaef64b569ba0c89cfc1fbf43a7f87df::orderbook::Pool<T0, T1>, arg5: vector<u8>, arg6: vector<u8>, arg7: vector<u8>, arg8: u64, arg9: &0x2::clock::Clock, arg10: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x908d14a365b07c0576ff3d6b662df3673667da4951eaf72e9f67cba843963e84::router::take_balance<T0>(arg0, arg8);
        let v1 = 0x2::balance::value<T0>(&v0);
        if (v1 == 0) {
            0x2::balance::destroy_zero<T0>(v0);
            return
        };
        0xbf7915f9fb7f3ccd2df1058c53e6869bdaef64b569ba0c89cfc1fbf43a7f87df::orderbook::update_quote_envelope<T0, T1>(arg1, arg2, arg3, arg4, arg5, arg6, arg9, arg10);
        let v2 = 0x1::vector::empty<0xbf7915f9fb7f3ccd2df1058c53e6869bdaef64b569ba0c89cfc1fbf43a7f87df::orderbook::QuoteFill>();
        0x1::vector::push_back<0xbf7915f9fb7f3ccd2df1058c53e6869bdaef64b569ba0c89cfc1fbf43a7f87df::orderbook::QuoteFill>(&mut v2, 0xbf7915f9fb7f3ccd2df1058c53e6869bdaef64b569ba0c89cfc1fbf43a7f87df::orderbook::new_quote_fill(arg7, v1));
        let (v3, v4) = 0xbf7915f9fb7f3ccd2df1058c53e6869bdaef64b569ba0c89cfc1fbf43a7f87df::orderbook::swap_exact_base_for_quote<T0, T1>(arg1, arg2, arg3, arg4, v2, v0, arg7, arg9, arg10);
        let v5 = v4;
        let v6 = v3;
        0x908d14a365b07c0576ff3d6b662df3673667da4951eaf72e9f67cba843963e84::router::merge_balance<T0>(arg0, v5);
        0x908d14a365b07c0576ff3d6b662df3673667da4951eaf72e9f67cba843963e84::router::merge_balance<T1>(arg0, v6);
        0x908d14a365b07c0576ff3d6b662df3673667da4951eaf72e9f67cba843963e84::router::emit_swap_event<T0, T1>(arg0, b"CETUSTIDE", 0x2::object::id<0xbf7915f9fb7f3ccd2df1058c53e6869bdaef64b569ba0c89cfc1fbf43a7f87df::orderbook::Pool<T0, T1>>(arg4), v1 - 0x2::balance::value<T0>(&v5), 0x2::balance::value<T1>(&v6), 0);
    }

    fun swap_b2a<T0, T1>(arg0: &mut 0x908d14a365b07c0576ff3d6b662df3673667da4951eaf72e9f67cba843963e84::router::SwapContext, arg1: &0xbf7915f9fb7f3ccd2df1058c53e6869bdaef64b569ba0c89cfc1fbf43a7f87df::versioned::Versioned, arg2: &0xbf7915f9fb7f3ccd2df1058c53e6869bdaef64b569ba0c89cfc1fbf43a7f87df::config::GlobalConfig, arg3: &0xbf7915f9fb7f3ccd2df1058c53e6869bdaef64b569ba0c89cfc1fbf43a7f87df::market_maker::MarketMaker, arg4: &mut 0xbf7915f9fb7f3ccd2df1058c53e6869bdaef64b569ba0c89cfc1fbf43a7f87df::orderbook::Pool<T0, T1>, arg5: vector<u8>, arg6: vector<u8>, arg7: vector<u8>, arg8: u64, arg9: &0x2::clock::Clock, arg10: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x908d14a365b07c0576ff3d6b662df3673667da4951eaf72e9f67cba843963e84::router::take_balance<T1>(arg0, arg8);
        let v1 = 0x2::balance::value<T1>(&v0);
        if (v1 == 0) {
            0x2::balance::destroy_zero<T1>(v0);
            return
        };
        0xbf7915f9fb7f3ccd2df1058c53e6869bdaef64b569ba0c89cfc1fbf43a7f87df::orderbook::update_quote_envelope<T0, T1>(arg1, arg2, arg3, arg4, arg5, arg6, arg9, arg10);
        let v2 = 0x1::vector::empty<0xbf7915f9fb7f3ccd2df1058c53e6869bdaef64b569ba0c89cfc1fbf43a7f87df::orderbook::QuoteFill>();
        0x1::vector::push_back<0xbf7915f9fb7f3ccd2df1058c53e6869bdaef64b569ba0c89cfc1fbf43a7f87df::orderbook::QuoteFill>(&mut v2, 0xbf7915f9fb7f3ccd2df1058c53e6869bdaef64b569ba0c89cfc1fbf43a7f87df::orderbook::new_quote_fill(arg7, v1));
        let (v3, v4) = 0xbf7915f9fb7f3ccd2df1058c53e6869bdaef64b569ba0c89cfc1fbf43a7f87df::orderbook::swap_exact_quote_for_base<T0, T1>(arg1, arg2, arg3, arg4, v2, v0, arg7, arg9, arg10);
        let v5 = v4;
        let v6 = v3;
        0x908d14a365b07c0576ff3d6b662df3673667da4951eaf72e9f67cba843963e84::router::merge_balance<T1>(arg0, v5);
        0x908d14a365b07c0576ff3d6b662df3673667da4951eaf72e9f67cba843963e84::router::merge_balance<T0>(arg0, v6);
        0x908d14a365b07c0576ff3d6b662df3673667da4951eaf72e9f67cba843963e84::router::emit_swap_event<T1, T0>(arg0, b"CETUSTIDE", 0x2::object::id<0xbf7915f9fb7f3ccd2df1058c53e6869bdaef64b569ba0c89cfc1fbf43a7f87df::orderbook::Pool<T0, T1>>(arg4), v1 - 0x2::balance::value<T1>(&v5), 0x2::balance::value<T0>(&v6), 0);
    }

    // decompiled from Move bytecode v7
}

