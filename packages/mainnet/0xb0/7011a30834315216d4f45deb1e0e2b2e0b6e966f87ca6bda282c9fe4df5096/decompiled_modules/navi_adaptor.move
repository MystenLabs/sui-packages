module 0xb07011a30834315216d4f45deb1e0e2b2e0b6e966f87ca6bda282c9fe4df5096::navi_adaptor {
    struct NaviMarketRegistryKey has copy, drop, store {
        dummy_field: bool,
    }

    struct NaviMarketState has copy, drop, store {
        value: u256,
        updated_at: u64,
    }

    struct NaviMarketRegistry has store {
        markets: 0x2::table::Table<0x1::ascii::String, 0x2::vec_map::VecMap<u64, NaviMarketState>>,
    }

    public(friend) fun add_navi_market<T0>(arg0: &mut 0xb07011a30834315216d4f45deb1e0e2b2e0b6e966f87ca6bda282c9fe4df5096::vault::Vault<T0>, arg1: 0x1::ascii::String, arg2: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::storage::Storage) {
        assert_navi_market_empty(0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::account::account_owner(0xb07011a30834315216d4f45deb1e0e2b2e0b6e966f87ca6bda282c9fe4df5096::vault::get_defi_asset_inner<T0, 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::account::AccountCap>(arg0, arg1)), arg2);
        add_navi_market_by_id<T0>(arg0, arg1, 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::storage::get_market_id(arg2));
    }

    fun add_navi_market_by_id<T0>(arg0: &mut 0xb07011a30834315216d4f45deb1e0e2b2e0b6e966f87ca6bda282c9fe4df5096::vault::Vault<T0>, arg1: 0x1::ascii::String, arg2: u64) {
        0xb07011a30834315216d4f45deb1e0e2b2e0b6e966f87ca6bda282c9fe4df5096::vault::check_version<T0>(arg0);
        0xb07011a30834315216d4f45deb1e0e2b2e0b6e966f87ca6bda282c9fe4df5096::vault::assert_enabled<T0>(arg0);
        0xb07011a30834315216d4f45deb1e0e2b2e0b6e966f87ca6bda282c9fe4df5096::vault::assert_not_during_operation<T0>(arg0);
        let v0 = registry_mut<T0>(arg0);
        if (!0x2::table::contains<0x1::ascii::String, 0x2::vec_map::VecMap<u64, NaviMarketState>>(&v0.markets, arg1)) {
            0x2::table::add<0x1::ascii::String, 0x2::vec_map::VecMap<u64, NaviMarketState>>(&mut v0.markets, arg1, 0x2::vec_map::empty<u64, NaviMarketState>());
        };
        let v1 = 0x2::table::borrow_mut<0x1::ascii::String, 0x2::vec_map::VecMap<u64, NaviMarketState>>(&mut v0.markets, arg1);
        assert!(!0x2::vec_map::contains<u64, NaviMarketState>(v1, &arg2), 6002);
        let v2 = NaviMarketState{
            value      : 0,
            updated_at : 0,
        };
        0x2::vec_map::insert<u64, NaviMarketState>(v1, arg2, v2);
    }

    fun assert_navi_market_empty(arg0: address, arg1: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::storage::Storage) {
        assert!(!navi_market_has_assets(arg0, arg1), 6005);
    }

    public fun calculate_navi_position_value(arg0: address, arg1: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::storage::Storage, arg2: &0xb07011a30834315216d4f45deb1e0e2b2e0b6e966f87ca6bda282c9fe4df5096::vault_oracle::OracleConfig, arg3: &0x2::clock::Clock) : u256 {
        let v0 = 0;
        let v1 = 0;
        let v2 = 0;
        while (v2 < 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::storage::get_reserves_count(arg1)) {
            let (v3, v4) = 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::storage::get_user_balance(arg1, v2, arg0);
            let (v5, v6) = 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::dynamic_calculator::calculate_current_index(arg3, arg1, v2);
            let v7 = 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::storage::get_coin_type(arg1, v2);
            if (v3 == 0 && v4 == 0) {
            } else if (v4 == 0 && !0xb07011a30834315216d4f45deb1e0e2b2e0b6e966f87ca6bda282c9fe4df5096::vault_oracle::has_aggregator(arg2, v7)) {
            } else {
                let v8 = 0xb07011a30834315216d4f45deb1e0e2b2e0b6e966f87ca6bda282c9fe4df5096::vault_oracle::get_asset_price(arg2, arg3, v7);
                v0 = v0 + 0xb07011a30834315216d4f45deb1e0e2b2e0b6e966f87ca6bda282c9fe4df5096::vault_utils::mul_with_oracle_price((0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::ray_math::ray_mul(v3, v5) as u256), v8);
                v1 = v1 + 0xb07011a30834315216d4f45deb1e0e2b2e0b6e966f87ca6bda282c9fe4df5096::vault_utils::mul_with_oracle_price((0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::ray_math::ray_mul(v4, v6) as u256), v8);
            };
            v2 = v2 + 1;
        };
        if (v0 < v1) {
            return 0
        };
        v0 - v1
    }

    public(friend) fun init_navi_market_registry<T0>(arg0: &mut 0xb07011a30834315216d4f45deb1e0e2b2e0b6e966f87ca6bda282c9fe4df5096::vault::Vault<T0>, arg1: &mut 0x2::tx_context::TxContext) {
        0xb07011a30834315216d4f45deb1e0e2b2e0b6e966f87ca6bda282c9fe4df5096::vault::check_version<T0>(arg0);
        let v0 = NaviMarketRegistryKey{dummy_field: false};
        let v1 = NaviMarketRegistry{markets: 0x2::table::new<0x1::ascii::String, 0x2::vec_map::VecMap<u64, NaviMarketState>>(arg1)};
        0x2::dynamic_field::add<NaviMarketRegistryKey, NaviMarketRegistry>(0xb07011a30834315216d4f45deb1e0e2b2e0b6e966f87ca6bda282c9fe4df5096::vault::vault_id_mut<T0>(arg0), v0, v1);
    }

    public(friend) fun init_navi_market_registry_for_migration<T0>(arg0: &mut 0xb07011a30834315216d4f45deb1e0e2b2e0b6e966f87ca6bda282c9fe4df5096::vault::Vault<T0>, arg1: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::storage::Storage, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::clock::timestamp_ms(arg2) < 1786752000000, 6006);
        0xb07011a30834315216d4f45deb1e0e2b2e0b6e966f87ca6bda282c9fe4df5096::vault::assert_not_during_operation<T0>(arg0);
        init_navi_market_registry<T0>(arg0, arg3);
        let v0 = 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::storage::get_market_id(arg1);
        let v1 = *0xb07011a30834315216d4f45deb1e0e2b2e0b6e966f87ca6bda282c9fe4df5096::vault::asset_types<T0>(arg0);
        let v2 = &v1;
        let v3 = 0;
        while (v3 < 0x1::vector::length<0x1::ascii::String>(v2)) {
            let v4 = 0x1::vector::borrow<0x1::ascii::String>(v2, v3);
            if (!0xb07011a30834315216d4f45deb1e0e2b2e0b6e966f87ca6bda282c9fe4df5096::vault::contains_defi_asset_of_type<T0, 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::account::AccountCap>(arg0, *v4)) {
            } else if (navi_market_has_assets(0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::account::account_owner(0xb07011a30834315216d4f45deb1e0e2b2e0b6e966f87ca6bda282c9fe4df5096::vault::get_defi_asset_inner<T0, 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::account::AccountCap>(arg0, *v4)), arg1)) {
                add_navi_market_by_id<T0>(arg0, *v4, v0);
            };
            v3 = v3 + 1;
        };
    }

    fun navi_market_has_assets(arg0: address, arg1: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::storage::Storage) : bool {
        let v0 = false;
        let v1 = 0;
        while (v1 < 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::storage::get_reserves_count(arg1)) {
            let (v2, v3) = 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::storage::get_user_balance(arg1, v1, arg0);
            if (v2 > 0 || v3 > 0) {
                v0 = true;
            };
            v1 = v1 + 1;
        };
        v0
    }

    fun record_navi_market_value<T0>(arg0: &mut 0xb07011a30834315216d4f45deb1e0e2b2e0b6e966f87ca6bda282c9fe4df5096::vault::Vault<T0>, arg1: 0x1::ascii::String, arg2: u64, arg3: u256, arg4: u64) : (u256, bool) {
        let v0 = registry_mut<T0>(arg0);
        assert!(0x2::table::contains<0x1::ascii::String, 0x2::vec_map::VecMap<u64, NaviMarketState>>(&v0.markets, arg1), 6001);
        let v1 = 0x2::table::borrow_mut<0x1::ascii::String, 0x2::vec_map::VecMap<u64, NaviMarketState>>(&mut v0.markets, arg1);
        assert!(0x2::vec_map::contains<u64, NaviMarketState>(v1, &arg2), 6001);
        let v2 = 0x2::vec_map::get_mut<u64, NaviMarketState>(v1, &arg2);
        v2.value = arg3;
        v2.updated_at = arg4;
        let v3 = 0;
        let v4 = true;
        let v5 = 0x2::vec_map::keys<u64, NaviMarketState>(v1);
        let v6 = &v5;
        let v7 = 0;
        while (v7 < 0x1::vector::length<u64>(v6)) {
            let v8 = 0x2::vec_map::get<u64, NaviMarketState>(v1, 0x1::vector::borrow<u64>(v6, v7));
            v3 = v3 + v8.value;
            if (v8.updated_at != arg4) {
                v4 = false;
            };
            v7 = v7 + 1;
        };
        if (v4) {
            reset_market_sync(v1);
        };
        (v3, v4)
    }

    fun registry_mut<T0>(arg0: &mut 0xb07011a30834315216d4f45deb1e0e2b2e0b6e966f87ca6bda282c9fe4df5096::vault::Vault<T0>) : &mut NaviMarketRegistry {
        let v0 = NaviMarketRegistryKey{dummy_field: false};
        0x2::dynamic_field::borrow_mut<NaviMarketRegistryKey, NaviMarketRegistry>(0xb07011a30834315216d4f45deb1e0e2b2e0b6e966f87ca6bda282c9fe4df5096::vault::vault_id_mut<T0>(arg0), v0)
    }

    public(friend) fun remove_navi_market<T0>(arg0: &mut 0xb07011a30834315216d4f45deb1e0e2b2e0b6e966f87ca6bda282c9fe4df5096::vault::Vault<T0>, arg1: 0x1::ascii::String, arg2: u64, arg3: &0x2::clock::Clock) {
        0xb07011a30834315216d4f45deb1e0e2b2e0b6e966f87ca6bda282c9fe4df5096::vault::check_version<T0>(arg0);
        0xb07011a30834315216d4f45deb1e0e2b2e0b6e966f87ca6bda282c9fe4df5096::vault::assert_enabled<T0>(arg0);
        0xb07011a30834315216d4f45deb1e0e2b2e0b6e966f87ca6bda282c9fe4df5096::vault::assert_not_during_operation<T0>(arg0);
        let v0 = registry_mut<T0>(arg0);
        assert!(0x2::table::contains<0x1::ascii::String, 0x2::vec_map::VecMap<u64, NaviMarketState>>(&v0.markets, arg1), 6001);
        let v1 = 0x2::table::borrow_mut<0x1::ascii::String, 0x2::vec_map::VecMap<u64, NaviMarketState>>(&mut v0.markets, arg1);
        assert!(0x2::vec_map::contains<u64, NaviMarketState>(v1, &arg2), 6001);
        let v2 = 0x2::vec_map::get<u64, NaviMarketState>(v1, &arg2);
        assert!(v2.value == 0, 6003);
        assert!(v2.updated_at == 0x2::clock::timestamp_ms(arg3), 6004);
        let (_, _) = 0x2::vec_map::remove<u64, NaviMarketState>(v1, &arg2);
    }

    fun reset_market_sync(arg0: &mut 0x2::vec_map::VecMap<u64, NaviMarketState>) {
        let v0 = 0x2::vec_map::keys<u64, NaviMarketState>(arg0);
        let v1 = &v0;
        let v2 = 0;
        while (v2 < 0x1::vector::length<u64>(v1)) {
            0x2::vec_map::get_mut<u64, NaviMarketState>(arg0, 0x1::vector::borrow<u64>(v1, v2)).updated_at = 0;
            v2 = v2 + 1;
        };
    }

    public(friend) fun reset_navi_market_sync<T0>(arg0: &mut 0xb07011a30834315216d4f45deb1e0e2b2e0b6e966f87ca6bda282c9fe4df5096::vault::Vault<T0>, arg1: 0x1::ascii::String) {
        let v0 = 0x2::table::borrow_mut<0x1::ascii::String, 0x2::vec_map::VecMap<u64, NaviMarketState>>(&mut registry_mut<T0>(arg0).markets, arg1);
        reset_market_sync(v0);
    }

    public fun update_navi_position_value<T0>(arg0: &mut 0xb07011a30834315216d4f45deb1e0e2b2e0b6e966f87ca6bda282c9fe4df5096::vault::Vault<T0>, arg1: &0xb07011a30834315216d4f45deb1e0e2b2e0b6e966f87ca6bda282c9fe4df5096::vault_oracle::OracleConfig, arg2: &0x2::clock::Clock, arg3: 0x1::ascii::String, arg4: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::storage::Storage) {
        0xb07011a30834315216d4f45deb1e0e2b2e0b6e966f87ca6bda282c9fe4df5096::vault::check_version<T0>(arg0);
        0xb07011a30834315216d4f45deb1e0e2b2e0b6e966f87ca6bda282c9fe4df5096::vault::assert_enabled<T0>(arg0);
        let v0 = 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::storage::get_market_id(arg4);
        let v1 = calculate_navi_position_value(0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::account::account_owner(0xb07011a30834315216d4f45deb1e0e2b2e0b6e966f87ca6bda282c9fe4df5096::vault::get_defi_asset_inner<T0, 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::account::AccountCap>(arg0, arg3)), arg4, arg1, arg2);
        let v2 = 0x2::clock::timestamp_ms(arg2);
        let (v3, v4) = record_navi_market_value<T0>(arg0, arg3, v0, v1, v2);
        if (v4) {
            0xb07011a30834315216d4f45deb1e0e2b2e0b6e966f87ca6bda282c9fe4df5096::vault::finish_update_asset_value<T0>(arg0, arg3, v3, v2);
        };
    }

    // decompiled from Move bytecode v7
}

