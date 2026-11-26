module 0x14a930f92b8f8e21838a5218e28c660094b8dff98dcd8647ee94ed696f6c4da3::cetus_tide_v2 {
    public fun swap_a2b<T0, T1>(arg0: &0xbf7915f9fb7f3ccd2df1058c53e6869bdaef64b569ba0c89cfc1fbf43a7f87df::versioned::Versioned, arg1: &0xbf7915f9fb7f3ccd2df1058c53e6869bdaef64b569ba0c89cfc1fbf43a7f87df::config::GlobalConfig, arg2: &0xbf7915f9fb7f3ccd2df1058c53e6869bdaef64b569ba0c89cfc1fbf43a7f87df::market_maker::MarketMaker, arg3: &mut 0xbf7915f9fb7f3ccd2df1058c53e6869bdaef64b569ba0c89cfc1fbf43a7f87df::orderbook_v2::Pool<T0, T1>, arg4: 0x2::balance::Balance<T0>, arg5: vector<u8>, arg6: vector<vector<u8>>, arg7: address, arg8: &0x2::clock::Clock, arg9: &mut 0x2::tx_context::TxContext) : 0x2::balance::Balance<T1> {
        if (0x2::balance::value<T0>(&arg4) == 0) {
            0x2::balance::destroy_zero<T0>(arg4);
            0x2::balance::zero<T1>()
        } else {
            0xbf7915f9fb7f3ccd2df1058c53e6869bdaef64b569ba0c89cfc1fbf43a7f87df::orderbook_v2::update_quote_envelope_v2<T0, T1>(arg0, arg1, arg2, arg3, arg5, arg6, arg8, arg9);
            let (v1, v2) = 0xbf7915f9fb7f3ccd2df1058c53e6869bdaef64b569ba0c89cfc1fbf43a7f87df::orderbook_v2::swap_exact_base_for_quote<T0, T1>(arg0, arg1, arg2, arg3, 0xbf7915f9fb7f3ccd2df1058c53e6869bdaef64b569ba0c89cfc1fbf43a7f87df::orderbook_v2::new_quote_fill(*0xbf7915f9fb7f3ccd2df1058c53e6869bdaef64b569ba0c89cfc1fbf43a7f87df::orderbook_v2::quote_hash(0x1::option::borrow<0xbf7915f9fb7f3ccd2df1058c53e6869bdaef64b569ba0c89cfc1fbf43a7f87df::orderbook_v2::QuoteEntryV2>(0xbf7915f9fb7f3ccd2df1058c53e6869bdaef64b569ba0c89cfc1fbf43a7f87df::orderbook_v2::pool_bid<T0, T1>(arg3))), 0x2::balance::value<T0>(&arg4)), arg4, arg8, arg9);
            0x806e8570f5a254d46eccdbc721ae4977aa7b3d8ff53dda1457944d6944a02953::settlement::settle<T0>(v2, arg7);
            v1
        }
    }

    public fun swap_b2a<T0, T1>(arg0: &0xbf7915f9fb7f3ccd2df1058c53e6869bdaef64b569ba0c89cfc1fbf43a7f87df::versioned::Versioned, arg1: &0xbf7915f9fb7f3ccd2df1058c53e6869bdaef64b569ba0c89cfc1fbf43a7f87df::config::GlobalConfig, arg2: &0xbf7915f9fb7f3ccd2df1058c53e6869bdaef64b569ba0c89cfc1fbf43a7f87df::market_maker::MarketMaker, arg3: &mut 0xbf7915f9fb7f3ccd2df1058c53e6869bdaef64b569ba0c89cfc1fbf43a7f87df::orderbook_v2::Pool<T0, T1>, arg4: 0x2::balance::Balance<T1>, arg5: vector<u8>, arg6: vector<vector<u8>>, arg7: address, arg8: &0x2::clock::Clock, arg9: &mut 0x2::tx_context::TxContext) : 0x2::balance::Balance<T0> {
        if (0x2::balance::value<T1>(&arg4) == 0) {
            0x2::balance::destroy_zero<T1>(arg4);
            0x2::balance::zero<T0>()
        } else {
            0xbf7915f9fb7f3ccd2df1058c53e6869bdaef64b569ba0c89cfc1fbf43a7f87df::orderbook_v2::update_quote_envelope_v2<T0, T1>(arg0, arg1, arg2, arg3, arg5, arg6, arg8, arg9);
            let (v1, v2) = 0xbf7915f9fb7f3ccd2df1058c53e6869bdaef64b569ba0c89cfc1fbf43a7f87df::orderbook_v2::swap_exact_quote_for_base<T0, T1>(arg0, arg1, arg2, arg3, 0xbf7915f9fb7f3ccd2df1058c53e6869bdaef64b569ba0c89cfc1fbf43a7f87df::orderbook_v2::new_quote_fill(*0xbf7915f9fb7f3ccd2df1058c53e6869bdaef64b569ba0c89cfc1fbf43a7f87df::orderbook_v2::quote_hash(0x1::option::borrow<0xbf7915f9fb7f3ccd2df1058c53e6869bdaef64b569ba0c89cfc1fbf43a7f87df::orderbook_v2::QuoteEntryV2>(0xbf7915f9fb7f3ccd2df1058c53e6869bdaef64b569ba0c89cfc1fbf43a7f87df::orderbook_v2::pool_ask<T0, T1>(arg3))), 0x2::balance::value<T1>(&arg4)), arg4, arg8, arg9);
            0x806e8570f5a254d46eccdbc721ae4977aa7b3d8ff53dda1457944d6944a02953::settlement::settle<T1>(v2, arg7);
            v1
        }
    }

    // decompiled from Move bytecode v7
}

