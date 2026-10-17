module 0xd5044740d9b2c23d134ad6c7a53070ab6a8e767050e3c755b9739a6d9f465ff7::route {
    fun fill_v1_a2b<T0, T1>(arg0: &0xbf7915f9fb7f3ccd2df1058c53e6869bdaef64b569ba0c89cfc1fbf43a7f87df::versioned::Versioned, arg1: &0xbf7915f9fb7f3ccd2df1058c53e6869bdaef64b569ba0c89cfc1fbf43a7f87df::config::GlobalConfig, arg2: &0xbf7915f9fb7f3ccd2df1058c53e6869bdaef64b569ba0c89cfc1fbf43a7f87df::market_maker::MarketMaker, arg3: &mut 0xbf7915f9fb7f3ccd2df1058c53e6869bdaef64b569ba0c89cfc1fbf43a7f87df::orderbook::Pool<T0, T1>, arg4: 0x2::coin::Coin<T0>, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T1>, 0x2::coin::Coin<T0>) {
        let v0 = 0x1::vector::empty<0xbf7915f9fb7f3ccd2df1058c53e6869bdaef64b569ba0c89cfc1fbf43a7f87df::orderbook::QuoteFill>();
        0x1::vector::push_back<0xbf7915f9fb7f3ccd2df1058c53e6869bdaef64b569ba0c89cfc1fbf43a7f87df::orderbook::QuoteFill>(&mut v0, 0xbf7915f9fb7f3ccd2df1058c53e6869bdaef64b569ba0c89cfc1fbf43a7f87df::orderbook::new_quote_fill(x"0000000000000000000000000000000000000000000000000000000000000000", 0x2::coin::value<T0>(&arg4)));
        let (v1, v2) = 0xbf7915f9fb7f3ccd2df1058c53e6869bdaef64b569ba0c89cfc1fbf43a7f87df::orderbook::swap_exact_base_for_quote<T0, T1>(arg0, arg1, arg2, arg3, v0, 0x2::coin::into_balance<T0>(arg4), x"0000000000000000000000000000000000000000000000000000000000000000", arg5, arg6);
        (0x2::coin::from_balance<T1>(v1, arg6), 0x2::coin::from_balance<T0>(v2, arg6))
    }

    fun fill_v1_b2a<T0, T1>(arg0: &0xbf7915f9fb7f3ccd2df1058c53e6869bdaef64b569ba0c89cfc1fbf43a7f87df::versioned::Versioned, arg1: &0xbf7915f9fb7f3ccd2df1058c53e6869bdaef64b569ba0c89cfc1fbf43a7f87df::config::GlobalConfig, arg2: &0xbf7915f9fb7f3ccd2df1058c53e6869bdaef64b569ba0c89cfc1fbf43a7f87df::market_maker::MarketMaker, arg3: &mut 0xbf7915f9fb7f3ccd2df1058c53e6869bdaef64b569ba0c89cfc1fbf43a7f87df::orderbook::Pool<T0, T1>, arg4: 0x2::coin::Coin<T1>, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T0>, 0x2::coin::Coin<T1>) {
        let v0 = 0x1::vector::empty<0xbf7915f9fb7f3ccd2df1058c53e6869bdaef64b569ba0c89cfc1fbf43a7f87df::orderbook::QuoteFill>();
        0x1::vector::push_back<0xbf7915f9fb7f3ccd2df1058c53e6869bdaef64b569ba0c89cfc1fbf43a7f87df::orderbook::QuoteFill>(&mut v0, 0xbf7915f9fb7f3ccd2df1058c53e6869bdaef64b569ba0c89cfc1fbf43a7f87df::orderbook::new_quote_fill(x"0000000000000000000000000000000000000000000000000000000000000000", 0x2::coin::value<T1>(&arg4)));
        let (v1, v2) = 0xbf7915f9fb7f3ccd2df1058c53e6869bdaef64b569ba0c89cfc1fbf43a7f87df::orderbook::swap_exact_quote_for_base<T0, T1>(arg0, arg1, arg2, arg3, v0, 0x2::coin::into_balance<T1>(arg4), x"0000000000000000000000000000000000000000000000000000000000000000", arg5, arg6);
        (0x2::coin::from_balance<T0>(v1, arg6), 0x2::coin::from_balance<T1>(v2, arg6))
    }

    fun fill_v2_a2b<T0, T1>(arg0: &0xbf7915f9fb7f3ccd2df1058c53e6869bdaef64b569ba0c89cfc1fbf43a7f87df::versioned::Versioned, arg1: &0xbf7915f9fb7f3ccd2df1058c53e6869bdaef64b569ba0c89cfc1fbf43a7f87df::config::GlobalConfig, arg2: &0xbf7915f9fb7f3ccd2df1058c53e6869bdaef64b569ba0c89cfc1fbf43a7f87df::market_maker::MarketMaker, arg3: &mut 0xbf7915f9fb7f3ccd2df1058c53e6869bdaef64b569ba0c89cfc1fbf43a7f87df::orderbook_v2::Pool<T0, T1>, arg4: 0x2::coin::Coin<T0>, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T1>, 0x2::coin::Coin<T0>) {
        let (v0, v1) = 0xbf7915f9fb7f3ccd2df1058c53e6869bdaef64b569ba0c89cfc1fbf43a7f87df::orderbook_v2::swap_exact_base_for_quote<T0, T1>(arg0, arg1, arg2, arg3, 0xbf7915f9fb7f3ccd2df1058c53e6869bdaef64b569ba0c89cfc1fbf43a7f87df::orderbook_v2::new_quote_fill(x"0000000000000000000000000000000000000000000000000000000000000000", 0x2::coin::value<T0>(&arg4)), 0x2::coin::into_balance<T0>(arg4), arg5, arg6);
        (0x2::coin::from_balance<T1>(v0, arg6), 0x2::coin::from_balance<T0>(v1, arg6))
    }

    fun fill_v2_b2a<T0, T1>(arg0: &0xbf7915f9fb7f3ccd2df1058c53e6869bdaef64b569ba0c89cfc1fbf43a7f87df::versioned::Versioned, arg1: &0xbf7915f9fb7f3ccd2df1058c53e6869bdaef64b569ba0c89cfc1fbf43a7f87df::config::GlobalConfig, arg2: &0xbf7915f9fb7f3ccd2df1058c53e6869bdaef64b569ba0c89cfc1fbf43a7f87df::market_maker::MarketMaker, arg3: &mut 0xbf7915f9fb7f3ccd2df1058c53e6869bdaef64b569ba0c89cfc1fbf43a7f87df::orderbook_v2::Pool<T0, T1>, arg4: 0x2::coin::Coin<T1>, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T0>, 0x2::coin::Coin<T1>) {
        let (v0, v1) = 0xbf7915f9fb7f3ccd2df1058c53e6869bdaef64b569ba0c89cfc1fbf43a7f87df::orderbook_v2::swap_exact_quote_for_base<T0, T1>(arg0, arg1, arg2, arg3, 0xbf7915f9fb7f3ccd2df1058c53e6869bdaef64b569ba0c89cfc1fbf43a7f87df::orderbook_v2::new_quote_fill(x"0000000000000000000000000000000000000000000000000000000000000000", 0x2::coin::value<T1>(&arg4)), 0x2::coin::into_balance<T1>(arg4), arg5, arg6);
        (0x2::coin::from_balance<T0>(v0, arg6), 0x2::coin::from_balance<T1>(v1, arg6))
    }

    fun finish_v2_a2b<T0, T1>(arg0: &0xbf7915f9fb7f3ccd2df1058c53e6869bdaef64b569ba0c89cfc1fbf43a7f87df::versioned::Versioned, arg1: &0xbf7915f9fb7f3ccd2df1058c53e6869bdaef64b569ba0c89cfc1fbf43a7f87df::config::GlobalConfig, arg2: &0xbf7915f9fb7f3ccd2df1058c53e6869bdaef64b569ba0c89cfc1fbf43a7f87df::market_maker::MarketMaker, arg3: &mut 0xbf7915f9fb7f3ccd2df1058c53e6869bdaef64b569ba0c89cfc1fbf43a7f87df::orderbook_v2::Pool<T0, T1>, arg4: 0x2::coin::Coin<T0>, arg5: vector<u64>, arg6: vector<0x2::coin::Coin<T1>>, arg7: vector<0x2::coin::Coin<T0>>, arg8: &0x2::clock::Clock, arg9: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T1> {
        let v0 = parts<T0>(arg4, arg5, arg9);
        while (!0x1::vector::is_empty<0x2::coin::Coin<T0>>(&v0)) {
            let (v1, v2) = fill_v2_a2b<T0, T1>(arg0, arg1, arg2, arg3, 0x1::vector::pop_back<0x2::coin::Coin<T0>>(&mut v0), arg8, arg9);
            0x1::vector::push_back<0x2::coin::Coin<T1>>(&mut arg6, v1);
            0x1::vector::push_back<0x2::coin::Coin<T0>>(&mut arg7, v2);
        };
        0x1::vector::destroy_empty<0x2::coin::Coin<T0>>(v0);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(merge<T0>(arg7), 0x2::tx_context::sender(arg9));
        merge<T1>(arg6)
    }

    fun finish_v2_b2a<T0, T1>(arg0: &0xbf7915f9fb7f3ccd2df1058c53e6869bdaef64b569ba0c89cfc1fbf43a7f87df::versioned::Versioned, arg1: &0xbf7915f9fb7f3ccd2df1058c53e6869bdaef64b569ba0c89cfc1fbf43a7f87df::config::GlobalConfig, arg2: &0xbf7915f9fb7f3ccd2df1058c53e6869bdaef64b569ba0c89cfc1fbf43a7f87df::market_maker::MarketMaker, arg3: &mut 0xbf7915f9fb7f3ccd2df1058c53e6869bdaef64b569ba0c89cfc1fbf43a7f87df::orderbook_v2::Pool<T0, T1>, arg4: 0x2::coin::Coin<T1>, arg5: vector<u64>, arg6: vector<0x2::coin::Coin<T0>>, arg7: vector<0x2::coin::Coin<T1>>, arg8: &0x2::clock::Clock, arg9: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        let v0 = parts<T1>(arg4, arg5, arg9);
        while (!0x1::vector::is_empty<0x2::coin::Coin<T1>>(&v0)) {
            let (v1, v2) = fill_v2_b2a<T0, T1>(arg0, arg1, arg2, arg3, 0x1::vector::pop_back<0x2::coin::Coin<T1>>(&mut v0), arg8, arg9);
            0x1::vector::push_back<0x2::coin::Coin<T0>>(&mut arg6, v1);
            0x1::vector::push_back<0x2::coin::Coin<T1>>(&mut arg7, v2);
        };
        0x1::vector::destroy_empty<0x2::coin::Coin<T1>>(v0);
        0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(merge<T1>(arg7), 0x2::tx_context::sender(arg9));
        merge<T0>(arg6)
    }

    fun merge<T0>(arg0: vector<0x2::coin::Coin<T0>>) : 0x2::coin::Coin<T0> {
        let v0 = 0x1::vector::pop_back<0x2::coin::Coin<T0>>(&mut arg0);
        0x1::vector::reverse<0x2::coin::Coin<T0>>(&mut arg0);
        while (!0x1::vector::is_empty<0x2::coin::Coin<T0>>(&arg0)) {
            0x2::coin::join<T0>(&mut v0, 0x1::vector::pop_back<0x2::coin::Coin<T0>>(&mut arg0));
        };
        0x1::vector::destroy_empty<0x2::coin::Coin<T0>>(arg0);
        v0
    }

    fun parts<T0>(arg0: 0x2::coin::Coin<T0>, arg1: vector<u64>, arg2: &mut 0x2::tx_context::TxContext) : vector<0x2::coin::Coin<T0>> {
        let v0 = 0x1::vector::empty<0x2::coin::Coin<T0>>();
        let v1 = 0;
        while (v1 < 0x1::vector::length<u64>(&arg1)) {
            0x1::vector::push_back<0x2::coin::Coin<T0>>(&mut v0, 0x2::coin::split<T0>(&mut arg0, *0x1::vector::borrow<u64>(&arg1, v1), arg2));
            v1 = v1 + 1;
        };
        0x1::vector::push_back<0x2::coin::Coin<T0>>(&mut v0, arg0);
        0x1::vector::reverse<0x2::coin::Coin<T0>>(&mut v0);
        v0
    }

    fun push_v1<T0, T1>(arg0: &0xbf7915f9fb7f3ccd2df1058c53e6869bdaef64b569ba0c89cfc1fbf43a7f87df::versioned::Versioned, arg1: &0xbf7915f9fb7f3ccd2df1058c53e6869bdaef64b569ba0c89cfc1fbf43a7f87df::config::GlobalConfig, arg2: &0xbf7915f9fb7f3ccd2df1058c53e6869bdaef64b569ba0c89cfc1fbf43a7f87df::market_maker::MarketMaker, arg3: &mut 0xbf7915f9fb7f3ccd2df1058c53e6869bdaef64b569ba0c89cfc1fbf43a7f87df::orderbook::Pool<T0, T1>, arg4: bool, arg5: vector<u8>, arg6: vector<u8>, arg7: &0x2::clock::Clock, arg8: &0x2::tx_context::TxContext) {
        if (arg4) {
            0xbf7915f9fb7f3ccd2df1058c53e6869bdaef64b569ba0c89cfc1fbf43a7f87df::orderbook::update_quote_envelope<T0, T1>(arg0, arg1, arg2, arg3, arg5, arg6, arg7, arg8);
        };
    }

    fun push_v2<T0, T1>(arg0: &0xbf7915f9fb7f3ccd2df1058c53e6869bdaef64b569ba0c89cfc1fbf43a7f87df::versioned::Versioned, arg1: &0xbf7915f9fb7f3ccd2df1058c53e6869bdaef64b569ba0c89cfc1fbf43a7f87df::config::GlobalConfig, arg2: &0xbf7915f9fb7f3ccd2df1058c53e6869bdaef64b569ba0c89cfc1fbf43a7f87df::market_maker::MarketMaker, arg3: &mut 0xbf7915f9fb7f3ccd2df1058c53e6869bdaef64b569ba0c89cfc1fbf43a7f87df::orderbook_v2::Pool<T0, T1>, arg4: bool, arg5: vector<u8>, arg6: vector<vector<u8>>, arg7: &0x2::clock::Clock, arg8: &0x2::tx_context::TxContext) {
        if (arg4) {
            0xbf7915f9fb7f3ccd2df1058c53e6869bdaef64b569ba0c89cfc1fbf43a7f87df::orderbook_v2::update_quote_envelope_v2<T0, T1>(arg0, arg1, arg2, arg3, arg5, arg6, arg7, arg8);
        };
    }

    public fun swap_a2b<T0, T1>(arg0: &0xbf7915f9fb7f3ccd2df1058c53e6869bdaef64b569ba0c89cfc1fbf43a7f87df::versioned::Versioned, arg1: &0xbf7915f9fb7f3ccd2df1058c53e6869bdaef64b569ba0c89cfc1fbf43a7f87df::config::GlobalConfig, arg2: &0xbf7915f9fb7f3ccd2df1058c53e6869bdaef64b569ba0c89cfc1fbf43a7f87df::market_maker::MarketMaker, arg3: &mut 0xbf7915f9fb7f3ccd2df1058c53e6869bdaef64b569ba0c89cfc1fbf43a7f87df::orderbook::Pool<T0, T1>, arg4: 0x2::coin::Coin<T0>, arg5: bool, arg6: vector<u8>, arg7: vector<u8>, arg8: &0x2::clock::Clock, arg9: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T1> {
        push_v1<T0, T1>(arg0, arg1, arg2, arg3, arg5, arg6, arg7, arg8, arg9);
        let (v0, v1) = fill_v1_a2b<T0, T1>(arg0, arg1, arg2, arg3, arg4, arg8, arg9);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(v1, 0x2::tx_context::sender(arg9));
        v0
    }

    public fun swap_b2a<T0, T1>(arg0: &0xbf7915f9fb7f3ccd2df1058c53e6869bdaef64b569ba0c89cfc1fbf43a7f87df::versioned::Versioned, arg1: &0xbf7915f9fb7f3ccd2df1058c53e6869bdaef64b569ba0c89cfc1fbf43a7f87df::config::GlobalConfig, arg2: &0xbf7915f9fb7f3ccd2df1058c53e6869bdaef64b569ba0c89cfc1fbf43a7f87df::market_maker::MarketMaker, arg3: &mut 0xbf7915f9fb7f3ccd2df1058c53e6869bdaef64b569ba0c89cfc1fbf43a7f87df::orderbook::Pool<T0, T1>, arg4: 0x2::coin::Coin<T1>, arg5: bool, arg6: vector<u8>, arg7: vector<u8>, arg8: &0x2::clock::Clock, arg9: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        push_v1<T0, T1>(arg0, arg1, arg2, arg3, arg5, arg6, arg7, arg8, arg9);
        let (v0, v1) = fill_v1_b2a<T0, T1>(arg0, arg1, arg2, arg3, arg4, arg8, arg9);
        0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(v1, 0x2::tx_context::sender(arg9));
        v0
    }

    public fun swap_v2_a2b<T0, T1>(arg0: &0xbf7915f9fb7f3ccd2df1058c53e6869bdaef64b569ba0c89cfc1fbf43a7f87df::versioned::Versioned, arg1: &0xbf7915f9fb7f3ccd2df1058c53e6869bdaef64b569ba0c89cfc1fbf43a7f87df::config::GlobalConfig, arg2: &0xbf7915f9fb7f3ccd2df1058c53e6869bdaef64b569ba0c89cfc1fbf43a7f87df::market_maker::MarketMaker, arg3: &mut 0xbf7915f9fb7f3ccd2df1058c53e6869bdaef64b569ba0c89cfc1fbf43a7f87df::orderbook_v2::Pool<T0, T1>, arg4: 0x2::coin::Coin<T0>, arg5: bool, arg6: vector<u8>, arg7: vector<vector<u8>>, arg8: vector<u64>, arg9: &0x2::clock::Clock, arg10: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T1> {
        push_v2<T0, T1>(arg0, arg1, arg2, arg3, arg5, arg6, arg7, arg9, arg10);
        finish_v2_a2b<T0, T1>(arg0, arg1, arg2, arg3, arg4, arg8, 0x1::vector::empty<0x2::coin::Coin<T1>>(), 0x1::vector::empty<0x2::coin::Coin<T0>>(), arg9, arg10)
    }

    public fun swap_v2_b2a<T0, T1>(arg0: &0xbf7915f9fb7f3ccd2df1058c53e6869bdaef64b569ba0c89cfc1fbf43a7f87df::versioned::Versioned, arg1: &0xbf7915f9fb7f3ccd2df1058c53e6869bdaef64b569ba0c89cfc1fbf43a7f87df::config::GlobalConfig, arg2: &0xbf7915f9fb7f3ccd2df1058c53e6869bdaef64b569ba0c89cfc1fbf43a7f87df::market_maker::MarketMaker, arg3: &mut 0xbf7915f9fb7f3ccd2df1058c53e6869bdaef64b569ba0c89cfc1fbf43a7f87df::orderbook_v2::Pool<T0, T1>, arg4: 0x2::coin::Coin<T1>, arg5: bool, arg6: vector<u8>, arg7: vector<vector<u8>>, arg8: vector<u64>, arg9: &0x2::clock::Clock, arg10: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        push_v2<T0, T1>(arg0, arg1, arg2, arg3, arg5, arg6, arg7, arg9, arg10);
        finish_v2_b2a<T0, T1>(arg0, arg1, arg2, arg3, arg4, arg8, 0x1::vector::empty<0x2::coin::Coin<T0>>(), 0x1::vector::empty<0x2::coin::Coin<T1>>(), arg9, arg10)
    }

    public fun swap_v2_overflow_a2b<T0, T1>(arg0: &0xbf7915f9fb7f3ccd2df1058c53e6869bdaef64b569ba0c89cfc1fbf43a7f87df::versioned::Versioned, arg1: &0xbf7915f9fb7f3ccd2df1058c53e6869bdaef64b569ba0c89cfc1fbf43a7f87df::config::GlobalConfig, arg2: &0xbf7915f9fb7f3ccd2df1058c53e6869bdaef64b569ba0c89cfc1fbf43a7f87df::market_maker::MarketMaker, arg3: &mut 0xbf7915f9fb7f3ccd2df1058c53e6869bdaef64b569ba0c89cfc1fbf43a7f87df::orderbook_v2::Pool<T0, T1>, arg4: 0x2::coin::Coin<T0>, arg5: bool, arg6: vector<u8>, arg7: vector<vector<u8>>, arg8: vector<u64>, arg9: &mut 0xbf7915f9fb7f3ccd2df1058c53e6869bdaef64b569ba0c89cfc1fbf43a7f87df::orderbook::Pool<T0, T1>, arg10: u64, arg11: bool, arg12: vector<u8>, arg13: vector<u8>, arg14: &0x2::clock::Clock, arg15: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T1> {
        push_v2<T0, T1>(arg0, arg1, arg2, arg3, arg5, arg6, arg7, arg14, arg15);
        let v0 = 0x2::coin::split<T0>(&mut arg4, arg10, arg15);
        push_v1<T0, T1>(arg0, arg1, arg2, arg9, arg11, arg12, arg13, arg14, arg15);
        let (v1, v2) = fill_v1_a2b<T0, T1>(arg0, arg1, arg2, arg9, v0, arg14, arg15);
        let v3 = 0x1::vector::empty<0x2::coin::Coin<T1>>();
        0x1::vector::push_back<0x2::coin::Coin<T1>>(&mut v3, v1);
        let v4 = 0x1::vector::empty<0x2::coin::Coin<T0>>();
        0x1::vector::push_back<0x2::coin::Coin<T0>>(&mut v4, v2);
        finish_v2_a2b<T0, T1>(arg0, arg1, arg2, arg3, arg4, arg8, v3, v4, arg14, arg15)
    }

    public fun swap_v2_overflow_b2a<T0, T1>(arg0: &0xbf7915f9fb7f3ccd2df1058c53e6869bdaef64b569ba0c89cfc1fbf43a7f87df::versioned::Versioned, arg1: &0xbf7915f9fb7f3ccd2df1058c53e6869bdaef64b569ba0c89cfc1fbf43a7f87df::config::GlobalConfig, arg2: &0xbf7915f9fb7f3ccd2df1058c53e6869bdaef64b569ba0c89cfc1fbf43a7f87df::market_maker::MarketMaker, arg3: &mut 0xbf7915f9fb7f3ccd2df1058c53e6869bdaef64b569ba0c89cfc1fbf43a7f87df::orderbook_v2::Pool<T0, T1>, arg4: 0x2::coin::Coin<T1>, arg5: bool, arg6: vector<u8>, arg7: vector<vector<u8>>, arg8: vector<u64>, arg9: &mut 0xbf7915f9fb7f3ccd2df1058c53e6869bdaef64b569ba0c89cfc1fbf43a7f87df::orderbook::Pool<T0, T1>, arg10: u64, arg11: bool, arg12: vector<u8>, arg13: vector<u8>, arg14: &0x2::clock::Clock, arg15: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        push_v2<T0, T1>(arg0, arg1, arg2, arg3, arg5, arg6, arg7, arg14, arg15);
        let v0 = 0x2::coin::split<T1>(&mut arg4, arg10, arg15);
        push_v1<T0, T1>(arg0, arg1, arg2, arg9, arg11, arg12, arg13, arg14, arg15);
        let (v1, v2) = fill_v1_b2a<T0, T1>(arg0, arg1, arg2, arg9, v0, arg14, arg15);
        let v3 = 0x1::vector::empty<0x2::coin::Coin<T0>>();
        0x1::vector::push_back<0x2::coin::Coin<T0>>(&mut v3, v1);
        let v4 = 0x1::vector::empty<0x2::coin::Coin<T1>>();
        0x1::vector::push_back<0x2::coin::Coin<T1>>(&mut v4, v2);
        finish_v2_b2a<T0, T1>(arg0, arg1, arg2, arg3, arg4, arg8, v3, v4, arg14, arg15)
    }

    // decompiled from Move bytecode v7
}

