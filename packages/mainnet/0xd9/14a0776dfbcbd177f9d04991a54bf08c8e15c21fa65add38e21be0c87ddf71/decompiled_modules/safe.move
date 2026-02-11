module 0xc6fe01f6d663198656ed9bcf77ee9f2a13306ae17a397fea7c00a5f69928e29d::safe {
    struct MigrationStarted has copy, drop {
        compatible_versions: vector<u64>,
    }

    struct MigrationAborted has copy, drop {
        compatible_versions: vector<u64>,
    }

    struct MigrationCompleted has copy, drop {
        compatible_versions: vector<u64>,
    }

    struct BridgeSafe has key {
        id: 0x2::object::UID,
        pause: 0xc6fe01f6d663198656ed9bcf77ee9f2a13306ae17a397fea7c00a5f69928e29d::pausable::Pause,
        roles: 0xc6fe01f6d663198656ed9bcf77ee9f2a13306ae17a397fea7c00a5f69928e29d::bridge_roles::Roles<0xc6fe01f6d663198656ed9bcf77ee9f2a13306ae17a397fea7c00a5f69928e29d::bridge_roles::BridgeSafeTag>,
        bridge_addr: address,
        batch_size: u16,
        batch_timeout_ms: u64,
        batch_settle_timeout_ms: u64,
        batches_count: u64,
        deposits_count: u64,
        token_cfg: 0x2::table::Table<vector<u8>, 0xc6fe01f6d663198656ed9bcf77ee9f2a13306ae17a397fea7c00a5f69928e29d::shared_structs::TokenConfig>,
        batches: 0x2::table::Table<u64, 0xc6fe01f6d663198656ed9bcf77ee9f2a13306ae17a397fea7c00a5f69928e29d::shared_structs::Batch>,
        batch_deposits: 0x2::table::Table<u64, vector<0xc6fe01f6d663198656ed9bcf77ee9f2a13306ae17a397fea7c00a5f69928e29d::shared_structs::Deposit>>,
        coin_storage: 0x2::bag::Bag,
        from_coin_cap: 0x8db9d9dc5cd5723ee55725869620073e28f88ddf3c360a512ebd73cb46f1903d::treasury::FromCoinCap<0x8db9d9dc5cd5723ee55725869620073e28f88ddf3c360a512ebd73cb46f1903d::bridge_token::BRIDGE_TOKEN>,
        compatible_versions: 0x2::vec_set::VecSet<u64>,
    }

    struct SAFE has drop {
        dummy_field: bool,
    }

    public(friend) fun transfer<T0>(arg0: &mut BridgeSafe, arg1: &0xc6fe01f6d663198656ed9bcf77ee9f2a13306ae17a397fea7c00a5f69928e29d::bridge_roles::BridgeCap, arg2: address, arg3: u64, arg4: &mut 0x8db9d9dc5cd5723ee55725869620073e28f88ddf3c360a512ebd73cb46f1903d::treasury::Treasury<0x8db9d9dc5cd5723ee55725869620073e28f88ddf3c360a512ebd73cb46f1903d::bridge_token::BRIDGE_TOKEN>, arg5: &mut 0x2::tx_context::TxContext) : bool {
        let v0 = 0xc6fe01f6d663198656ed9bcf77ee9f2a13306ae17a397fea7c00a5f69928e29d::utils::type_name_bytes<T0>();
        if (!0x2::table::contains<vector<u8>, 0xc6fe01f6d663198656ed9bcf77ee9f2a13306ae17a397fea7c00a5f69928e29d::shared_structs::TokenConfig>(&arg0.token_cfg, v0)) {
            return false
        };
        let v1 = 0x2::table::borrow<vector<u8>, 0xc6fe01f6d663198656ed9bcf77ee9f2a13306ae17a397fea7c00a5f69928e29d::shared_structs::TokenConfig>(&arg0.token_cfg, v0);
        if (0xc6fe01f6d663198656ed9bcf77ee9f2a13306ae17a397fea7c00a5f69928e29d::shared_structs::token_config_total_balance(v1) < arg3) {
            return false
        };
        if (!0x2::bag::contains<vector<u8>>(&arg0.coin_storage, v0)) {
            return false
        };
        if (!0xc6fe01f6d663198656ed9bcf77ee9f2a13306ae17a397fea7c00a5f69928e29d::shared_structs::get_token_config_is_locked(v1)) {
            let v2 = 0x2::bag::borrow_mut<vector<u8>, 0x2::coin::Coin<T0>>(&mut arg0.coin_storage, v0);
            if (0x2::coin::value<T0>(v2) < arg3) {
                return false
            };
            if (0x2::coin::value<T0>(v2) == 0) {
                0x2::coin::destroy_zero<T0>(0x2::bag::remove<vector<u8>, 0x2::coin::Coin<T0>>(&mut arg0.coin_storage, v0));
            };
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::split<T0>(v2, arg3, arg5), arg2);
        } else {
            0x8db9d9dc5cd5723ee55725869620073e28f88ddf3c360a512ebd73cb46f1903d::treasury::transfer_from_coin<0x8db9d9dc5cd5723ee55725869620073e28f88ddf3c360a512ebd73cb46f1903d::bridge_token::BRIDGE_TOKEN>(arg4, arg2, &arg0.from_coin_cap, 0x2::coin::split<0x8db9d9dc5cd5723ee55725869620073e28f88ddf3c360a512ebd73cb46f1903d::bridge_token::BRIDGE_TOKEN>(0x2::bag::borrow_mut<vector<u8>, 0x2::coin::Coin<0x8db9d9dc5cd5723ee55725869620073e28f88ddf3c360a512ebd73cb46f1903d::bridge_token::BRIDGE_TOKEN>>(&mut arg0.coin_storage, v0), arg3, arg5), arg5);
        };
        0xc6fe01f6d663198656ed9bcf77ee9f2a13306ae17a397fea7c00a5f69928e29d::shared_structs::subtract_from_token_config_total_balance(borrow_token_cfg_mut(arg0, v0), arg3);
        true
    }

    public fun abort_migration(arg0: &mut BridgeSafe, arg1: &0x2::tx_context::TxContext) {
        0xe0917b74a5912e4ad186ac634e29c922ab83903f71af7500969f9411706f9b9a::two_step_role::assert_sender_is_active_role<0xc6fe01f6d663198656ed9bcf77ee9f2a13306ae17a397fea7c00a5f69928e29d::bridge_roles::OwnerRole<0xc6fe01f6d663198656ed9bcf77ee9f2a13306ae17a397fea7c00a5f69928e29d::bridge_roles::BridgeSafeTag>>(0xc6fe01f6d663198656ed9bcf77ee9f2a13306ae17a397fea7c00a5f69928e29d::bridge_roles::owner_role<0xc6fe01f6d663198656ed9bcf77ee9f2a13306ae17a397fea7c00a5f69928e29d::bridge_roles::BridgeSafeTag>(&arg0.roles), arg1);
        assert!(0x2::vec_set::length<u64>(&arg0.compatible_versions) == 2, 17);
        let v0 = 0x1::u64::max(*0x1::vector::borrow<u64>(0x2::vec_set::keys<u64>(&arg0.compatible_versions), 0), *0x1::vector::borrow<u64>(0x2::vec_set::keys<u64>(&arg0.compatible_versions), 1));
        assert!(v0 == 0xc6fe01f6d663198656ed9bcf77ee9f2a13306ae17a397fea7c00a5f69928e29d::bridge_version_control::current_version(), 18);
        0x2::vec_set::remove<u64>(&mut arg0.compatible_versions, &v0);
        let v1 = MigrationAborted{compatible_versions: *0x2::vec_set::keys<u64>(&arg0.compatible_versions)};
        0x2::event::emit<MigrationAborted>(v1);
    }

    public fun accept_ownership(arg0: &mut BridgeSafe, arg1: &0x2::tx_context::TxContext) {
        0xe0917b74a5912e4ad186ac634e29c922ab83903f71af7500969f9411706f9b9a::two_step_role::accept_role<0xc6fe01f6d663198656ed9bcf77ee9f2a13306ae17a397fea7c00a5f69928e29d::bridge_roles::OwnerRole<0xc6fe01f6d663198656ed9bcf77ee9f2a13306ae17a397fea7c00a5f69928e29d::bridge_roles::BridgeSafeTag>>(0xc6fe01f6d663198656ed9bcf77ee9f2a13306ae17a397fea7c00a5f69928e29d::bridge_roles::owner_role_mut<0xc6fe01f6d663198656ed9bcf77ee9f2a13306ae17a397fea7c00a5f69928e29d::bridge_roles::BridgeSafeTag>(roles_mut(arg0)), arg1);
    }

    public(friend) fun assert_is_compatible(arg0: &BridgeSafe) {
        0xc6fe01f6d663198656ed9bcf77ee9f2a13306ae17a397fea7c00a5f69928e29d::bridge_version_control::assert_object_version_is_compatible_with_package(arg0.compatible_versions);
    }

    fun borrow_token_cfg_mut(arg0: &mut BridgeSafe, arg1: vector<u8>) : &mut 0xc6fe01f6d663198656ed9bcf77ee9f2a13306ae17a397fea7c00a5f69928e29d::shared_structs::TokenConfig {
        0x2::table::borrow_mut<vector<u8>, 0xc6fe01f6d663198656ed9bcf77ee9f2a13306ae17a397fea7c00a5f69928e29d::shared_structs::TokenConfig>(&mut arg0.token_cfg, arg1)
    }

    public(friend) fun checkOwnerRole(arg0: &BridgeSafe, arg1: &0x2::tx_context::TxContext) {
        0xe0917b74a5912e4ad186ac634e29c922ab83903f71af7500969f9411706f9b9a::two_step_role::assert_sender_is_active_role<0xc6fe01f6d663198656ed9bcf77ee9f2a13306ae17a397fea7c00a5f69928e29d::bridge_roles::OwnerRole<0xc6fe01f6d663198656ed9bcf77ee9f2a13306ae17a397fea7c00a5f69928e29d::bridge_roles::BridgeSafeTag>>(0xc6fe01f6d663198656ed9bcf77ee9f2a13306ae17a397fea7c00a5f69928e29d::bridge_roles::owner_role<0xc6fe01f6d663198656ed9bcf77ee9f2a13306ae17a397fea7c00a5f69928e29d::bridge_roles::BridgeSafeTag>(&arg0.roles), arg1);
    }

    public fun compatible_versions(arg0: &BridgeSafe) : vector<u64> {
        *0x2::vec_set::keys<u64>(&arg0.compatible_versions)
    }

    public fun complete_migration(arg0: &mut BridgeSafe, arg1: &0x2::tx_context::TxContext) {
        0xe0917b74a5912e4ad186ac634e29c922ab83903f71af7500969f9411706f9b9a::two_step_role::assert_sender_is_active_role<0xc6fe01f6d663198656ed9bcf77ee9f2a13306ae17a397fea7c00a5f69928e29d::bridge_roles::OwnerRole<0xc6fe01f6d663198656ed9bcf77ee9f2a13306ae17a397fea7c00a5f69928e29d::bridge_roles::BridgeSafeTag>>(0xc6fe01f6d663198656ed9bcf77ee9f2a13306ae17a397fea7c00a5f69928e29d::bridge_roles::owner_role<0xc6fe01f6d663198656ed9bcf77ee9f2a13306ae17a397fea7c00a5f69928e29d::bridge_roles::BridgeSafeTag>(&arg0.roles), arg1);
        assert!(0x2::vec_set::length<u64>(&arg0.compatible_versions) == 2, 17);
        let v0 = *0x1::vector::borrow<u64>(0x2::vec_set::keys<u64>(&arg0.compatible_versions), 0);
        let v1 = *0x1::vector::borrow<u64>(0x2::vec_set::keys<u64>(&arg0.compatible_versions), 1);
        let v2 = 0x1::u64::min(v0, v1);
        assert!(0x1::u64::max(v0, v1) == 0xc6fe01f6d663198656ed9bcf77ee9f2a13306ae17a397fea7c00a5f69928e29d::bridge_version_control::current_version(), 18);
        0x2::vec_set::remove<u64>(&mut arg0.compatible_versions, &v2);
        let v3 = MigrationCompleted{compatible_versions: *0x2::vec_set::keys<u64>(&arg0.compatible_versions)};
        0x2::event::emit<MigrationCompleted>(v3);
    }

    fun create_new_batch_internal(arg0: &mut BridgeSafe, arg1: &0x2::clock::Clock, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.batches_count < 18446744073709551615, 11);
        let v0 = arg0.batches_count + 1;
        0x2::table::add<u64, 0xc6fe01f6d663198656ed9bcf77ee9f2a13306ae17a397fea7c00a5f69928e29d::shared_structs::Batch>(&mut arg0.batches, arg0.batches_count, 0xc6fe01f6d663198656ed9bcf77ee9f2a13306ae17a397fea7c00a5f69928e29d::shared_structs::create_batch(v0, 0x2::clock::timestamp_ms(arg1)));
        arg0.batches_count = v0;
    }

    public fun current_active_version(arg0: &BridgeSafe) : u64 {
        let v0 = 0x2::vec_set::keys<u64>(&arg0.compatible_versions);
        if (0x1::vector::length<u64>(v0) == 1) {
            *0x1::vector::borrow<u64>(v0, 0)
        } else {
            0x1::u64::min(*0x1::vector::borrow<u64>(v0, 0), *0x1::vector::borrow<u64>(v0, 1))
        }
    }

    public fun deposit<T0>(arg0: &mut BridgeSafe, arg1: 0x2::coin::Coin<T0>, arg2: vector<u8>, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        0xc6fe01f6d663198656ed9bcf77ee9f2a13306ae17a397fea7c00a5f69928e29d::pausable::assert_not_paused(&arg0.pause);
        assert!(0x1::vector::length<u8>(&arg2) == 32, 9);
        let v0 = 0xc6fe01f6d663198656ed9bcf77ee9f2a13306ae17a397fea7c00a5f69928e29d::utils::type_name_bytes<T0>();
        let v1 = 0x2::table::borrow<vector<u8>, 0xc6fe01f6d663198656ed9bcf77ee9f2a13306ae17a397fea7c00a5f69928e29d::shared_structs::TokenConfig>(&arg0.token_cfg, v0);
        assert!(0xc6fe01f6d663198656ed9bcf77ee9f2a13306ae17a397fea7c00a5f69928e29d::shared_structs::token_config_whitelisted(v1), 5);
        let v2 = 0x2::coin::value<T0>(&arg1);
        assert!(v2 > 0, 10);
        assert!(v2 >= 0xc6fe01f6d663198656ed9bcf77ee9f2a13306ae17a397fea7c00a5f69928e29d::shared_structs::token_config_min_limit(v1), 6);
        assert!(v2 <= 0xc6fe01f6d663198656ed9bcf77ee9f2a13306ae17a397fea7c00a5f69928e29d::shared_structs::token_config_max_limit(v1), 7);
        if (should_create_new_batch_internal(arg0, arg3)) {
            create_new_batch_internal(arg0, arg3, arg4);
        };
        let v3 = arg0.batches_count - 1;
        let v4 = 0x2::table::borrow_mut<u64, 0xc6fe01f6d663198656ed9bcf77ee9f2a13306ae17a397fea7c00a5f69928e29d::shared_structs::Batch>(&mut arg0.batches, v3);
        assert!(arg0.deposits_count < 18446744073709551615, 11);
        let v5 = arg0.deposits_count + 1;
        if (!0x2::table::contains<u64, vector<0xc6fe01f6d663198656ed9bcf77ee9f2a13306ae17a397fea7c00a5f69928e29d::shared_structs::Deposit>>(&arg0.batch_deposits, v3)) {
            0x2::table::add<u64, vector<0xc6fe01f6d663198656ed9bcf77ee9f2a13306ae17a397fea7c00a5f69928e29d::shared_structs::Deposit>>(&mut arg0.batch_deposits, v3, 0x1::vector::empty<0xc6fe01f6d663198656ed9bcf77ee9f2a13306ae17a397fea7c00a5f69928e29d::shared_structs::Deposit>());
        };
        0x1::vector::push_back<0xc6fe01f6d663198656ed9bcf77ee9f2a13306ae17a397fea7c00a5f69928e29d::shared_structs::Deposit>(0x2::table::borrow_mut<u64, vector<0xc6fe01f6d663198656ed9bcf77ee9f2a13306ae17a397fea7c00a5f69928e29d::shared_structs::Deposit>>(&mut arg0.batch_deposits, v3), 0xc6fe01f6d663198656ed9bcf77ee9f2a13306ae17a397fea7c00a5f69928e29d::shared_structs::create_deposit(v5, v0, v2, 0x2::tx_context::sender(arg4), arg2));
        arg0.deposits_count = v5;
        0xc6fe01f6d663198656ed9bcf77ee9f2a13306ae17a397fea7c00a5f69928e29d::shared_structs::increment_batch_deposits(v4);
        0xc6fe01f6d663198656ed9bcf77ee9f2a13306ae17a397fea7c00a5f69928e29d::shared_structs::set_batch_last_updated_timestamp_ms(v4, 0x2::clock::timestamp_ms(arg3));
        let v6 = borrow_token_cfg_mut(arg0, v0);
        0xc6fe01f6d663198656ed9bcf77ee9f2a13306ae17a397fea7c00a5f69928e29d::shared_structs::add_to_token_config_total_balance(v6, v2);
        if (0x2::bag::contains<vector<u8>>(&arg0.coin_storage, v0)) {
            0x2::coin::join<T0>(0x2::bag::borrow_mut<vector<u8>, 0x2::coin::Coin<T0>>(&mut arg0.coin_storage, v0), arg1);
        } else {
            0x2::bag::add<vector<u8>, 0x2::coin::Coin<T0>>(&mut arg0.coin_storage, v0, arg1);
        };
        0xc6fe01f6d663198656ed9bcf77ee9f2a13306ae17a397fea7c00a5f69928e29d::events::emit_deposit_v1(0xc6fe01f6d663198656ed9bcf77ee9f2a13306ae17a397fea7c00a5f69928e29d::shared_structs::batch_nonce(v4), v5, 0x2::tx_context::sender(arg4), arg2, v2, v0);
    }

    public fun get_batch(arg0: &BridgeSafe, arg1: u64, arg2: &0x2::clock::Clock) : (0xc6fe01f6d663198656ed9bcf77ee9f2a13306ae17a397fea7c00a5f69928e29d::shared_structs::Batch, bool) {
        assert!(arg1 > 0, 12);
        let v0 = arg1 - 1;
        if (!0x2::table::contains<u64, 0xc6fe01f6d663198656ed9bcf77ee9f2a13306ae17a397fea7c00a5f69928e29d::shared_structs::Batch>(&arg0.batches, v0)) {
            return (0xc6fe01f6d663198656ed9bcf77ee9f2a13306ae17a397fea7c00a5f69928e29d::shared_structs::create_batch(0, 0), false)
        };
        let v1 = *0x2::table::borrow<u64, 0xc6fe01f6d663198656ed9bcf77ee9f2a13306ae17a397fea7c00a5f69928e29d::shared_structs::Batch>(&arg0.batches, v0);
        (v1, is_batch_final_internal(arg0, &v1, arg2))
    }

    public fun get_batch_deposits_count(arg0: &0xc6fe01f6d663198656ed9bcf77ee9f2a13306ae17a397fea7c00a5f69928e29d::shared_structs::Batch) : u16 {
        0xc6fe01f6d663198656ed9bcf77ee9f2a13306ae17a397fea7c00a5f69928e29d::shared_structs::batch_deposits_count(arg0)
    }

    public fun get_batch_nonce(arg0: &0xc6fe01f6d663198656ed9bcf77ee9f2a13306ae17a397fea7c00a5f69928e29d::shared_structs::Batch) : u64 {
        0xc6fe01f6d663198656ed9bcf77ee9f2a13306ae17a397fea7c00a5f69928e29d::shared_structs::batch_nonce(arg0)
    }

    public fun get_batch_settle_timeout_ms(arg0: &BridgeSafe) : u64 {
        arg0.batch_settle_timeout_ms
    }

    public fun get_batch_size(arg0: &BridgeSafe) : u16 {
        arg0.batch_size
    }

    public fun get_batch_timeout_ms(arg0: &BridgeSafe) : u64 {
        arg0.batch_timeout_ms
    }

    public fun get_batches_count(arg0: &BridgeSafe) : u64 {
        arg0.batches_count
    }

    public fun get_bridge_addr(arg0: &BridgeSafe) : address {
        arg0.bridge_addr
    }

    public fun get_coin_storage_balance<T0>(arg0: &BridgeSafe) : u64 {
        let v0 = 0xc6fe01f6d663198656ed9bcf77ee9f2a13306ae17a397fea7c00a5f69928e29d::utils::type_name_bytes<T0>();
        if (!0x2::bag::contains<vector<u8>>(&arg0.coin_storage, v0)) {
            return 0
        };
        0x2::coin::value<T0>(0x2::bag::borrow<vector<u8>, 0x2::coin::Coin<T0>>(&arg0.coin_storage, v0))
    }

    public fun get_deposits(arg0: &BridgeSafe, arg1: u64, arg2: &0x2::clock::Clock) : (vector<0xc6fe01f6d663198656ed9bcf77ee9f2a13306ae17a397fea7c00a5f69928e29d::shared_structs::Deposit>, bool) {
        assert!(arg1 > 0, 12);
        let v0 = arg1 - 1;
        let v1 = if (0x2::table::contains<u64, vector<0xc6fe01f6d663198656ed9bcf77ee9f2a13306ae17a397fea7c00a5f69928e29d::shared_structs::Deposit>>(&arg0.batch_deposits, v0)) {
            *0x2::table::borrow<u64, vector<0xc6fe01f6d663198656ed9bcf77ee9f2a13306ae17a397fea7c00a5f69928e29d::shared_structs::Deposit>>(&arg0.batch_deposits, v0)
        } else {
            0x1::vector::empty<0xc6fe01f6d663198656ed9bcf77ee9f2a13306ae17a397fea7c00a5f69928e29d::shared_structs::Deposit>()
        };
        if (!0x2::table::contains<u64, 0xc6fe01f6d663198656ed9bcf77ee9f2a13306ae17a397fea7c00a5f69928e29d::shared_structs::Batch>(&arg0.batches, v0)) {
            return (v1, false)
        };
        (v1, is_batch_final_internal(arg0, 0x2::table::borrow<u64, 0xc6fe01f6d663198656ed9bcf77ee9f2a13306ae17a397fea7c00a5f69928e29d::shared_structs::Batch>(&arg0.batches, v0), arg2))
    }

    public fun get_deposits_count(arg0: &BridgeSafe) : u64 {
        arg0.deposits_count
    }

    public fun get_owner(arg0: &BridgeSafe) : address {
        0xc6fe01f6d663198656ed9bcf77ee9f2a13306ae17a397fea7c00a5f69928e29d::bridge_roles::owner<0xc6fe01f6d663198656ed9bcf77ee9f2a13306ae17a397fea7c00a5f69928e29d::bridge_roles::BridgeSafeTag>(&arg0.roles)
    }

    public fun get_pause(arg0: &BridgeSafe) : &0xc6fe01f6d663198656ed9bcf77ee9f2a13306ae17a397fea7c00a5f69928e29d::pausable::Pause {
        &arg0.pause
    }

    public fun get_pause_mut(arg0: &mut BridgeSafe) : &mut 0xc6fe01f6d663198656ed9bcf77ee9f2a13306ae17a397fea7c00a5f69928e29d::pausable::Pause {
        &mut arg0.pause
    }

    public fun get_pending_owner(arg0: &BridgeSafe) : 0x1::option::Option<address> {
        0xc6fe01f6d663198656ed9bcf77ee9f2a13306ae17a397fea7c00a5f69928e29d::bridge_roles::pending_owner<0xc6fe01f6d663198656ed9bcf77ee9f2a13306ae17a397fea7c00a5f69928e29d::bridge_roles::BridgeSafeTag>(&arg0.roles)
    }

    public fun get_stored_coin_balance<T0>(arg0: &mut BridgeSafe) : u64 {
        let v0 = 0xc6fe01f6d663198656ed9bcf77ee9f2a13306ae17a397fea7c00a5f69928e29d::utils::type_name_bytes<T0>();
        if (!0x2::table::contains<vector<u8>, 0xc6fe01f6d663198656ed9bcf77ee9f2a13306ae17a397fea7c00a5f69928e29d::shared_structs::TokenConfig>(&arg0.token_cfg, v0)) {
            return 0
        };
        0xc6fe01f6d663198656ed9bcf77ee9f2a13306ae17a397fea7c00a5f69928e29d::shared_structs::token_config_total_balance(0x2::table::borrow<vector<u8>, 0xc6fe01f6d663198656ed9bcf77ee9f2a13306ae17a397fea7c00a5f69928e29d::shared_structs::TokenConfig>(&arg0.token_cfg, v0))
    }

    public fun get_token_is_mint_burn<T0>(arg0: &BridgeSafe) : bool {
        0xc6fe01f6d663198656ed9bcf77ee9f2a13306ae17a397fea7c00a5f69928e29d::shared_structs::token_config_is_mint_burn(0x2::table::borrow<vector<u8>, 0xc6fe01f6d663198656ed9bcf77ee9f2a13306ae17a397fea7c00a5f69928e29d::shared_structs::TokenConfig>(&arg0.token_cfg, 0xc6fe01f6d663198656ed9bcf77ee9f2a13306ae17a397fea7c00a5f69928e29d::utils::type_name_bytes<T0>()))
    }

    public fun get_token_is_native<T0>(arg0: &BridgeSafe) : bool {
        0xc6fe01f6d663198656ed9bcf77ee9f2a13306ae17a397fea7c00a5f69928e29d::shared_structs::token_config_is_native(0x2::table::borrow<vector<u8>, 0xc6fe01f6d663198656ed9bcf77ee9f2a13306ae17a397fea7c00a5f69928e29d::shared_structs::TokenConfig>(&arg0.token_cfg, 0xc6fe01f6d663198656ed9bcf77ee9f2a13306ae17a397fea7c00a5f69928e29d::utils::type_name_bytes<T0>()))
    }

    public fun get_token_max_limit<T0>(arg0: &BridgeSafe) : u64 {
        0xc6fe01f6d663198656ed9bcf77ee9f2a13306ae17a397fea7c00a5f69928e29d::shared_structs::token_config_max_limit(0x2::table::borrow<vector<u8>, 0xc6fe01f6d663198656ed9bcf77ee9f2a13306ae17a397fea7c00a5f69928e29d::shared_structs::TokenConfig>(&arg0.token_cfg, 0xc6fe01f6d663198656ed9bcf77ee9f2a13306ae17a397fea7c00a5f69928e29d::utils::type_name_bytes<T0>()))
    }

    public fun get_token_min_limit<T0>(arg0: &BridgeSafe) : u64 {
        0xc6fe01f6d663198656ed9bcf77ee9f2a13306ae17a397fea7c00a5f69928e29d::shared_structs::token_config_min_limit(0x2::table::borrow<vector<u8>, 0xc6fe01f6d663198656ed9bcf77ee9f2a13306ae17a397fea7c00a5f69928e29d::shared_structs::TokenConfig>(&arg0.token_cfg, 0xc6fe01f6d663198656ed9bcf77ee9f2a13306ae17a397fea7c00a5f69928e29d::utils::type_name_bytes<T0>()))
    }

    fun init(arg0: SAFE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, _) = 0xc6fe01f6d663198656ed9bcf77ee9f2a13306ae17a397fea7c00a5f69928e29d::upgrade_service_bridge::new<SAFE>(arg0, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_share_object<0xc6fe01f6d663198656ed9bcf77ee9f2a13306ae17a397fea7c00a5f69928e29d::upgrade_service_bridge::UpgradeService<SAFE>>(v0);
    }

    public fun init_supply<T0>(arg0: &mut BridgeSafe, arg1: 0x2::coin::Coin<T0>, arg2: &mut 0x2::tx_context::TxContext) {
        0xe0917b74a5912e4ad186ac634e29c922ab83903f71af7500969f9411706f9b9a::two_step_role::assert_sender_is_active_role<0xc6fe01f6d663198656ed9bcf77ee9f2a13306ae17a397fea7c00a5f69928e29d::bridge_roles::OwnerRole<0xc6fe01f6d663198656ed9bcf77ee9f2a13306ae17a397fea7c00a5f69928e29d::bridge_roles::BridgeSafeTag>>(0xc6fe01f6d663198656ed9bcf77ee9f2a13306ae17a397fea7c00a5f69928e29d::bridge_roles::owner_role<0xc6fe01f6d663198656ed9bcf77ee9f2a13306ae17a397fea7c00a5f69928e29d::bridge_roles::BridgeSafeTag>(&arg0.roles), arg2);
        let v0 = 0xc6fe01f6d663198656ed9bcf77ee9f2a13306ae17a397fea7c00a5f69928e29d::utils::type_name_bytes<T0>();
        assert!(0x2::table::contains<vector<u8>, 0xc6fe01f6d663198656ed9bcf77ee9f2a13306ae17a397fea7c00a5f69928e29d::shared_structs::TokenConfig>(&arg0.token_cfg, v0), 5);
        let v1 = 0x2::table::borrow<vector<u8>, 0xc6fe01f6d663198656ed9bcf77ee9f2a13306ae17a397fea7c00a5f69928e29d::shared_structs::TokenConfig>(&arg0.token_cfg, v0);
        assert!(0xc6fe01f6d663198656ed9bcf77ee9f2a13306ae17a397fea7c00a5f69928e29d::shared_structs::token_config_whitelisted(v1), 5);
        assert!(0xc6fe01f6d663198656ed9bcf77ee9f2a13306ae17a397fea7c00a5f69928e29d::shared_structs::token_config_is_native(v1), 8);
        let v2 = borrow_token_cfg_mut(arg0, v0);
        0xc6fe01f6d663198656ed9bcf77ee9f2a13306ae17a397fea7c00a5f69928e29d::shared_structs::add_to_token_config_total_balance(v2, 0x2::coin::value<T0>(&arg1));
        if (0x2::bag::contains<vector<u8>>(&arg0.coin_storage, v0)) {
            0x2::coin::join<T0>(0x2::bag::borrow_mut<vector<u8>, 0x2::coin::Coin<T0>>(&mut arg0.coin_storage, v0), arg1);
        } else {
            0x2::bag::add<vector<u8>, 0x2::coin::Coin<T0>>(&mut arg0.coin_storage, v0, arg1);
        };
    }

    public fun initialize(arg0: 0x8db9d9dc5cd5723ee55725869620073e28f88ddf3c360a512ebd73cb46f1903d::treasury::FromCoinCap<0x8db9d9dc5cd5723ee55725869620073e28f88ddf3c360a512ebd73cb46f1903d::bridge_token::BRIDGE_TOKEN>, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let v1 = BridgeSafe{
            id                      : 0x2::object::new(arg1),
            pause                   : 0xc6fe01f6d663198656ed9bcf77ee9f2a13306ae17a397fea7c00a5f69928e29d::pausable::new(),
            roles                   : 0xc6fe01f6d663198656ed9bcf77ee9f2a13306ae17a397fea7c00a5f69928e29d::bridge_roles::new<0xc6fe01f6d663198656ed9bcf77ee9f2a13306ae17a397fea7c00a5f69928e29d::bridge_roles::BridgeSafeTag>(v0, arg1),
            bridge_addr             : v0,
            batch_size              : 10,
            batch_timeout_ms        : 5000,
            batch_settle_timeout_ms : 10000,
            batches_count           : 0,
            deposits_count          : 0,
            token_cfg               : 0x2::table::new<vector<u8>, 0xc6fe01f6d663198656ed9bcf77ee9f2a13306ae17a397fea7c00a5f69928e29d::shared_structs::TokenConfig>(arg1),
            batches                 : 0x2::table::new<u64, 0xc6fe01f6d663198656ed9bcf77ee9f2a13306ae17a397fea7c00a5f69928e29d::shared_structs::Batch>(arg1),
            batch_deposits          : 0x2::table::new<u64, vector<0xc6fe01f6d663198656ed9bcf77ee9f2a13306ae17a397fea7c00a5f69928e29d::shared_structs::Deposit>>(arg1),
            coin_storage            : 0x2::bag::new(arg1),
            from_coin_cap           : arg0,
            compatible_versions     : 0x2::vec_set::singleton<u64>(0xc6fe01f6d663198656ed9bcf77ee9f2a13306ae17a397fea7c00a5f69928e29d::bridge_version_control::current_version()),
        };
        0x2::transfer::public_transfer<0xc6fe01f6d663198656ed9bcf77ee9f2a13306ae17a397fea7c00a5f69928e29d::bridge_roles::BridgeCap>(0xc6fe01f6d663198656ed9bcf77ee9f2a13306ae17a397fea7c00a5f69928e29d::bridge_roles::publish_caps(0xc6fe01f6d663198656ed9bcf77ee9f2a13306ae17a397fea7c00a5f69928e29d::bridge_roles::grant_witness(), arg1), v0);
        0x2::transfer::share_object<BridgeSafe>(v1);
    }

    public fun is_any_batch_in_progress(arg0: &BridgeSafe, arg1: &0x2::clock::Clock) : bool {
        is_any_batch_in_progress_internal(arg0, arg1)
    }

    fun is_any_batch_in_progress_internal(arg0: &BridgeSafe, arg1: &0x2::clock::Clock) : bool {
        if (arg0.batches_count == 0) {
            return false
        };
        if (!should_create_new_batch_internal(arg0, arg1)) {
            return true
        };
        !is_batch_final_internal(arg0, 0x2::table::borrow<u64, 0xc6fe01f6d663198656ed9bcf77ee9f2a13306ae17a397fea7c00a5f69928e29d::shared_structs::Batch>(&arg0.batches, arg0.batches_count - 1), arg1)
    }

    fun is_batch_final_internal(arg0: &BridgeSafe, arg1: &0xc6fe01f6d663198656ed9bcf77ee9f2a13306ae17a397fea7c00a5f69928e29d::shared_structs::Batch, arg2: &0x2::clock::Clock) : bool {
        0xc6fe01f6d663198656ed9bcf77ee9f2a13306ae17a397fea7c00a5f69928e29d::shared_structs::batch_last_updated_timestamp_ms(arg1) + arg0.batch_settle_timeout_ms <= 0x2::clock::timestamp_ms(arg2)
    }

    fun is_batch_progress_over_internal(arg0: &BridgeSafe, arg1: u16, arg2: u64, arg3: &0x2::clock::Clock) : bool {
        if (arg1 == 0) {
            return false
        };
        arg2 + arg0.batch_timeout_ms <= 0x2::clock::timestamp_ms(arg3)
    }

    public fun is_migration_in_progress(arg0: &BridgeSafe) : bool {
        0x2::vec_set::length<u64>(&arg0.compatible_versions) > 1
    }

    public fun is_token_whitelisted<T0>(arg0: &BridgeSafe) : bool {
        let v0 = 0xc6fe01f6d663198656ed9bcf77ee9f2a13306ae17a397fea7c00a5f69928e29d::utils::type_name_bytes<T0>();
        if (!0x2::table::contains<vector<u8>, 0xc6fe01f6d663198656ed9bcf77ee9f2a13306ae17a397fea7c00a5f69928e29d::shared_structs::TokenConfig>(&arg0.token_cfg, v0)) {
            return false
        };
        0xc6fe01f6d663198656ed9bcf77ee9f2a13306ae17a397fea7c00a5f69928e29d::shared_structs::token_config_whitelisted(0x2::table::borrow<vector<u8>, 0xc6fe01f6d663198656ed9bcf77ee9f2a13306ae17a397fea7c00a5f69928e29d::shared_structs::TokenConfig>(&arg0.token_cfg, v0))
    }

    public fun pause_contract(arg0: &mut BridgeSafe, arg1: &mut 0x2::tx_context::TxContext) {
        0xe0917b74a5912e4ad186ac634e29c922ab83903f71af7500969f9411706f9b9a::two_step_role::assert_sender_is_active_role<0xc6fe01f6d663198656ed9bcf77ee9f2a13306ae17a397fea7c00a5f69928e29d::bridge_roles::OwnerRole<0xc6fe01f6d663198656ed9bcf77ee9f2a13306ae17a397fea7c00a5f69928e29d::bridge_roles::BridgeSafeTag>>(0xc6fe01f6d663198656ed9bcf77ee9f2a13306ae17a397fea7c00a5f69928e29d::bridge_roles::owner_role<0xc6fe01f6d663198656ed9bcf77ee9f2a13306ae17a397fea7c00a5f69928e29d::bridge_roles::BridgeSafeTag>(&arg0.roles), arg1);
        0xc6fe01f6d663198656ed9bcf77ee9f2a13306ae17a397fea7c00a5f69928e29d::pausable::pause(&mut arg0.pause);
    }

    public fun pending_version(arg0: &BridgeSafe) : 0x1::option::Option<u64> {
        if (0x2::vec_set::length<u64>(&arg0.compatible_versions) == 2) {
            let v1 = 0x2::vec_set::keys<u64>(&arg0.compatible_versions);
            0x1::option::some<u64>(0x1::u64::max(*0x1::vector::borrow<u64>(v1, 0), *0x1::vector::borrow<u64>(v1, 1)))
        } else {
            0x1::option::none<u64>()
        }
    }

    public fun remove_token_from_whitelist<T0>(arg0: &mut BridgeSafe, arg1: &mut 0x2::tx_context::TxContext) {
        0xe0917b74a5912e4ad186ac634e29c922ab83903f71af7500969f9411706f9b9a::two_step_role::assert_sender_is_active_role<0xc6fe01f6d663198656ed9bcf77ee9f2a13306ae17a397fea7c00a5f69928e29d::bridge_roles::OwnerRole<0xc6fe01f6d663198656ed9bcf77ee9f2a13306ae17a397fea7c00a5f69928e29d::bridge_roles::BridgeSafeTag>>(0xc6fe01f6d663198656ed9bcf77ee9f2a13306ae17a397fea7c00a5f69928e29d::bridge_roles::owner_role<0xc6fe01f6d663198656ed9bcf77ee9f2a13306ae17a397fea7c00a5f69928e29d::bridge_roles::BridgeSafeTag>(&arg0.roles), arg1);
        let v0 = 0xc6fe01f6d663198656ed9bcf77ee9f2a13306ae17a397fea7c00a5f69928e29d::utils::type_name_bytes<T0>();
        0xc6fe01f6d663198656ed9bcf77ee9f2a13306ae17a397fea7c00a5f69928e29d::shared_structs::set_token_config_whitelisted(borrow_token_cfg_mut(arg0, v0), false);
        0xc6fe01f6d663198656ed9bcf77ee9f2a13306ae17a397fea7c00a5f69928e29d::events::emit_token_removed_from_whitelist(v0);
    }

    public(friend) fun roles_mut(arg0: &mut BridgeSafe) : &mut 0xc6fe01f6d663198656ed9bcf77ee9f2a13306ae17a397fea7c00a5f69928e29d::bridge_roles::Roles<0xc6fe01f6d663198656ed9bcf77ee9f2a13306ae17a397fea7c00a5f69928e29d::bridge_roles::BridgeSafeTag> {
        &mut arg0.roles
    }

    public fun set_batch_settle_timeout_ms(arg0: &mut BridgeSafe, arg1: u64, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        0xc6fe01f6d663198656ed9bcf77ee9f2a13306ae17a397fea7c00a5f69928e29d::pausable::assert_paused(&arg0.pause);
        0xe0917b74a5912e4ad186ac634e29c922ab83903f71af7500969f9411706f9b9a::two_step_role::assert_sender_is_active_role<0xc6fe01f6d663198656ed9bcf77ee9f2a13306ae17a397fea7c00a5f69928e29d::bridge_roles::OwnerRole<0xc6fe01f6d663198656ed9bcf77ee9f2a13306ae17a397fea7c00a5f69928e29d::bridge_roles::BridgeSafeTag>>(0xc6fe01f6d663198656ed9bcf77ee9f2a13306ae17a397fea7c00a5f69928e29d::bridge_roles::owner_role<0xc6fe01f6d663198656ed9bcf77ee9f2a13306ae17a397fea7c00a5f69928e29d::bridge_roles::BridgeSafeTag>(&arg0.roles), arg3);
        assert!(arg1 >= arg0.batch_timeout_ms, 2);
        assert!(!is_any_batch_in_progress_internal(arg0, arg2), 3);
        arg0.batch_settle_timeout_ms = arg1;
    }

    public fun set_batch_size(arg0: &mut BridgeSafe, arg1: u16, arg2: &mut 0x2::tx_context::TxContext) {
        0xe0917b74a5912e4ad186ac634e29c922ab83903f71af7500969f9411706f9b9a::two_step_role::assert_sender_is_active_role<0xc6fe01f6d663198656ed9bcf77ee9f2a13306ae17a397fea7c00a5f69928e29d::bridge_roles::OwnerRole<0xc6fe01f6d663198656ed9bcf77ee9f2a13306ae17a397fea7c00a5f69928e29d::bridge_roles::BridgeSafeTag>>(0xc6fe01f6d663198656ed9bcf77ee9f2a13306ae17a397fea7c00a5f69928e29d::bridge_roles::owner_role<0xc6fe01f6d663198656ed9bcf77ee9f2a13306ae17a397fea7c00a5f69928e29d::bridge_roles::BridgeSafeTag>(&arg0.roles), arg2);
        assert!(arg1 > 0, 13);
        assert!(arg1 <= 100, 4);
        arg0.batch_size = arg1;
    }

    public fun set_batch_timeout_ms(arg0: &mut BridgeSafe, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) {
        0xe0917b74a5912e4ad186ac634e29c922ab83903f71af7500969f9411706f9b9a::two_step_role::assert_sender_is_active_role<0xc6fe01f6d663198656ed9bcf77ee9f2a13306ae17a397fea7c00a5f69928e29d::bridge_roles::OwnerRole<0xc6fe01f6d663198656ed9bcf77ee9f2a13306ae17a397fea7c00a5f69928e29d::bridge_roles::BridgeSafeTag>>(0xc6fe01f6d663198656ed9bcf77ee9f2a13306ae17a397fea7c00a5f69928e29d::bridge_roles::owner_role<0xc6fe01f6d663198656ed9bcf77ee9f2a13306ae17a397fea7c00a5f69928e29d::bridge_roles::BridgeSafeTag>(&arg0.roles), arg2);
        assert!(arg1 <= arg0.batch_settle_timeout_ms, 1);
        arg0.batch_timeout_ms = arg1;
    }

    public fun set_bridge_addr(arg0: &mut BridgeSafe, arg1: address, arg2: &0x2::tx_context::TxContext) {
        0xe0917b74a5912e4ad186ac634e29c922ab83903f71af7500969f9411706f9b9a::two_step_role::assert_sender_is_active_role<0xc6fe01f6d663198656ed9bcf77ee9f2a13306ae17a397fea7c00a5f69928e29d::bridge_roles::OwnerRole<0xc6fe01f6d663198656ed9bcf77ee9f2a13306ae17a397fea7c00a5f69928e29d::bridge_roles::BridgeSafeTag>>(0xc6fe01f6d663198656ed9bcf77ee9f2a13306ae17a397fea7c00a5f69928e29d::bridge_roles::owner_role<0xc6fe01f6d663198656ed9bcf77ee9f2a13306ae17a397fea7c00a5f69928e29d::bridge_roles::BridgeSafeTag>(&arg0.roles), arg2);
        arg0.bridge_addr = arg1;
        0xc6fe01f6d663198656ed9bcf77ee9f2a13306ae17a397fea7c00a5f69928e29d::events::emit_bridge_transferred(arg0.bridge_addr, arg1);
    }

    public fun set_token_is_locked<T0>(arg0: &mut BridgeSafe, arg1: bool, arg2: &mut 0x2::tx_context::TxContext) {
        0xe0917b74a5912e4ad186ac634e29c922ab83903f71af7500969f9411706f9b9a::two_step_role::assert_sender_is_active_role<0xc6fe01f6d663198656ed9bcf77ee9f2a13306ae17a397fea7c00a5f69928e29d::bridge_roles::OwnerRole<0xc6fe01f6d663198656ed9bcf77ee9f2a13306ae17a397fea7c00a5f69928e29d::bridge_roles::BridgeSafeTag>>(0xc6fe01f6d663198656ed9bcf77ee9f2a13306ae17a397fea7c00a5f69928e29d::bridge_roles::owner_role<0xc6fe01f6d663198656ed9bcf77ee9f2a13306ae17a397fea7c00a5f69928e29d::bridge_roles::BridgeSafeTag>(&arg0.roles), arg2);
        let v0 = 0xc6fe01f6d663198656ed9bcf77ee9f2a13306ae17a397fea7c00a5f69928e29d::utils::type_name_bytes<T0>();
        0xc6fe01f6d663198656ed9bcf77ee9f2a13306ae17a397fea7c00a5f69928e29d::shared_structs::set_token_config_is_locked(borrow_token_cfg_mut(arg0, v0), arg1);
        0xc6fe01f6d663198656ed9bcf77ee9f2a13306ae17a397fea7c00a5f69928e29d::events::emit_token_is_locked_updated(v0, arg1);
    }

    public fun set_token_is_mint_burn<T0>(arg0: &mut BridgeSafe, arg1: bool, arg2: &mut 0x2::tx_context::TxContext) {
        0xe0917b74a5912e4ad186ac634e29c922ab83903f71af7500969f9411706f9b9a::two_step_role::assert_sender_is_active_role<0xc6fe01f6d663198656ed9bcf77ee9f2a13306ae17a397fea7c00a5f69928e29d::bridge_roles::OwnerRole<0xc6fe01f6d663198656ed9bcf77ee9f2a13306ae17a397fea7c00a5f69928e29d::bridge_roles::BridgeSafeTag>>(0xc6fe01f6d663198656ed9bcf77ee9f2a13306ae17a397fea7c00a5f69928e29d::bridge_roles::owner_role<0xc6fe01f6d663198656ed9bcf77ee9f2a13306ae17a397fea7c00a5f69928e29d::bridge_roles::BridgeSafeTag>(&arg0.roles), arg2);
        let v0 = 0xc6fe01f6d663198656ed9bcf77ee9f2a13306ae17a397fea7c00a5f69928e29d::utils::type_name_bytes<T0>();
        0xc6fe01f6d663198656ed9bcf77ee9f2a13306ae17a397fea7c00a5f69928e29d::shared_structs::set_token_config_is_mint_burn(borrow_token_cfg_mut(arg0, v0), arg1);
        0xc6fe01f6d663198656ed9bcf77ee9f2a13306ae17a397fea7c00a5f69928e29d::events::emit_token_is_mint_burn_updated(v0, arg1);
    }

    public fun set_token_is_native<T0>(arg0: &mut BridgeSafe, arg1: bool, arg2: &mut 0x2::tx_context::TxContext) {
        0xe0917b74a5912e4ad186ac634e29c922ab83903f71af7500969f9411706f9b9a::two_step_role::assert_sender_is_active_role<0xc6fe01f6d663198656ed9bcf77ee9f2a13306ae17a397fea7c00a5f69928e29d::bridge_roles::OwnerRole<0xc6fe01f6d663198656ed9bcf77ee9f2a13306ae17a397fea7c00a5f69928e29d::bridge_roles::BridgeSafeTag>>(0xc6fe01f6d663198656ed9bcf77ee9f2a13306ae17a397fea7c00a5f69928e29d::bridge_roles::owner_role<0xc6fe01f6d663198656ed9bcf77ee9f2a13306ae17a397fea7c00a5f69928e29d::bridge_roles::BridgeSafeTag>(&arg0.roles), arg2);
        let v0 = 0xc6fe01f6d663198656ed9bcf77ee9f2a13306ae17a397fea7c00a5f69928e29d::utils::type_name_bytes<T0>();
        0xc6fe01f6d663198656ed9bcf77ee9f2a13306ae17a397fea7c00a5f69928e29d::shared_structs::set_token_config_is_native(borrow_token_cfg_mut(arg0, v0), arg1);
        0xc6fe01f6d663198656ed9bcf77ee9f2a13306ae17a397fea7c00a5f69928e29d::events::emit_token_is_native_updated(v0, arg1);
    }

    public fun set_token_max_limit<T0>(arg0: &mut BridgeSafe, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) {
        0xe0917b74a5912e4ad186ac634e29c922ab83903f71af7500969f9411706f9b9a::two_step_role::assert_sender_is_active_role<0xc6fe01f6d663198656ed9bcf77ee9f2a13306ae17a397fea7c00a5f69928e29d::bridge_roles::OwnerRole<0xc6fe01f6d663198656ed9bcf77ee9f2a13306ae17a397fea7c00a5f69928e29d::bridge_roles::BridgeSafeTag>>(0xc6fe01f6d663198656ed9bcf77ee9f2a13306ae17a397fea7c00a5f69928e29d::bridge_roles::owner_role<0xc6fe01f6d663198656ed9bcf77ee9f2a13306ae17a397fea7c00a5f69928e29d::bridge_roles::BridgeSafeTag>(&arg0.roles), arg2);
        let v0 = 0xc6fe01f6d663198656ed9bcf77ee9f2a13306ae17a397fea7c00a5f69928e29d::utils::type_name_bytes<T0>();
        let v1 = borrow_token_cfg_mut(arg0, v0);
        let v2 = 0xc6fe01f6d663198656ed9bcf77ee9f2a13306ae17a397fea7c00a5f69928e29d::shared_structs::token_config_min_limit(v1);
        assert!(arg1 >= v2, 15);
        0xc6fe01f6d663198656ed9bcf77ee9f2a13306ae17a397fea7c00a5f69928e29d::shared_structs::set_token_config_max_limit(v1, arg1);
        0xc6fe01f6d663198656ed9bcf77ee9f2a13306ae17a397fea7c00a5f69928e29d::events::emit_token_limits_updated(v0, v2, arg1);
    }

    public fun set_token_min_limit<T0>(arg0: &mut BridgeSafe, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) {
        0xe0917b74a5912e4ad186ac634e29c922ab83903f71af7500969f9411706f9b9a::two_step_role::assert_sender_is_active_role<0xc6fe01f6d663198656ed9bcf77ee9f2a13306ae17a397fea7c00a5f69928e29d::bridge_roles::OwnerRole<0xc6fe01f6d663198656ed9bcf77ee9f2a13306ae17a397fea7c00a5f69928e29d::bridge_roles::BridgeSafeTag>>(0xc6fe01f6d663198656ed9bcf77ee9f2a13306ae17a397fea7c00a5f69928e29d::bridge_roles::owner_role<0xc6fe01f6d663198656ed9bcf77ee9f2a13306ae17a397fea7c00a5f69928e29d::bridge_roles::BridgeSafeTag>(&arg0.roles), arg2);
        let v0 = 0xc6fe01f6d663198656ed9bcf77ee9f2a13306ae17a397fea7c00a5f69928e29d::utils::type_name_bytes<T0>();
        let v1 = borrow_token_cfg_mut(arg0, v0);
        let v2 = 0xc6fe01f6d663198656ed9bcf77ee9f2a13306ae17a397fea7c00a5f69928e29d::shared_structs::token_config_max_limit(v1);
        assert!(arg1 > 0, 10);
        assert!(arg1 <= v2, 15);
        0xc6fe01f6d663198656ed9bcf77ee9f2a13306ae17a397fea7c00a5f69928e29d::shared_structs::set_token_config_min_limit(v1, arg1);
        0xc6fe01f6d663198656ed9bcf77ee9f2a13306ae17a397fea7c00a5f69928e29d::events::emit_token_limits_updated(v0, arg1, v2);
    }

    fun should_create_new_batch_internal(arg0: &BridgeSafe, arg1: &0x2::clock::Clock) : bool {
        if (arg0.batches_count == 0) {
            return true
        };
        let v0 = 0x2::table::borrow<u64, 0xc6fe01f6d663198656ed9bcf77ee9f2a13306ae17a397fea7c00a5f69928e29d::shared_structs::Batch>(&arg0.batches, arg0.batches_count - 1);
        is_batch_progress_over_internal(arg0, 0xc6fe01f6d663198656ed9bcf77ee9f2a13306ae17a397fea7c00a5f69928e29d::shared_structs::batch_deposits_count(v0), 0xc6fe01f6d663198656ed9bcf77ee9f2a13306ae17a397fea7c00a5f69928e29d::shared_structs::batch_timestamp_ms(v0), arg1) || 0xc6fe01f6d663198656ed9bcf77ee9f2a13306ae17a397fea7c00a5f69928e29d::shared_structs::batch_deposits_count(v0) >= arg0.batch_size
    }

    public fun start_migration(arg0: &mut BridgeSafe, arg1: &0x2::tx_context::TxContext) {
        0xe0917b74a5912e4ad186ac634e29c922ab83903f71af7500969f9411706f9b9a::two_step_role::assert_sender_is_active_role<0xc6fe01f6d663198656ed9bcf77ee9f2a13306ae17a397fea7c00a5f69928e29d::bridge_roles::OwnerRole<0xc6fe01f6d663198656ed9bcf77ee9f2a13306ae17a397fea7c00a5f69928e29d::bridge_roles::BridgeSafeTag>>(0xc6fe01f6d663198656ed9bcf77ee9f2a13306ae17a397fea7c00a5f69928e29d::bridge_roles::owner_role<0xc6fe01f6d663198656ed9bcf77ee9f2a13306ae17a397fea7c00a5f69928e29d::bridge_roles::BridgeSafeTag>(&arg0.roles), arg1);
        assert!(0x2::vec_set::length<u64>(&arg0.compatible_versions) == 1, 16);
        assert!(*0x1::vector::borrow<u64>(0x2::vec_set::keys<u64>(&arg0.compatible_versions), 0) < 0xc6fe01f6d663198656ed9bcf77ee9f2a13306ae17a397fea7c00a5f69928e29d::bridge_version_control::current_version(), 14);
        0x2::vec_set::insert<u64>(&mut arg0.compatible_versions, 0xc6fe01f6d663198656ed9bcf77ee9f2a13306ae17a397fea7c00a5f69928e29d::bridge_version_control::current_version());
        let v0 = MigrationStarted{compatible_versions: *0x2::vec_set::keys<u64>(&arg0.compatible_versions)};
        0x2::event::emit<MigrationStarted>(v0);
    }

    public fun sync_supply<T0>(arg0: &mut BridgeSafe, arg1: 0x2::coin::Coin<T0>, arg2: &mut 0x2::tx_context::TxContext) {
        0xe0917b74a5912e4ad186ac634e29c922ab83903f71af7500969f9411706f9b9a::two_step_role::assert_sender_is_active_role<0xc6fe01f6d663198656ed9bcf77ee9f2a13306ae17a397fea7c00a5f69928e29d::bridge_roles::OwnerRole<0xc6fe01f6d663198656ed9bcf77ee9f2a13306ae17a397fea7c00a5f69928e29d::bridge_roles::BridgeSafeTag>>(0xc6fe01f6d663198656ed9bcf77ee9f2a13306ae17a397fea7c00a5f69928e29d::bridge_roles::owner_role<0xc6fe01f6d663198656ed9bcf77ee9f2a13306ae17a397fea7c00a5f69928e29d::bridge_roles::BridgeSafeTag>(&arg0.roles), arg2);
        let v0 = 0xc6fe01f6d663198656ed9bcf77ee9f2a13306ae17a397fea7c00a5f69928e29d::utils::type_name_bytes<T0>();
        assert!(0x2::table::contains<vector<u8>, 0xc6fe01f6d663198656ed9bcf77ee9f2a13306ae17a397fea7c00a5f69928e29d::shared_structs::TokenConfig>(&arg0.token_cfg, v0), 5);
        let v1 = 0x2::table::borrow<vector<u8>, 0xc6fe01f6d663198656ed9bcf77ee9f2a13306ae17a397fea7c00a5f69928e29d::shared_structs::TokenConfig>(&arg0.token_cfg, v0);
        assert!(0xc6fe01f6d663198656ed9bcf77ee9f2a13306ae17a397fea7c00a5f69928e29d::shared_structs::token_config_whitelisted(v1), 5);
        assert!(0xc6fe01f6d663198656ed9bcf77ee9f2a13306ae17a397fea7c00a5f69928e29d::shared_structs::token_config_is_native(v1), 8);
        let v2 = 0xc6fe01f6d663198656ed9bcf77ee9f2a13306ae17a397fea7c00a5f69928e29d::shared_structs::token_config_total_balance(v1);
        let v3 = if (0x2::bag::contains<vector<u8>>(&arg0.coin_storage, v0)) {
            0x2::coin::value<T0>(0x2::bag::borrow<vector<u8>, 0x2::coin::Coin<T0>>(&arg0.coin_storage, v0))
        } else {
            0
        };
        assert!(v2 > v3, 8);
        let v4 = v2 - v3;
        assert!(0x2::coin::value<T0>(&arg1) >= v4, 8);
        if (0x2::bag::contains<vector<u8>>(&arg0.coin_storage, v0)) {
            0x2::coin::join<T0>(0x2::bag::borrow_mut<vector<u8>, 0x2::coin::Coin<T0>>(&mut arg0.coin_storage, v0), 0x2::coin::split<T0>(&mut arg1, v4, arg2));
        } else {
            0x2::bag::add<vector<u8>, 0x2::coin::Coin<T0>>(&mut arg0.coin_storage, v0, 0x2::coin::split<T0>(&mut arg1, v4, arg2));
        };
        if (0x2::coin::value<T0>(&arg1) == 0) {
            0x2::coin::destroy_zero<T0>(arg1);
        } else {
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(arg1, 0x2::tx_context::sender(arg2));
        };
    }

    public fun transfer_ownership(arg0: &mut BridgeSafe, arg1: address, arg2: &0x2::tx_context::TxContext) {
        0xe0917b74a5912e4ad186ac634e29c922ab83903f71af7500969f9411706f9b9a::two_step_role::begin_role_transfer<0xc6fe01f6d663198656ed9bcf77ee9f2a13306ae17a397fea7c00a5f69928e29d::bridge_roles::OwnerRole<0xc6fe01f6d663198656ed9bcf77ee9f2a13306ae17a397fea7c00a5f69928e29d::bridge_roles::BridgeSafeTag>>(0xc6fe01f6d663198656ed9bcf77ee9f2a13306ae17a397fea7c00a5f69928e29d::bridge_roles::owner_role_mut<0xc6fe01f6d663198656ed9bcf77ee9f2a13306ae17a397fea7c00a5f69928e29d::bridge_roles::BridgeSafeTag>(roles_mut(arg0)), arg1, arg2);
    }

    public fun unpause_contract(arg0: &mut BridgeSafe, arg1: &mut 0x2::tx_context::TxContext) {
        0xe0917b74a5912e4ad186ac634e29c922ab83903f71af7500969f9411706f9b9a::two_step_role::assert_sender_is_active_role<0xc6fe01f6d663198656ed9bcf77ee9f2a13306ae17a397fea7c00a5f69928e29d::bridge_roles::OwnerRole<0xc6fe01f6d663198656ed9bcf77ee9f2a13306ae17a397fea7c00a5f69928e29d::bridge_roles::BridgeSafeTag>>(0xc6fe01f6d663198656ed9bcf77ee9f2a13306ae17a397fea7c00a5f69928e29d::bridge_roles::owner_role<0xc6fe01f6d663198656ed9bcf77ee9f2a13306ae17a397fea7c00a5f69928e29d::bridge_roles::BridgeSafeTag>(&arg0.roles), arg1);
        0xc6fe01f6d663198656ed9bcf77ee9f2a13306ae17a397fea7c00a5f69928e29d::pausable::unpause(&mut arg0.pause);
    }

    public fun whitelist_token<T0>(arg0: &mut BridgeSafe, arg1: u64, arg2: u64, arg3: bool, arg4: bool, arg5: &mut 0x2::tx_context::TxContext) {
        0xe0917b74a5912e4ad186ac634e29c922ab83903f71af7500969f9411706f9b9a::two_step_role::assert_sender_is_active_role<0xc6fe01f6d663198656ed9bcf77ee9f2a13306ae17a397fea7c00a5f69928e29d::bridge_roles::OwnerRole<0xc6fe01f6d663198656ed9bcf77ee9f2a13306ae17a397fea7c00a5f69928e29d::bridge_roles::BridgeSafeTag>>(0xc6fe01f6d663198656ed9bcf77ee9f2a13306ae17a397fea7c00a5f69928e29d::bridge_roles::owner_role<0xc6fe01f6d663198656ed9bcf77ee9f2a13306ae17a397fea7c00a5f69928e29d::bridge_roles::BridgeSafeTag>(&arg0.roles), arg5);
        let v0 = 0xc6fe01f6d663198656ed9bcf77ee9f2a13306ae17a397fea7c00a5f69928e29d::utils::type_name_bytes<T0>();
        assert!(arg1 > 0, 10);
        assert!(arg1 <= arg2, 15);
        if (0x2::table::contains<vector<u8>, 0xc6fe01f6d663198656ed9bcf77ee9f2a13306ae17a397fea7c00a5f69928e29d::shared_structs::TokenConfig>(&arg0.token_cfg, v0)) {
            assert!(!0xc6fe01f6d663198656ed9bcf77ee9f2a13306ae17a397fea7c00a5f69928e29d::shared_structs::token_config_whitelisted(0x2::table::borrow<vector<u8>, 0xc6fe01f6d663198656ed9bcf77ee9f2a13306ae17a397fea7c00a5f69928e29d::shared_structs::TokenConfig>(&arg0.token_cfg, v0)), 0);
            let v1 = borrow_token_cfg_mut(arg0, v0);
            0xc6fe01f6d663198656ed9bcf77ee9f2a13306ae17a397fea7c00a5f69928e29d::shared_structs::set_token_config_whitelisted(v1, true);
            0xc6fe01f6d663198656ed9bcf77ee9f2a13306ae17a397fea7c00a5f69928e29d::shared_structs::set_token_config_is_native(v1, arg3);
            0xc6fe01f6d663198656ed9bcf77ee9f2a13306ae17a397fea7c00a5f69928e29d::shared_structs::set_token_config_min_limit(v1, arg1);
            0xc6fe01f6d663198656ed9bcf77ee9f2a13306ae17a397fea7c00a5f69928e29d::shared_structs::set_token_config_max_limit(v1, arg2);
            0xc6fe01f6d663198656ed9bcf77ee9f2a13306ae17a397fea7c00a5f69928e29d::shared_structs::set_token_config_is_locked(v1, arg4);
        } else {
            0x2::table::add<vector<u8>, 0xc6fe01f6d663198656ed9bcf77ee9f2a13306ae17a397fea7c00a5f69928e29d::shared_structs::TokenConfig>(&mut arg0.token_cfg, v0, 0xc6fe01f6d663198656ed9bcf77ee9f2a13306ae17a397fea7c00a5f69928e29d::shared_structs::create_token_config(true, arg3, arg1, arg2, arg4));
        };
        0xc6fe01f6d663198656ed9bcf77ee9f2a13306ae17a397fea7c00a5f69928e29d::events::emit_token_whitelisted(v0, arg1, arg2, arg3, false, arg4);
    }

    // decompiled from Move bytecode v6
}

