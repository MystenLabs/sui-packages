module 0x43f20f0b5ea40842441de0a6320d81854f3d8658eb4f2b7ccfc50f15fa50d461::oracle {
    struct PoolPriceUpdateEvent has copy, drop {
        protocol_name: vector<u8>,
        pool_id: 0x2::object::ID,
        price: u128,
    }

    struct PoolPriceRangeEvent has copy, drop {
        min_price: u128,
        max_price: u128,
    }

    struct ProtocolPoolPair has copy, drop, store {
        name: vector<u8>,
        pool_ids: 0x2::vec_set::VecSet<0x2::object::ID>,
    }

    struct PriceConfig has store, key {
        id: 0x2::object::UID,
        protocols: vector<ProtocolPoolPair>,
    }

    struct PriceOracle has store, key {
        id: 0x2::object::UID,
    }

    public fun add_protocol_pool_pair(arg0: &mut PriceConfig, arg1: vector<u8>, arg2: 0x2::object::ID, arg3: &0x2::tx_context::TxContext) {
        let v0 = 0;
        while (v0 < 0x1::vector::length<ProtocolPoolPair>(&arg0.protocols)) {
            let v1 = 0x1::vector::borrow_mut<ProtocolPoolPair>(&mut arg0.protocols, v0);
            if (v1.name == arg1) {
                0x2::vec_set::insert<0x2::object::ID>(&mut v1.pool_ids, arg2);
                return
            };
            v0 = v0 + 1;
        };
        let v2 = 0x2::vec_set::empty<0x2::object::ID>();
        0x2::vec_set::insert<0x2::object::ID>(&mut v2, arg2);
        let v3 = ProtocolPoolPair{
            name     : arg1,
            pool_ids : v2,
        };
        0x1::vector::push_back<ProtocolPoolPair>(&mut arg0.protocols, v3);
    }

    public fun destroy_price_oracle(arg0: PriceOracle) {
        let PriceOracle { id: v0 } = arg0;
        let v1 = 0x2::dynamic_field::remove<vector<u8>, 0x2::table::Table<0x2::object::ID, u128>>(&mut v0, b"cetus");
        assert!(0x2::table::is_empty<0x2::object::ID, u128>(&v1), 1);
        0x2::table::drop<0x2::object::ID, u128>(v1);
        0x2::object::delete(v0);
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = PriceConfig{
            id        : 0x2::object::new(arg0),
            protocols : 0x1::vector::empty<ProtocolPoolPair>(),
        };
        0x2::transfer::share_object<PriceConfig>(v0);
    }

    public fun new_price_oracle(arg0: &mut 0x2::tx_context::TxContext) : PriceOracle {
        let v0 = PriceOracle{id: 0x2::object::new(arg0)};
        0x2::dynamic_field::add<vector<u8>, 0x2::table::Table<0x2::object::ID, u128>>(&mut v0.id, b"cetus", 0x2::table::new<0x2::object::ID, u128>(arg0));
        v0
    }

    fun query_cetus_price(arg0: &mut PriceOracle, arg1: 0x2::vec_set::VecSet<0x2::object::ID>) : (u128, u128) {
        let v0 = 0x2::dynamic_field::borrow_mut<vector<u8>, 0x2::table::Table<0x2::object::ID, u128>>(&mut arg0.id, b"cetus");
        let v1 = 0x2::vec_set::into_keys<0x2::object::ID>(arg1);
        let v2 = 0;
        let v3 = 340282366920938463463374607431768211455;
        let v4 = v3;
        let v5 = 0;
        let v6 = v5;
        while (v2 < 0x1::vector::length<0x2::object::ID>(&v1)) {
            let v7 = *0x1::vector::borrow<0x2::object::ID>(&v1, v2);
            assert!(0x2::table::contains<0x2::object::ID, u128>(v0, v7), 3);
            let v8 = *0x2::table::borrow<0x2::object::ID, u128>(v0, v7);
            if (v8 < v3) {
                v4 = v8;
            };
            if (v8 > v5) {
                v6 = v8;
            };
            let v9 = PoolPriceUpdateEvent{
                protocol_name : b"cetus",
                pool_id       : v7,
                price         : v8,
            };
            0x2::event::emit<PoolPriceUpdateEvent>(v9);
            0x2::table::remove<0x2::object::ID, u128>(v0, v7);
            v2 = v2 + 1;
        };
        (v4, v6)
    }

    public fun remove_protocol_pool(arg0: &mut PriceConfig, arg1: vector<u8>, arg2: 0x2::object::ID, arg3: &0x2::tx_context::TxContext) {
        let v0 = 0;
        while (v0 < 0x1::vector::length<ProtocolPoolPair>(&arg0.protocols)) {
            let v1 = 0x1::vector::borrow_mut<ProtocolPoolPair>(&mut arg0.protocols, v0);
            if (v1.name == arg1) {
                0x2::vec_set::remove<0x2::object::ID>(&mut v1.pool_ids, &arg2);
                if (0x2::vec_set::is_empty<0x2::object::ID>(&v1.pool_ids)) {
                    0x1::vector::remove<ProtocolPoolPair>(&mut arg0.protocols, v0);
                };
                return
            };
            v0 = v0 + 1;
        };
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

    public fun use_price_oracle(arg0: PriceOracle, arg1: &vector<ProtocolPoolPair>) : (u128, u128) {
        let v0 = 0;
        let v1 = 340282366920938463463374607431768211455;
        let v2 = v1;
        let v3 = 0;
        let v4 = v3;
        while (v0 < 0x1::vector::length<ProtocolPoolPair>(arg1)) {
            let v5 = 0x1::vector::borrow<ProtocolPoolPair>(arg1, v0);
            if (v5.name == b"cetus") {
                let v6 = &mut arg0;
                let (v7, v8) = query_cetus_price(v6, v5.pool_ids);
                if (v7 < v1) {
                    v2 = v7;
                };
                if (v8 > v3) {
                    v4 = v8;
                };
            };
            v0 = v0 + 1;
        };
        let v9 = PoolPriceRangeEvent{
            min_price : v2,
            max_price : v4,
        };
        0x2::event::emit<PoolPriceRangeEvent>(v9);
        destroy_price_oracle(arg0);
        (v2, v4)
    }

    // decompiled from Move bytecode v6
}

