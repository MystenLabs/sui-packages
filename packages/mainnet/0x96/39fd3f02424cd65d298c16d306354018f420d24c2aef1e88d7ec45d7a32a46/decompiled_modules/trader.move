module 0xa0e3b011012b80af4957afa30e556486eb3da0a7d96eeb733cf16ccd3aec32e0::trader {
    struct ChargeMaintainerFeeEvent has copy, drop {
        pool_id: 0x2::object::ID,
        maintainer: address,
        is_base_coin: bool,
        amount: u64,
        base_quote_price: u64,
        quote_usd_price: u64,
        trade_num: u64,
    }

    struct SellBaseTokenEvent has copy, drop {
        pool_id: 0x2::object::ID,
        seller: address,
        pay_base: u64,
        receive_quote: u64,
        base_quote_price: u64,
        quote_usd_price: u64,
        trade_num: u64,
    }

    struct BuyBaseTokenEvent has copy, drop {
        pool_id: 0x2::object::ID,
        buyer: address,
        receive_base: u64,
        pay_quote: u64,
        base_quote_price: u64,
        quote_usd_price: u64,
        trade_num: u64,
    }

    public fun query_buy_base_coin<T0, T1>(arg0: &0xa0e3b011012b80af4957afa30e556486eb3da0a7d96eeb733cf16ccd3aec32e0::oracle_driven_pool::Pool<T0, T1>, arg1: &0x2::clock::Clock, arg2: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg3: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg4: u64) : u64 {
        let (v0, v1) = 0xa0e3b011012b80af4957afa30e556486eb3da0a7d96eeb733cf16ccd3aec32e0::oracle_driven_pool::get_price_id<T0, T1>(arg0);
        let (_, v3, _, _) = 0xa0e3b011012b80af4957afa30e556486eb3da0a7d96eeb733cf16ccd3aec32e0::oracle::calculate_pyth_primitive_prices(v0, v1, arg1, arg2, arg3, 0xa0e3b011012b80af4957afa30e556486eb3da0a7d96eeb733cf16ccd3aec32e0::oracle_driven_pool::get_base_coin_decimals<T0, T1>(arg0), 0xa0e3b011012b80af4957afa30e556486eb3da0a7d96eeb733cf16ccd3aec32e0::oracle_driven_pool::get_quote_coin_decimals<T0, T1>(arg0), 0xa0e3b011012b80af4957afa30e556486eb3da0a7d96eeb733cf16ccd3aec32e0::oracle_driven_pool::get_base_usd_price_age<T0, T1>(arg0), 0xa0e3b011012b80af4957afa30e556486eb3da0a7d96eeb733cf16ccd3aec32e0::oracle_driven_pool::get_quote_usd_price_age<T0, T1>(arg0));
        query_buy_base_coin_internal<T0, T1>(arg0, v3, arg4)
    }

    public fun query_sell_base_coin<T0, T1>(arg0: &0xa0e3b011012b80af4957afa30e556486eb3da0a7d96eeb733cf16ccd3aec32e0::oracle_driven_pool::Pool<T0, T1>, arg1: &0x2::clock::Clock, arg2: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg3: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg4: u64) : u64 {
        let (v0, v1) = 0xa0e3b011012b80af4957afa30e556486eb3da0a7d96eeb733cf16ccd3aec32e0::oracle_driven_pool::get_price_id<T0, T1>(arg0);
        let (v2, _, _, _) = 0xa0e3b011012b80af4957afa30e556486eb3da0a7d96eeb733cf16ccd3aec32e0::oracle::calculate_pyth_primitive_prices(v0, v1, arg1, arg2, arg3, 0xa0e3b011012b80af4957afa30e556486eb3da0a7d96eeb733cf16ccd3aec32e0::oracle_driven_pool::get_base_coin_decimals<T0, T1>(arg0), 0xa0e3b011012b80af4957afa30e556486eb3da0a7d96eeb733cf16ccd3aec32e0::oracle_driven_pool::get_quote_coin_decimals<T0, T1>(arg0), 0xa0e3b011012b80af4957afa30e556486eb3da0a7d96eeb733cf16ccd3aec32e0::oracle_driven_pool::get_base_usd_price_age<T0, T1>(arg0), 0xa0e3b011012b80af4957afa30e556486eb3da0a7d96eeb733cf16ccd3aec32e0::oracle_driven_pool::get_quote_usd_price_age<T0, T1>(arg0));
        query_sell_base_coin_internal<T0, T1>(arg0, v2, arg4)
    }

    public fun query_sell_quote_coin<T0, T1>(arg0: &0xa0e3b011012b80af4957afa30e556486eb3da0a7d96eeb733cf16ccd3aec32e0::oracle_driven_pool::Pool<T0, T1>, arg1: &0x2::clock::Clock, arg2: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg3: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg4: u64) : u64 {
        let (v0, v1) = 0xa0e3b011012b80af4957afa30e556486eb3da0a7d96eeb733cf16ccd3aec32e0::oracle_driven_pool::get_price_id<T0, T1>(arg0);
        let (v2, v3, _, _) = 0xa0e3b011012b80af4957afa30e556486eb3da0a7d96eeb733cf16ccd3aec32e0::oracle::calculate_pyth_primitive_prices(v0, v1, arg1, arg2, arg3, 0xa0e3b011012b80af4957afa30e556486eb3da0a7d96eeb733cf16ccd3aec32e0::oracle_driven_pool::get_base_coin_decimals<T0, T1>(arg0), 0xa0e3b011012b80af4957afa30e556486eb3da0a7d96eeb733cf16ccd3aec32e0::oracle_driven_pool::get_quote_coin_decimals<T0, T1>(arg0), 0xa0e3b011012b80af4957afa30e556486eb3da0a7d96eeb733cf16ccd3aec32e0::oracle_driven_pool::get_base_usd_price_age<T0, T1>(arg0), 0xa0e3b011012b80af4957afa30e556486eb3da0a7d96eeb733cf16ccd3aec32e0::oracle_driven_pool::get_quote_usd_price_age<T0, T1>(arg0));
        query_sell_quote_coin_internal<T0, T1>(arg0, v2, v3, arg4)
    }

    public fun buy_base_coin<T0, T1>(arg0: &mut 0xa0e3b011012b80af4957afa30e556486eb3da0a7d96eeb733cf16ccd3aec32e0::oracle_driven_pool::Pool<T0, T1>, arg1: &0x2::clock::Clock, arg2: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg3: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg4: &mut 0x2::coin::Coin<T1>, arg5: u64, arg6: u64, arg7: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        0xa0e3b011012b80af4957afa30e556486eb3da0a7d96eeb733cf16ccd3aec32e0::oracle_driven_pool::assert_version<T0, T1>(arg0);
        let (v0, v1) = 0xa0e3b011012b80af4957afa30e556486eb3da0a7d96eeb733cf16ccd3aec32e0::oracle_driven_pool::get_price_id<T0, T1>(arg0);
        let (v2, _, v4, v5) = 0xa0e3b011012b80af4957afa30e556486eb3da0a7d96eeb733cf16ccd3aec32e0::oracle::calculate_pyth_primitive_prices(v0, v1, arg1, arg2, arg3, 0xa0e3b011012b80af4957afa30e556486eb3da0a7d96eeb733cf16ccd3aec32e0::oracle_driven_pool::get_base_coin_decimals<T0, T1>(arg0), 0xa0e3b011012b80af4957afa30e556486eb3da0a7d96eeb733cf16ccd3aec32e0::oracle_driven_pool::get_quote_coin_decimals<T0, T1>(arg0), 0xa0e3b011012b80af4957afa30e556486eb3da0a7d96eeb733cf16ccd3aec32e0::oracle_driven_pool::get_base_usd_price_age<T0, T1>(arg0), 0xa0e3b011012b80af4957afa30e556486eb3da0a7d96eeb733cf16ccd3aec32e0::oracle_driven_pool::get_quote_usd_price_age<T0, T1>(arg0));
        0xa0e3b011012b80af4957afa30e556486eb3da0a7d96eeb733cf16ccd3aec32e0::oracle_driven_pool::set_prices<T0, T1>(arg0, v4, v5);
        buy_base_coin_internal<T0, T1>(arg0, v2, arg4, arg5, arg6, arg7)
    }

    fun buy_base_coin_internal<T0, T1>(arg0: &mut 0xa0e3b011012b80af4957afa30e556486eb3da0a7d96eeb733cf16ccd3aec32e0::oracle_driven_pool::Pool<T0, T1>, arg1: u64, arg2: &mut 0x2::coin::Coin<T1>, arg3: u64, arg4: u64, arg5: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        0xa0e3b011012b80af4957afa30e556486eb3da0a7d96eeb733cf16ccd3aec32e0::oracle_driven_pool::assert_trade_allowed<T0, T1>(arg0);
        0xa0e3b011012b80af4957afa30e556486eb3da0a7d96eeb733cf16ccd3aec32e0::oracle_driven_pool::assert_buying_allowed<T0, T1>(arg0);
        0xa0e3b011012b80af4957afa30e556486eb3da0a7d96eeb733cf16ccd3aec32e0::oracle_driven_pool::increase_trade_num<T0, T1>(arg0);
        let (v0, v1, v2, v3, v4, v5) = 0xa0e3b011012b80af4957afa30e556486eb3da0a7d96eeb733cf16ccd3aec32e0::oracle_driven_pool::query_buy_base_coin<T0, T1>(arg0, arg1, arg3);
        assert!(v0 != 0, 3);
        assert!(v0 <= arg4, 2);
        0xa0e3b011012b80af4957afa30e556486eb3da0a7d96eeb733cf16ccd3aec32e0::oracle_driven_pool::quote_coin_pay_in<T0, T1>(arg0, 0x2::balance::split<T1>(0x2::coin::balance_mut<T1>(arg2), v0));
        let v6 = 0xa0e3b011012b80af4957afa30e556486eb3da0a7d96eeb733cf16ccd3aec32e0::oracle_driven_pool::get_trade_num<T0, T1>(arg0);
        if (v2 != 0) {
            let v7 = 0xa0e3b011012b80af4957afa30e556486eb3da0a7d96eeb733cf16ccd3aec32e0::oracle_driven_pool::get_maintainer<T0, T1>(arg0);
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0xa0e3b011012b80af4957afa30e556486eb3da0a7d96eeb733cf16ccd3aec32e0::oracle_driven_pool::base_coin_pay_out<T0, T1>(arg0, v2, arg5), v7);
            let v8 = ChargeMaintainerFeeEvent{
                pool_id          : 0x2::object::id<0xa0e3b011012b80af4957afa30e556486eb3da0a7d96eeb733cf16ccd3aec32e0::oracle_driven_pool::Pool<T0, T1>>(arg0),
                maintainer       : v7,
                is_base_coin     : true,
                amount           : v2,
                base_quote_price : arg1,
                quote_usd_price  : 0xa0e3b011012b80af4957afa30e556486eb3da0a7d96eeb733cf16ccd3aec32e0::oracle_driven_pool::get_quote_usd_price<T0, T1>(arg0),
                trade_num        : v6,
            };
            0x2::event::emit<ChargeMaintainerFeeEvent>(v8);
        };
        0xa0e3b011012b80af4957afa30e556486eb3da0a7d96eeb733cf16ccd3aec32e0::oracle_driven_pool::set_target_base_coin_amount<T0, T1>(arg0, v5);
        0xa0e3b011012b80af4957afa30e556486eb3da0a7d96eeb733cf16ccd3aec32e0::oracle_driven_pool::set_target_quote_coin_amount<T0, T1>(arg0, v4);
        0xa0e3b011012b80af4957afa30e556486eb3da0a7d96eeb733cf16ccd3aec32e0::oracle_driven_pool::set_r_status<T0, T1>(arg0, v3);
        0xa0e3b011012b80af4957afa30e556486eb3da0a7d96eeb733cf16ccd3aec32e0::oracle_driven_pool::donate_base_coin<T0, T1>(arg0, v1, true, v6);
        let v9 = BuyBaseTokenEvent{
            pool_id          : 0x2::object::id<0xa0e3b011012b80af4957afa30e556486eb3da0a7d96eeb733cf16ccd3aec32e0::oracle_driven_pool::Pool<T0, T1>>(arg0),
            buyer            : 0x2::tx_context::sender(arg5),
            receive_base     : arg3,
            pay_quote        : v0,
            base_quote_price : arg1,
            quote_usd_price  : 0xa0e3b011012b80af4957afa30e556486eb3da0a7d96eeb733cf16ccd3aec32e0::oracle_driven_pool::get_quote_usd_price<T0, T1>(arg0),
            trade_num        : v6,
        };
        0x2::event::emit<BuyBaseTokenEvent>(v9);
        0xa0e3b011012b80af4957afa30e556486eb3da0a7d96eeb733cf16ccd3aec32e0::oracle_driven_pool::base_coin_pay_out<T0, T1>(arg0, arg3, arg5)
    }

    public entry fun entry_buy_base_coin<T0, T1>(arg0: &mut 0xa0e3b011012b80af4957afa30e556486eb3da0a7d96eeb733cf16ccd3aec32e0::oracle_driven_pool::Pool<T0, T1>, arg1: &0x2::clock::Clock, arg2: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg3: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg4: &mut 0x2::coin::Coin<T1>, arg5: u64, arg6: u64, arg7: &mut 0x2::tx_context::TxContext) {
        let v0 = buy_base_coin<T0, T1>(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(v0, 0x2::tx_context::sender(arg7));
    }

    public entry fun entry_sell_base_coin<T0, T1>(arg0: &mut 0xa0e3b011012b80af4957afa30e556486eb3da0a7d96eeb733cf16ccd3aec32e0::oracle_driven_pool::Pool<T0, T1>, arg1: &0x2::clock::Clock, arg2: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg3: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg4: &mut 0x2::coin::Coin<T0>, arg5: u64, arg6: u64, arg7: &mut 0x2::tx_context::TxContext) {
        let v0 = sell_base_coin<T0, T1>(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7);
        0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(v0, 0x2::tx_context::sender(arg7));
    }

    public entry fun entry_sell_quote_coin<T0, T1>(arg0: &mut 0xa0e3b011012b80af4957afa30e556486eb3da0a7d96eeb733cf16ccd3aec32e0::oracle_driven_pool::Pool<T0, T1>, arg1: &0x2::clock::Clock, arg2: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg3: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg4: &mut 0x2::coin::Coin<T1>, arg5: u64, arg6: u64, arg7: &mut 0x2::tx_context::TxContext) {
        let v0 = sell_quote_coin<T0, T1>(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(v0, 0x2::tx_context::sender(arg7));
    }

    public fun get_mid_price<T0, T1>(arg0: &0xa0e3b011012b80af4957afa30e556486eb3da0a7d96eeb733cf16ccd3aec32e0::oracle_driven_pool::Pool<T0, T1>, arg1: &0x2::clock::Clock, arg2: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg3: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject) : u64 {
        let (v0, v1) = 0xa0e3b011012b80af4957afa30e556486eb3da0a7d96eeb733cf16ccd3aec32e0::oracle_driven_pool::get_price_id<T0, T1>(arg0);
        let (v2, _, _, _) = 0xa0e3b011012b80af4957afa30e556486eb3da0a7d96eeb733cf16ccd3aec32e0::oracle::calculate_pyth_primitive_prices(v0, v1, arg1, arg2, arg3, 0xa0e3b011012b80af4957afa30e556486eb3da0a7d96eeb733cf16ccd3aec32e0::oracle_driven_pool::get_base_coin_decimals<T0, T1>(arg0), 0xa0e3b011012b80af4957afa30e556486eb3da0a7d96eeb733cf16ccd3aec32e0::oracle_driven_pool::get_quote_coin_decimals<T0, T1>(arg0), 0xa0e3b011012b80af4957afa30e556486eb3da0a7d96eeb733cf16ccd3aec32e0::oracle_driven_pool::get_base_usd_price_age<T0, T1>(arg0), 0xa0e3b011012b80af4957afa30e556486eb3da0a7d96eeb733cf16ccd3aec32e0::oracle_driven_pool::get_quote_usd_price_age<T0, T1>(arg0));
        0xa0e3b011012b80af4957afa30e556486eb3da0a7d96eeb733cf16ccd3aec32e0::oracle_driven_pool::get_mid_price_internal<T0, T1>(arg0, v2)
    }

    public(friend) fun query_buy_base_coin_internal<T0, T1>(arg0: &0xa0e3b011012b80af4957afa30e556486eb3da0a7d96eeb733cf16ccd3aec32e0::oracle_driven_pool::Pool<T0, T1>, arg1: u64, arg2: u64) : u64 {
        let (v0, _, _, _, _, _) = 0xa0e3b011012b80af4957afa30e556486eb3da0a7d96eeb733cf16ccd3aec32e0::oracle_driven_pool::query_buy_base_coin<T0, T1>(arg0, arg1, arg2);
        v0
    }

    public(friend) fun query_sell_base_coin_internal<T0, T1>(arg0: &0xa0e3b011012b80af4957afa30e556486eb3da0a7d96eeb733cf16ccd3aec32e0::oracle_driven_pool::Pool<T0, T1>, arg1: u64, arg2: u64) : u64 {
        let (v0, _, _, _, _, _) = 0xa0e3b011012b80af4957afa30e556486eb3da0a7d96eeb733cf16ccd3aec32e0::oracle_driven_pool::query_sell_base_coin<T0, T1>(arg0, arg1, arg2);
        v0
    }

    public(friend) fun query_sell_quote_coin_internal<T0, T1>(arg0: &0xa0e3b011012b80af4957afa30e556486eb3da0a7d96eeb733cf16ccd3aec32e0::oracle_driven_pool::Pool<T0, T1>, arg1: u64, arg2: u64, arg3: u64) : u64 {
        let (v0, _, _, _, _, _) = 0xa0e3b011012b80af4957afa30e556486eb3da0a7d96eeb733cf16ccd3aec32e0::oracle_driven_pool::query_sell_quote_coin<T0, T1>(arg0, arg1, arg2, arg3);
        v0
    }

    public fun sell_base_coin<T0, T1>(arg0: &mut 0xa0e3b011012b80af4957afa30e556486eb3da0a7d96eeb733cf16ccd3aec32e0::oracle_driven_pool::Pool<T0, T1>, arg1: &0x2::clock::Clock, arg2: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg3: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg4: &mut 0x2::coin::Coin<T0>, arg5: u64, arg6: u64, arg7: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T1> {
        0xa0e3b011012b80af4957afa30e556486eb3da0a7d96eeb733cf16ccd3aec32e0::oracle_driven_pool::assert_version<T0, T1>(arg0);
        let (v0, v1) = 0xa0e3b011012b80af4957afa30e556486eb3da0a7d96eeb733cf16ccd3aec32e0::oracle_driven_pool::get_price_id<T0, T1>(arg0);
        let (v2, _, v4, v5) = 0xa0e3b011012b80af4957afa30e556486eb3da0a7d96eeb733cf16ccd3aec32e0::oracle::calculate_pyth_primitive_prices(v0, v1, arg1, arg2, arg3, 0xa0e3b011012b80af4957afa30e556486eb3da0a7d96eeb733cf16ccd3aec32e0::oracle_driven_pool::get_base_coin_decimals<T0, T1>(arg0), 0xa0e3b011012b80af4957afa30e556486eb3da0a7d96eeb733cf16ccd3aec32e0::oracle_driven_pool::get_quote_coin_decimals<T0, T1>(arg0), 0xa0e3b011012b80af4957afa30e556486eb3da0a7d96eeb733cf16ccd3aec32e0::oracle_driven_pool::get_base_usd_price_age<T0, T1>(arg0), 0xa0e3b011012b80af4957afa30e556486eb3da0a7d96eeb733cf16ccd3aec32e0::oracle_driven_pool::get_quote_usd_price_age<T0, T1>(arg0));
        0xa0e3b011012b80af4957afa30e556486eb3da0a7d96eeb733cf16ccd3aec32e0::oracle_driven_pool::set_prices<T0, T1>(arg0, v4, v5);
        sell_base_coin_internal<T0, T1>(arg0, v2, arg4, arg5, arg6, arg7)
    }

    fun sell_base_coin_internal<T0, T1>(arg0: &mut 0xa0e3b011012b80af4957afa30e556486eb3da0a7d96eeb733cf16ccd3aec32e0::oracle_driven_pool::Pool<T0, T1>, arg1: u64, arg2: &mut 0x2::coin::Coin<T0>, arg3: u64, arg4: u64, arg5: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T1> {
        0xa0e3b011012b80af4957afa30e556486eb3da0a7d96eeb733cf16ccd3aec32e0::oracle_driven_pool::assert_trade_allowed<T0, T1>(arg0);
        0xa0e3b011012b80af4957afa30e556486eb3da0a7d96eeb733cf16ccd3aec32e0::oracle_driven_pool::assert_selling_allowed<T0, T1>(arg0);
        0xa0e3b011012b80af4957afa30e556486eb3da0a7d96eeb733cf16ccd3aec32e0::oracle_driven_pool::increase_trade_num<T0, T1>(arg0);
        let (v0, v1, v2, v3, v4, v5) = 0xa0e3b011012b80af4957afa30e556486eb3da0a7d96eeb733cf16ccd3aec32e0::oracle_driven_pool::query_sell_base_coin<T0, T1>(arg0, arg1, arg3);
        assert!(v0 >= arg4, 1);
        0xa0e3b011012b80af4957afa30e556486eb3da0a7d96eeb733cf16ccd3aec32e0::oracle_driven_pool::base_coin_pay_in<T0, T1>(arg0, 0x2::balance::split<T0>(0x2::coin::balance_mut<T0>(arg2), arg3));
        let v6 = 0xa0e3b011012b80af4957afa30e556486eb3da0a7d96eeb733cf16ccd3aec32e0::oracle_driven_pool::get_trade_num<T0, T1>(arg0);
        if (v2 != 0) {
            let v7 = 0xa0e3b011012b80af4957afa30e556486eb3da0a7d96eeb733cf16ccd3aec32e0::oracle_driven_pool::get_maintainer<T0, T1>(arg0);
            0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(0xa0e3b011012b80af4957afa30e556486eb3da0a7d96eeb733cf16ccd3aec32e0::oracle_driven_pool::quote_coin_pay_out<T0, T1>(arg0, v2, arg5), v7);
            let v8 = ChargeMaintainerFeeEvent{
                pool_id          : 0x2::object::id<0xa0e3b011012b80af4957afa30e556486eb3da0a7d96eeb733cf16ccd3aec32e0::oracle_driven_pool::Pool<T0, T1>>(arg0),
                maintainer       : v7,
                is_base_coin     : false,
                amount           : v2,
                base_quote_price : arg1,
                quote_usd_price  : 0xa0e3b011012b80af4957afa30e556486eb3da0a7d96eeb733cf16ccd3aec32e0::oracle_driven_pool::get_quote_usd_price<T0, T1>(arg0),
                trade_num        : v6,
            };
            0x2::event::emit<ChargeMaintainerFeeEvent>(v8);
        };
        0xa0e3b011012b80af4957afa30e556486eb3da0a7d96eeb733cf16ccd3aec32e0::oracle_driven_pool::set_target_base_coin_amount<T0, T1>(arg0, v5);
        0xa0e3b011012b80af4957afa30e556486eb3da0a7d96eeb733cf16ccd3aec32e0::oracle_driven_pool::set_target_quote_coin_amount<T0, T1>(arg0, v4);
        0xa0e3b011012b80af4957afa30e556486eb3da0a7d96eeb733cf16ccd3aec32e0::oracle_driven_pool::set_r_status<T0, T1>(arg0, v3);
        0xa0e3b011012b80af4957afa30e556486eb3da0a7d96eeb733cf16ccd3aec32e0::oracle_driven_pool::donate_quote_coin<T0, T1>(arg0, v1, true, v6);
        let v9 = SellBaseTokenEvent{
            pool_id          : 0x2::object::id<0xa0e3b011012b80af4957afa30e556486eb3da0a7d96eeb733cf16ccd3aec32e0::oracle_driven_pool::Pool<T0, T1>>(arg0),
            seller           : 0x2::tx_context::sender(arg5),
            pay_base         : arg3,
            receive_quote    : v0,
            base_quote_price : arg1,
            quote_usd_price  : 0xa0e3b011012b80af4957afa30e556486eb3da0a7d96eeb733cf16ccd3aec32e0::oracle_driven_pool::get_quote_usd_price<T0, T1>(arg0),
            trade_num        : v6,
        };
        0x2::event::emit<SellBaseTokenEvent>(v9);
        0xa0e3b011012b80af4957afa30e556486eb3da0a7d96eeb733cf16ccd3aec32e0::oracle_driven_pool::quote_coin_pay_out<T0, T1>(arg0, v0, arg5)
    }

    public fun sell_quote_coin<T0, T1>(arg0: &mut 0xa0e3b011012b80af4957afa30e556486eb3da0a7d96eeb733cf16ccd3aec32e0::oracle_driven_pool::Pool<T0, T1>, arg1: &0x2::clock::Clock, arg2: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg3: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg4: &mut 0x2::coin::Coin<T1>, arg5: u64, arg6: u64, arg7: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        0xa0e3b011012b80af4957afa30e556486eb3da0a7d96eeb733cf16ccd3aec32e0::oracle_driven_pool::assert_version<T0, T1>(arg0);
        let (v0, v1) = 0xa0e3b011012b80af4957afa30e556486eb3da0a7d96eeb733cf16ccd3aec32e0::oracle_driven_pool::get_price_id<T0, T1>(arg0);
        let (v2, v3, v4, v5) = 0xa0e3b011012b80af4957afa30e556486eb3da0a7d96eeb733cf16ccd3aec32e0::oracle::calculate_pyth_primitive_prices(v0, v1, arg1, arg2, arg3, 0xa0e3b011012b80af4957afa30e556486eb3da0a7d96eeb733cf16ccd3aec32e0::oracle_driven_pool::get_base_coin_decimals<T0, T1>(arg0), 0xa0e3b011012b80af4957afa30e556486eb3da0a7d96eeb733cf16ccd3aec32e0::oracle_driven_pool::get_quote_coin_decimals<T0, T1>(arg0), 0xa0e3b011012b80af4957afa30e556486eb3da0a7d96eeb733cf16ccd3aec32e0::oracle_driven_pool::get_base_usd_price_age<T0, T1>(arg0), 0xa0e3b011012b80af4957afa30e556486eb3da0a7d96eeb733cf16ccd3aec32e0::oracle_driven_pool::get_quote_usd_price_age<T0, T1>(arg0));
        0xa0e3b011012b80af4957afa30e556486eb3da0a7d96eeb733cf16ccd3aec32e0::oracle_driven_pool::set_prices<T0, T1>(arg0, v4, v5);
        sell_quote_coin_internal<T0, T1>(arg0, v2, v3, arg4, arg5, arg6, arg7)
    }

    fun sell_quote_coin_internal<T0, T1>(arg0: &mut 0xa0e3b011012b80af4957afa30e556486eb3da0a7d96eeb733cf16ccd3aec32e0::oracle_driven_pool::Pool<T0, T1>, arg1: u64, arg2: u64, arg3: &mut 0x2::coin::Coin<T1>, arg4: u64, arg5: u64, arg6: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        0xa0e3b011012b80af4957afa30e556486eb3da0a7d96eeb733cf16ccd3aec32e0::oracle_driven_pool::assert_trade_allowed<T0, T1>(arg0);
        0xa0e3b011012b80af4957afa30e556486eb3da0a7d96eeb733cf16ccd3aec32e0::oracle_driven_pool::assert_selling_allowed<T0, T1>(arg0);
        0xa0e3b011012b80af4957afa30e556486eb3da0a7d96eeb733cf16ccd3aec32e0::oracle_driven_pool::increase_trade_num<T0, T1>(arg0);
        let (v0, v1, v2, v3, v4, v5) = 0xa0e3b011012b80af4957afa30e556486eb3da0a7d96eeb733cf16ccd3aec32e0::oracle_driven_pool::query_sell_quote_coin<T0, T1>(arg0, arg1, arg2, arg4);
        assert!(v0 >= arg5, 4);
        0xa0e3b011012b80af4957afa30e556486eb3da0a7d96eeb733cf16ccd3aec32e0::oracle_driven_pool::quote_coin_pay_in<T0, T1>(arg0, 0x2::balance::split<T1>(0x2::coin::balance_mut<T1>(arg3), arg4));
        let v6 = 0xa0e3b011012b80af4957afa30e556486eb3da0a7d96eeb733cf16ccd3aec32e0::oracle_driven_pool::get_trade_num<T0, T1>(arg0);
        if (v2 != 0) {
            let v7 = 0xa0e3b011012b80af4957afa30e556486eb3da0a7d96eeb733cf16ccd3aec32e0::oracle_driven_pool::get_maintainer<T0, T1>(arg0);
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0xa0e3b011012b80af4957afa30e556486eb3da0a7d96eeb733cf16ccd3aec32e0::oracle_driven_pool::base_coin_pay_out<T0, T1>(arg0, v2, arg6), v7);
            let v8 = ChargeMaintainerFeeEvent{
                pool_id          : 0x2::object::id<0xa0e3b011012b80af4957afa30e556486eb3da0a7d96eeb733cf16ccd3aec32e0::oracle_driven_pool::Pool<T0, T1>>(arg0),
                maintainer       : v7,
                is_base_coin     : true,
                amount           : v2,
                base_quote_price : arg1,
                quote_usd_price  : 0xa0e3b011012b80af4957afa30e556486eb3da0a7d96eeb733cf16ccd3aec32e0::oracle_driven_pool::get_quote_usd_price<T0, T1>(arg0),
                trade_num        : v6,
            };
            0x2::event::emit<ChargeMaintainerFeeEvent>(v8);
        };
        0xa0e3b011012b80af4957afa30e556486eb3da0a7d96eeb733cf16ccd3aec32e0::oracle_driven_pool::set_target_base_coin_amount<T0, T1>(arg0, v5);
        0xa0e3b011012b80af4957afa30e556486eb3da0a7d96eeb733cf16ccd3aec32e0::oracle_driven_pool::set_target_quote_coin_amount<T0, T1>(arg0, v4);
        0xa0e3b011012b80af4957afa30e556486eb3da0a7d96eeb733cf16ccd3aec32e0::oracle_driven_pool::set_r_status<T0, T1>(arg0, v3);
        0xa0e3b011012b80af4957afa30e556486eb3da0a7d96eeb733cf16ccd3aec32e0::oracle_driven_pool::donate_base_coin<T0, T1>(arg0, v1, true, v6);
        let v9 = BuyBaseTokenEvent{
            pool_id          : 0x2::object::id<0xa0e3b011012b80af4957afa30e556486eb3da0a7d96eeb733cf16ccd3aec32e0::oracle_driven_pool::Pool<T0, T1>>(arg0),
            buyer            : 0x2::tx_context::sender(arg6),
            receive_base     : v0,
            pay_quote        : arg4,
            base_quote_price : arg1,
            quote_usd_price  : 0xa0e3b011012b80af4957afa30e556486eb3da0a7d96eeb733cf16ccd3aec32e0::oracle_driven_pool::get_quote_usd_price<T0, T1>(arg0),
            trade_num        : v6,
        };
        0x2::event::emit<BuyBaseTokenEvent>(v9);
        0xa0e3b011012b80af4957afa30e556486eb3da0a7d96eeb733cf16ccd3aec32e0::oracle_driven_pool::base_coin_pay_out<T0, T1>(arg0, v0, arg6)
    }

    // decompiled from Move bytecode v6
}

