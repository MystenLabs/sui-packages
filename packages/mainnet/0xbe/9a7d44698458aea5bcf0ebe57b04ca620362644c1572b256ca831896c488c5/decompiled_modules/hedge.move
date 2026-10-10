module 0xbe9a7d44698458aea5bcf0ebe57b04ca620362644c1572b256ca831896c488c5::hedge {
    struct AccountClosed has copy, drop {
        schema: u8,
        market: 0x2::object::ID,
        account: 0x2::object::ID,
    }

    struct Synced has copy, drop {
        schema: u8,
        market: 0x2::object::ID,
        by: u8,
        buy: bool,
        wanted: u64,
        filled: u64,
        cost: u64,
        base: u64,
        target: u64,
        price: u256,
        equity: u64,
    }

    struct MarginMoved has copy, drop {
        schema: u8,
        market: 0x2::object::ID,
        added: u64,
        returned: u64,
    }

    struct Fill has copy, drop {
        buy: bool,
        wanted: u64,
        filled: u64,
        spent: u64,
        added: u64,
    }

    fun below_min_order<T0>(arg0: &0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::clearing_house::ClearingHouse<T0>, arg1: u64, arg2: u256) : bool {
        (arg1 as u256) * 1000000000 * arg2 / 1000000000000000000 < 0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::market::min_order_usd_value(0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::clearing_house::market_params<T0>(arg0))
    }

    fun bring_home<T0, T1>(arg0: &mut 0xbe9a7d44698458aea5bcf0ebe57b04ca620362644c1572b256ca831896c488c5::market::Market<T0, T1>, arg1: &mut 0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::account::Account<T1>, arg2: &mut 0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::clearing_house::ClearingHouse<T1>, arg3: &0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::registry::Registry, arg4: &0x9237337d846fc90b0a7acbdee4ab91809298691873d28e1d64d91e6303ff6ba4::price_feed_storage::PriceFeedStorage, arg5: &0x9237337d846fc90b0a7acbdee4ab91809298691873d28e1d64d91e6303ff6ba4::price_feed_storage::PriceFeedStorage, arg6: u64, arg7: u256, arg8: &0x2::clock::Clock, arg9: &mut 0x2::tx_context::TxContext) : u64 {
        0xbe9a7d44698458aea5bcf0ebe57b04ca620362644c1572b256ca831896c488c5::custody::release_margin<T1>(0x1::option::borrow<0xbe9a7d44698458aea5bcf0ebe57b04ca620362644c1572b256ca831896c488c5::custody::Vault<T1>>(0xbe9a7d44698458aea5bcf0ebe57b04ca620362644c1572b256ca831896c488c5::market::account<T0, T1>(arg0)), arg1, arg2, arg4, arg5, arg8);
        let v0 = 0;
        let v1 = 0xbe9a7d44698458aea5bcf0ebe57b04ca620362644c1572b256ca831896c488c5::custody::balance<T1>(0x1::option::borrow<0xbe9a7d44698458aea5bcf0ebe57b04ca620362644c1572b256ca831896c488c5::custody::Vault<T1>>(0xbe9a7d44698458aea5bcf0ebe57b04ca620362644c1572b256ca831896c488c5::market::account<T0, T1>(arg0)), arg1);
        if (v1 > 0) {
            0xbe9a7d44698458aea5bcf0ebe57b04ca620362644c1572b256ca831896c488c5::market::cash_in<T0, T1>(arg0, 0xbe9a7d44698458aea5bcf0ebe57b04ca620362644c1572b256ca831896c488c5::custody::withdraw<T1>(0x1::option::borrow<0xbe9a7d44698458aea5bcf0ebe57b04ca620362644c1572b256ca831896c488c5::custody::Vault<T1>>(0xbe9a7d44698458aea5bcf0ebe57b04ca620362644c1572b256ca831896c488c5::market::account<T0, T1>(arg0)), arg1, arg3, v1, arg9), 1);
            v0 = v1;
        };
        let v2 = 0xbe9a7d44698458aea5bcf0ebe57b04ca620362644c1572b256ca831896c488c5::market::ready_short<T0, T1>(arg0, arg7);
        if (v2 > 0) {
            v0 = v0 + release<T0, T1>(arg0, arg1, arg2, arg3, arg4, arg5, arg6, v2, arg8, arg9);
        };
        v0
    }

    public fun buy<T0, T1>(arg0: &mut 0xbe9a7d44698458aea5bcf0ebe57b04ca620362644c1572b256ca831896c488c5::market::Market<T0, T1>, arg1: &0xbe9a7d44698458aea5bcf0ebe57b04ca620362644c1572b256ca831896c488c5::config::Config, arg2: 0x2::coin::Coin<T1>, arg3: u64, arg4: &mut 0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::account::Account<T1>, arg5: 0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::clearing_house::ClearingHouse<T1>, arg6: &0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::registry::Registry, arg7: &0x9237337d846fc90b0a7acbdee4ab91809298691873d28e1d64d91e6303ff6ba4::price_feed_storage::PriceFeedStorage, arg8: &0x9237337d846fc90b0a7acbdee4ab91809298691873d28e1d64d91e6303ff6ba4::price_feed_storage::PriceFeedStorage, arg9: &0x2::clock::Clock, arg10: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T0>, 0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::clearing_house::ClearingHouse<T1>) {
        0xbe9a7d44698458aea5bcf0ebe57b04ca620362644c1572b256ca831896c488c5::market::assert_config<T0, T1>(arg0, arg1);
        assert!(0x1::option::is_some<0xbe9a7d44698458aea5bcf0ebe57b04ca620362644c1572b256ca831896c488c5::custody::Vault<T1>>(0xbe9a7d44698458aea5bcf0ebe57b04ca620362644c1572b256ca831896c488c5::market::account<T0, T1>(arg0)), 300);
        let v0 = 0xbe9a7d44698458aea5bcf0ebe57b04ca620362644c1572b256ca831896c488c5::market::settings<T0, T1>(arg0);
        let (_, v2) = 0xbe9a7d44698458aea5bcf0ebe57b04ca620362644c1572b256ca831896c488c5::market::ages(&v0);
        let v3 = 0xbe9a7d44698458aea5bcf0ebe57b04ca620362644c1572b256ca831896c488c5::oracle::price<T1>(&arg5, arg7, arg9, 0xbe9a7d44698458aea5bcf0ebe57b04ca620362644c1572b256ca831896c488c5::market::venue<T0, T1>(arg0), v2);
        let v4 = 0xbe9a7d44698458aea5bcf0ebe57b04ca620362644c1572b256ca831896c488c5::oracle::long_funding_bps<T1>(&arg5, v3 * 0xbe9a7d44698458aea5bcf0ebe57b04ca620362644c1572b256ca831896c488c5::math::price_scale());
        let v5 = 0xbe9a7d44698458aea5bcf0ebe57b04ca620362644c1572b256ca831896c488c5::market::buy_gate<T0, T1>(arg0, arg1, v4);
        assert!(v5 == 0, v5);
        let (v6, _) = 0xbe9a7d44698458aea5bcf0ebe57b04ca620362644c1572b256ca831896c488c5::market::decimals<T0, T1>(arg0);
        let v8 = 0x2::coin::value<T1>(&arg2);
        let v9 = 0xbe9a7d44698458aea5bcf0ebe57b04ca620362644c1572b256ca831896c488c5::market::coins_for<T0, T1>(arg0, v8, v3);
        0xbe9a7d44698458aea5bcf0ebe57b04ca620362644c1572b256ca831896c488c5::market::assert_room<T0, T1>(arg0, v9, v3);
        0xbe9a7d44698458aea5bcf0ebe57b04ca620362644c1572b256ca831896c488c5::market::cash_in<T0, T1>(arg0, arg2, 0);
        0xbe9a7d44698458aea5bcf0ebe57b04ca620362644c1572b256ca831896c488c5::valuation::settle<T1>(0x1::option::borrow<0xbe9a7d44698458aea5bcf0ebe57b04ca620362644c1572b256ca831896c488c5::custody::Vault<T1>>(0xbe9a7d44698458aea5bcf0ebe57b04ca620362644c1572b256ca831896c488c5::market::account<T0, T1>(arg0)), arg4, &mut arg5, arg7, arg8, arg9);
        let v10 = to_b9(0xbe9a7d44698458aea5bcf0ebe57b04ca620362644c1572b256ca831896c488c5::market::supply<T0, T1>(arg0) + v9, v6);
        let v11 = if (v10 > held_b9<T1>(&arg5, arg4)) {
            let (v12, v13) = step<T0, T1>(arg0, arg4, arg5, arg6, arg7, arg8, v3, v10, 0, 0xbe9a7d44698458aea5bcf0ebe57b04ca620362644c1572b256ca831896c488c5::market::trade_slippage_bps(&v0), arg9, arg10);
            arg5 = v12;
            v13
        } else {
            none(true)
        };
        let v14 = v11;
        let (_, _, _, v18) = 0xbe9a7d44698458aea5bcf0ebe57b04ca620362644c1572b256ca831896c488c5::market::hedge_rules(&v0);
        let v19 = &mut arg5;
        let v20 = bring_home<T0, T1>(arg0, arg4, v19, arg6, arg7, arg8, v18, v3, arg9, arg10);
        if (v14.added > 0 || v20 > 0) {
            let v21 = MarginMoved{
                schema   : 0xbe9a7d44698458aea5bcf0ebe57b04ca620362644c1572b256ca831896c488c5::config::schema(),
                market   : 0x2::object::id<0xbe9a7d44698458aea5bcf0ebe57b04ca620362644c1572b256ca831896c488c5::market::Market<T0, T1>>(arg0),
                added    : v14.added,
                returned : v20,
            };
            0x2::event::emit<MarginMoved>(v21);
        };
        let v22 = 0xbe9a7d44698458aea5bcf0ebe57b04ca620362644c1572b256ca831896c488c5::valuation::oracle_prices<T1>(&arg5, arg7, arg8, arg9);
        let v23 = store<T0, T1>(arg0, arg4, &arg5, &v22, v3, arg9);
        let v24 = cost_of(&v14, to_b9(v9, v6));
        emit_synced<T0, T1>(arg0, 1, &v14, v24, held_b9<T1>(&arg5, arg4), v10, v3, v23);
        (0xbe9a7d44698458aea5bcf0ebe57b04ca620362644c1572b256ca831896c488c5::market::buy_paid<T0, T1>(arg0, arg1, v8, arg3, v3, v4, v24, 0x2::clock::timestamp_ms(arg9), arg10), arg5)
    }

    public fun close_account<T0, T1>(arg0: &mut 0xbe9a7d44698458aea5bcf0ebe57b04ca620362644c1572b256ca831896c488c5::market::Market<T0, T1>, arg1: &0xbe9a7d44698458aea5bcf0ebe57b04ca620362644c1572b256ca831896c488c5::config::Config, arg2: &mut 0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::account::Account<T1>, arg3: &mut 0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::clearing_house::ClearingHouse<T1>, arg4: &0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::registry::Registry, arg5: &0x9237337d846fc90b0a7acbdee4ab91809298691873d28e1d64d91e6303ff6ba4::price_feed_storage::PriceFeedStorage, arg6: &0x9237337d846fc90b0a7acbdee4ab91809298691873d28e1d64d91e6303ff6ba4::price_feed_storage::PriceFeedStorage, arg7: &0x2::clock::Clock, arg8: &mut 0x2::tx_context::TxContext) {
        0xbe9a7d44698458aea5bcf0ebe57b04ca620362644c1572b256ca831896c488c5::market::assert_config<T0, T1>(arg0, arg1);
        0xbe9a7d44698458aea5bcf0ebe57b04ca620362644c1572b256ca831896c488c5::config::assert_keeper(arg1, arg8);
        assert!(0x1::option::is_some<0xbe9a7d44698458aea5bcf0ebe57b04ca620362644c1572b256ca831896c488c5::custody::Vault<T1>>(0xbe9a7d44698458aea5bcf0ebe57b04ca620362644c1572b256ca831896c488c5::market::account<T0, T1>(arg0)), 300);
        assert!(held_b9<T1>(arg3, arg2) == 0, 304);
        0xbe9a7d44698458aea5bcf0ebe57b04ca620362644c1572b256ca831896c488c5::custody::release_margin<T1>(0x1::option::borrow<0xbe9a7d44698458aea5bcf0ebe57b04ca620362644c1572b256ca831896c488c5::custody::Vault<T1>>(0xbe9a7d44698458aea5bcf0ebe57b04ca620362644c1572b256ca831896c488c5::market::account<T0, T1>(arg0)), arg2, arg3, arg5, arg6, arg7);
        let v0 = 0xbe9a7d44698458aea5bcf0ebe57b04ca620362644c1572b256ca831896c488c5::custody::balance<T1>(0x1::option::borrow<0xbe9a7d44698458aea5bcf0ebe57b04ca620362644c1572b256ca831896c488c5::custody::Vault<T1>>(0xbe9a7d44698458aea5bcf0ebe57b04ca620362644c1572b256ca831896c488c5::market::account<T0, T1>(arg0)), arg2);
        if (v0 > 0) {
            0xbe9a7d44698458aea5bcf0ebe57b04ca620362644c1572b256ca831896c488c5::market::cash_in<T0, T1>(arg0, 0xbe9a7d44698458aea5bcf0ebe57b04ca620362644c1572b256ca831896c488c5::custody::withdraw<T1>(0x1::option::borrow<0xbe9a7d44698458aea5bcf0ebe57b04ca620362644c1572b256ca831896c488c5::custody::Vault<T1>>(0xbe9a7d44698458aea5bcf0ebe57b04ca620362644c1572b256ca831896c488c5::market::account<T0, T1>(arg0)), arg2, arg4, v0, arg8), 1);
        };
        let v1 = 0xbe9a7d44698458aea5bcf0ebe57b04ca620362644c1572b256ca831896c488c5::market::take_account<T0, T1>(arg0);
        let v2 = AccountClosed{
            schema  : 0xbe9a7d44698458aea5bcf0ebe57b04ca620362644c1572b256ca831896c488c5::config::schema(),
            market  : 0x2::object::id<0xbe9a7d44698458aea5bcf0ebe57b04ca620362644c1572b256ca831896c488c5::market::Market<T0, T1>>(arg0),
            account : 0xbe9a7d44698458aea5bcf0ebe57b04ca620362644c1572b256ca831896c488c5::custody::account_id<T1>(&v1),
        };
        0x2::event::emit<AccountClosed>(v2);
        0xbe9a7d44698458aea5bcf0ebe57b04ca620362644c1572b256ca831896c488c5::custody::destroy_empty<T1>(v1, arg2);
        let (v3, _) = 0xbe9a7d44698458aea5bcf0ebe57b04ca620362644c1572b256ca831896c488c5::market::last_price<T0, T1>(arg0);
        0xbe9a7d44698458aea5bcf0ebe57b04ca620362644c1572b256ca831896c488c5::market::set_hedge_mark<T0, T1>(arg0, 0, 0, v3, 0x2::clock::timestamp_ms(arg7));
    }

    public fun collect<T0, T1>(arg0: &mut 0xbe9a7d44698458aea5bcf0ebe57b04ca620362644c1572b256ca831896c488c5::market::Market<T0, T1>, arg1: &0xbe9a7d44698458aea5bcf0ebe57b04ca620362644c1572b256ca831896c488c5::config::Config, arg2: &mut 0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::account::Account<T1>, arg3: &mut 0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::clearing_house::ClearingHouse<T1>, arg4: &0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::registry::Registry, arg5: &0x9237337d846fc90b0a7acbdee4ab91809298691873d28e1d64d91e6303ff6ba4::price_feed_storage::PriceFeedStorage, arg6: &0x9237337d846fc90b0a7acbdee4ab91809298691873d28e1d64d91e6303ff6ba4::price_feed_storage::PriceFeedStorage, arg7: &0x2::clock::Clock, arg8: &mut 0x2::tx_context::TxContext) : u64 {
        0xbe9a7d44698458aea5bcf0ebe57b04ca620362644c1572b256ca831896c488c5::market::assert_config<T0, T1>(arg0, arg1);
        0xbe9a7d44698458aea5bcf0ebe57b04ca620362644c1572b256ca831896c488c5::config::assert_keeper(arg1, arg8);
        assert!(0x1::option::is_some<0xbe9a7d44698458aea5bcf0ebe57b04ca620362644c1572b256ca831896c488c5::custody::Vault<T1>>(0xbe9a7d44698458aea5bcf0ebe57b04ca620362644c1572b256ca831896c488c5::market::account<T0, T1>(arg0)), 300);
        let v0 = 0xbe9a7d44698458aea5bcf0ebe57b04ca620362644c1572b256ca831896c488c5::market::settings<T0, T1>(arg0);
        let (_, _, _, v4) = 0xbe9a7d44698458aea5bcf0ebe57b04ca620362644c1572b256ca831896c488c5::market::hedge_rules(&v0);
        let (_, v6) = 0xbe9a7d44698458aea5bcf0ebe57b04ca620362644c1572b256ca831896c488c5::market::ages(&v0);
        let v7 = 0xbe9a7d44698458aea5bcf0ebe57b04ca620362644c1572b256ca831896c488c5::oracle::price<T1>(arg3, arg5, arg7, 0xbe9a7d44698458aea5bcf0ebe57b04ca620362644c1572b256ca831896c488c5::market::venue<T0, T1>(arg0), v6);
        0xbe9a7d44698458aea5bcf0ebe57b04ca620362644c1572b256ca831896c488c5::valuation::settle<T1>(0x1::option::borrow<0xbe9a7d44698458aea5bcf0ebe57b04ca620362644c1572b256ca831896c488c5::custody::Vault<T1>>(0xbe9a7d44698458aea5bcf0ebe57b04ca620362644c1572b256ca831896c488c5::market::account<T0, T1>(arg0)), arg2, arg3, arg5, arg6, arg7);
        let v8 = bring_home<T0, T1>(arg0, arg2, arg3, arg4, arg5, arg6, v4, v7, arg7, arg8);
        if (v8 > 0) {
            let v9 = MarginMoved{
                schema   : 0xbe9a7d44698458aea5bcf0ebe57b04ca620362644c1572b256ca831896c488c5::config::schema(),
                market   : 0x2::object::id<0xbe9a7d44698458aea5bcf0ebe57b04ca620362644c1572b256ca831896c488c5::market::Market<T0, T1>>(arg0),
                added    : 0,
                returned : v8,
            };
            0x2::event::emit<MarginMoved>(v9);
        };
        let v10 = 0xbe9a7d44698458aea5bcf0ebe57b04ca620362644c1572b256ca831896c488c5::valuation::oracle_prices<T1>(arg3, arg5, arg6, arg7);
        store<T0, T1>(arg0, arg2, arg3, &v10, v7, arg7);
        v8
    }

    fun cost_of(arg0: &Fill, arg1: u64) : u64 {
        if (arg0.filled == 0) {
            return 0
        };
        let v0 = if (arg0.filled <= arg1) {
            arg0.spent
        } else {
            ((((arg0.spent as u256) * (arg1 as u256) + (arg0.filled as u256) - 1) / (arg0.filled as u256)) as u64)
        };
        v0 + 1
    }

    public fun defend<T0, T1>(arg0: &mut 0xbe9a7d44698458aea5bcf0ebe57b04ca620362644c1572b256ca831896c488c5::market::Market<T0, T1>, arg1: &0xbe9a7d44698458aea5bcf0ebe57b04ca620362644c1572b256ca831896c488c5::config::Config, arg2: &mut 0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::account::Account<T1>, arg3: &mut 0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::clearing_house::ClearingHouse<T1>, arg4: &0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::registry::Registry, arg5: &0x9237337d846fc90b0a7acbdee4ab91809298691873d28e1d64d91e6303ff6ba4::price_feed_storage::PriceFeedStorage, arg6: &0x9237337d846fc90b0a7acbdee4ab91809298691873d28e1d64d91e6303ff6ba4::price_feed_storage::PriceFeedStorage, arg7: &0x2::clock::Clock, arg8: &mut 0x2::tx_context::TxContext) : u64 {
        0xbe9a7d44698458aea5bcf0ebe57b04ca620362644c1572b256ca831896c488c5::market::assert_config<T0, T1>(arg0, arg1);
        0xbe9a7d44698458aea5bcf0ebe57b04ca620362644c1572b256ca831896c488c5::config::assert_keeper(arg1, arg8);
        assert!(0x1::option::is_some<0xbe9a7d44698458aea5bcf0ebe57b04ca620362644c1572b256ca831896c488c5::custody::Vault<T1>>(0xbe9a7d44698458aea5bcf0ebe57b04ca620362644c1572b256ca831896c488c5::market::account<T0, T1>(arg0)), 300);
        let v0 = 0xbe9a7d44698458aea5bcf0ebe57b04ca620362644c1572b256ca831896c488c5::market::settings<T0, T1>(arg0);
        let (_, _, _, v4) = 0xbe9a7d44698458aea5bcf0ebe57b04ca620362644c1572b256ca831896c488c5::market::hedge_rules(&v0);
        let (_, v6) = 0xbe9a7d44698458aea5bcf0ebe57b04ca620362644c1572b256ca831896c488c5::market::ages(&v0);
        let v7 = 0xbe9a7d44698458aea5bcf0ebe57b04ca620362644c1572b256ca831896c488c5::oracle::price<T1>(arg3, arg5, arg7, 0xbe9a7d44698458aea5bcf0ebe57b04ca620362644c1572b256ca831896c488c5::market::venue<T0, T1>(arg0), v6);
        0xbe9a7d44698458aea5bcf0ebe57b04ca620362644c1572b256ca831896c488c5::valuation::settle<T1>(0x1::option::borrow<0xbe9a7d44698458aea5bcf0ebe57b04ca620362644c1572b256ca831896c488c5::custody::Vault<T1>>(0xbe9a7d44698458aea5bcf0ebe57b04ca620362644c1572b256ca831896c488c5::market::account<T0, T1>(arg0)), arg2, arg3, arg5, arg6, arg7);
        let v8 = 0;
        if (0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::clearing_house::exists_position<T1>(arg3, 0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::account::account_id<T1>(arg2))) {
            let v9 = 0xbe9a7d44698458aea5bcf0ebe57b04ca620362644c1572b256ca831896c488c5::valuation::prices<T1>(arg3, arg5, arg6, arg7);
            let v10 = 0xbe9a7d44698458aea5bcf0ebe57b04ca620362644c1572b256ca831896c488c5::valuation::margin_shortfall<T1>(arg2, arg3, &v9, v4);
            let v11 = 0xbe9a7d44698458aea5bcf0ebe57b04ca620362644c1572b256ca831896c488c5::custody::balance<T1>(0x1::option::borrow<0xbe9a7d44698458aea5bcf0ebe57b04ca620362644c1572b256ca831896c488c5::custody::Vault<T1>>(0xbe9a7d44698458aea5bcf0ebe57b04ca620362644c1572b256ca831896c488c5::market::account<T0, T1>(arg0)), arg2);
            if (v10 > v11) {
                let v12 = 0x1::u64::min(v10 - v11, 0xbe9a7d44698458aea5bcf0ebe57b04ca620362644c1572b256ca831896c488c5::market::spare_cash<T0, T1>(arg0, v7));
                v8 = v12;
                if (v12 > 0) {
                    0xbe9a7d44698458aea5bcf0ebe57b04ca620362644c1572b256ca831896c488c5::custody::deposit<T1>(0x1::option::borrow<0xbe9a7d44698458aea5bcf0ebe57b04ca620362644c1572b256ca831896c488c5::custody::Vault<T1>>(0xbe9a7d44698458aea5bcf0ebe57b04ca620362644c1572b256ca831896c488c5::market::account<T0, T1>(arg0)), arg2, arg4, 0xbe9a7d44698458aea5bcf0ebe57b04ca620362644c1572b256ca831896c488c5::market::cash_out<T0, T1>(arg0, v12, 1, arg8));
                };
            };
            let v13 = 0x1::option::borrow<0xbe9a7d44698458aea5bcf0ebe57b04ca620362644c1572b256ca831896c488c5::custody::Vault<T1>>(0xbe9a7d44698458aea5bcf0ebe57b04ca620362644c1572b256ca831896c488c5::market::account<T0, T1>(arg0));
            let v14 = 0x1::u64::min(v10, 0xbe9a7d44698458aea5bcf0ebe57b04ca620362644c1572b256ca831896c488c5::custody::balance<T1>(v13, arg2));
            if (v14 > 0) {
                0xbe9a7d44698458aea5bcf0ebe57b04ca620362644c1572b256ca831896c488c5::custody::allocate_margin<T1>(v13, arg2, arg3, v14);
            };
        };
        if (v8 > 0) {
            let v15 = MarginMoved{
                schema   : 0xbe9a7d44698458aea5bcf0ebe57b04ca620362644c1572b256ca831896c488c5::config::schema(),
                market   : 0x2::object::id<0xbe9a7d44698458aea5bcf0ebe57b04ca620362644c1572b256ca831896c488c5::market::Market<T0, T1>>(arg0),
                added    : v8,
                returned : 0,
            };
            0x2::event::emit<MarginMoved>(v15);
        };
        let v16 = 0xbe9a7d44698458aea5bcf0ebe57b04ca620362644c1572b256ca831896c488c5::valuation::oracle_prices<T1>(arg3, arg5, arg6, arg7);
        store<T0, T1>(arg0, arg2, arg3, &v16, v7, arg7);
        v8
    }

    fun emit_synced<T0, T1>(arg0: &0xbe9a7d44698458aea5bcf0ebe57b04ca620362644c1572b256ca831896c488c5::market::Market<T0, T1>, arg1: u8, arg2: &Fill, arg3: u64, arg4: u64, arg5: u64, arg6: u256, arg7: u64) {
        let (v0, _) = 0xbe9a7d44698458aea5bcf0ebe57b04ca620362644c1572b256ca831896c488c5::market::decimals<T0, T1>(arg0);
        let v2 = Synced{
            schema : 0xbe9a7d44698458aea5bcf0ebe57b04ca620362644c1572b256ca831896c488c5::config::schema(),
            market : 0x2::object::id<0xbe9a7d44698458aea5bcf0ebe57b04ca620362644c1572b256ca831896c488c5::market::Market<T0, T1>>(arg0),
            by     : arg1,
            buy    : arg2.buy,
            wanted : from_b9(arg2.wanted, v0),
            filled : from_b9(arg2.filled, v0),
            cost   : arg3,
            base   : from_b9(arg4, v0),
            target : from_b9(arg5, v0),
            price  : arg6,
            equity : arg7,
        };
        0x2::event::emit<Synced>(v2);
    }

    fun equity<T0>(arg0: &0xbe9a7d44698458aea5bcf0ebe57b04ca620362644c1572b256ca831896c488c5::custody::Vault<T0>, arg1: &0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::account::Account<T0>, arg2: &0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::clearing_house::ClearingHouse<T0>, arg3: &0xbe9a7d44698458aea5bcf0ebe57b04ca620362644c1572b256ca831896c488c5::valuation::Prices) : u64 {
        let v0 = 0xbe9a7d44698458aea5bcf0ebe57b04ca620362644c1572b256ca831896c488c5::valuation::custody_value<T0>(arg0, arg1, arg2, arg3);
        if (0x4b4703a7581781d74a4c7b0fb0836b2a67f34f1a377fb81aab6f5cad29d78760::ifixed::is_neg(v0)) {
            0
        } else {
            0x4b4703a7581781d74a4c7b0fb0836b2a67f34f1a377fb81aab6f5cad29d78760::ifixed::to_balance(v0, 0xbe9a7d44698458aea5bcf0ebe57b04ca620362644c1572b256ca831896c488c5::valuation::collateral_scaling(arg3))
        }
    }

    fun from_b9(arg0: u64, arg1: u8) : u64 {
        (((arg0 as u256) / 0xbe9a7d44698458aea5bcf0ebe57b04ca620362644c1572b256ca831896c488c5::math::pow10(9 - arg1)) as u64)
    }

    fun held_b9<T0>(arg0: &0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::clearing_house::ClearingHouse<T0>, arg1: &0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::account::Account<T0>) : u64 {
        if (!0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::clearing_house::exists_position<T0>(arg0, 0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::account::account_id<T0>(arg1))) {
            return 0
        };
        let v0 = 0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::clearing_house::position<T0>(arg0, 0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::account::account_id<T0>(arg1));
        let (v1, _) = 0x9196fffe0341b2f0ca7424926b22d9e9e35b4807a1f625fc20eeea1382d08dec::position::base_and_quote_amounts(v0);
        assert!(0x9196fffe0341b2f0ca7424926b22d9e9e35b4807a1f625fc20eeea1382d08dec::position::is_long_or_flat(v0), 302);
        ((v1 / 1000000000) as u64)
    }

    public fun mark<T0, T1>(arg0: &mut 0xbe9a7d44698458aea5bcf0ebe57b04ca620362644c1572b256ca831896c488c5::market::Market<T0, T1>, arg1: &0xbe9a7d44698458aea5bcf0ebe57b04ca620362644c1572b256ca831896c488c5::config::Config, arg2: &0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::account::Account<T1>, arg3: &mut 0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::clearing_house::ClearingHouse<T1>, arg4: &0x9237337d846fc90b0a7acbdee4ab91809298691873d28e1d64d91e6303ff6ba4::price_feed_storage::PriceFeedStorage, arg5: &0x9237337d846fc90b0a7acbdee4ab91809298691873d28e1d64d91e6303ff6ba4::price_feed_storage::PriceFeedStorage, arg6: &0x2::clock::Clock) : u64 {
        0xbe9a7d44698458aea5bcf0ebe57b04ca620362644c1572b256ca831896c488c5::market::assert_config<T0, T1>(arg0, arg1);
        assert!(0x1::option::is_some<0xbe9a7d44698458aea5bcf0ebe57b04ca620362644c1572b256ca831896c488c5::custody::Vault<T1>>(0xbe9a7d44698458aea5bcf0ebe57b04ca620362644c1572b256ca831896c488c5::market::account<T0, T1>(arg0)), 300);
        let v0 = 0xbe9a7d44698458aea5bcf0ebe57b04ca620362644c1572b256ca831896c488c5::market::settings<T0, T1>(arg0);
        let (_, v2) = 0xbe9a7d44698458aea5bcf0ebe57b04ca620362644c1572b256ca831896c488c5::market::ages(&v0);
        let v3 = 0xbe9a7d44698458aea5bcf0ebe57b04ca620362644c1572b256ca831896c488c5::oracle::price<T1>(arg3, arg4, arg6, 0xbe9a7d44698458aea5bcf0ebe57b04ca620362644c1572b256ca831896c488c5::market::venue<T0, T1>(arg0), v2);
        0xbe9a7d44698458aea5bcf0ebe57b04ca620362644c1572b256ca831896c488c5::valuation::settle<T1>(0x1::option::borrow<0xbe9a7d44698458aea5bcf0ebe57b04ca620362644c1572b256ca831896c488c5::custody::Vault<T1>>(0xbe9a7d44698458aea5bcf0ebe57b04ca620362644c1572b256ca831896c488c5::market::account<T0, T1>(arg0)), arg2, arg3, arg4, arg5, arg6);
        let v4 = 0xbe9a7d44698458aea5bcf0ebe57b04ca620362644c1572b256ca831896c488c5::valuation::oracle_prices<T1>(arg3, arg4, arg5, arg6);
        store<T0, T1>(arg0, arg2, arg3, &v4, v3, arg6)
    }

    fun none(arg0: bool) : Fill {
        Fill{
            buy    : arg0,
            wanted : 0,
            filled : 0,
            spent  : 0,
            added  : 0,
        }
    }

    public fun open_account<T0, T1>(arg0: &mut 0xbe9a7d44698458aea5bcf0ebe57b04ca620362644c1572b256ca831896c488c5::market::Market<T0, T1>, arg1: &0xbe9a7d44698458aea5bcf0ebe57b04ca620362644c1572b256ca831896c488c5::config::Config, arg2: &mut 0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::registry::Registry, arg3: &mut 0x2::tx_context::TxContext) {
        0xbe9a7d44698458aea5bcf0ebe57b04ca620362644c1572b256ca831896c488c5::market::assert_config<T0, T1>(arg0, arg1);
        0xbe9a7d44698458aea5bcf0ebe57b04ca620362644c1572b256ca831896c488c5::market::open_venue_account<T0, T1>(arg0, arg2, arg3);
    }

    fun raise_cash<T0, T1>(arg0: &mut 0xbe9a7d44698458aea5bcf0ebe57b04ca620362644c1572b256ca831896c488c5::market::Market<T0, T1>, arg1: &mut 0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::account::Account<T1>, arg2: &mut 0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::clearing_house::ClearingHouse<T1>, arg3: &0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::registry::Registry, arg4: &0x9237337d846fc90b0a7acbdee4ab91809298691873d28e1d64d91e6303ff6ba4::price_feed_storage::PriceFeedStorage, arg5: &0x9237337d846fc90b0a7acbdee4ab91809298691873d28e1d64d91e6303ff6ba4::price_feed_storage::PriceFeedStorage, arg6: u64, arg7: u64, arg8: &0x2::clock::Clock, arg9: &mut 0x2::tx_context::TxContext) : u64 {
        let v0 = 0xbe9a7d44698458aea5bcf0ebe57b04ca620362644c1572b256ca831896c488c5::market::cash<T0, T1>(arg0);
        if (v0 >= arg7) {
            return 0
        };
        release<T0, T1>(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7 - v0, arg8, arg9)
    }

    fun release<T0, T1>(arg0: &mut 0xbe9a7d44698458aea5bcf0ebe57b04ca620362644c1572b256ca831896c488c5::market::Market<T0, T1>, arg1: &mut 0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::account::Account<T1>, arg2: &mut 0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::clearing_house::ClearingHouse<T1>, arg3: &0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::registry::Registry, arg4: &0x9237337d846fc90b0a7acbdee4ab91809298691873d28e1d64d91e6303ff6ba4::price_feed_storage::PriceFeedStorage, arg5: &0x9237337d846fc90b0a7acbdee4ab91809298691873d28e1d64d91e6303ff6ba4::price_feed_storage::PriceFeedStorage, arg6: u64, arg7: u64, arg8: &0x2::clock::Clock, arg9: &mut 0x2::tx_context::TxContext) : u64 {
        0xbe9a7d44698458aea5bcf0ebe57b04ca620362644c1572b256ca831896c488c5::custody::release_to_floor<T1>(0x1::option::borrow<0xbe9a7d44698458aea5bcf0ebe57b04ca620362644c1572b256ca831896c488c5::custody::Vault<T1>>(0xbe9a7d44698458aea5bcf0ebe57b04ca620362644c1572b256ca831896c488c5::market::account<T0, T1>(arg0)), arg1, arg2, arg4, arg5, 0x1::u64::max(arg6, 0xbe9a7d44698458aea5bcf0ebe57b04ca620362644c1572b256ca831896c488c5::custody::venue_floor_bps<T1>(arg2)), arg8);
        let v0 = 0xbe9a7d44698458aea5bcf0ebe57b04ca620362644c1572b256ca831896c488c5::custody::balance<T1>(0x1::option::borrow<0xbe9a7d44698458aea5bcf0ebe57b04ca620362644c1572b256ca831896c488c5::custody::Vault<T1>>(0xbe9a7d44698458aea5bcf0ebe57b04ca620362644c1572b256ca831896c488c5::market::account<T0, T1>(arg0)), arg1);
        let v1 = 0x1::u64::min(v0, arg7);
        if (v1 > 0) {
            0xbe9a7d44698458aea5bcf0ebe57b04ca620362644c1572b256ca831896c488c5::market::cash_in<T0, T1>(arg0, 0xbe9a7d44698458aea5bcf0ebe57b04ca620362644c1572b256ca831896c488c5::custody::withdraw<T1>(0x1::option::borrow<0xbe9a7d44698458aea5bcf0ebe57b04ca620362644c1572b256ca831896c488c5::custody::Vault<T1>>(0xbe9a7d44698458aea5bcf0ebe57b04ca620362644c1572b256ca831896c488c5::market::account<T0, T1>(arg0)), arg1, arg3, v1, arg9), 1);
        };
        if (v0 > v1) {
            0xbe9a7d44698458aea5bcf0ebe57b04ca620362644c1572b256ca831896c488c5::custody::allocate_margin<T1>(0x1::option::borrow<0xbe9a7d44698458aea5bcf0ebe57b04ca620362644c1572b256ca831896c488c5::custody::Vault<T1>>(0xbe9a7d44698458aea5bcf0ebe57b04ca620362644c1572b256ca831896c488c5::market::account<T0, T1>(arg0)), arg1, arg2, v0 - v1);
        };
        v1
    }

    public fun sell<T0, T1>(arg0: &mut 0xbe9a7d44698458aea5bcf0ebe57b04ca620362644c1572b256ca831896c488c5::market::Market<T0, T1>, arg1: &0xbe9a7d44698458aea5bcf0ebe57b04ca620362644c1572b256ca831896c488c5::config::Config, arg2: 0x2::coin::Coin<T0>, arg3: u64, arg4: &mut 0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::account::Account<T1>, arg5: 0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::clearing_house::ClearingHouse<T1>, arg6: &0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::registry::Registry, arg7: &0x9237337d846fc90b0a7acbdee4ab91809298691873d28e1d64d91e6303ff6ba4::price_feed_storage::PriceFeedStorage, arg8: &0x9237337d846fc90b0a7acbdee4ab91809298691873d28e1d64d91e6303ff6ba4::price_feed_storage::PriceFeedStorage, arg9: &0x2::clock::Clock, arg10: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T1>, 0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::clearing_house::ClearingHouse<T1>) {
        0xbe9a7d44698458aea5bcf0ebe57b04ca620362644c1572b256ca831896c488c5::market::assert_config<T0, T1>(arg0, arg1);
        let v0 = 0xbe9a7d44698458aea5bcf0ebe57b04ca620362644c1572b256ca831896c488c5::market::settings<T0, T1>(arg0);
        let (_, v2) = 0xbe9a7d44698458aea5bcf0ebe57b04ca620362644c1572b256ca831896c488c5::market::ages(&v0);
        let v3 = 0xbe9a7d44698458aea5bcf0ebe57b04ca620362644c1572b256ca831896c488c5::oracle::feed_price<T1>(&arg5, arg7, arg9, 0xbe9a7d44698458aea5bcf0ebe57b04ca620362644c1572b256ca831896c488c5::market::venue<T0, T1>(arg0), v2);
        let v4 = 0x2::clock::timestamp_ms(arg9);
        let v5 = 0x2::coin::value<T0>(&arg2);
        let v6 = 0;
        let v7 = if (0xbe9a7d44698458aea5bcf0ebe57b04ca620362644c1572b256ca831896c488c5::market::state<T0, T1>(arg0) == 0) {
            if (0x1::option::is_some<0xbe9a7d44698458aea5bcf0ebe57b04ca620362644c1572b256ca831896c488c5::custody::Vault<T1>>(0xbe9a7d44698458aea5bcf0ebe57b04ca620362644c1572b256ca831896c488c5::market::account<T0, T1>(arg0))) {
                0xbe9a7d44698458aea5bcf0ebe57b04ca620362644c1572b256ca831896c488c5::oracle::venue_tradable<T1>(&arg5, arg7, arg8, arg9)
            } else {
                false
            }
        } else {
            false
        };
        if (v7) {
            let (v8, _) = 0xbe9a7d44698458aea5bcf0ebe57b04ca620362644c1572b256ca831896c488c5::market::decimals<T0, T1>(arg0);
            let (_, _, _, v13) = 0xbe9a7d44698458aea5bcf0ebe57b04ca620362644c1572b256ca831896c488c5::market::hedge_rules(&v0);
            0xbe9a7d44698458aea5bcf0ebe57b04ca620362644c1572b256ca831896c488c5::valuation::settle<T1>(0x1::option::borrow<0xbe9a7d44698458aea5bcf0ebe57b04ca620362644c1572b256ca831896c488c5::custody::Vault<T1>>(0xbe9a7d44698458aea5bcf0ebe57b04ca620362644c1572b256ca831896c488c5::market::account<T0, T1>(arg0)), arg4, &mut arg5, arg7, arg8, arg9);
            let v14 = to_b9(0xbe9a7d44698458aea5bcf0ebe57b04ca620362644c1572b256ca831896c488c5::math::sat_sub(0xbe9a7d44698458aea5bcf0ebe57b04ca620362644c1572b256ca831896c488c5::market::supply<T0, T1>(arg0), v5), v8);
            let v15 = if (held_b9<T1>(&arg5, arg4) > v14) {
                let (v16, v17) = step<T0, T1>(arg0, arg4, arg5, arg6, arg7, arg8, v3, v14, 0, 0xbe9a7d44698458aea5bcf0ebe57b04ca620362644c1572b256ca831896c488c5::market::trade_slippage_bps(&v0), arg9, arg10);
                arg5 = v16;
                v17
            } else {
                none(false)
            };
            let v18 = v15;
            let v19 = &mut arg5;
            let v20 = bring_home<T0, T1>(arg0, arg4, v19, arg6, arg7, arg8, v13, v3, arg9, arg10);
            let v21 = 0xbe9a7d44698458aea5bcf0ebe57b04ca620362644c1572b256ca831896c488c5::valuation::oracle_prices<T1>(&arg5, arg7, arg8, arg9);
            let v22 = store<T0, T1>(arg0, arg4, &arg5, &v21, v3, arg9);
            let v23 = cost_of(&v18, to_b9(v5, v8));
            v6 = v23;
            let v24 = 0xbe9a7d44698458aea5bcf0ebe57b04ca620362644c1572b256ca831896c488c5::math::sat_sub(0xbe9a7d44698458aea5bcf0ebe57b04ca620362644c1572b256ca831896c488c5::market::sale_payout<T0, T1>(arg0, v5, v3, v4), v23);
            let v25 = &mut arg5;
            let v26 = raise_cash<T0, T1>(arg0, arg4, v25, arg6, arg7, arg8, v13, v24, arg9, arg10);
            if (v26 > 0) {
                store<T0, T1>(arg0, arg4, &arg5, &v21, v3, arg9);
            };
            if (v20 + v26 > 0) {
                let v27 = MarginMoved{
                    schema   : 0xbe9a7d44698458aea5bcf0ebe57b04ca620362644c1572b256ca831896c488c5::config::schema(),
                    market   : 0x2::object::id<0xbe9a7d44698458aea5bcf0ebe57b04ca620362644c1572b256ca831896c488c5::market::Market<T0, T1>>(arg0),
                    added    : 0,
                    returned : v20 + v26,
                };
                0x2::event::emit<MarginMoved>(v27);
            };
            emit_synced<T0, T1>(arg0, 2, &v18, v23, held_b9<T1>(&arg5, arg4), v14, v3, v22);
        };
        (0xbe9a7d44698458aea5bcf0ebe57b04ca620362644c1572b256ca831896c488c5::market::sell_costed<T0, T1>(arg0, arg2, arg3, v3, v6, v4, arg10), arg5)
    }

    fun step<T0, T1>(arg0: &mut 0xbe9a7d44698458aea5bcf0ebe57b04ca620362644c1572b256ca831896c488c5::market::Market<T0, T1>, arg1: &mut 0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::account::Account<T1>, arg2: 0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::clearing_house::ClearingHouse<T1>, arg3: &0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::registry::Registry, arg4: &0x9237337d846fc90b0a7acbdee4ab91809298691873d28e1d64d91e6303ff6ba4::price_feed_storage::PriceFeedStorage, arg5: &0x9237337d846fc90b0a7acbdee4ab91809298691873d28e1d64d91e6303ff6ba4::price_feed_storage::PriceFeedStorage, arg6: u256, arg7: u64, arg8: u64, arg9: u64, arg10: &0x2::clock::Clock, arg11: &mut 0x2::tx_context::TxContext) : (0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::clearing_house::ClearingHouse<T1>, Fill) {
        let v0 = 0xbe9a7d44698458aea5bcf0ebe57b04ca620362644c1572b256ca831896c488c5::market::settings<T0, T1>(arg0);
        let (_, _, _, v4) = 0xbe9a7d44698458aea5bcf0ebe57b04ca620362644c1572b256ca831896c488c5::market::hedge_rules(&v0);
        let (v5, v6) = 0xbe9a7d44698458aea5bcf0ebe57b04ca620362644c1572b256ca831896c488c5::market::decimals<T0, T1>(arg0);
        let v7 = 0xbe9a7d44698458aea5bcf0ebe57b04ca620362644c1572b256ca831896c488c5::valuation::oracle_prices<T1>(&arg2, arg4, arg5, arg10);
        let v8 = 0xbe9a7d44698458aea5bcf0ebe57b04ca620362644c1572b256ca831896c488c5::valuation::mark(&v7);
        let v9 = 0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::market::lot_size(0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::clearing_house::market_params<T1>(&arg2));
        let v10 = held_b9<T1>(&arg2, arg1);
        let v11 = arg7 > v10;
        let v12 = if (v11) {
            arg7 - v10
        } else {
            v10 - arg7
        };
        let v13 = v12 / v9 * v9;
        let v14 = v13;
        if (arg8 > 0) {
            v14 = 0x1::u64::min(v13, 0xbe9a7d44698458aea5bcf0ebe57b04ca620362644c1572b256ca831896c488c5::lev_math::order_size(arg8, v8, v9));
        };
        if (v14 == 0 || below_min_order<T1>(&arg2, v14, v8)) {
            v14 = 0;
        };
        let v15 = equity<T1>(0x1::option::borrow<0xbe9a7d44698458aea5bcf0ebe57b04ca620362644c1572b256ca831896c488c5::custody::Vault<T1>>(0xbe9a7d44698458aea5bcf0ebe57b04ca620362644c1572b256ca831896c488c5::market::account<T0, T1>(arg0)), arg1, &arg2, &v7);
        let v16 = 0;
        if (v14 > 0 && v11) {
            let v17 = 0xbe9a7d44698458aea5bcf0ebe57b04ca620362644c1572b256ca831896c488c5::math::value_up(from_b9(v14, v5), arg6, v5, v6);
            let v18 = 0xbe9a7d44698458aea5bcf0ebe57b04ca620362644c1572b256ca831896c488c5::math::share_up(v17, v4) + 0xbe9a7d44698458aea5bcf0ebe57b04ca620362644c1572b256ca831896c488c5::math::share_up(v17, 200) + 1;
            let v19 = 0x1::u64::min(v18, 0xbe9a7d44698458aea5bcf0ebe57b04ca620362644c1572b256ca831896c488c5::market::spare_cash<T0, T1>(arg0, arg6));
            v16 = v19;
            if (v19 < v18) {
                let v20 = (((v14 as u256) * (v19 as u256) / (v18 as u256)) as u64) / v9;
                v14 = v20 * v9;
            };
            let v21 = if (v14 > 0) {
                if (!below_min_order<T1>(&arg2, v14, v8)) {
                    v19 > 0
                } else {
                    false
                }
            } else {
                false
            };
            if (v21) {
                let v22 = 0x1::option::borrow<0xbe9a7d44698458aea5bcf0ebe57b04ca620362644c1572b256ca831896c488c5::custody::Vault<T1>>(0xbe9a7d44698458aea5bcf0ebe57b04ca620362644c1572b256ca831896c488c5::market::account<T0, T1>(arg0));
                0xbe9a7d44698458aea5bcf0ebe57b04ca620362644c1572b256ca831896c488c5::custody::deposit<T1>(v22, arg1, arg3, 0xbe9a7d44698458aea5bcf0ebe57b04ca620362644c1572b256ca831896c488c5::market::cash_out<T0, T1>(arg0, v19, 1, arg11));
                0xbe9a7d44698458aea5bcf0ebe57b04ca620362644c1572b256ca831896c488c5::custody::configure_margin<T1>(v22, arg1, &mut arg2, 0x1::u64::max(v4, 0xbe9a7d44698458aea5bcf0ebe57b04ca620362644c1572b256ca831896c488c5::custody::venue_floor_bps<T1>(&arg2)));
            } else {
                v16 = 0;
                v14 = 0;
            };
        };
        if (v14 > 0) {
            let v23 = 0xbe9a7d44698458aea5bcf0ebe57b04ca620362644c1572b256ca831896c488c5::lev_math::limit_price(v8, arg9, v11, 0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::market::tick_size(0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::clearing_house::market_params<T1>(&arg2)));
            let v24 = arg2;
            arg2 = 0xbe9a7d44698458aea5bcf0ebe57b04ca620362644c1572b256ca831896c488c5::custody::trade_limit<T1>(0x1::option::borrow<0xbe9a7d44698458aea5bcf0ebe57b04ca620362644c1572b256ca831896c488c5::custody::Vault<T1>>(0xbe9a7d44698458aea5bcf0ebe57b04ca620362644c1572b256ca831896c488c5::market::account<T0, T1>(arg0)), arg1, v24, arg4, arg5, !v11, v14, v23, !v11, arg10, arg11);
        };
        let v25 = held_b9<T1>(&arg2, arg1);
        let v26 = if (v25 > v10) {
            v25 - v10
        } else {
            v10 - v25
        };
        let v27 = 0xbe9a7d44698458aea5bcf0ebe57b04ca620362644c1572b256ca831896c488c5::math::sat_sub(v15 + v16, equity<T1>(0x1::option::borrow<0xbe9a7d44698458aea5bcf0ebe57b04ca620362644c1572b256ca831896c488c5::custody::Vault<T1>>(0xbe9a7d44698458aea5bcf0ebe57b04ca620362644c1572b256ca831896c488c5::market::account<T0, T1>(arg0)), arg1, &arg2, &v7));
        assert!(v27 <= 0xbe9a7d44698458aea5bcf0ebe57b04ca620362644c1572b256ca831896c488c5::math::share_up(0xbe9a7d44698458aea5bcf0ebe57b04ca620362644c1572b256ca831896c488c5::math::value_up(from_b9(v26, v5), arg6, v5, v6), arg9 + 15) + 1, 303);
        let v28 = Fill{
            buy    : v11,
            wanted : v14,
            filled : v26,
            spent  : v27,
            added  : v16,
        };
        (arg2, v28)
    }

    fun store<T0, T1>(arg0: &mut 0xbe9a7d44698458aea5bcf0ebe57b04ca620362644c1572b256ca831896c488c5::market::Market<T0, T1>, arg1: &0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::account::Account<T1>, arg2: &0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::clearing_house::ClearingHouse<T1>, arg3: &0xbe9a7d44698458aea5bcf0ebe57b04ca620362644c1572b256ca831896c488c5::valuation::Prices, arg4: u256, arg5: &0x2::clock::Clock) : u64 {
        let (v0, _) = 0xbe9a7d44698458aea5bcf0ebe57b04ca620362644c1572b256ca831896c488c5::market::decimals<T0, T1>(arg0);
        let v2 = equity<T1>(0x1::option::borrow<0xbe9a7d44698458aea5bcf0ebe57b04ca620362644c1572b256ca831896c488c5::custody::Vault<T1>>(0xbe9a7d44698458aea5bcf0ebe57b04ca620362644c1572b256ca831896c488c5::market::account<T0, T1>(arg0)), arg1, arg2, arg3);
        0xbe9a7d44698458aea5bcf0ebe57b04ca620362644c1572b256ca831896c488c5::market::set_hedge_mark<T0, T1>(arg0, v2, from_b9(held_b9<T1>(arg2, arg1), v0), arg4, 0x2::clock::timestamp_ms(arg5));
        v2
    }

    public fun sync<T0, T1>(arg0: &mut 0xbe9a7d44698458aea5bcf0ebe57b04ca620362644c1572b256ca831896c488c5::market::Market<T0, T1>, arg1: &0xbe9a7d44698458aea5bcf0ebe57b04ca620362644c1572b256ca831896c488c5::config::Config, arg2: &mut 0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::account::Account<T1>, arg3: 0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::clearing_house::ClearingHouse<T1>, arg4: &0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::registry::Registry, arg5: &0x9237337d846fc90b0a7acbdee4ab91809298691873d28e1d64d91e6303ff6ba4::price_feed_storage::PriceFeedStorage, arg6: &0x9237337d846fc90b0a7acbdee4ab91809298691873d28e1d64d91e6303ff6ba4::price_feed_storage::PriceFeedStorage, arg7: &0x2::clock::Clock, arg8: &mut 0x2::tx_context::TxContext) : 0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::clearing_house::ClearingHouse<T1> {
        0xbe9a7d44698458aea5bcf0ebe57b04ca620362644c1572b256ca831896c488c5::market::assert_config<T0, T1>(arg0, arg1);
        0xbe9a7d44698458aea5bcf0ebe57b04ca620362644c1572b256ca831896c488c5::config::assert_keeper(arg1, arg8);
        assert!(0x1::option::is_some<0xbe9a7d44698458aea5bcf0ebe57b04ca620362644c1572b256ca831896c488c5::custody::Vault<T1>>(0xbe9a7d44698458aea5bcf0ebe57b04ca620362644c1572b256ca831896c488c5::market::account<T0, T1>(arg0)), 300);
        let v0 = 0xbe9a7d44698458aea5bcf0ebe57b04ca620362644c1572b256ca831896c488c5::market::settings<T0, T1>(arg0);
        let (v1, v2, v3, v4) = 0xbe9a7d44698458aea5bcf0ebe57b04ca620362644c1572b256ca831896c488c5::market::hedge_rules(&v0);
        let (_, v6) = 0xbe9a7d44698458aea5bcf0ebe57b04ca620362644c1572b256ca831896c488c5::market::ages(&v0);
        let v7 = 0xbe9a7d44698458aea5bcf0ebe57b04ca620362644c1572b256ca831896c488c5::oracle::price<T1>(&arg3, arg5, arg7, 0xbe9a7d44698458aea5bcf0ebe57b04ca620362644c1572b256ca831896c488c5::market::venue<T0, T1>(arg0), v6);
        let (v8, v9) = 0xbe9a7d44698458aea5bcf0ebe57b04ca620362644c1572b256ca831896c488c5::market::decimals<T0, T1>(arg0);
        0xbe9a7d44698458aea5bcf0ebe57b04ca620362644c1572b256ca831896c488c5::valuation::settle<T1>(0x1::option::borrow<0xbe9a7d44698458aea5bcf0ebe57b04ca620362644c1572b256ca831896c488c5::custody::Vault<T1>>(0xbe9a7d44698458aea5bcf0ebe57b04ca620362644c1572b256ca831896c488c5::market::account<T0, T1>(arg0)), arg2, &mut arg3, arg5, arg6, arg7);
        let v10 = held_b9<T1>(&arg3, arg2);
        let v11 = to_b9(0xbe9a7d44698458aea5bcf0ebe57b04ca620362644c1572b256ca831896c488c5::market::hedge_target<T0, T1>(arg0), v8);
        let v12 = if (v11 > v10) {
            v11 - v10
        } else {
            v10 - v11
        };
        let v13 = if (v11 > 0 && 0xbe9a7d44698458aea5bcf0ebe57b04ca620362644c1572b256ca831896c488c5::math::value_down(from_b9(v12, v8), v7, v8, v9) < 0xbe9a7d44698458aea5bcf0ebe57b04ca620362644c1572b256ca831896c488c5::math::share_down(0xbe9a7d44698458aea5bcf0ebe57b04ca620362644c1572b256ca831896c488c5::market::owed_at<T0, T1>(arg0, v7), v1)) {
            v10
        } else {
            v11
        };
        let (v14, v15) = step<T0, T1>(arg0, arg2, arg3, arg4, arg5, arg6, v7, v13, to_usd_e6(v2, v9), v3, arg7, arg8);
        let v16 = v15;
        arg3 = v14;
        let v17 = &mut arg3;
        let v18 = bring_home<T0, T1>(arg0, arg2, v17, arg4, arg5, arg6, v4, v7, arg7, arg8);
        if (v16.added > 0 || v18 > 0) {
            let v19 = MarginMoved{
                schema   : 0xbe9a7d44698458aea5bcf0ebe57b04ca620362644c1572b256ca831896c488c5::config::schema(),
                market   : 0x2::object::id<0xbe9a7d44698458aea5bcf0ebe57b04ca620362644c1572b256ca831896c488c5::market::Market<T0, T1>>(arg0),
                added    : v16.added,
                returned : v18,
            };
            0x2::event::emit<MarginMoved>(v19);
        };
        let v20 = 0xbe9a7d44698458aea5bcf0ebe57b04ca620362644c1572b256ca831896c488c5::valuation::oracle_prices<T1>(&arg3, arg5, arg6, arg7);
        let v21 = store<T0, T1>(arg0, arg2, &arg3, &v20, v7, arg7);
        emit_synced<T0, T1>(arg0, 0, &v16, v16.spent, held_b9<T1>(&arg3, arg2), v11, v7, v21);
        arg3
    }

    fun to_b9(arg0: u64, arg1: u8) : u64 {
        (((arg0 as u256) * 0xbe9a7d44698458aea5bcf0ebe57b04ca620362644c1572b256ca831896c488c5::math::pow10(9 - arg1)) as u64)
    }

    fun to_usd_e6(arg0: u64, arg1: u8) : u64 {
        if (arg1 >= 6) {
            (((arg0 as u256) / 0xbe9a7d44698458aea5bcf0ebe57b04ca620362644c1572b256ca831896c488c5::math::pow10(arg1 - 6)) as u64)
        } else {
            (((arg0 as u256) * 0xbe9a7d44698458aea5bcf0ebe57b04ca620362644c1572b256ca831896c488c5::math::pow10(6 - arg1)) as u64)
        }
    }

    // decompiled from Move bytecode v7
}

