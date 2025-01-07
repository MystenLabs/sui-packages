module 0xeb33956a22d831ed7410e747cf0b4135e55aa74fa1d3f00b79dde8a45917f7aa::trade {
    struct PoolOracleConfig has store {
        base_price_id: vector<u8>,
        quote_price_id: vector<u8>,
        base_usd_price_age: u64,
        quote_usd_price_age: u64,
    }

    struct Pool has key {
        id: 0x2::object::UID,
        base_coin_decimals: u8,
        quote_coin_decimals: u8,
    }

    struct PriceEvent has copy, drop {
        primitive_base_price: u64,
        primitive_quote_price: u64,
        base_price: u64,
        quote_price: u64,
    }

    struct PriceDetailEvent has copy, drop {
        price_id: vector<u8>,
        price: 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price::Price,
    }

    public entry fun create(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = Pool{
            id                  : 0x2::object::new(arg0),
            base_coin_decimals  : 9,
            quote_coin_decimals : 9,
        };
        0x2::transfer::share_object<Pool>(v0);
    }

    public entry fun get_price(arg0: &Pool, arg1: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg2: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg3: &0x2::clock::Clock) {
        let v0 = 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::get_price_info_from_price_info_object(arg1);
        let v1 = 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::get_price_identifier(&v0);
        let v2 = 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::get_price_info_from_price_info_object(arg2);
        let v3 = 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::get_price_identifier(&v2);
        let (v4, v5, v6, v7) = 0xeb33956a22d831ed7410e747cf0b4135e55aa74fa1d3f00b79dde8a45917f7aa::oracle::calculate_pyth_primitive_prices(0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_identifier::get_bytes(&v1), 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_identifier::get_bytes(&v3), arg3, arg1, arg2, arg0.base_coin_decimals, arg0.quote_coin_decimals, 60, 60);
        let v8 = PriceEvent{
            primitive_base_price  : v4,
            primitive_quote_price : v5,
            base_price            : v6,
            quote_price           : v7,
        };
        0x2::event::emit<PriceEvent>(v8);
    }

    public fun use_pyth_price(arg0: &0x2::clock::Clock, arg1: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject) {
        let v0 = 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::get_price_info_from_price_info_object(arg1);
        let v1 = 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::get_price_identifier(&v0);
        let v2 = PriceDetailEvent{
            price_id : 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_identifier::get_bytes(&v1),
            price    : 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::pyth::get_price_no_older_than(arg1, arg0, 60),
        };
        0x2::event::emit<PriceDetailEvent>(v2);
    }

    // decompiled from Move bytecode v6
}

