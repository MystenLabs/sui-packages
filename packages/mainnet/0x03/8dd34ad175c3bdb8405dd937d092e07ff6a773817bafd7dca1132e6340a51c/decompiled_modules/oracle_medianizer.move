module 0x9ec6f17e19c5e64c8872779a635235497fd6c71f7b5c23b07f652b02a240c84a::oracle_medianizer {
    struct OracleSource has copy, drop, store {
        address: address,
        oracle_type: u8,
    }

    struct PriceSourceStore has store {
        primary_sources: 0x2::table::Table<0x1::type_name::TypeName, 0x2::table::Table<0x1::type_name::TypeName, vector<OracleSource>>>,
        max_price_deviations: 0x2::table::Table<0x1::type_name::TypeName, 0x2::table::Table<0x1::type_name::TypeName, u64>>,
        max_price_stales: 0x2::table::Table<0x1::type_name::TypeName, 0x2::table::Table<0x1::type_name::TypeName, u64>>,
    }

    fun check_oracle_type(arg0: u8) {
        assert!(arg0 == 1 || arg0 == 2, 8);
    }

    fun check_source(arg0: &0x9ec6f17e19c5e64c8872779a635235497fd6c71f7b5c23b07f652b02a240c84a::global_storage::GlobalStorage, arg1: address, arg2: u8) {
        assert!(arg2 == 1 && 0x9ec6f17e19c5e64c8872779a635235497fd6c71f7b5c23b07f652b02a240c84a::price_oracle::is_account_registered(arg0, arg1) || arg2 == 2 && 0x9ec6f17e19c5e64c8872779a635235497fd6c71f7b5c23b07f652b02a240c84a::switchboard_oracle::is_account_registered(arg0, arg1), 9);
    }

    public fun get_price(arg0: &0x9ec6f17e19c5e64c8872779a635235497fd6c71f7b5c23b07f652b02a240c84a::global_storage::GlobalStorage, arg1: address, arg2: 0x1::type_name::TypeName, arg3: 0x1::type_name::TypeName, arg4: &0x8d79f4d920b03d88faca1e421af023a87fbb1e4a6fd200248e6e9998d09e470::aggregator::Aggregator, arg5: &0x8d79f4d920b03d88faca1e421af023a87fbb1e4a6fd200248e6e9998d09e470::aggregator::Aggregator, arg6: &0x2::clock::Clock) : (u64, u64) {
        0x9ec6f17e19c5e64c8872779a635235497fd6c71f7b5c23b07f652b02a240c84a::global_storage::checked_package_version(arg0);
        assert!(0x9ec6f17e19c5e64c8872779a635235497fd6c71f7b5c23b07f652b02a240c84a::global_storage::contains<PriceSourceStore>(arg0, arg1), 0);
        let v0 = 0x9ec6f17e19c5e64c8872779a635235497fd6c71f7b5c23b07f652b02a240c84a::global_storage::borrow<PriceSourceStore>(arg0, arg1);
        assert!(0x2::table::contains<0x1::type_name::TypeName, 0x2::table::Table<0x1::type_name::TypeName, vector<OracleSource>>>(&v0.primary_sources, arg2), 0);
        let v1 = 0x2::table::borrow<0x1::type_name::TypeName, 0x2::table::Table<0x1::type_name::TypeName, vector<OracleSource>>>(&v0.primary_sources, arg2);
        assert!(0x2::table::contains<0x1::type_name::TypeName, vector<OracleSource>>(v1, arg3), 0);
        let v2 = 0x2::table::borrow<0x1::type_name::TypeName, vector<OracleSource>>(v1, arg3);
        let v3 = 0x1::vector::length<OracleSource>(v2);
        assert!(v3 > 0, 0);
        let v4 = now_seconds(arg6);
        let v5 = 0x1::vector::empty<u64>();
        let v6 = &mut v5;
        let v7 = 0;
        let v8 = 0;
        while (v8 < v3) {
            let v9 = 0x1::vector::borrow<OracleSource>(v2, v8);
            let (v10, v11) = if (v9.oracle_type == 1) {
                0x9ec6f17e19c5e64c8872779a635235497fd6c71f7b5c23b07f652b02a240c84a::price_oracle::get_price(arg0, v9.address, arg2, arg3)
            } else {
                assert!(v9.oracle_type == 2, 8);
                0x9ec6f17e19c5e64c8872779a635235497fd6c71f7b5c23b07f652b02a240c84a::switchboard_oracle::get_price(arg0, v9.address, arg2, arg3, arg4, arg5)
            };
            if (v11 + *0x2::table::borrow<0x1::type_name::TypeName, u64>(0x2::table::borrow<0x1::type_name::TypeName, 0x2::table::Table<0x1::type_name::TypeName, u64>>(&v0.max_price_stales, arg2), arg3) >= v4) {
                0x1::vector::push_back<u64>(v6, v10);
                v7 = v7 + 1;
            };
            v8 = v8 + 1;
        };
        assert!(v7 > 0, 4);
        v8 = 0;
        while (v8 < v7 - 1) {
            let v12 = 0;
            while (v12 < v7 - v8 - 1) {
                if (*0x1::vector::borrow<u64>(v6, v12) > *0x1::vector::borrow<u64>(v6, v12 + 1)) {
                    0x1::vector::swap<u64>(v6, v8, v12);
                };
                v12 = v12 + 1;
            };
            v8 = v8 + 1;
        };
        if (v7 == 1) {
            return (*0x1::vector::borrow<u64>(v6, 0), v4)
        };
        let v13 = *0x2::table::borrow<0x1::type_name::TypeName, u64>(0x2::table::borrow<0x1::type_name::TypeName, 0x2::table::Table<0x1::type_name::TypeName, u64>>(&v0.max_price_deviations, arg2), arg3);
        if (v7 == 2) {
            let v14 = *0x1::vector::borrow<u64>(v6, 0);
            let v15 = *0x1::vector::borrow<u64>(v6, 1);
            assert!(v15 * 1000000 / v14 <= v13, 5);
            return ((v14 + v15) / 2, v4)
        };
        let v16 = *0x1::vector::borrow<u64>(v6, 0);
        let v17 = *0x1::vector::borrow<u64>(v6, 1);
        let v18 = *0x1::vector::borrow<u64>(v6, 2);
        let v19 = v17 * 1000000 / v16 <= v13;
        let v20 = v18 * 1000000 / v17 <= v13;
        if (v19 && v20) {
            return (v17, v4)
        };
        if (v19) {
            return ((v16 + v17) / 2, v4)
        };
        assert!(v20, 5);
        ((v17 + v18) / 2, v4)
    }

    public fun get_price_generic<T0, T1>(arg0: &0x9ec6f17e19c5e64c8872779a635235497fd6c71f7b5c23b07f652b02a240c84a::global_storage::GlobalStorage, arg1: address, arg2: &0x8d79f4d920b03d88faca1e421af023a87fbb1e4a6fd200248e6e9998d09e470::aggregator::Aggregator, arg3: &0x8d79f4d920b03d88faca1e421af023a87fbb1e4a6fd200248e6e9998d09e470::aggregator::Aggregator, arg4: &0x2::clock::Clock) : (u64, u64) {
        0x9ec6f17e19c5e64c8872779a635235497fd6c71f7b5c23b07f652b02a240c84a::global_storage::checked_package_version(arg0);
        get_price(arg0, arg1, 0x1::type_name::get<T0>(), 0x1::type_name::get<T1>(), arg2, arg3, arg4)
    }

    public fun is_account_registered(arg0: &0x9ec6f17e19c5e64c8872779a635235497fd6c71f7b5c23b07f652b02a240c84a::global_storage::GlobalStorage, arg1: address) : bool {
        0x9ec6f17e19c5e64c8872779a635235497fd6c71f7b5c23b07f652b02a240c84a::global_storage::checked_package_version(arg0);
        0x9ec6f17e19c5e64c8872779a635235497fd6c71f7b5c23b07f652b02a240c84a::global_storage::contains<PriceSourceStore>(arg0, arg1)
    }

    fun now_seconds(arg0: &0x2::clock::Clock) : u64 {
        0x2::clock::timestamp_ms(arg0) / 1000
    }

    public entry fun register(arg0: &mut 0x9ec6f17e19c5e64c8872779a635235497fd6c71f7b5c23b07f652b02a240c84a::global_storage::GlobalStorage, arg1: &mut 0x2::tx_context::TxContext) {
        0x9ec6f17e19c5e64c8872779a635235497fd6c71f7b5c23b07f652b02a240c84a::global_storage::checked_package_version(arg0);
        assert!(!is_account_registered(arg0, 0x2::tx_context::sender(arg1)), 6);
        let v0 = PriceSourceStore{
            primary_sources      : 0x2::table::new<0x1::type_name::TypeName, 0x2::table::Table<0x1::type_name::TypeName, vector<OracleSource>>>(arg1),
            max_price_deviations : 0x2::table::new<0x1::type_name::TypeName, 0x2::table::Table<0x1::type_name::TypeName, u64>>(arg1),
            max_price_stales     : 0x2::table::new<0x1::type_name::TypeName, 0x2::table::Table<0x1::type_name::TypeName, u64>>(arg1),
        };
        0x9ec6f17e19c5e64c8872779a635235497fd6c71f7b5c23b07f652b02a240c84a::global_storage::add<PriceSourceStore>(arg0, v0, arg1);
    }

    public fun set_primary_sources(arg0: &mut 0x9ec6f17e19c5e64c8872779a635235497fd6c71f7b5c23b07f652b02a240c84a::global_storage::GlobalStorage, arg1: 0x1::type_name::TypeName, arg2: 0x1::type_name::TypeName, arg3: u64, arg4: u64, arg5: vector<address>, arg6: vector<u8>, arg7: &mut 0x2::tx_context::TxContext) {
        0x9ec6f17e19c5e64c8872779a635235497fd6c71f7b5c23b07f652b02a240c84a::global_storage::checked_package_version(arg0);
        assert!(is_account_registered(arg0, 0x2::tx_context::sender(arg7)), 0);
        set_primary_sources_unchecked(arg0, arg1, arg2, arg3, arg4, &arg5, &arg6, arg7);
    }

    public entry fun set_primary_sources_generic<T0, T1>(arg0: &mut 0x9ec6f17e19c5e64c8872779a635235497fd6c71f7b5c23b07f652b02a240c84a::global_storage::GlobalStorage, arg1: u64, arg2: u64, arg3: vector<address>, arg4: vector<u8>, arg5: &mut 0x2::tx_context::TxContext) {
        0x9ec6f17e19c5e64c8872779a635235497fd6c71f7b5c23b07f652b02a240c84a::global_storage::checked_package_version(arg0);
        set_primary_sources(arg0, 0x1::type_name::get<T0>(), 0x1::type_name::get<T1>(), arg1, arg2, arg3, arg4, arg5);
    }

    fun set_primary_sources_unchecked(arg0: &mut 0x9ec6f17e19c5e64c8872779a635235497fd6c71f7b5c23b07f652b02a240c84a::global_storage::GlobalStorage, arg1: 0x1::type_name::TypeName, arg2: 0x1::type_name::TypeName, arg3: u64, arg4: u64, arg5: &vector<address>, arg6: &vector<u8>, arg7: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x1::vector::length<address>(arg5);
        assert!(arg3 >= 1000000 && arg3 <= 1500000, 1);
        assert!(v0 <= 3, 2);
        assert!(v0 == 0x1::vector::length<u8>(arg6), 7);
        let v1 = 0x1::vector::empty<OracleSource>();
        let v2 = 0;
        while (v2 < v0) {
            let v3 = *0x1::vector::borrow<u8>(arg6, v2);
            check_oracle_type(v3);
            let v4 = *0x1::vector::borrow<address>(arg5, v2);
            check_source(arg0, v4, v3);
            let v5 = OracleSource{
                address     : v4,
                oracle_type : v3,
            };
            0x1::vector::push_back<OracleSource>(&mut v1, v5);
            v2 = v2 + 1;
        };
        let v6 = 0x9ec6f17e19c5e64c8872779a635235497fd6c71f7b5c23b07f652b02a240c84a::global_storage::borrow_mut<PriceSourceStore>(arg0, 0x2::tx_context::sender(arg7));
        let v7 = &mut v6.primary_sources;
        upsert_inner<0x1::type_name::TypeName, vector<OracleSource>>(v7, arg1, arg2, v1, arg7);
        let v8 = &mut v6.primary_sources;
        upsert_inner<0x1::type_name::TypeName, vector<OracleSource>>(v8, arg2, arg1, v1, arg7);
        let v9 = &mut v6.max_price_deviations;
        upsert_inner<0x1::type_name::TypeName, u64>(v9, arg1, arg2, arg3, arg7);
        let v10 = &mut v6.max_price_deviations;
        upsert_inner<0x1::type_name::TypeName, u64>(v10, arg2, arg1, arg3, arg7);
        let v11 = &mut v6.max_price_stales;
        upsert_inner<0x1::type_name::TypeName, u64>(v11, arg1, arg2, arg4, arg7);
        let v12 = &mut v6.max_price_stales;
        upsert_inner<0x1::type_name::TypeName, u64>(v12, arg2, arg1, arg4, arg7);
    }

    fun upsert_inner<T0: copy + drop + store, T1: drop + store>(arg0: &mut 0x2::table::Table<T0, 0x2::table::Table<T0, T1>>, arg1: T0, arg2: T0, arg3: T1, arg4: &mut 0x2::tx_context::TxContext) {
        if (!0x2::table::contains<T0, 0x2::table::Table<T0, T1>>(arg0, arg1)) {
            let v0 = 0x2::table::new<T0, T1>(arg4);
            0x2::table::add<T0, T1>(&mut v0, arg2, arg3);
            0x2::table::add<T0, 0x2::table::Table<T0, T1>>(arg0, arg1, v0);
        } else {
            let v1 = 0x2::table::borrow_mut<T0, 0x2::table::Table<T0, T1>>(arg0, arg1);
            if (0x2::table::contains<T0, T1>(v1, arg2)) {
                *0x2::table::borrow_mut<T0, T1>(v1, arg2) = arg3;
            } else {
                0x2::table::add<T0, T1>(v1, arg2, arg3);
            };
        };
    }

    // decompiled from Move bytecode v6
}

