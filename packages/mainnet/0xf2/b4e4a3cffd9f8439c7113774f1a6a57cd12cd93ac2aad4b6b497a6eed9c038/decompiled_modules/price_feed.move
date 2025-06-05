module 0xf2b4e4a3cffd9f8439c7113774f1a6a57cd12cd93ac2aad4b6b497a6eed9c038::price_feed {
    struct PriceFeed has store, key {
        id: 0x2::object::UID,
        pool_addr: address,
        pool_type: u8,
        is_reverse_pool: bool,
        exponent: u8,
        weight: u64,
        price: 0xf2b4e4a3cffd9f8439c7113774f1a6a57cd12cd93ac2aad4b6b497a6eed9c038::price::Price,
    }

    public(friend) fun new(arg0: address, arg1: u8, arg2: bool, arg3: u8, arg4: u64, arg5: &mut 0x2::tx_context::TxContext) : PriceFeed {
        PriceFeed{
            id              : 0x2::object::new(arg5),
            pool_addr       : arg0,
            pool_type       : arg1,
            is_reverse_pool : arg2,
            exponent        : arg3,
            weight          : arg4,
            price           : 0xf2b4e4a3cffd9f8439c7113774f1a6a57cd12cd93ac2aad4b6b497a6eed9c038::price::new(0, 0),
        }
    }

    public fun get_timestamp_ms(arg0: &PriceFeed) : u64 {
        0xf2b4e4a3cffd9f8439c7113774f1a6a57cd12cd93ac2aad4b6b497a6eed9c038::price::get_timestamp_ms(arg0.price)
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

    public fun get_pool_type(arg0: &PriceFeed) : u8 {
        arg0.pool_type
    }

    public fun get_price_with_exponent(arg0: &PriceFeed) : (u256, u8) {
        (0xf2b4e4a3cffd9f8439c7113774f1a6a57cd12cd93ac2aad4b6b497a6eed9c038::price::get_value(arg0.price), arg0.exponent)
    }

    public fun get_weight(arg0: &PriceFeed) : u64 {
        arg0.weight
    }

    public(friend) fun set_weight(arg0: &mut PriceFeed, arg1: u64) {
        arg0.weight = arg1;
    }

    public fun update_bluefin_spot<T0, T1>(arg0: &mut PriceFeed, arg1: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T0, T1>, arg2: &0x2::clock::Clock) {
        assert!(arg0.pool_addr == 0x2::object::id_address<0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T0, T1>>(arg1) && !arg0.is_reverse_pool, 0xf2b4e4a3cffd9f8439c7113774f1a6a57cd12cd93ac2aad4b6b497a6eed9c038::errors::EPoolMismatch());
        arg0.price = 0xf2b4e4a3cffd9f8439c7113774f1a6a57cd12cd93ac2aad4b6b497a6eed9c038::bluefin_spot::new<T0, T1>(arg1, arg0.exponent, arg2);
    }

    public fun update_bluefin_spot_reverse<T0, T1>(arg0: &mut PriceFeed, arg1: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T1, T0>, arg2: &0x2::clock::Clock) {
        assert!(arg0.pool_addr == 0x2::object::id_address<0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T1, T0>>(arg1) && arg0.is_reverse_pool, 0xf2b4e4a3cffd9f8439c7113774f1a6a57cd12cd93ac2aad4b6b497a6eed9c038::errors::EPoolMismatch());
        arg0.price = 0xf2b4e4a3cffd9f8439c7113774f1a6a57cd12cd93ac2aad4b6b497a6eed9c038::bluefin_spot::new_reverse<T0, T1>(arg1, arg0.exponent, arg2);
    }

    public fun update_cetus_clmm<T0, T1>(arg0: &mut PriceFeed, arg1: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg2: &0x2::clock::Clock) {
        assert!(arg0.pool_addr == 0x2::object::id_address<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>>(arg1) && !arg0.is_reverse_pool, 0xf2b4e4a3cffd9f8439c7113774f1a6a57cd12cd93ac2aad4b6b497a6eed9c038::errors::EPoolMismatch());
        arg0.price = 0xf2b4e4a3cffd9f8439c7113774f1a6a57cd12cd93ac2aad4b6b497a6eed9c038::cetus_clmm::new<T0, T1>(arg1, arg0.exponent, arg2);
    }

    public fun update_cetus_clmm_reverse<T0, T1>(arg0: &mut PriceFeed, arg1: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T1, T0>, arg2: &0x2::clock::Clock) {
        assert!(arg0.pool_addr == 0x2::object::id_address<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T1, T0>>(arg1) && arg0.is_reverse_pool, 0xf2b4e4a3cffd9f8439c7113774f1a6a57cd12cd93ac2aad4b6b497a6eed9c038::errors::EPoolMismatch());
        arg0.price = 0xf2b4e4a3cffd9f8439c7113774f1a6a57cd12cd93ac2aad4b6b497a6eed9c038::cetus_clmm::new_reverse<T0, T1>(arg1, arg0.exponent, arg2);
    }

    public fun update_mmt_v3<T0, T1>(arg0: &mut PriceFeed, arg1: &0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::pool::Pool<T0, T1>, arg2: &0x2::clock::Clock) {
        assert!(arg0.pool_addr == 0x2::object::id_address<0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::pool::Pool<T0, T1>>(arg1) && !arg0.is_reverse_pool, 0xf2b4e4a3cffd9f8439c7113774f1a6a57cd12cd93ac2aad4b6b497a6eed9c038::errors::EPoolMismatch());
        arg0.price = 0xf2b4e4a3cffd9f8439c7113774f1a6a57cd12cd93ac2aad4b6b497a6eed9c038::mmt_v3::new<T0, T1>(arg1, arg0.exponent, arg2);
    }

    public fun update_mmt_v3_reverse<T0, T1>(arg0: &mut PriceFeed, arg1: &0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::pool::Pool<T1, T0>, arg2: &0x2::clock::Clock) {
        assert!(arg0.pool_addr == 0x2::object::id_address<0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::pool::Pool<T1, T0>>(arg1) && arg0.is_reverse_pool, 0xf2b4e4a3cffd9f8439c7113774f1a6a57cd12cd93ac2aad4b6b497a6eed9c038::errors::EPoolMismatch());
        arg0.price = 0xf2b4e4a3cffd9f8439c7113774f1a6a57cd12cd93ac2aad4b6b497a6eed9c038::mmt_v3::new_reverse<T0, T1>(arg1, arg0.exponent, arg2);
    }

    // decompiled from Move bytecode v6
}

