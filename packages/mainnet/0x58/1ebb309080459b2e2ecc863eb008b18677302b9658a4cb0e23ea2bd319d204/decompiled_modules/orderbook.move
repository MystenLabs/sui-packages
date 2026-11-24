module 0x581ebb309080459b2e2ecc863eb008b18677302b9658a4cb0e23ea2bd319d204::orderbook {
    public fun swap<T0, T1>(arg0: &mut 0x4a9914d41430f9a8efbdb07c2d7872777fe1ba9d6c7cb0fb6b345fcfe5af5470::router::SwapContext, arg1: &0xbf7915f9fb7f3ccd2df1058c53e6869bdaef64b569ba0c89cfc1fbf43a7f87df::versioned::Versioned, arg2: &0xbf7915f9fb7f3ccd2df1058c53e6869bdaef64b569ba0c89cfc1fbf43a7f87df::config::GlobalConfig, arg3: &0xbf7915f9fb7f3ccd2df1058c53e6869bdaef64b569ba0c89cfc1fbf43a7f87df::market_maker::MarketMaker, arg4: &mut 0xbf7915f9fb7f3ccd2df1058c53e6869bdaef64b569ba0c89cfc1fbf43a7f87df::orderbook::Pool<T0, T1>, arg5: vector<u8>, arg6: vector<u8>, arg7: vector<u8>, arg8: u64, arg9: bool, arg10: vector<u8>, arg11: &0x2::clock::Clock, arg12: &mut 0x2::tx_context::TxContext) {
        if (arg9) {
            swap_a2b<T0, T1>(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg10, arg11, arg12);
        } else {
            swap_b2a<T0, T1>(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg10, arg11, arg12);
        };
    }

    public fun swap_a2b<T0, T1>(arg0: &mut 0x4a9914d41430f9a8efbdb07c2d7872777fe1ba9d6c7cb0fb6b345fcfe5af5470::router::SwapContext, arg1: &0xbf7915f9fb7f3ccd2df1058c53e6869bdaef64b569ba0c89cfc1fbf43a7f87df::versioned::Versioned, arg2: &0xbf7915f9fb7f3ccd2df1058c53e6869bdaef64b569ba0c89cfc1fbf43a7f87df::config::GlobalConfig, arg3: &0xbf7915f9fb7f3ccd2df1058c53e6869bdaef64b569ba0c89cfc1fbf43a7f87df::market_maker::MarketMaker, arg4: &mut 0xbf7915f9fb7f3ccd2df1058c53e6869bdaef64b569ba0c89cfc1fbf43a7f87df::orderbook::Pool<T0, T1>, arg5: vector<u8>, arg6: vector<u8>, arg7: vector<u8>, arg8: u64, arg9: vector<u8>, arg10: &0x2::clock::Clock, arg11: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x4a9914d41430f9a8efbdb07c2d7872777fe1ba9d6c7cb0fb6b345fcfe5af5470::router::take_balance<T0>(arg0, arg8);
        let v1 = 0x2::balance::value<T0>(&v0);
        if (v1 == 0) {
            0x2::balance::destroy_zero<T0>(v0);
            return
        };
        0xbf7915f9fb7f3ccd2df1058c53e6869bdaef64b569ba0c89cfc1fbf43a7f87df::orderbook::update_quote_envelope<T0, T1>(arg1, arg2, arg3, arg4, arg5, arg6, arg10, arg11);
        let v2 = 0x1::vector::empty<0xbf7915f9fb7f3ccd2df1058c53e6869bdaef64b569ba0c89cfc1fbf43a7f87df::orderbook::QuoteFill>();
        0x1::vector::push_back<0xbf7915f9fb7f3ccd2df1058c53e6869bdaef64b569ba0c89cfc1fbf43a7f87df::orderbook::QuoteFill>(&mut v2, 0xbf7915f9fb7f3ccd2df1058c53e6869bdaef64b569ba0c89cfc1fbf43a7f87df::orderbook::new_quote_fill(arg9, v1));
        let (v3, v4) = 0xbf7915f9fb7f3ccd2df1058c53e6869bdaef64b569ba0c89cfc1fbf43a7f87df::orderbook::swap_exact_base_for_quote<T0, T1>(arg1, arg2, arg3, arg4, v2, v0, arg7, arg10, arg11);
        let v5 = v4;
        let v6 = v3;
        let v7 = 0x2::balance::value<T0>(&v5);
        0x4a9914d41430f9a8efbdb07c2d7872777fe1ba9d6c7cb0fb6b345fcfe5af5470::router::merge_balance<T0>(arg0, v5);
        0x4a9914d41430f9a8efbdb07c2d7872777fe1ba9d6c7cb0fb6b345fcfe5af5470::router::merge_balance<T1>(arg0, v6);
        0x4a9914d41430f9a8efbdb07c2d7872777fe1ba9d6c7cb0fb6b345fcfe5af5470::router::emit_swap_event<T0, T1>(arg0, b"PQF_ORDERBOOK", 0x2::object::id<0xbf7915f9fb7f3ccd2df1058c53e6869bdaef64b569ba0c89cfc1fbf43a7f87df::orderbook::Pool<T0, T1>>(arg4), v1 - v7, 0x2::balance::value<T1>(&v6), v7);
    }

    public fun swap_b2a<T0, T1>(arg0: &mut 0x4a9914d41430f9a8efbdb07c2d7872777fe1ba9d6c7cb0fb6b345fcfe5af5470::router::SwapContext, arg1: &0xbf7915f9fb7f3ccd2df1058c53e6869bdaef64b569ba0c89cfc1fbf43a7f87df::versioned::Versioned, arg2: &0xbf7915f9fb7f3ccd2df1058c53e6869bdaef64b569ba0c89cfc1fbf43a7f87df::config::GlobalConfig, arg3: &0xbf7915f9fb7f3ccd2df1058c53e6869bdaef64b569ba0c89cfc1fbf43a7f87df::market_maker::MarketMaker, arg4: &mut 0xbf7915f9fb7f3ccd2df1058c53e6869bdaef64b569ba0c89cfc1fbf43a7f87df::orderbook::Pool<T0, T1>, arg5: vector<u8>, arg6: vector<u8>, arg7: vector<u8>, arg8: u64, arg9: vector<u8>, arg10: &0x2::clock::Clock, arg11: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x4a9914d41430f9a8efbdb07c2d7872777fe1ba9d6c7cb0fb6b345fcfe5af5470::router::take_balance<T1>(arg0, arg8);
        let v1 = 0x2::balance::value<T1>(&v0);
        if (v1 == 0) {
            0x2::balance::destroy_zero<T1>(v0);
            return
        };
        0xbf7915f9fb7f3ccd2df1058c53e6869bdaef64b569ba0c89cfc1fbf43a7f87df::orderbook::update_quote_envelope<T0, T1>(arg1, arg2, arg3, arg4, arg5, arg6, arg10, arg11);
        let v2 = 0x1::vector::empty<0xbf7915f9fb7f3ccd2df1058c53e6869bdaef64b569ba0c89cfc1fbf43a7f87df::orderbook::QuoteFill>();
        0x1::vector::push_back<0xbf7915f9fb7f3ccd2df1058c53e6869bdaef64b569ba0c89cfc1fbf43a7f87df::orderbook::QuoteFill>(&mut v2, 0xbf7915f9fb7f3ccd2df1058c53e6869bdaef64b569ba0c89cfc1fbf43a7f87df::orderbook::new_quote_fill(arg9, v1));
        let (v3, v4) = 0xbf7915f9fb7f3ccd2df1058c53e6869bdaef64b569ba0c89cfc1fbf43a7f87df::orderbook::swap_exact_quote_for_base<T0, T1>(arg1, arg2, arg3, arg4, v2, v0, arg7, arg10, arg11);
        let v5 = v4;
        let v6 = v3;
        let v7 = 0x2::balance::value<T1>(&v5);
        0x4a9914d41430f9a8efbdb07c2d7872777fe1ba9d6c7cb0fb6b345fcfe5af5470::router::merge_balance<T1>(arg0, v5);
        0x4a9914d41430f9a8efbdb07c2d7872777fe1ba9d6c7cb0fb6b345fcfe5af5470::router::merge_balance<T0>(arg0, v6);
        0x4a9914d41430f9a8efbdb07c2d7872777fe1ba9d6c7cb0fb6b345fcfe5af5470::router::emit_swap_event<T1, T0>(arg0, b"PQF_ORDERBOOK", 0x2::object::id<0xbf7915f9fb7f3ccd2df1058c53e6869bdaef64b569ba0c89cfc1fbf43a7f87df::orderbook::Pool<T0, T1>>(arg4), v1 - v7, 0x2::balance::value<T0>(&v6), v7);
    }

    // decompiled from Move bytecode v7
}

