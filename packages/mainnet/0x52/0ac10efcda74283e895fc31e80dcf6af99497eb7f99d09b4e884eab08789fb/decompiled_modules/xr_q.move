module 0x520ac10efcda74283e895fc31e80dcf6af99497eb7f99d09b4e884eab08789fb::xr_q {
    public fun qs0<T0, T1>(arg0: &mut 0x520ac10efcda74283e895fc31e80dcf6af99497eb7f99d09b4e884eab08789fb::hz::Ht, arg1: &0xbf7915f9fb7f3ccd2df1058c53e6869bdaef64b569ba0c89cfc1fbf43a7f87df::versioned::Versioned, arg2: &0xbf7915f9fb7f3ccd2df1058c53e6869bdaef64b569ba0c89cfc1fbf43a7f87df::config::GlobalConfig, arg3: &0xbf7915f9fb7f3ccd2df1058c53e6869bdaef64b569ba0c89cfc1fbf43a7f87df::market_maker::MarketMaker, arg4: &mut 0xbf7915f9fb7f3ccd2df1058c53e6869bdaef64b569ba0c89cfc1fbf43a7f87df::orderbook::Pool<T0, T1>, arg5: 0x2::balance::Balance<T0>, arg6: &0x2::clock::Clock, arg7: &mut 0x2::tx_context::TxContext) : 0x2::balance::Balance<T1> {
        0x520ac10efcda74283e895fc31e80dcf6af99497eb7f99d09b4e884eab08789fb::hz::bl(arg0, 0x2::object::id<0xbf7915f9fb7f3ccd2df1058c53e6869bdaef64b569ba0c89cfc1fbf43a7f87df::orderbook::Pool<T0, T1>>(arg4), true);
        if (!0x520ac10efcda74283e895fc31e80dcf6af99497eb7f99d09b4e884eab08789fb::hz::ia(arg0)) {
            0x2::balance::destroy_zero<T0>(arg5);
            return 0x2::balance::zero<T1>()
        };
        let v0 = 0x1::vector::empty<0xbf7915f9fb7f3ccd2df1058c53e6869bdaef64b569ba0c89cfc1fbf43a7f87df::orderbook::QuoteFill>();
        0x1::vector::push_back<0xbf7915f9fb7f3ccd2df1058c53e6869bdaef64b569ba0c89cfc1fbf43a7f87df::orderbook::QuoteFill>(&mut v0, 0xbf7915f9fb7f3ccd2df1058c53e6869bdaef64b569ba0c89cfc1fbf43a7f87df::orderbook::new_quote_fill(b"", 0x2::balance::value<T0>(&arg5)));
        let (v1, v2) = 0xbf7915f9fb7f3ccd2df1058c53e6869bdaef64b569ba0c89cfc1fbf43a7f87df::orderbook::swap_exact_base_for_quote<T0, T1>(arg1, arg2, arg3, arg4, v0, arg5, *0xbf7915f9fb7f3ccd2df1058c53e6869bdaef64b569ba0c89cfc1fbf43a7f87df::orderbook::quote_hash(0x1::option::borrow<0xbf7915f9fb7f3ccd2df1058c53e6869bdaef64b569ba0c89cfc1fbf43a7f87df::orderbook::QuoteEntry>(0xbf7915f9fb7f3ccd2df1058c53e6869bdaef64b569ba0c89cfc1fbf43a7f87df::orderbook::pool_bid<T0, T1>(arg4))), arg6, arg7);
        let v3 = v2;
        assert!(0x2::balance::value<T0>(&v3) == 0, 172);
        0x2::balance::destroy_zero<T0>(v3);
        v1
    }

    public fun qs1<T0, T1>(arg0: &mut 0x520ac10efcda74283e895fc31e80dcf6af99497eb7f99d09b4e884eab08789fb::hz::Ht, arg1: &0xbf7915f9fb7f3ccd2df1058c53e6869bdaef64b569ba0c89cfc1fbf43a7f87df::versioned::Versioned, arg2: &0xbf7915f9fb7f3ccd2df1058c53e6869bdaef64b569ba0c89cfc1fbf43a7f87df::config::GlobalConfig, arg3: &0xbf7915f9fb7f3ccd2df1058c53e6869bdaef64b569ba0c89cfc1fbf43a7f87df::market_maker::MarketMaker, arg4: &mut 0xbf7915f9fb7f3ccd2df1058c53e6869bdaef64b569ba0c89cfc1fbf43a7f87df::orderbook::Pool<T0, T1>, arg5: 0x2::balance::Balance<T1>, arg6: &0x2::clock::Clock, arg7: &mut 0x2::tx_context::TxContext) : 0x2::balance::Balance<T0> {
        0x520ac10efcda74283e895fc31e80dcf6af99497eb7f99d09b4e884eab08789fb::hz::bl(arg0, 0x2::object::id<0xbf7915f9fb7f3ccd2df1058c53e6869bdaef64b569ba0c89cfc1fbf43a7f87df::orderbook::Pool<T0, T1>>(arg4), false);
        if (!0x520ac10efcda74283e895fc31e80dcf6af99497eb7f99d09b4e884eab08789fb::hz::ia(arg0)) {
            0x2::balance::destroy_zero<T1>(arg5);
            return 0x2::balance::zero<T0>()
        };
        let v0 = 0x1::vector::empty<0xbf7915f9fb7f3ccd2df1058c53e6869bdaef64b569ba0c89cfc1fbf43a7f87df::orderbook::QuoteFill>();
        0x1::vector::push_back<0xbf7915f9fb7f3ccd2df1058c53e6869bdaef64b569ba0c89cfc1fbf43a7f87df::orderbook::QuoteFill>(&mut v0, 0xbf7915f9fb7f3ccd2df1058c53e6869bdaef64b569ba0c89cfc1fbf43a7f87df::orderbook::new_quote_fill(b"", 0x2::balance::value<T1>(&arg5)));
        let (v1, v2) = 0xbf7915f9fb7f3ccd2df1058c53e6869bdaef64b569ba0c89cfc1fbf43a7f87df::orderbook::swap_exact_quote_for_base<T0, T1>(arg1, arg2, arg3, arg4, v0, arg5, *0xbf7915f9fb7f3ccd2df1058c53e6869bdaef64b569ba0c89cfc1fbf43a7f87df::orderbook::quote_hash(0x1::option::borrow<0xbf7915f9fb7f3ccd2df1058c53e6869bdaef64b569ba0c89cfc1fbf43a7f87df::orderbook::QuoteEntry>(0xbf7915f9fb7f3ccd2df1058c53e6869bdaef64b569ba0c89cfc1fbf43a7f87df::orderbook::pool_ask<T0, T1>(arg4))), arg6, arg7);
        let v3 = v2;
        assert!(0x2::balance::value<T1>(&v3) == 0, 172);
        0x2::balance::destroy_zero<T1>(v3);
        v1
    }

    // decompiled from Move bytecode v7
}

