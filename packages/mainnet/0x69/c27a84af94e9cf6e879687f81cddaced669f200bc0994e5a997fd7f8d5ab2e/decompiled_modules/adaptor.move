module 0x69c27a84af94e9cf6e879687f81cddaced669f200bc0994e5a997fd7f8d5ab2e::adaptor {
    struct SupraRegistry has key {
        id: 0x2::object::UID,
        table: 0x2::table::Table<0x1::type_name::TypeName, u32>,
        pair2Id: 0x2::table::Table<u32, u8>,
    }

    struct SupraRegistryCap has store, key {
        id: 0x2::object::UID,
        for: 0x2::object::ID,
    }

    struct RegisterTokenEvent has copy, drop {
        admin: address,
        type_name: 0x1::ascii::String,
        pair: u32,
        index: u8,
    }

    public entry fun get_each_price(arg0: &SupraRegistry, arg1: &0x5d8fbbf6f908a4af8c6d072669a462d53e03eb3c1d863bd0359dc818c69ea706::SupraSValueFeed::OracleHolder, arg2: u32, arg3: &0x5ba7c7ba602dcfd4f7cf31e2be48d522c6f6102b6cf192bb4ed2935ed8377c3e::navi_aggregator::NaviAggregator) : (u8, u256, u8, u64) {
        assert!(!0x2::table::contains<u32, u8>(&arg0.pair2Id, arg2), 30003);
        let v0 = *0x2::table::borrow<u32, u8>(&arg0.pair2Id, arg2);
        let (v1, v2, v3, _) = 0x5d8fbbf6f908a4af8c6d072669a462d53e03eb3c1d863bd0359dc818c69ea706::SupraSValueFeed::get_price(arg1, arg2);
        let v5 = (v2 as u8);
        let (v6, v7) = 0x5ba7c7ba602dcfd4f7cf31e2be48d522c6f6102b6cf192bb4ed2935ed8377c3e::navi_aggregator::get_token_decimal(arg3, v0);
        assert!(v6, 30002);
        let v8 = if (v5 < v7) {
            (v1 as u256) * (0x2::math::pow(10, v7 - v5) as u256)
        } else {
            (v1 as u256) / (0x2::math::pow(10, v5 - v7) as u256)
        };
        (v0, v8, v7, (v3 as u64))
    }

    public entry fun get_sui_price(arg0: &SupraRegistry, arg1: &0x5d8fbbf6f908a4af8c6d072669a462d53e03eb3c1d863bd0359dc818c69ea706::SupraSValueFeed::OracleHolder, arg2: u32, arg3: u32, arg4: &0x5ba7c7ba602dcfd4f7cf31e2be48d522c6f6102b6cf192bb4ed2935ed8377c3e::navi_aggregator::NaviAggregator) : (u8, u256, u8, u64) {
        let (_, v1, v2, _) = get_each_price(arg0, arg1, arg3, arg4);
        let (v4, v5, v6, v7) = get_each_price(arg0, arg1, arg2, arg4);
        (v4, v5 * v1 / (0x2::math::pow(10, v2) as u256), v6, v7)
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = SupraRegistry{
            id      : 0x2::object::new(arg0),
            table   : 0x2::table::new<0x1::type_name::TypeName, u32>(arg0),
            pair2Id : 0x2::table::new<u32, u8>(arg0),
        };
        let v1 = SupraRegistryCap{
            id  : 0x2::object::new(arg0),
            for : 0x2::object::id<SupraRegistry>(&v0),
        };
        0x2::transfer::share_object<SupraRegistry>(v0);
        0x2::transfer::transfer<SupraRegistryCap>(v1, 0x2::tx_context::sender(arg0));
    }

    public entry fun register_supra_pair<T0>(arg0: &mut SupraRegistry, arg1: &SupraRegistryCap, arg2: u32, arg3: &0x5ba7c7ba602dcfd4f7cf31e2be48d522c6f6102b6cf192bb4ed2935ed8377c3e::navi_aggregator::NaviAggregator, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::object::id<SupraRegistry>(arg0) == arg1.for, 30001);
        let v0 = 0x1::type_name::get<T0>();
        let (v1, v2, _) = 0x5ba7c7ba602dcfd4f7cf31e2be48d522c6f6102b6cf192bb4ed2935ed8377c3e::navi_aggregator::get_token_info<T0>(arg3);
        assert!(v1, 30002);
        if (0x2::table::contains<0x1::type_name::TypeName, u32>(&arg0.table, v0)) {
            0x2::table::remove<0x1::type_name::TypeName, u32>(&mut arg0.table, v0);
            0x2::table::remove<u32, u8>(&mut arg0.pair2Id, arg2);
        };
        0x2::table::add<0x1::type_name::TypeName, u32>(&mut arg0.table, v0, arg2);
        0x2::table::add<u32, u8>(&mut arg0.pair2Id, arg2, v2);
        let v4 = RegisterTokenEvent{
            admin     : 0x2::tx_context::sender(arg4),
            type_name : 0x1::type_name::into_string(v0),
            pair      : arg2,
            index     : v2,
        };
        0x2::event::emit<RegisterTokenEvent>(v4);
    }

    public entry fun set_supra_price_batch(arg0: &SupraRegistry, arg1: &0x5d8fbbf6f908a4af8c6d072669a462d53e03eb3c1d863bd0359dc818c69ea706::SupraSValueFeed::OracleHolder, arg2: u32, arg3: u32, arg4: vector<u32>, arg5: &0x5ba7c7ba602dcfd4f7cf31e2be48d522c6f6102b6cf192bb4ed2935ed8377c3e::navi_aggregator::NaviAggregatorCap, arg6: &mut 0x5ba7c7ba602dcfd4f7cf31e2be48d522c6f6102b6cf192bb4ed2935ed8377c3e::navi_aggregator::NaviAggregator, arg7: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x1::vector::empty<u8>();
        let v1 = 0x1::vector::empty<u256>();
        let v2 = 0x1::vector::empty<u64>();
        let (v3, v4, v5, v6) = get_each_price(arg0, arg1, arg3, arg6);
        let v7 = 0;
        while (v7 < 0x1::vector::length<u32>(&arg4)) {
            let v8 = *0x1::vector::borrow<u32>(&arg4, v7);
            if (v8 == arg3) {
                0x1::vector::push_back<u8>(&mut v0, v3);
                0x1::vector::push_back<u256>(&mut v1, v4);
                0x1::vector::push_back<u64>(&mut v2, v6);
                v7 = v7 + 1;
                continue
            };
            let (v9, v10, _, v12) = get_each_price(arg0, arg1, v8, arg6);
            let v13 = v10;
            0x1::vector::push_back<u8>(&mut v0, v9);
            0x1::vector::push_back<u64>(&mut v2, v12);
            if (v8 == arg2) {
                v13 = v10 * v4 / (0x2::math::pow(10, v5) as u256);
            };
            0x1::vector::push_back<u256>(&mut v1, v13);
            v7 = v7 + 1;
        };
        0x5ba7c7ba602dcfd4f7cf31e2be48d522c6f6102b6cf192bb4ed2935ed8377c3e::navi_aggregator::update_internal_token_price_batch(arg5, arg6, 2, v0, v1, v2, arg7);
    }

    // decompiled from Move bytecode v6
}

