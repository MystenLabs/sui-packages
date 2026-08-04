module 0x1cd46539840a60ea47f12b6b3b20c4afa2ebbba5eb6efdd077bb03cfef11ca8::navi_adaptor {
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

    struct NaviMarketRegistryInitialized has copy, drop {
        vault_id: address,
        migration: bool,
    }

    struct NaviMarketAdded has copy, drop {
        vault_id: address,
        asset_type: 0x1::ascii::String,
        market_id: u64,
    }

    struct NaviMarketRemoved has copy, drop {
        vault_id: address,
        asset_type: 0x1::ascii::String,
        market_id: u64,
    }

    public(friend) fun add_navi_market<T0>(arg0: &mut 0x1cd46539840a60ea47f12b6b3b20c4afa2ebbba5eb6efdd077bb03cfef11ca8::vault::Vault<T0>, arg1: 0x1::ascii::String, arg2: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::storage::Storage) {
        assert_navi_market_empty(0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::account::account_owner(0x1cd46539840a60ea47f12b6b3b20c4afa2ebbba5eb6efdd077bb03cfef11ca8::vault::get_defi_asset_inner<T0, 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::account::AccountCap>(arg0, arg1)), arg2);
        add_navi_market_by_id<T0>(arg0, arg1, 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::storage::get_market_id(arg2));
    }

    fun add_navi_market_by_id<T0>(arg0: &mut 0x1cd46539840a60ea47f12b6b3b20c4afa2ebbba5eb6efdd077bb03cfef11ca8::vault::Vault<T0>, arg1: 0x1::ascii::String, arg2: u64) {
        0x1cd46539840a60ea47f12b6b3b20c4afa2ebbba5eb6efdd077bb03cfef11ca8::vault::check_version<T0>(arg0);
        0x1cd46539840a60ea47f12b6b3b20c4afa2ebbba5eb6efdd077bb03cfef11ca8::vault::assert_enabled<T0>(arg0);
        0x1cd46539840a60ea47f12b6b3b20c4afa2ebbba5eb6efdd077bb03cfef11ca8::vault::assert_not_during_operation<T0>(arg0);
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
        let v3 = NaviMarketAdded{
            vault_id   : 0x1cd46539840a60ea47f12b6b3b20c4afa2ebbba5eb6efdd077bb03cfef11ca8::vault::vault_id<T0>(arg0),
            asset_type : arg1,
            market_id  : arg2,
        };
        0x2::event::emit<NaviMarketAdded>(v3);
    }

    fun assert_navi_market_empty(arg0: address, arg1: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::storage::Storage) {
        let v0 = 0;
        while (v0 < 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::storage::get_reserves_count(arg1)) {
            let (v1, v2) = 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::storage::get_user_balance(arg1, v0, arg0);
            assert!(v1 == 0 && v2 == 0, 6005);
            v0 = v0 + 1;
        };
    }

    public fun calculate_navi_position_value(arg0: address, arg1: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::storage::Storage, arg2: &0x1cd46539840a60ea47f12b6b3b20c4afa2ebbba5eb6efdd077bb03cfef11ca8::vault_oracle::OracleConfig, arg3: &0x2::clock::Clock) : u256 {
        let v0 = 0;
        let v1 = 0;
        let v2 = 0;
        while (v2 < 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::storage::get_reserves_count(arg1)) {
            let (v3, v4) = 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::storage::get_user_balance(arg1, v2, arg0);
            let (v5, v6) = 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::dynamic_calculator::calculate_current_index(arg3, arg1, v2);
            let v7 = 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::storage::get_coin_type(arg1, v2);
            if (v3 == 0 && v4 == 0) {
            } else if (v4 == 0 && !0x1cd46539840a60ea47f12b6b3b20c4afa2ebbba5eb6efdd077bb03cfef11ca8::vault_oracle::has_aggregator(arg2, v7)) {
            } else {
                let v8 = 0x1cd46539840a60ea47f12b6b3b20c4afa2ebbba5eb6efdd077bb03cfef11ca8::vault_oracle::get_asset_price(arg2, arg3, v7);
                v0 = v0 + 0x1cd46539840a60ea47f12b6b3b20c4afa2ebbba5eb6efdd077bb03cfef11ca8::vault_utils::mul_with_oracle_price((0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::ray_math::ray_mul(v3, v5) as u256), v8);
                v1 = v1 + 0x1cd46539840a60ea47f12b6b3b20c4afa2ebbba5eb6efdd077bb03cfef11ca8::vault_utils::mul_with_oracle_price((0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::ray_math::ray_mul(v4, v6) as u256), v8);
            };
            v2 = v2 + 1;
        };
        if (v0 < v1) {
            return 0
        };
        v0 - v1
    }

    public fun has_navi_market_registry<T0>(arg0: &0x1cd46539840a60ea47f12b6b3b20c4afa2ebbba5eb6efdd077bb03cfef11ca8::vault::Vault<T0>) : bool {
        let v0 = NaviMarketRegistryKey{dummy_field: false};
        0x2::dynamic_field::exists_with_type<NaviMarketRegistryKey, NaviMarketRegistry>(0x1cd46539840a60ea47f12b6b3b20c4afa2ebbba5eb6efdd077bb03cfef11ca8::vault::vault_uid<T0>(arg0), v0)
    }

    public(friend) fun init_navi_market_registry<T0>(arg0: &mut 0x1cd46539840a60ea47f12b6b3b20c4afa2ebbba5eb6efdd077bb03cfef11ca8::vault::Vault<T0>, arg1: &mut 0x2::tx_context::TxContext) {
        install_registry<T0>(arg0, arg1);
        let v0 = NaviMarketRegistryInitialized{
            vault_id  : 0x1cd46539840a60ea47f12b6b3b20c4afa2ebbba5eb6efdd077bb03cfef11ca8::vault::vault_id<T0>(arg0),
            migration : false,
        };
        0x2::event::emit<NaviMarketRegistryInitialized>(v0);
    }

    public(friend) fun init_navi_market_registry_for_migration<T0>(arg0: &mut 0x1cd46539840a60ea47f12b6b3b20c4afa2ebbba5eb6efdd077bb03cfef11ca8::vault::Vault<T0>, arg1: &0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::storage::Storage, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::clock::timestamp_ms(arg2) < 1786752000000, 6006);
        assert!(0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::storage::get_market_id(arg1) == 0, 6007);
        0x1cd46539840a60ea47f12b6b3b20c4afa2ebbba5eb6efdd077bb03cfef11ca8::vault::assert_not_during_operation<T0>(arg0);
        install_registry<T0>(arg0, arg3);
        let v0 = NaviMarketRegistryInitialized{
            vault_id  : 0x1cd46539840a60ea47f12b6b3b20c4afa2ebbba5eb6efdd077bb03cfef11ca8::vault::vault_id<T0>(arg0),
            migration : true,
        };
        0x2::event::emit<NaviMarketRegistryInitialized>(v0);
        let v1 = *0x1cd46539840a60ea47f12b6b3b20c4afa2ebbba5eb6efdd077bb03cfef11ca8::vault::asset_types<T0>(arg0);
        let v2 = &v1;
        let v3 = 0;
        while (v3 < 0x1::vector::length<0x1::ascii::String>(v2)) {
            let v4 = 0x1::vector::borrow<0x1::ascii::String>(v2, v3);
            if (0x1cd46539840a60ea47f12b6b3b20c4afa2ebbba5eb6efdd077bb03cfef11ca8::vault::contains_defi_asset_of_type<T0, 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::account::AccountCap>(arg0, *v4)) {
                add_navi_market_by_id<T0>(arg0, *v4, 0);
            };
            v3 = v3 + 1;
        };
    }

    fun install_registry<T0>(arg0: &mut 0x1cd46539840a60ea47f12b6b3b20c4afa2ebbba5eb6efdd077bb03cfef11ca8::vault::Vault<T0>, arg1: &mut 0x2::tx_context::TxContext) {
        0x1cd46539840a60ea47f12b6b3b20c4afa2ebbba5eb6efdd077bb03cfef11ca8::vault::check_version<T0>(arg0);
        let v0 = NaviMarketRegistryKey{dummy_field: false};
        let v1 = NaviMarketRegistry{markets: 0x2::table::new<0x1::ascii::String, 0x2::vec_map::VecMap<u64, NaviMarketState>>(arg1)};
        0x2::dynamic_field::add<NaviMarketRegistryKey, NaviMarketRegistry>(0x1cd46539840a60ea47f12b6b3b20c4afa2ebbba5eb6efdd077bb03cfef11ca8::vault::vault_id_mut<T0>(arg0), v0, v1);
    }

    public fun navi_market_ids<T0>(arg0: &0x1cd46539840a60ea47f12b6b3b20c4afa2ebbba5eb6efdd077bb03cfef11ca8::vault::Vault<T0>, arg1: 0x1::ascii::String) : vector<u64> {
        if (!has_navi_market_registry<T0>(arg0)) {
            return vector[]
        };
        let v0 = registry<T0>(arg0);
        if (!0x2::table::contains<0x1::ascii::String, 0x2::vec_map::VecMap<u64, NaviMarketState>>(&v0.markets, arg1)) {
            return vector[]
        };
        0x2::vec_map::keys<u64, NaviMarketState>(0x2::table::borrow<0x1::ascii::String, 0x2::vec_map::VecMap<u64, NaviMarketState>>(&v0.markets, arg1))
    }

    fun record_navi_market_value<T0>(arg0: &mut 0x1cd46539840a60ea47f12b6b3b20c4afa2ebbba5eb6efdd077bb03cfef11ca8::vault::Vault<T0>, arg1: 0x1::ascii::String, arg2: u64, arg3: u256, arg4: u64) : (u256, bool) {
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

    fun registry<T0>(arg0: &0x1cd46539840a60ea47f12b6b3b20c4afa2ebbba5eb6efdd077bb03cfef11ca8::vault::Vault<T0>) : &NaviMarketRegistry {
        let v0 = NaviMarketRegistryKey{dummy_field: false};
        0x2::dynamic_field::borrow<NaviMarketRegistryKey, NaviMarketRegistry>(0x1cd46539840a60ea47f12b6b3b20c4afa2ebbba5eb6efdd077bb03cfef11ca8::vault::vault_uid<T0>(arg0), v0)
    }

    fun registry_mut<T0>(arg0: &mut 0x1cd46539840a60ea47f12b6b3b20c4afa2ebbba5eb6efdd077bb03cfef11ca8::vault::Vault<T0>) : &mut NaviMarketRegistry {
        let v0 = NaviMarketRegistryKey{dummy_field: false};
        0x2::dynamic_field::borrow_mut<NaviMarketRegistryKey, NaviMarketRegistry>(0x1cd46539840a60ea47f12b6b3b20c4afa2ebbba5eb6efdd077bb03cfef11ca8::vault::vault_id_mut<T0>(arg0), v0)
    }

    public(friend) fun remove_navi_market<T0>(arg0: &mut 0x1cd46539840a60ea47f12b6b3b20c4afa2ebbba5eb6efdd077bb03cfef11ca8::vault::Vault<T0>, arg1: 0x1::ascii::String, arg2: u64, arg3: &0x2::clock::Clock) {
        0x1cd46539840a60ea47f12b6b3b20c4afa2ebbba5eb6efdd077bb03cfef11ca8::vault::check_version<T0>(arg0);
        0x1cd46539840a60ea47f12b6b3b20c4afa2ebbba5eb6efdd077bb03cfef11ca8::vault::assert_enabled<T0>(arg0);
        0x1cd46539840a60ea47f12b6b3b20c4afa2ebbba5eb6efdd077bb03cfef11ca8::vault::assert_not_during_operation<T0>(arg0);
        let v0 = registry_mut<T0>(arg0);
        assert!(0x2::table::contains<0x1::ascii::String, 0x2::vec_map::VecMap<u64, NaviMarketState>>(&v0.markets, arg1), 6001);
        let v1 = 0x2::table::borrow_mut<0x1::ascii::String, 0x2::vec_map::VecMap<u64, NaviMarketState>>(&mut v0.markets, arg1);
        assert!(0x2::vec_map::contains<u64, NaviMarketState>(v1, &arg2), 6001);
        let v2 = 0x2::vec_map::get<u64, NaviMarketState>(v1, &arg2);
        assert!(v2.value == 0, 6003);
        assert!(v2.updated_at == 0x2::clock::timestamp_ms(arg3), 6004);
        let (_, _) = 0x2::vec_map::remove<u64, NaviMarketState>(v1, &arg2);
        let v5 = NaviMarketRemoved{
            vault_id   : 0x1cd46539840a60ea47f12b6b3b20c4afa2ebbba5eb6efdd077bb03cfef11ca8::vault::vault_id<T0>(arg0),
            asset_type : arg1,
            market_id  : arg2,
        };
        0x2::event::emit<NaviMarketRemoved>(v5);
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

    public(friend) fun reset_navi_market_sync<T0>(arg0: &mut 0x1cd46539840a60ea47f12b6b3b20c4afa2ebbba5eb6efdd077bb03cfef11ca8::vault::Vault<T0>, arg1: 0x1::ascii::String) {
        let v0 = 0x2::table::borrow_mut<0x1::ascii::String, 0x2::vec_map::VecMap<u64, NaviMarketState>>(&mut registry_mut<T0>(arg0).markets, arg1);
        reset_market_sync(v0);
    }

    public fun update_navi_position_value<T0>(arg0: &mut 0x1cd46539840a60ea47f12b6b3b20c4afa2ebbba5eb6efdd077bb03cfef11ca8::vault::Vault<T0>, arg1: &0x1cd46539840a60ea47f12b6b3b20c4afa2ebbba5eb6efdd077bb03cfef11ca8::vault_oracle::OracleConfig, arg2: &0x2::clock::Clock, arg3: 0x1::ascii::String, arg4: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::storage::Storage) {
        0x1cd46539840a60ea47f12b6b3b20c4afa2ebbba5eb6efdd077bb03cfef11ca8::vault::check_version<T0>(arg0);
        0x1cd46539840a60ea47f12b6b3b20c4afa2ebbba5eb6efdd077bb03cfef11ca8::vault::assert_enabled<T0>(arg0);
        let v0 = 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::storage::get_market_id(arg4);
        let v1 = calculate_navi_position_value(0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::account::account_owner(0x1cd46539840a60ea47f12b6b3b20c4afa2ebbba5eb6efdd077bb03cfef11ca8::vault::get_defi_asset_inner<T0, 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::account::AccountCap>(arg0, arg3)), arg4, arg1, arg2);
        let v2 = 0x2::clock::timestamp_ms(arg2);
        let (v3, v4) = record_navi_market_value<T0>(arg0, arg3, v0, v1, v2);
        if (v4) {
            0x1cd46539840a60ea47f12b6b3b20c4afa2ebbba5eb6efdd077bb03cfef11ca8::vault::finish_update_asset_value<T0>(arg0, arg3, v3, v2);
        };
    }

    // decompiled from Move bytecode v7
}

