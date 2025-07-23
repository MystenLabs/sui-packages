module 0xaf5e1c99cba1fbc17ff600a0c8277a0bd7d3183a02e46832f1cbe5113ea63c7e::oracle {
    struct PoolPriceUpdateEvent has copy, drop {
        protocol_name: vector<u8>,
        pool_id: 0x2::object::ID,
        price: u128,
    }

    struct PriceOracle has store, key {
        id: 0x2::object::UID,
    }

    public fun new_price_oracle(arg0: &mut 0x2::tx_context::TxContext) : PriceOracle {
        let v0 = PriceOracle{id: 0x2::object::new(arg0)};
        0x2::dynamic_field::add<vector<u8>, 0x2::table::Table<0x2::object::ID, u128>>(&mut v0.id, b"cetus", 0x2::table::new<0x2::object::ID, u128>(arg0));
        v0
    }

    public fun update_cetus_pool_price<T0, T1>(arg0: &mut PriceOracle, arg1: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>) {
        let v0 = 0x2::object::id<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>>(arg1);
        let v1 = 0x2::dynamic_field::borrow_mut<vector<u8>, 0x2::table::Table<0x2::object::ID, u128>>(&mut arg0.id, b"cetus");
        if (0x2::table::contains<0x2::object::ID, u128>(v1, v0)) {
            *0x2::table::borrow_mut<0x2::object::ID, u128>(v1, v0) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::current_sqrt_price<T0, T1>(arg1);
        } else {
            0x2::table::add<0x2::object::ID, u128>(v1, v0, 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::current_sqrt_price<T0, T1>(arg1));
        };
    }

    public fun use_price_oracle(arg0: PriceOracle, arg1: vector<0x2::object::ID>) {
        let PriceOracle { id: v0 } = arg0;
        let v1 = 0x2::dynamic_field::remove<vector<u8>, 0x2::table::Table<0x2::object::ID, u128>>(&mut v0, b"cetus");
        let v2 = 0;
        while (v2 < 0x1::vector::length<0x2::object::ID>(&arg1)) {
            let v3 = *0x1::vector::borrow<0x2::object::ID>(&arg1, v2);
            if (0x2::table::contains<0x2::object::ID, u128>(&v1, v3)) {
                let v4 = PoolPriceUpdateEvent{
                    protocol_name : b"cetus",
                    pool_id       : v3,
                    price         : 0x2::table::remove<0x2::object::ID, u128>(&mut v1, v3),
                };
                0x2::event::emit<PoolPriceUpdateEvent>(v4);
            };
            v2 = v2 + 1;
        };
        assert!(0x2::table::is_empty<0x2::object::ID, u128>(&v1), 0);
        0x2::table::drop<0x2::object::ID, u128>(v1);
        0x2::object::delete(v0);
    }

    // decompiled from Move bytecode v6
}

