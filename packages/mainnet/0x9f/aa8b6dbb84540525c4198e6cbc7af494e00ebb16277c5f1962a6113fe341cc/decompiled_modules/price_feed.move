module 0x9faa8b6dbb84540525c4198e6cbc7af494e00ebb16277c5f1962a6113fe341cc::price_feed {
    struct PriceFeed has store, key {
        id: 0x2::object::UID,
        pool_addr: address,
        is_reverse_pool: bool,
        exponent: u8,
        price: 0x9faa8b6dbb84540525c4198e6cbc7af494e00ebb16277c5f1962a6113fe341cc::price::Price,
    }

    public fun new(arg0: address, arg1: bool, arg2: u8, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = PriceFeed{
            id              : 0x2::object::new(arg3),
            pool_addr       : arg0,
            is_reverse_pool : arg1,
            exponent        : arg2,
            price           : 0x9faa8b6dbb84540525c4198e6cbc7af494e00ebb16277c5f1962a6113fe341cc::price::new(0, 0),
        };
        0x2::transfer::share_object<PriceFeed>(v0);
    }

    public fun get_timestamp_ms(arg0: &PriceFeed) : u64 {
        0x9faa8b6dbb84540525c4198e6cbc7af494e00ebb16277c5f1962a6113fe341cc::price::get_timestamp_ms(arg0.price)
    }

    public fun get_exponent(arg0: &PriceFeed) : u8 {
        arg0.exponent
    }

    public fun get_is_reverse_pool(arg0: &PriceFeed) : bool {
        arg0.is_reverse_pool
    }

    public fun get_pool_addr(arg0: &PriceFeed) : address {
        arg0.pool_addr
    }

    public fun get_price_with_exponent(arg0: &PriceFeed) : (u256, u8) {
        (0x9faa8b6dbb84540525c4198e6cbc7af494e00ebb16277c5f1962a6113fe341cc::price::get_value(arg0.price), arg0.exponent)
    }

    public fun update_bluefin_spot<T0, T1>(arg0: &mut PriceFeed, arg1: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T0, T1>, arg2: &0x2::clock::Clock) {
        assert!(arg0.pool_addr == 0x2::object::id_address<0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T0, T1>>(arg1) && !arg0.is_reverse_pool, 0x9faa8b6dbb84540525c4198e6cbc7af494e00ebb16277c5f1962a6113fe341cc::errors::EPoolMismatch());
        arg0.price = 0x9faa8b6dbb84540525c4198e6cbc7af494e00ebb16277c5f1962a6113fe341cc::bluefin_spot::new<T0, T1>(arg1, arg0.exponent, arg2);
    }

    public fun update_bluefin_spot_reverse<T0, T1>(arg0: &mut PriceFeed, arg1: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T1, T0>, arg2: &0x2::clock::Clock) {
        assert!(arg0.pool_addr == 0x2::object::id_address<0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T1, T0>>(arg1) && arg0.is_reverse_pool, 0x9faa8b6dbb84540525c4198e6cbc7af494e00ebb16277c5f1962a6113fe341cc::errors::EPoolMismatch());
        arg0.price = 0x9faa8b6dbb84540525c4198e6cbc7af494e00ebb16277c5f1962a6113fe341cc::bluefin_spot::new_reverse<T0, T1>(arg1, arg0.exponent, arg2);
    }

    public fun update_cetus_clmm<T0, T1>(arg0: &mut PriceFeed, arg1: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg2: &0x2::clock::Clock) {
        assert!(arg0.pool_addr == 0x2::object::id_address<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>>(arg1) && !arg0.is_reverse_pool, 0x9faa8b6dbb84540525c4198e6cbc7af494e00ebb16277c5f1962a6113fe341cc::errors::EPoolMismatch());
        arg0.price = 0x9faa8b6dbb84540525c4198e6cbc7af494e00ebb16277c5f1962a6113fe341cc::cetus_clmm::new<T0, T1>(arg1, arg0.exponent, arg2);
    }

    public fun update_cetus_clmm_reverse<T0, T1>(arg0: &mut PriceFeed, arg1: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T1, T0>, arg2: &0x2::clock::Clock) {
        assert!(arg0.pool_addr == 0x2::object::id_address<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T1, T0>>(arg1) && arg0.is_reverse_pool, 0x9faa8b6dbb84540525c4198e6cbc7af494e00ebb16277c5f1962a6113fe341cc::errors::EPoolMismatch());
        arg0.price = 0x9faa8b6dbb84540525c4198e6cbc7af494e00ebb16277c5f1962a6113fe341cc::cetus_clmm::new_reverse<T0, T1>(arg1, arg0.exponent, arg2);
    }

    public fun update_mmt_v3<T0, T1>(arg0: &mut PriceFeed, arg1: &0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::pool::Pool<T0, T1>, arg2: &0x2::clock::Clock) {
        assert!(arg0.pool_addr == 0x2::object::id_address<0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::pool::Pool<T0, T1>>(arg1) && !arg0.is_reverse_pool, 0x9faa8b6dbb84540525c4198e6cbc7af494e00ebb16277c5f1962a6113fe341cc::errors::EPoolMismatch());
        arg0.price = 0x9faa8b6dbb84540525c4198e6cbc7af494e00ebb16277c5f1962a6113fe341cc::mmt_v3::new<T0, T1>(arg1, arg0.exponent, arg2);
    }

    public fun update_mmt_v3_reverse<T0, T1>(arg0: &mut PriceFeed, arg1: &0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::pool::Pool<T1, T0>, arg2: &0x2::clock::Clock) {
        assert!(arg0.pool_addr == 0x2::object::id_address<0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::pool::Pool<T1, T0>>(arg1) && arg0.is_reverse_pool, 0x9faa8b6dbb84540525c4198e6cbc7af494e00ebb16277c5f1962a6113fe341cc::errors::EPoolMismatch());
        arg0.price = 0x9faa8b6dbb84540525c4198e6cbc7af494e00ebb16277c5f1962a6113fe341cc::mmt_v3::new_reverse<T0, T1>(arg1, arg0.exponent, arg2);
    }

    // decompiled from Move bytecode v6
}

