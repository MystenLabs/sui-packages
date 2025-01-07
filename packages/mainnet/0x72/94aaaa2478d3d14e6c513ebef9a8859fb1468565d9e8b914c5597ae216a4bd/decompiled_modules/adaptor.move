module 0x7294aaaa2478d3d14e6c513ebef9a8859fb1468565d9e8b914c5597ae216a4bd::adaptor {
    struct PythRegistry has key {
        id: 0x2::object::UID,
        table: 0x2::table::Table<0x1::type_name::TypeName, 0x2::object::ID>,
        id_table: 0x2::table::Table<0x2::object::ID, u8>,
    }

    struct PythRegistryCap has store, key {
        id: 0x2::object::UID,
        for: 0x2::object::ID,
    }

    struct RegisterTokenEvent has copy, drop {
        admin: address,
        type_name: 0x1::ascii::String,
        price_info_object: 0x2::object::ID,
        index: u8,
    }

    fun assert_pyth_price_info_object<T0>(arg0: &PythRegistry, arg1: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject) {
        assert!(0x2::object::id<0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject>(arg1) == *0x2::table::borrow<0x1::type_name::TypeName, 0x2::object::ID>(&arg0.table, 0x1::type_name::get<T0>()), 20002);
    }

    fun get_each_price(arg0: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::state::State, arg1: &PythRegistry, arg2: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg3: &mut 0x5ba7c7ba602dcfd4f7cf31e2be48d522c6f6102b6cf192bb4ed2935ed8377c3e::navi_aggregator::NaviAggregator, arg4: &0x2::clock::Clock) : (u256, u64) {
        assert!(0x2::table::contains<0x2::object::ID, u8>(&arg1.id_table, 0x2::object::id<0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject>(arg2)), 20002);
        let (v0, v1) = 0x5ba7c7ba602dcfd4f7cf31e2be48d522c6f6102b6cf192bb4ed2935ed8377c3e::navi_aggregator::get_token_decimal(arg3, *0x2::table::borrow<0x2::object::ID, u8>(&arg1.id_table, 0x2::object::id<0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject>(arg2)));
        assert!(v0, 20004);
        let (v2, v3, v4) = get_pyth_price(arg0, arg2, arg4);
        assert!(v2 > 0, 20001);
        let v5 = if (v3 < v1) {
            v2 * 0x2::math::pow(10, v1 - v3)
        } else {
            v2 / 0x2::math::pow(10, v3 - v1)
        };
        ((v5 as u256), v4)
    }

    public fun get_pyth_price(arg0: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::state::State, arg1: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg2: &0x2::clock::Clock) : (u64, u8, u64) {
        let v0 = 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::pyth::get_price(arg0, arg1, arg2);
        let v1 = 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price::get_price(&v0);
        let v2 = 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price::get_expo(&v0);
        let v3 = 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::i64::get_magnitude_if_negative(&v2);
        assert!(v3 <= 255, 20001);
        (0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::i64::get_magnitude_if_positive(&v1), (v3 as u8), 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price::get_timestamp(&v0) * 1000)
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = PythRegistry{
            id       : 0x2::object::new(arg0),
            table    : 0x2::table::new<0x1::type_name::TypeName, 0x2::object::ID>(arg0),
            id_table : 0x2::table::new<0x2::object::ID, u8>(arg0),
        };
        let v1 = PythRegistryCap{
            id  : 0x2::object::new(arg0),
            for : 0x2::object::id<PythRegistry>(&v0),
        };
        0x2::transfer::share_object<PythRegistry>(v0);
        0x2::transfer::transfer<PythRegistryCap>(v1, 0x2::tx_context::sender(arg0));
    }

    public entry fun register_pyth_price_info_object<T0>(arg0: &mut PythRegistry, arg1: &PythRegistryCap, arg2: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg3: &0x5ba7c7ba602dcfd4f7cf31e2be48d522c6f6102b6cf192bb4ed2935ed8377c3e::navi_aggregator::NaviAggregator, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::object::id<PythRegistry>(arg0) == arg1.for, 20003);
        let v0 = 0x1::type_name::get<T0>();
        let (v1, v2, _) = 0x5ba7c7ba602dcfd4f7cf31e2be48d522c6f6102b6cf192bb4ed2935ed8377c3e::navi_aggregator::get_token_info<T0>(arg3);
        assert!(v1, 20004);
        if (0x2::table::contains<0x1::type_name::TypeName, 0x2::object::ID>(&arg0.table, v0)) {
            0x2::table::remove<0x1::type_name::TypeName, 0x2::object::ID>(&mut arg0.table, v0);
            0x2::table::remove<0x2::object::ID, u8>(&mut arg0.id_table, 0x2::object::id<0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject>(arg2));
        };
        0x2::table::add<0x1::type_name::TypeName, 0x2::object::ID>(&mut arg0.table, v0, 0x2::object::id<0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject>(arg2));
        0x2::table::add<0x2::object::ID, u8>(&mut arg0.id_table, 0x2::object::id<0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject>(arg2), v2);
        let v4 = RegisterTokenEvent{
            admin             : 0x2::tx_context::sender(arg4),
            type_name         : 0x1::type_name::into_string(v0),
            price_info_object : 0x2::object::id<0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject>(arg2),
            index             : v2,
        };
        0x2::event::emit<RegisterTokenEvent>(v4);
    }

    public entry fun set_pyth_price_batch(arg0: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::state::State, arg1: &PythRegistry, arg2: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg3: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg4: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg5: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg6: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg7: &0x5ba7c7ba602dcfd4f7cf31e2be48d522c6f6102b6cf192bb4ed2935ed8377c3e::navi_aggregator::NaviAggregatorCap, arg8: &mut 0x5ba7c7ba602dcfd4f7cf31e2be48d522c6f6102b6cf192bb4ed2935ed8377c3e::navi_aggregator::NaviAggregator, arg9: &0x2::clock::Clock, arg10: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x1::vector::empty<u256>();
        let v1 = 0x1::vector::empty<u64>();
        let (v2, v3) = get_each_price(arg0, arg1, arg2, arg8, arg9);
        0x1::vector::push_back<u256>(&mut v0, v2);
        0x1::vector::push_back<u64>(&mut v1, v3);
        let (v4, v5) = get_each_price(arg0, arg1, arg3, arg8, arg9);
        0x1::vector::push_back<u256>(&mut v0, v4);
        0x1::vector::push_back<u64>(&mut v1, v5);
        let (v6, v7) = get_each_price(arg0, arg1, arg4, arg8, arg9);
        0x1::vector::push_back<u256>(&mut v0, v6);
        0x1::vector::push_back<u64>(&mut v1, v7);
        let (v8, v9) = get_each_price(arg0, arg1, arg5, arg8, arg9);
        0x1::vector::push_back<u256>(&mut v0, v8);
        0x1::vector::push_back<u64>(&mut v1, v9);
        let (v10, v11) = get_each_price(arg0, arg1, arg6, arg8, arg9);
        0x1::vector::push_back<u256>(&mut v0, v10);
        0x1::vector::push_back<u64>(&mut v1, v11);
        0x5ba7c7ba602dcfd4f7cf31e2be48d522c6f6102b6cf192bb4ed2935ed8377c3e::navi_aggregator::update_internal_token_price_batch(arg7, arg8, 1, x"0001020304", v0, v1, arg10);
    }

    public entry fun set_pyth_price_batch_v2(arg0: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::state::State, arg1: &PythRegistry, arg2: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg3: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg4: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg5: &0x5ba7c7ba602dcfd4f7cf31e2be48d522c6f6102b6cf192bb4ed2935ed8377c3e::navi_aggregator::NaviAggregatorCap, arg6: &mut 0x5ba7c7ba602dcfd4f7cf31e2be48d522c6f6102b6cf192bb4ed2935ed8377c3e::navi_aggregator::NaviAggregator, arg7: &0x2::clock::Clock, arg8: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x1::vector::empty<u256>();
        let v1 = 0x1::vector::empty<u64>();
        let (v2, v3) = get_each_price(arg0, arg1, arg2, arg6, arg7);
        0x1::vector::push_back<u256>(&mut v0, v2);
        0x1::vector::push_back<u64>(&mut v1, v3);
        let (v4, v5) = get_each_price(arg0, arg1, arg3, arg6, arg7);
        0x1::vector::push_back<u256>(&mut v0, v4);
        0x1::vector::push_back<u64>(&mut v1, v5);
        let (v6, v7) = get_each_price(arg0, arg1, arg4, arg6, arg7);
        0x1::vector::push_back<u256>(&mut v0, v6);
        0x1::vector::push_back<u64>(&mut v1, v7);
        0x5ba7c7ba602dcfd4f7cf31e2be48d522c6f6102b6cf192bb4ed2935ed8377c3e::navi_aggregator::update_internal_token_price_batch(arg5, arg6, 1, x"000102", v0, v1, arg8);
    }

    public entry fun set_pyth_price_batch_v3(arg0: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::state::State, arg1: &PythRegistry, arg2: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg3: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg4: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg5: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg6: &0x5ba7c7ba602dcfd4f7cf31e2be48d522c6f6102b6cf192bb4ed2935ed8377c3e::navi_aggregator::NaviAggregatorCap, arg7: &mut 0x5ba7c7ba602dcfd4f7cf31e2be48d522c6f6102b6cf192bb4ed2935ed8377c3e::navi_aggregator::NaviAggregator, arg8: &0x2::clock::Clock, arg9: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x1::vector::empty<u256>();
        let v1 = 0x1::vector::empty<u64>();
        let (v2, v3) = get_each_price(arg0, arg1, arg2, arg7, arg8);
        0x1::vector::push_back<u256>(&mut v0, v2);
        0x1::vector::push_back<u64>(&mut v1, v3);
        let (v4, v5) = get_each_price(arg0, arg1, arg3, arg7, arg8);
        0x1::vector::push_back<u256>(&mut v0, v4);
        0x1::vector::push_back<u64>(&mut v1, v5);
        let (v6, v7) = get_each_price(arg0, arg1, arg4, arg7, arg8);
        0x1::vector::push_back<u256>(&mut v0, v6);
        0x1::vector::push_back<u64>(&mut v1, v7);
        let (v8, v9) = get_each_price(arg0, arg1, arg5, arg7, arg8);
        0x1::vector::push_back<u256>(&mut v0, v8);
        0x1::vector::push_back<u64>(&mut v1, v9);
        0x5ba7c7ba602dcfd4f7cf31e2be48d522c6f6102b6cf192bb4ed2935ed8377c3e::navi_aggregator::update_internal_token_price_batch(arg6, arg7, 1, x"00010203", v0, v1, arg9);
    }

    // decompiled from Move bytecode v6
}

