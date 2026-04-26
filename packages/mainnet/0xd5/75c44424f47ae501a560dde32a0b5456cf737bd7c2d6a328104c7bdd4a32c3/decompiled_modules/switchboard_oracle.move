module 0x9ec6f17e19c5e64c8872779a635235497fd6c71f7b5c23b07f652b02a240c84a::switchboard_oracle {
    struct AggregatorPair has copy, drop, store {
        addr_vec: vector<address>,
        is_single_feed: bool,
        is_reverse: bool,
    }

    struct AggregatorStore has store {
        aggregators: 0x2::table::Table<0x1::type_name::TypeName, 0x2::table::Table<0x1::type_name::TypeName, AggregatorPair>>,
    }

    struct FeedCap has store, key {
        id: 0x2::object::UID,
        oracle: address,
    }

    struct AdminCap has store, key {
        id: 0x2::object::UID,
    }

    public fun get_price(arg0: &0x9ec6f17e19c5e64c8872779a635235497fd6c71f7b5c23b07f652b02a240c84a::global_storage::GlobalStorage, arg1: address, arg2: 0x1::type_name::TypeName, arg3: 0x1::type_name::TypeName, arg4: &0x8d79f4d920b03d88faca1e421af023a87fbb1e4a6fd200248e6e9998d09e470::aggregator::Aggregator, arg5: &0x8d79f4d920b03d88faca1e421af023a87fbb1e4a6fd200248e6e9998d09e470::aggregator::Aggregator) : (u64, u64) {
        0x9ec6f17e19c5e64c8872779a635235497fd6c71f7b5c23b07f652b02a240c84a::global_storage::checked_package_version(arg0);
        assert!(0x9ec6f17e19c5e64c8872779a635235497fd6c71f7b5c23b07f652b02a240c84a::global_storage::contains<AggregatorStore>(arg0, arg1), 0);
        let v0 = &0x9ec6f17e19c5e64c8872779a635235497fd6c71f7b5c23b07f652b02a240c84a::global_storage::borrow<AggregatorStore>(arg0, arg1).aggregators;
        if (!0x2::table::contains<0x1::type_name::TypeName, 0x2::table::Table<0x1::type_name::TypeName, AggregatorPair>>(v0, arg2)) {
            abort 1
        };
        let v1 = 0x2::table::borrow<0x1::type_name::TypeName, 0x2::table::Table<0x1::type_name::TypeName, AggregatorPair>>(v0, arg2);
        if (!0x2::table::contains<0x1::type_name::TypeName, AggregatorPair>(v1, arg3)) {
            abort 1
        };
        let v2 = 0x2::table::borrow<0x1::type_name::TypeName, AggregatorPair>(v1, arg3);
        let v3 = &v2.addr_vec;
        let v4 = 0x1::vector::borrow<address>(v3, 1);
        if (v2.is_single_feed) {
            assert!(0x2::object::id_address<0x8d79f4d920b03d88faca1e421af023a87fbb1e4a6fd200248e6e9998d09e470::aggregator::Aggregator>(arg4) == *0x1::vector::borrow<address>(v3, 0), 5);
            let (v7, v8) = 0x8d79f4d920b03d88faca1e421af023a87fbb1e4a6fd200248e6e9998d09e470::aggregator::latest_value(arg4);
            let (v9, v10, _) = 0x8d79f4d920b03d88faca1e421af023a87fbb1e4a6fd200248e6e9998d09e470::math::unpack(v7);
            let v12 = if (!v2.is_reverse) {
                if (v10 > 8) {
                    ((v9 / 0x8d79f4d920b03d88faca1e421af023a87fbb1e4a6fd200248e6e9998d09e470::math::pow(10, v10 - 8)) as u64)
                } else {
                    ((v9 * 0x8d79f4d920b03d88faca1e421af023a87fbb1e4a6fd200248e6e9998d09e470::math::pow(10, 8 - v10)) as u64)
                }
            } else {
                ((0x8d79f4d920b03d88faca1e421af023a87fbb1e4a6fd200248e6e9998d09e470::math::pow(10, 8 + v10) / v9) as u64)
            };
            (v12, v8)
        } else {
            assert!(0x2::object::id_address<0x8d79f4d920b03d88faca1e421af023a87fbb1e4a6fd200248e6e9998d09e470::aggregator::Aggregator>(arg4) == *0x1::vector::borrow<address>(v3, 0) && 0x2::object::id_address<0x8d79f4d920b03d88faca1e421af023a87fbb1e4a6fd200248e6e9998d09e470::aggregator::Aggregator>(arg5) == *v4, 5);
            let (v13, v14) = 0x8d79f4d920b03d88faca1e421af023a87fbb1e4a6fd200248e6e9998d09e470::aggregator::latest_value(arg4);
            let (v15, v16) = 0x8d79f4d920b03d88faca1e421af023a87fbb1e4a6fd200248e6e9998d09e470::aggregator::latest_value(arg5);
            let (v17, v18, _) = 0x8d79f4d920b03d88faca1e421af023a87fbb1e4a6fd200248e6e9998d09e470::math::unpack(v13);
            let v20 = v17;
            let (v21, v22, _) = 0x8d79f4d920b03d88faca1e421af023a87fbb1e4a6fd200248e6e9998d09e470::math::unpack(v15);
            let v24 = v21;
            if (v18 < v22) {
                v20 = v17 * 0x8d79f4d920b03d88faca1e421af023a87fbb1e4a6fd200248e6e9998d09e470::math::pow(10, v22 - v18);
            } else {
                v24 = v21 * 0x8d79f4d920b03d88faca1e421af023a87fbb1e4a6fd200248e6e9998d09e470::math::pow(10, v18 - v22);
            };
            let v25 = if (v14 > v16) {
                v16
            } else {
                v14
            };
            ((0x9ec6f17e19c5e64c8872779a635235497fd6c71f7b5c23b07f652b02a240c84a::mole_math::mul_div_u128(v20, 100000000, v24) as u64), v25)
        }
    }

    public fun get_price_generic<T0, T1>(arg0: &0x9ec6f17e19c5e64c8872779a635235497fd6c71f7b5c23b07f652b02a240c84a::global_storage::GlobalStorage, arg1: address, arg2: &0x8d79f4d920b03d88faca1e421af023a87fbb1e4a6fd200248e6e9998d09e470::aggregator::Aggregator, arg3: &0x8d79f4d920b03d88faca1e421af023a87fbb1e4a6fd200248e6e9998d09e470::aggregator::Aggregator) : (u64, u64) {
        0x9ec6f17e19c5e64c8872779a635235497fd6c71f7b5c23b07f652b02a240c84a::global_storage::checked_package_version(arg0);
        get_price(arg0, arg1, 0x1::type_name::get<T0>(), 0x1::type_name::get<T1>(), arg2, arg3)
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = AdminCap{id: 0x2::object::new(arg0)};
        0x2::transfer::transfer<AdminCap>(v0, 0x2::tx_context::sender(arg0));
    }

    public fun is_account_registered(arg0: &0x9ec6f17e19c5e64c8872779a635235497fd6c71f7b5c23b07f652b02a240c84a::global_storage::GlobalStorage, arg1: address) : bool {
        0x9ec6f17e19c5e64c8872779a635235497fd6c71f7b5c23b07f652b02a240c84a::global_storage::contains<AggregatorStore>(arg0, arg1)
    }

    public entry fun register(arg0: &AdminCap, arg1: &mut 0x9ec6f17e19c5e64c8872779a635235497fd6c71f7b5c23b07f652b02a240c84a::global_storage::GlobalStorage, arg2: &mut 0x2::tx_context::TxContext) {
        0x9ec6f17e19c5e64c8872779a635235497fd6c71f7b5c23b07f652b02a240c84a::global_storage::checked_package_version(arg1);
        assert!(!is_account_registered(arg1, 0x2::tx_context::sender(arg2)), 3);
        let v0 = AggregatorStore{aggregators: 0x2::table::new<0x1::type_name::TypeName, 0x2::table::Table<0x1::type_name::TypeName, AggregatorPair>>(arg2)};
        0x9ec6f17e19c5e64c8872779a635235497fd6c71f7b5c23b07f652b02a240c84a::global_storage::add<AggregatorStore>(arg1, v0, arg2);
        let v1 = 0x2::tx_context::sender(arg2);
        let v2 = FeedCap{
            id     : 0x2::object::new(arg2),
            oracle : v1,
        };
        0x2::transfer::transfer<FeedCap>(v2, v1);
    }

    public fun set_price_feed(arg0: &AdminCap, arg1: &FeedCap, arg2: &mut 0x9ec6f17e19c5e64c8872779a635235497fd6c71f7b5c23b07f652b02a240c84a::global_storage::GlobalStorage, arg3: 0x1::type_name::TypeName, arg4: 0x1::type_name::TypeName, arg5: &0x8d79f4d920b03d88faca1e421af023a87fbb1e4a6fd200248e6e9998d09e470::aggregator::Aggregator, arg6: &0x8d79f4d920b03d88faca1e421af023a87fbb1e4a6fd200248e6e9998d09e470::aggregator::Aggregator, arg7: bool, arg8: bool, arg9: &mut 0x2::tx_context::TxContext) {
        0x9ec6f17e19c5e64c8872779a635235497fd6c71f7b5c23b07f652b02a240c84a::global_storage::checked_package_version(arg2);
        let v0 = arg1.oracle;
        assert!(0x9ec6f17e19c5e64c8872779a635235497fd6c71f7b5c23b07f652b02a240c84a::global_storage::contains<AggregatorStore>(arg2, v0), 0);
        let v1 = &mut 0x9ec6f17e19c5e64c8872779a635235497fd6c71f7b5c23b07f652b02a240c84a::global_storage::borrow_mut<AggregatorStore>(arg2, v0).aggregators;
        if (!0x2::table::contains<0x1::type_name::TypeName, 0x2::table::Table<0x1::type_name::TypeName, AggregatorPair>>(v1, arg3)) {
            0x2::table::add<0x1::type_name::TypeName, 0x2::table::Table<0x1::type_name::TypeName, AggregatorPair>>(v1, arg3, 0x2::table::new<0x1::type_name::TypeName, AggregatorPair>(arg9));
        };
        let v2 = 0x2::table::borrow_mut<0x1::type_name::TypeName, 0x2::table::Table<0x1::type_name::TypeName, AggregatorPair>>(v1, arg3);
        let v3 = 0x1::vector::empty<address>();
        0x1::vector::push_back<address>(&mut v3, 0x2::object::id_address<0x8d79f4d920b03d88faca1e421af023a87fbb1e4a6fd200248e6e9998d09e470::aggregator::Aggregator>(arg5));
        let v4 = v3;
        if (!arg7) {
            let v5 = 0x1::vector::empty<address>();
            let v6 = &mut v5;
            0x1::vector::push_back<address>(v6, 0x2::object::id_address<0x8d79f4d920b03d88faca1e421af023a87fbb1e4a6fd200248e6e9998d09e470::aggregator::Aggregator>(arg5));
            0x1::vector::push_back<address>(v6, 0x2::object::id_address<0x8d79f4d920b03d88faca1e421af023a87fbb1e4a6fd200248e6e9998d09e470::aggregator::Aggregator>(arg6));
            v4 = v5;
        };
        if (0x2::table::contains<0x1::type_name::TypeName, AggregatorPair>(v2, arg4)) {
            let v7 = 0x2::table::borrow_mut<0x1::type_name::TypeName, AggregatorPair>(v2, arg4);
            v7.addr_vec = v4;
            v7.is_single_feed = arg7;
            v7.is_reverse = arg8;
        } else {
            let v8 = AggregatorPair{
                addr_vec       : v4,
                is_single_feed : arg7,
                is_reverse     : arg8,
            };
            0x2::table::add<0x1::type_name::TypeName, AggregatorPair>(v2, arg4, v8);
        };
    }

    public entry fun set_price_feed_generic<T0, T1>(arg0: &AdminCap, arg1: &FeedCap, arg2: &mut 0x9ec6f17e19c5e64c8872779a635235497fd6c71f7b5c23b07f652b02a240c84a::global_storage::GlobalStorage, arg3: &0x8d79f4d920b03d88faca1e421af023a87fbb1e4a6fd200248e6e9998d09e470::aggregator::Aggregator, arg4: &0x8d79f4d920b03d88faca1e421af023a87fbb1e4a6fd200248e6e9998d09e470::aggregator::Aggregator, arg5: bool, arg6: bool, arg7: &mut 0x2::tx_context::TxContext) {
        0x9ec6f17e19c5e64c8872779a635235497fd6c71f7b5c23b07f652b02a240c84a::global_storage::checked_package_version(arg2);
        set_price_feed(arg0, arg1, arg2, 0x1::type_name::get<T0>(), 0x1::type_name::get<T1>(), arg3, arg4, arg5, arg6, arg7);
    }

    // decompiled from Move bytecode v6
}

