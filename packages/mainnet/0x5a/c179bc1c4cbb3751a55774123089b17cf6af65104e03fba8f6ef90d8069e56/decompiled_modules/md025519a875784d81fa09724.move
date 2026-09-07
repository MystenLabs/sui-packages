module 0x5ac179bc1c4cbb3751a55774123089b17cf6af65104e03fba8f6ef90d8069e56::md025519a875784d81fa09724 {
    public fun f07516d5bf8e0f60e499d12ba<T0, T1>(arg0: &0xbf7915f9fb7f3ccd2df1058c53e6869bdaef64b569ba0c89cfc1fbf43a7f87df::versioned::Versioned, arg1: &0xbf7915f9fb7f3ccd2df1058c53e6869bdaef64b569ba0c89cfc1fbf43a7f87df::config::GlobalConfig, arg2: &0xbf7915f9fb7f3ccd2df1058c53e6869bdaef64b569ba0c89cfc1fbf43a7f87df::market_maker::MarketMaker, arg3: &mut 0xbf7915f9fb7f3ccd2df1058c53e6869bdaef64b569ba0c89cfc1fbf43a7f87df::orderbook_v2::Pool<T0, T1>, arg4: 0xbf7915f9fb7f3ccd2df1058c53e6869bdaef64b569ba0c89cfc1fbf43a7f87df::orderbook_v2::QuoteFill, arg5: 0x2::balance::Balance<T1>, arg6: &0x2::clock::Clock, arg7: &mut 0x2::tx_context::TxContext) : (0x2::balance::Balance<T0>, 0x2::balance::Balance<T1>) {
        0xbf7915f9fb7f3ccd2df1058c53e6869bdaef64b569ba0c89cfc1fbf43a7f87df::orderbook_v2::swap_exact_quote_for_base<T0, T1>(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7)
    }

    public fun f16d71d6713ed0aaf2041b20e<T0, T1>(arg0: &0xbf7915f9fb7f3ccd2df1058c53e6869bdaef64b569ba0c89cfc1fbf43a7f87df::versioned::Versioned, arg1: &0xbf7915f9fb7f3ccd2df1058c53e6869bdaef64b569ba0c89cfc1fbf43a7f87df::config::GlobalConfig, arg2: &0xbf7915f9fb7f3ccd2df1058c53e6869bdaef64b569ba0c89cfc1fbf43a7f87df::market_maker::MarketMaker, arg3: &mut 0xbf7915f9fb7f3ccd2df1058c53e6869bdaef64b569ba0c89cfc1fbf43a7f87df::orderbook_v2::Pool<T0, T1>, arg4: vector<u8>, arg5: vector<vector<u8>>, arg6: &0x2::clock::Clock, arg7: &0x2::tx_context::TxContext) {
        0xbf7915f9fb7f3ccd2df1058c53e6869bdaef64b569ba0c89cfc1fbf43a7f87df::orderbook_v2::update_quote_envelope_v2<T0, T1>(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7);
    }

    public fun f4fa04ba9f9c3fb829ac6c12d(arg0: vector<u8>, arg1: u64) : 0xbf7915f9fb7f3ccd2df1058c53e6869bdaef64b569ba0c89cfc1fbf43a7f87df::orderbook_v2::QuoteFill {
        0xbf7915f9fb7f3ccd2df1058c53e6869bdaef64b569ba0c89cfc1fbf43a7f87df::orderbook_v2::new_quote_fill(arg0, arg1)
    }

    public fun f6fd9de0da6e19d5d3e4daafd<T0, T1>(arg0: &0xbf7915f9fb7f3ccd2df1058c53e6869bdaef64b569ba0c89cfc1fbf43a7f87df::versioned::Versioned, arg1: &0xbf7915f9fb7f3ccd2df1058c53e6869bdaef64b569ba0c89cfc1fbf43a7f87df::config::GlobalConfig, arg2: &0xbf7915f9fb7f3ccd2df1058c53e6869bdaef64b569ba0c89cfc1fbf43a7f87df::market_maker::MarketMaker, arg3: &mut 0xbf7915f9fb7f3ccd2df1058c53e6869bdaef64b569ba0c89cfc1fbf43a7f87df::orderbook::Pool<T0, T1>, arg4: vector<u8>, arg5: vector<u8>, arg6: &0x2::clock::Clock, arg7: &0x2::tx_context::TxContext) {
        0xbf7915f9fb7f3ccd2df1058c53e6869bdaef64b569ba0c89cfc1fbf43a7f87df::orderbook::update_quote_envelope<T0, T1>(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7);
    }

    public fun f718280f33eb04d33a2a1a47e<T0, T1>(arg0: &0xbf7915f9fb7f3ccd2df1058c53e6869bdaef64b569ba0c89cfc1fbf43a7f87df::versioned::Versioned, arg1: &0xbf7915f9fb7f3ccd2df1058c53e6869bdaef64b569ba0c89cfc1fbf43a7f87df::config::GlobalConfig, arg2: &0xbf7915f9fb7f3ccd2df1058c53e6869bdaef64b569ba0c89cfc1fbf43a7f87df::market_maker::MarketMaker, arg3: &mut 0xbf7915f9fb7f3ccd2df1058c53e6869bdaef64b569ba0c89cfc1fbf43a7f87df::orderbook_v2::Pool<T0, T1>, arg4: 0xbf7915f9fb7f3ccd2df1058c53e6869bdaef64b569ba0c89cfc1fbf43a7f87df::orderbook_v2::QuoteFill, arg5: 0x2::balance::Balance<T0>, arg6: &0x2::clock::Clock, arg7: &mut 0x2::tx_context::TxContext) : (0x2::balance::Balance<T1>, 0x2::balance::Balance<T0>) {
        0xbf7915f9fb7f3ccd2df1058c53e6869bdaef64b569ba0c89cfc1fbf43a7f87df::orderbook_v2::swap_exact_base_for_quote<T0, T1>(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7)
    }

    public fun faf84c95a9f5a5a03d78fb447(arg0: vector<u8>, arg1: u64) : 0xbf7915f9fb7f3ccd2df1058c53e6869bdaef64b569ba0c89cfc1fbf43a7f87df::orderbook::QuoteFill {
        0xbf7915f9fb7f3ccd2df1058c53e6869bdaef64b569ba0c89cfc1fbf43a7f87df::orderbook::new_quote_fill(arg0, arg1)
    }

    public fun fecf9439999de10921949be58<T0, T1>(arg0: &0xbf7915f9fb7f3ccd2df1058c53e6869bdaef64b569ba0c89cfc1fbf43a7f87df::versioned::Versioned, arg1: &0xbf7915f9fb7f3ccd2df1058c53e6869bdaef64b569ba0c89cfc1fbf43a7f87df::config::GlobalConfig, arg2: &0xbf7915f9fb7f3ccd2df1058c53e6869bdaef64b569ba0c89cfc1fbf43a7f87df::market_maker::MarketMaker, arg3: &mut 0xbf7915f9fb7f3ccd2df1058c53e6869bdaef64b569ba0c89cfc1fbf43a7f87df::orderbook::Pool<T0, T1>, arg4: vector<0xbf7915f9fb7f3ccd2df1058c53e6869bdaef64b569ba0c89cfc1fbf43a7f87df::orderbook::QuoteFill>, arg5: 0x2::balance::Balance<T1>, arg6: vector<u8>, arg7: &0x2::clock::Clock, arg8: &mut 0x2::tx_context::TxContext) : (0x2::balance::Balance<T0>, 0x2::balance::Balance<T1>) {
        0xbf7915f9fb7f3ccd2df1058c53e6869bdaef64b569ba0c89cfc1fbf43a7f87df::orderbook::swap_exact_quote_for_base<T0, T1>(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8)
    }

    public fun ff97c7528963b57af3508a988<T0, T1>(arg0: &0xbf7915f9fb7f3ccd2df1058c53e6869bdaef64b569ba0c89cfc1fbf43a7f87df::versioned::Versioned, arg1: &0xbf7915f9fb7f3ccd2df1058c53e6869bdaef64b569ba0c89cfc1fbf43a7f87df::config::GlobalConfig, arg2: &0xbf7915f9fb7f3ccd2df1058c53e6869bdaef64b569ba0c89cfc1fbf43a7f87df::market_maker::MarketMaker, arg3: &mut 0xbf7915f9fb7f3ccd2df1058c53e6869bdaef64b569ba0c89cfc1fbf43a7f87df::orderbook::Pool<T0, T1>, arg4: vector<0xbf7915f9fb7f3ccd2df1058c53e6869bdaef64b569ba0c89cfc1fbf43a7f87df::orderbook::QuoteFill>, arg5: 0x2::balance::Balance<T0>, arg6: vector<u8>, arg7: &0x2::clock::Clock, arg8: &mut 0x2::tx_context::TxContext) : (0x2::balance::Balance<T1>, 0x2::balance::Balance<T0>) {
        0xbf7915f9fb7f3ccd2df1058c53e6869bdaef64b569ba0c89cfc1fbf43a7f87df::orderbook::swap_exact_base_for_quote<T0, T1>(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8)
    }

    // decompiled from Move bytecode v7
}

