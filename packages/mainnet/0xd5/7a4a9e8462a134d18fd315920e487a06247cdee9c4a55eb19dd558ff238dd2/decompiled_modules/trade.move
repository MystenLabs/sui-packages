module 0xd57a4a9e8462a134d18fd315920e487a06247cdee9c4a55eb19dd558ff238dd2::trade {
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

    public entry fun get_price(arg0: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg1: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg2: u8, arg3: u8, arg4: &0x2::clock::Clock) {
        let v0 = 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::get_price_info_from_price_info_object(arg0);
        let v1 = 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::get_price_identifier(&v0);
        let v2 = 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::get_price_info_from_price_info_object(arg1);
        let v3 = 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::get_price_identifier(&v2);
        let (v4, v5, v6, v7) = 0xd57a4a9e8462a134d18fd315920e487a06247cdee9c4a55eb19dd558ff238dd2::oracle::calculate_pyth_primitive_prices(0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_identifier::get_bytes(&v1), 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_identifier::get_bytes(&v3), arg4, arg0, arg1, arg2, arg3, 60, 60);
        let v8 = PriceEvent{
            primitive_base_price  : v4,
            primitive_quote_price : v5,
            base_price            : v6,
            quote_price           : v7,
        };
        0x2::event::emit<PriceEvent>(v8);
    }

    public entry fun use_pyth_price(arg0: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg1: &0x2::clock::Clock) {
        let v0 = 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::get_price_info_from_price_info_object(arg0);
        let v1 = 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::get_price_identifier(&v0);
        let v2 = PriceDetailEvent{
            price_id : 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_identifier::get_bytes(&v1),
            price    : 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::pyth::get_price_no_older_than(arg0, arg1, 60),
        };
        0x2::event::emit<PriceDetailEvent>(v2);
    }

    // decompiled from Move bytecode v6
}

