module 0x1d18986b0ecc895e9f4be9f37fc28084e75e3ae9cb845f87ec4b5b16a6b20b0::price_feed {
    struct PriceFeed has store, key {
        id: 0x2::object::UID,
        pool_addr: address,
        is_reverse_pool: bool,
        price: 0x1d18986b0ecc895e9f4be9f37fc28084e75e3ae9cb845f87ec4b5b16a6b20b0::price::Price,
    }

    public fun new(arg0: address, arg1: bool, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = PriceFeed{
            id              : 0x2::object::new(arg2),
            pool_addr       : arg0,
            is_reverse_pool : arg1,
            price           : 0x1d18986b0ecc895e9f4be9f37fc28084e75e3ae9cb845f87ec4b5b16a6b20b0::price::new(0xc5f0aa630b9e6de12ecdc2bbcd4307d1db3a90e1efec271f32d984b4b971c301::decimal::from(0), 0),
        };
        0x2::transfer::share_object<PriceFeed>(v0);
    }

    public fun get_price(arg0: &PriceFeed) : 0xc5f0aa630b9e6de12ecdc2bbcd4307d1db3a90e1efec271f32d984b4b971c301::decimal::Decimal {
        0x1d18986b0ecc895e9f4be9f37fc28084e75e3ae9cb845f87ec4b5b16a6b20b0::price::get_price(arg0.price)
    }

    public fun get_timestamp_ms(arg0: &PriceFeed) : u64 {
        0x1d18986b0ecc895e9f4be9f37fc28084e75e3ae9cb845f87ec4b5b16a6b20b0::price::get_timestamp_ms(arg0.price)
    }

    public fun get_is_reverse_pool(arg0: &PriceFeed) : bool {
        arg0.is_reverse_pool
    }

    public fun get_pool_addr(arg0: &PriceFeed) : address {
        arg0.pool_addr
    }

    public fun update_bluefin_spot<T0, T1>(arg0: &mut PriceFeed, arg1: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T0, T1>, arg2: &0x2::clock::Clock) {
        assert!(arg0.pool_addr == 0x2::object::id_address<0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T0, T1>>(arg1) && !arg0.is_reverse_pool, 0x1d18986b0ecc895e9f4be9f37fc28084e75e3ae9cb845f87ec4b5b16a6b20b0::errors::EPoolMismatch());
        arg0.price = 0x1d18986b0ecc895e9f4be9f37fc28084e75e3ae9cb845f87ec4b5b16a6b20b0::bluefin_spot::new<T0, T1>(arg1, arg2);
    }

    public fun update_bluefin_spot_reverse<T0, T1>(arg0: &mut PriceFeed, arg1: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T1, T0>, arg2: &0x2::clock::Clock) {
        assert!(arg0.pool_addr == 0x2::object::id_address<0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T1, T0>>(arg1) && arg0.is_reverse_pool, 0x1d18986b0ecc895e9f4be9f37fc28084e75e3ae9cb845f87ec4b5b16a6b20b0::errors::EPoolMismatch());
        arg0.price = 0x1d18986b0ecc895e9f4be9f37fc28084e75e3ae9cb845f87ec4b5b16a6b20b0::bluefin_spot::new_reverse<T0, T1>(arg1, arg2);
    }

    public fun update_cetus_clmm<T0, T1>(arg0: &mut PriceFeed, arg1: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg2: &0x2::clock::Clock) {
        assert!(arg0.pool_addr == 0x2::object::id_address<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>>(arg1) && !arg0.is_reverse_pool, 0x1d18986b0ecc895e9f4be9f37fc28084e75e3ae9cb845f87ec4b5b16a6b20b0::errors::EPoolMismatch());
        arg0.price = 0x1d18986b0ecc895e9f4be9f37fc28084e75e3ae9cb845f87ec4b5b16a6b20b0::cetus_clmm::new<T0, T1>(arg1, arg2);
    }

    public fun update_cetus_clmm_reverse<T0, T1>(arg0: &mut PriceFeed, arg1: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T1, T0>, arg2: &0x2::clock::Clock) {
        assert!(arg0.pool_addr == 0x2::object::id_address<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T1, T0>>(arg1) && arg0.is_reverse_pool, 0x1d18986b0ecc895e9f4be9f37fc28084e75e3ae9cb845f87ec4b5b16a6b20b0::errors::EPoolMismatch());
        arg0.price = 0x1d18986b0ecc895e9f4be9f37fc28084e75e3ae9cb845f87ec4b5b16a6b20b0::cetus_clmm::new_reverse<T0, T1>(arg1, arg2);
    }

    // decompiled from Move bytecode v6
}

