module 0xb3a692af64df57943e376279995f211e3c1734d6c1c3b833a37ed039ae61bc04::safe {
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
        pause: 0xb3a692af64df57943e376279995f211e3c1734d6c1c3b833a37ed039ae61bc04::pausable::Pause,
        roles: 0xb3a692af64df57943e376279995f211e3c1734d6c1c3b833a37ed039ae61bc04::bridge_roles::Roles<0xb3a692af64df57943e376279995f211e3c1734d6c1c3b833a37ed039ae61bc04::bridge_roles::BridgeSafeTag>,
        bridge_addr: address,
        batch_size: u16,
        batch_timeout_ms: u64,
        batch_settle_timeout_ms: u64,
        batches_count: u64,
        deposits_count: u64,
        token_cfg: 0x2::table::Table<vector<u8>, 0xb3a692af64df57943e376279995f211e3c1734d6c1c3b833a37ed039ae61bc04::shared_structs::TokenConfig>,
        batches: 0x2::table::Table<u64, 0xb3a692af64df57943e376279995f211e3c1734d6c1c3b833a37ed039ae61bc04::shared_structs::Batch>,
        batch_deposits: 0x2::table::Table<u64, vector<0xb3a692af64df57943e376279995f211e3c1734d6c1c3b833a37ed039ae61bc04::shared_structs::Deposit>>,
        coin_storage: 0x2::bag::Bag,
        from_coin_cap: 0x8db9d9dc5cd5723ee55725869620073e28f88ddf3c360a512ebd73cb46f1903d::treasury::FromCoinCap<0x8db9d9dc5cd5723ee55725869620073e28f88ddf3c360a512ebd73cb46f1903d::bridge_token::BRIDGE_TOKEN>,
        compatible_versions: 0x2::vec_set::VecSet<u64>,
    }

    struct SafeInitCap has key {
        id: 0x2::object::UID,
    }

    struct SAFE has drop {
        dummy_field: bool,
    }

    public(friend) fun transfer<T0>(arg0: &mut BridgeSafe, arg1: &0xb3a692af64df57943e376279995f211e3c1734d6c1c3b833a37ed039ae61bc04::bridge_roles::BridgeCap, arg2: address, arg3: u64, arg4: &mut 0x8db9d9dc5cd5723ee55725869620073e28f88ddf3c360a512ebd73cb46f1903d::treasury::Treasury<0x8db9d9dc5cd5723ee55725869620073e28f88ddf3c360a512ebd73cb46f1903d::bridge_token::BRIDGE_TOKEN>, arg5: &mut 0x2::tx_context::TxContext) : bool {
        assert!(0xb3a692af64df57943e376279995f211e3c1734d6c1c3b833a37ed039ae61bc04::bridge_roles::bridge_cap_safe_id(arg1) == 0x2::object::uid_to_inner(&arg0.id), 23);
        let v0 = 0xb3a692af64df57943e376279995f211e3c1734d6c1c3b833a37ed039ae61bc04::utils::type_name_bytes<T0>();
        if (!0x2::table::contains<vector<u8>, 0xb3a692af64df57943e376279995f211e3c1734d6c1c3b833a37ed039ae61bc04::shared_structs::TokenConfig>(&arg0.token_cfg, v0)) {
            return false
        };
        let v1 = 0x2::table::borrow<vector<u8>, 0xb3a692af64df57943e376279995f211e3c1734d6c1c3b833a37ed039ae61bc04::shared_structs::TokenConfig>(&arg0.token_cfg, v0);
        if (0xb3a692af64df57943e376279995f211e3c1734d6c1c3b833a37ed039ae61bc04::shared_structs::token_config_is_mint_burn(v1)) {
            return false
        };
        if (0xb3a692af64df57943e376279995f211e3c1734d6c1c3b833a37ed039ae61bc04::shared_structs::token_config_total_balance(v1) < arg3) {
            return false
        };
        if (!0x2::bag::contains<vector<u8>>(&arg0.coin_storage, v0)) {
            return false
        };
        if (!0xb3a692af64df57943e376279995f211e3c1734d6c1c3b833a37ed039ae61bc04::shared_structs::get_token_config_is_locked(v1)) {
            let v2 = 0x2::bag::borrow_mut<vector<u8>, 0x2::coin::Coin<T0>>(&mut arg0.coin_storage, v0);
            if (0x2::coin::value<T0>(v2) < arg3) {
                return false
            };
            if (0x2::coin::value<T0>(v2) == 0) {
                0x2::coin::destroy_zero<T0>(0x2::bag::remove<vector<u8>, 0x2::coin::Coin<T0>>(&mut arg0.coin_storage, v0));
            };
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::split<T0>(v2, arg3, arg5), arg2);
        } else {
            let v3 = 0x2::bag::borrow_mut<vector<u8>, 0x2::coin::Coin<0x8db9d9dc5cd5723ee55725869620073e28f88ddf3c360a512ebd73cb46f1903d::bridge_token::BRIDGE_TOKEN>>(&mut arg0.coin_storage, v0);
            if (0x2::coin::value<0x8db9d9dc5cd5723ee55725869620073e28f88ddf3c360a512ebd73cb46f1903d::bridge_token::BRIDGE_TOKEN>(v3) < arg3) {
                return false
            };
            if (0x2::coin::value<0x8db9d9dc5cd5723ee55725869620073e28f88ddf3c360a512ebd73cb46f1903d::bridge_token::BRIDGE_TOKEN>(v3) == 0) {
                0x2::coin::destroy_zero<0x8db9d9dc5cd5723ee55725869620073e28f88ddf3c360a512ebd73cb46f1903d::bridge_token::BRIDGE_TOKEN>(0x2::bag::remove<vector<u8>, 0x2::coin::Coin<0x8db9d9dc5cd5723ee55725869620073e28f88ddf3c360a512ebd73cb46f1903d::bridge_token::BRIDGE_TOKEN>>(&mut arg0.coin_storage, v0));
            };
            0x8db9d9dc5cd5723ee55725869620073e28f88ddf3c360a512ebd73cb46f1903d::treasury::transfer_from_coin<0x8db9d9dc5cd5723ee55725869620073e28f88ddf3c360a512ebd73cb46f1903d::bridge_token::BRIDGE_TOKEN>(arg4, arg2, &arg0.from_coin_cap, 0x2::coin::split<0x8db9d9dc5cd5723ee55725869620073e28f88ddf3c360a512ebd73cb46f1903d::bridge_token::BRIDGE_TOKEN>(v3, arg3, arg5), arg5);
        };
        0xb3a692af64df57943e376279995f211e3c1734d6c1c3b833a37ed039ae61bc04::shared_structs::subtract_from_token_config_total_balance(borrow_token_cfg_mut(arg0, v0), arg3);
        true
    }

    public fun abort_migration(arg0: &mut BridgeSafe, arg1: &0x2::tx_context::TxContext) {
        0xb3a692af64df57943e376279995f211e3c1734d6c1c3b833a37ed039ae61bc04::two_step_role::assert_sender_is_active_role<0xb3a692af64df57943e376279995f211e3c1734d6c1c3b833a37ed039ae61bc04::bridge_roles::OwnerRole<0xb3a692af64df57943e376279995f211e3c1734d6c1c3b833a37ed039ae61bc04::bridge_roles::BridgeSafeTag>>(0xb3a692af64df57943e376279995f211e3c1734d6c1c3b833a37ed039ae61bc04::bridge_roles::owner_role<0xb3a692af64df57943e376279995f211e3c1734d6c1c3b833a37ed039ae61bc04::bridge_roles::BridgeSafeTag>(&arg0.roles), arg1);
        assert!(0x2::vec_set::length<u64>(&arg0.compatible_versions) == 2, 17);
        let v0 = 0x1::u64::max(*0x1::vector::borrow<u64>(0x2::vec_set::keys<u64>(&arg0.compatible_versions), 0), *0x1::vector::borrow<u64>(0x2::vec_set::keys<u64>(&arg0.compatible_versions), 1));
        assert!(v0 == 0xb3a692af64df57943e376279995f211e3c1734d6c1c3b833a37ed039ae61bc04::bridge_version_control::current_version(), 18);
        0x2::vec_set::remove<u64>(&mut arg0.compatible_versions, &v0);
        let v1 = MigrationAborted{compatible_versions: *0x2::vec_set::keys<u64>(&arg0.compatible_versions)};
        0x2::event::emit<MigrationAborted>(v1);
    }

    public fun accept_ownership(arg0: &mut BridgeSafe, arg1: &0x2::tx_context::TxContext) {
        assert_is_compatible(arg0);
        0xb3a692af64df57943e376279995f211e3c1734d6c1c3b833a37ed039ae61bc04::two_step_role::accept_role<0xb3a692af64df57943e376279995f211e3c1734d6c1c3b833a37ed039ae61bc04::bridge_roles::OwnerRole<0xb3a692af64df57943e376279995f211e3c1734d6c1c3b833a37ed039ae61bc04::bridge_roles::BridgeSafeTag>>(0xb3a692af64df57943e376279995f211e3c1734d6c1c3b833a37ed039ae61bc04::bridge_roles::owner_role_mut<0xb3a692af64df57943e376279995f211e3c1734d6c1c3b833a37ed039ae61bc04::bridge_roles::BridgeSafeTag>(roles_mut(arg0)), arg1);
    }

    public(friend) fun assert_is_compatible(arg0: &BridgeSafe) {
        0xb3a692af64df57943e376279995f211e3c1734d6c1c3b833a37ed039ae61bc04::bridge_version_control::assert_object_version_is_compatible_with_package(arg0.compatible_versions);
    }

    public(friend) fun assert_token_is_mint_burn(arg0: &BridgeSafe, arg1: vector<u8>) {
        assert!(0x2::table::contains<vector<u8>, 0xb3a692af64df57943e376279995f211e3c1734d6c1c3b833a37ed039ae61bc04::shared_structs::TokenConfig>(&arg0.token_cfg, arg1), 5);
        assert!(0xb3a692af64df57943e376279995f211e3c1734d6c1c3b833a37ed039ae61bc04::shared_structs::token_config_is_mint_burn(0x2::table::borrow<vector<u8>, 0xb3a692af64df57943e376279995f211e3c1734d6c1c3b833a37ed039ae61bc04::shared_structs::TokenConfig>(&arg0.token_cfg, arg1)), 22);
    }

    public(friend) fun assert_token_is_not_whitelisted(arg0: &BridgeSafe, arg1: vector<u8>) {
        assert!(0x2::table::contains<vector<u8>, 0xb3a692af64df57943e376279995f211e3c1734d6c1c3b833a37ed039ae61bc04::shared_structs::TokenConfig>(&arg0.token_cfg, arg1), 5);
        assert!(!0xb3a692af64df57943e376279995f211e3c1734d6c1c3b833a37ed039ae61bc04::shared_structs::token_config_whitelisted(0x2::table::borrow<vector<u8>, 0xb3a692af64df57943e376279995f211e3c1734d6c1c3b833a37ed039ae61bc04::shared_structs::TokenConfig>(&arg0.token_cfg, arg1)), 0);
    }

    public(friend) fun assert_token_is_whitelisted(arg0: &BridgeSafe, arg1: vector<u8>) {
        assert!(0x2::table::contains<vector<u8>, 0xb3a692af64df57943e376279995f211e3c1734d6c1c3b833a37ed039ae61bc04::shared_structs::TokenConfig>(&arg0.token_cfg, arg1), 5);
        assert!(0xb3a692af64df57943e376279995f211e3c1734d6c1c3b833a37ed039ae61bc04::shared_structs::token_config_whitelisted(0x2::table::borrow<vector<u8>, 0xb3a692af64df57943e376279995f211e3c1734d6c1c3b833a37ed039ae61bc04::shared_structs::TokenConfig>(&arg0.token_cfg, arg1)), 5);
    }

    fun borrow_token_cfg_mut(arg0: &mut BridgeSafe, arg1: vector<u8>) : &mut 0xb3a692af64df57943e376279995f211e3c1734d6c1c3b833a37ed039ae61bc04::shared_structs::TokenConfig {
        0x2::table::borrow_mut<vector<u8>, 0xb3a692af64df57943e376279995f211e3c1734d6c1c3b833a37ed039ae61bc04::shared_structs::TokenConfig>(&mut arg0.token_cfg, arg1)
    }

    public(friend) fun checkOwnerRole(arg0: &BridgeSafe, arg1: &0x2::tx_context::TxContext) {
        0xb3a692af64df57943e376279995f211e3c1734d6c1c3b833a37ed039ae61bc04::two_step_role::assert_sender_is_active_role<0xb3a692af64df57943e376279995f211e3c1734d6c1c3b833a37ed039ae61bc04::bridge_roles::OwnerRole<0xb3a692af64df57943e376279995f211e3c1734d6c1c3b833a37ed039ae61bc04::bridge_roles::BridgeSafeTag>>(0xb3a692af64df57943e376279995f211e3c1734d6c1c3b833a37ed039ae61bc04::bridge_roles::owner_role<0xb3a692af64df57943e376279995f211e3c1734d6c1c3b833a37ed039ae61bc04::bridge_roles::BridgeSafeTag>(&arg0.roles), arg1);
    }

    public fun compatible_versions(arg0: &BridgeSafe) : vector<u64> {
        *0x2::vec_set::keys<u64>(&arg0.compatible_versions)
    }

    public fun complete_migration(arg0: &mut BridgeSafe, arg1: &0x2::tx_context::TxContext) {
        0xb3a692af64df57943e376279995f211e3c1734d6c1c3b833a37ed039ae61bc04::two_step_role::assert_sender_is_active_role<0xb3a692af64df57943e376279995f211e3c1734d6c1c3b833a37ed039ae61bc04::bridge_roles::OwnerRole<0xb3a692af64df57943e376279995f211e3c1734d6c1c3b833a37ed039ae61bc04::bridge_roles::BridgeSafeTag>>(0xb3a692af64df57943e376279995f211e3c1734d6c1c3b833a37ed039ae61bc04::bridge_roles::owner_role<0xb3a692af64df57943e376279995f211e3c1734d6c1c3b833a37ed039ae61bc04::bridge_roles::BridgeSafeTag>(&arg0.roles), arg1);
        assert!(0x2::vec_set::length<u64>(&arg0.compatible_versions) == 2, 17);
        let v0 = *0x1::vector::borrow<u64>(0x2::vec_set::keys<u64>(&arg0.compatible_versions), 0);
        let v1 = *0x1::vector::borrow<u64>(0x2::vec_set::keys<u64>(&arg0.compatible_versions), 1);
        let v2 = 0x1::u64::min(v0, v1);
        assert!(0x1::u64::max(v0, v1) == 0xb3a692af64df57943e376279995f211e3c1734d6c1c3b833a37ed039ae61bc04::bridge_version_control::current_version(), 18);
        0x2::vec_set::remove<u64>(&mut arg0.compatible_versions, &v2);
        let v3 = MigrationCompleted{compatible_versions: *0x2::vec_set::keys<u64>(&arg0.compatible_versions)};
        0x2::event::emit<MigrationCompleted>(v3);
    }

    fun create_new_batch_internal(arg0: &mut BridgeSafe, arg1: &0x2::clock::Clock, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.batches_count < 18446744073709551615, 11);
        let v0 = arg0.batches_count + 1;
        0x2::table::add<u64, 0xb3a692af64df57943e376279995f211e3c1734d6c1c3b833a37ed039ae61bc04::shared_structs::Batch>(&mut arg0.batches, arg0.batches_count, 0xb3a692af64df57943e376279995f211e3c1734d6c1c3b833a37ed039ae61bc04::shared_structs::create_batch(v0, 0x2::clock::timestamp_ms(arg1)));
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
        assert_is_compatible(arg0);
        let (v0, v1, v2, v3) = deposit_validate_and_record<T0>(arg0, &arg1, arg2, false, arg3, arg4);
        if (0x2::bag::contains<vector<u8>>(&arg0.coin_storage, v0)) {
            0x2::coin::join<T0>(0x2::bag::borrow_mut<vector<u8>, 0x2::coin::Coin<T0>>(&mut arg0.coin_storage, v0), arg1);
        } else {
            0x2::bag::add<vector<u8>, 0x2::coin::Coin<T0>>(&mut arg0.coin_storage, v0, arg1);
        };
        0xb3a692af64df57943e376279995f211e3c1734d6c1c3b833a37ed039ae61bc04::events::emit_deposit_v1(v2, v3, 0x2::tx_context::sender(arg4), arg2, v1, v0);
    }

    public(friend) fun deposit_validate_and_record<T0>(arg0: &mut BridgeSafe, arg1: &0x2::coin::Coin<T0>, arg2: vector<u8>, arg3: bool, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) : (vector<u8>, u64, u64, u64) {
        0xb3a692af64df57943e376279995f211e3c1734d6c1c3b833a37ed039ae61bc04::pausable::assert_not_paused(&arg0.pause);
        assert!(0x1::vector::length<u8>(&arg2) == 32, 9);
        let v0 = 0xb3a692af64df57943e376279995f211e3c1734d6c1c3b833a37ed039ae61bc04::utils::type_name_bytes<T0>();
        let v1 = 0x2::table::borrow<vector<u8>, 0xb3a692af64df57943e376279995f211e3c1734d6c1c3b833a37ed039ae61bc04::shared_structs::TokenConfig>(&arg0.token_cfg, v0);
        assert!(0xb3a692af64df57943e376279995f211e3c1734d6c1c3b833a37ed039ae61bc04::shared_structs::token_config_whitelisted(v1), 5);
        assert!(0xb3a692af64df57943e376279995f211e3c1734d6c1c3b833a37ed039ae61bc04::shared_structs::token_config_is_mint_burn(v1) == arg3, 22);
        let v2 = 0x2::coin::value<T0>(arg1);
        assert!(v2 > 0, 10);
        assert!(v2 >= 0xb3a692af64df57943e376279995f211e3c1734d6c1c3b833a37ed039ae61bc04::shared_structs::token_config_min_limit(v1), 6);
        assert!(v2 <= 0xb3a692af64df57943e376279995f211e3c1734d6c1c3b833a37ed039ae61bc04::shared_structs::token_config_max_limit(v1), 7);
        if (should_create_new_batch_internal(arg0, arg4)) {
            create_new_batch_internal(arg0, arg4, arg5);
        };
        let v3 = arg0.batches_count - 1;
        let v4 = 0x2::table::borrow_mut<u64, 0xb3a692af64df57943e376279995f211e3c1734d6c1c3b833a37ed039ae61bc04::shared_structs::Batch>(&mut arg0.batches, v3);
        assert!(arg0.deposits_count < 18446744073709551615, 11);
        let v5 = arg0.deposits_count + 1;
        if (!0x2::table::contains<u64, vector<0xb3a692af64df57943e376279995f211e3c1734d6c1c3b833a37ed039ae61bc04::shared_structs::Deposit>>(&arg0.batch_deposits, v3)) {
            0x2::table::add<u64, vector<0xb3a692af64df57943e376279995f211e3c1734d6c1c3b833a37ed039ae61bc04::shared_structs::Deposit>>(&mut arg0.batch_deposits, v3, 0x1::vector::empty<0xb3a692af64df57943e376279995f211e3c1734d6c1c3b833a37ed039ae61bc04::shared_structs::Deposit>());
        };
        0x1::vector::push_back<0xb3a692af64df57943e376279995f211e3c1734d6c1c3b833a37ed039ae61bc04::shared_structs::Deposit>(0x2::table::borrow_mut<u64, vector<0xb3a692af64df57943e376279995f211e3c1734d6c1c3b833a37ed039ae61bc04::shared_structs::Deposit>>(&mut arg0.batch_deposits, v3), 0xb3a692af64df57943e376279995f211e3c1734d6c1c3b833a37ed039ae61bc04::shared_structs::create_deposit(v5, v0, v2, 0x2::tx_context::sender(arg5), arg2));
        arg0.deposits_count = v5;
        0xb3a692af64df57943e376279995f211e3c1734d6c1c3b833a37ed039ae61bc04::shared_structs::increment_batch_deposits(v4);
        0xb3a692af64df57943e376279995f211e3c1734d6c1c3b833a37ed039ae61bc04::shared_structs::set_batch_last_updated_timestamp_ms(v4, 0x2::clock::timestamp_ms(arg4));
        0xb3a692af64df57943e376279995f211e3c1734d6c1c3b833a37ed039ae61bc04::shared_structs::add_to_token_config_total_balance(borrow_token_cfg_mut(arg0, v0), v2);
        (v0, v2, 0xb3a692af64df57943e376279995f211e3c1734d6c1c3b833a37ed039ae61bc04::shared_structs::batch_nonce(v4), v5)
    }

    public fun get_batch(arg0: &BridgeSafe, arg1: u64, arg2: &0x2::clock::Clock) : (0xb3a692af64df57943e376279995f211e3c1734d6c1c3b833a37ed039ae61bc04::shared_structs::Batch, bool) {
        assert!(arg1 > 0, 12);
        let v0 = arg1 - 1;
        if (!0x2::table::contains<u64, 0xb3a692af64df57943e376279995f211e3c1734d6c1c3b833a37ed039ae61bc04::shared_structs::Batch>(&arg0.batches, v0)) {
            return (0xb3a692af64df57943e376279995f211e3c1734d6c1c3b833a37ed039ae61bc04::shared_structs::create_batch(0, 0), false)
        };
        let v1 = *0x2::table::borrow<u64, 0xb3a692af64df57943e376279995f211e3c1734d6c1c3b833a37ed039ae61bc04::shared_structs::Batch>(&arg0.batches, v0);
        (v1, is_batch_final_internal(arg0, &v1, arg2))
    }

    public fun get_batch_deposits_count(arg0: &0xb3a692af64df57943e376279995f211e3c1734d6c1c3b833a37ed039ae61bc04::shared_structs::Batch) : u16 {
        0xb3a692af64df57943e376279995f211e3c1734d6c1c3b833a37ed039ae61bc04::shared_structs::batch_deposits_count(arg0)
    }

    public fun get_batch_nonce(arg0: &0xb3a692af64df57943e376279995f211e3c1734d6c1c3b833a37ed039ae61bc04::shared_structs::Batch) : u64 {
        0xb3a692af64df57943e376279995f211e3c1734d6c1c3b833a37ed039ae61bc04::shared_structs::batch_nonce(arg0)
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
        let v0 = 0xb3a692af64df57943e376279995f211e3c1734d6c1c3b833a37ed039ae61bc04::utils::type_name_bytes<T0>();
        if (!0x2::bag::contains<vector<u8>>(&arg0.coin_storage, v0)) {
            return 0
        };
        0x2::coin::value<T0>(0x2::bag::borrow<vector<u8>, 0x2::coin::Coin<T0>>(&arg0.coin_storage, v0))
    }

    public fun get_deposits(arg0: &BridgeSafe, arg1: u64, arg2: &0x2::clock::Clock) : (vector<0xb3a692af64df57943e376279995f211e3c1734d6c1c3b833a37ed039ae61bc04::shared_structs::Deposit>, bool) {
        assert!(arg1 > 0, 12);
        let v0 = arg1 - 1;
        let v1 = if (0x2::table::contains<u64, vector<0xb3a692af64df57943e376279995f211e3c1734d6c1c3b833a37ed039ae61bc04::shared_structs::Deposit>>(&arg0.batch_deposits, v0)) {
            *0x2::table::borrow<u64, vector<0xb3a692af64df57943e376279995f211e3c1734d6c1c3b833a37ed039ae61bc04::shared_structs::Deposit>>(&arg0.batch_deposits, v0)
        } else {
            0x1::vector::empty<0xb3a692af64df57943e376279995f211e3c1734d6c1c3b833a37ed039ae61bc04::shared_structs::Deposit>()
        };
        if (!0x2::table::contains<u64, 0xb3a692af64df57943e376279995f211e3c1734d6c1c3b833a37ed039ae61bc04::shared_structs::Batch>(&arg0.batches, v0)) {
            return (v1, false)
        };
        (v1, is_batch_final_internal(arg0, 0x2::table::borrow<u64, 0xb3a692af64df57943e376279995f211e3c1734d6c1c3b833a37ed039ae61bc04::shared_structs::Batch>(&arg0.batches, v0), arg2))
    }

    public fun get_deposits_count(arg0: &BridgeSafe) : u64 {
        arg0.deposits_count
    }

    public fun get_owner(arg0: &BridgeSafe) : address {
        0xb3a692af64df57943e376279995f211e3c1734d6c1c3b833a37ed039ae61bc04::bridge_roles::owner<0xb3a692af64df57943e376279995f211e3c1734d6c1c3b833a37ed039ae61bc04::bridge_roles::BridgeSafeTag>(&arg0.roles)
    }

    public fun get_pause(arg0: &BridgeSafe) : &0xb3a692af64df57943e376279995f211e3c1734d6c1c3b833a37ed039ae61bc04::pausable::Pause {
        &arg0.pause
    }

    public(friend) fun get_pause_mut(arg0: &mut BridgeSafe) : &mut 0xb3a692af64df57943e376279995f211e3c1734d6c1c3b833a37ed039ae61bc04::pausable::Pause {
        &mut arg0.pause
    }

    public fun get_pending_owner(arg0: &BridgeSafe) : 0x1::option::Option<address> {
        0xb3a692af64df57943e376279995f211e3c1734d6c1c3b833a37ed039ae61bc04::bridge_roles::pending_owner<0xb3a692af64df57943e376279995f211e3c1734d6c1c3b833a37ed039ae61bc04::bridge_roles::BridgeSafeTag>(&arg0.roles)
    }

    public fun get_stored_coin_balance<T0>(arg0: &mut BridgeSafe) : u64 {
        let v0 = 0xb3a692af64df57943e376279995f211e3c1734d6c1c3b833a37ed039ae61bc04::utils::type_name_bytes<T0>();
        if (!0x2::table::contains<vector<u8>, 0xb3a692af64df57943e376279995f211e3c1734d6c1c3b833a37ed039ae61bc04::shared_structs::TokenConfig>(&arg0.token_cfg, v0)) {
            return 0
        };
        0xb3a692af64df57943e376279995f211e3c1734d6c1c3b833a37ed039ae61bc04::shared_structs::token_config_total_balance(0x2::table::borrow<vector<u8>, 0xb3a692af64df57943e376279995f211e3c1734d6c1c3b833a37ed039ae61bc04::shared_structs::TokenConfig>(&arg0.token_cfg, v0))
    }

    public fun get_token_is_mint_burn<T0>(arg0: &BridgeSafe) : bool {
        0xb3a692af64df57943e376279995f211e3c1734d6c1c3b833a37ed039ae61bc04::shared_structs::token_config_is_mint_burn(0x2::table::borrow<vector<u8>, 0xb3a692af64df57943e376279995f211e3c1734d6c1c3b833a37ed039ae61bc04::shared_structs::TokenConfig>(&arg0.token_cfg, 0xb3a692af64df57943e376279995f211e3c1734d6c1c3b833a37ed039ae61bc04::utils::type_name_bytes<T0>()))
    }

    public fun get_token_is_native<T0>(arg0: &BridgeSafe) : bool {
        0xb3a692af64df57943e376279995f211e3c1734d6c1c3b833a37ed039ae61bc04::shared_structs::token_config_is_native(0x2::table::borrow<vector<u8>, 0xb3a692af64df57943e376279995f211e3c1734d6c1c3b833a37ed039ae61bc04::shared_structs::TokenConfig>(&arg0.token_cfg, 0xb3a692af64df57943e376279995f211e3c1734d6c1c3b833a37ed039ae61bc04::utils::type_name_bytes<T0>()))
    }

    public fun get_token_max_limit<T0>(arg0: &BridgeSafe) : u64 {
        0xb3a692af64df57943e376279995f211e3c1734d6c1c3b833a37ed039ae61bc04::shared_structs::token_config_max_limit(0x2::table::borrow<vector<u8>, 0xb3a692af64df57943e376279995f211e3c1734d6c1c3b833a37ed039ae61bc04::shared_structs::TokenConfig>(&arg0.token_cfg, 0xb3a692af64df57943e376279995f211e3c1734d6c1c3b833a37ed039ae61bc04::utils::type_name_bytes<T0>()))
    }

    public fun get_token_min_limit<T0>(arg0: &BridgeSafe) : u64 {
        0xb3a692af64df57943e376279995f211e3c1734d6c1c3b833a37ed039ae61bc04::shared_structs::token_config_min_limit(0x2::table::borrow<vector<u8>, 0xb3a692af64df57943e376279995f211e3c1734d6c1c3b833a37ed039ae61bc04::shared_structs::TokenConfig>(&arg0.token_cfg, 0xb3a692af64df57943e376279995f211e3c1734d6c1c3b833a37ed039ae61bc04::utils::type_name_bytes<T0>()))
    }

    public(friend) fun has_token_config<T0>(arg0: &BridgeSafe) : bool {
        0x2::table::contains<vector<u8>, 0xb3a692af64df57943e376279995f211e3c1734d6c1c3b833a37ed039ae61bc04::shared_structs::TokenConfig>(&arg0.token_cfg, 0xb3a692af64df57943e376279995f211e3c1734d6c1c3b833a37ed039ae61bc04::utils::type_name_bytes<T0>())
    }

    fun init(arg0: SAFE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, _) = 0xb3a692af64df57943e376279995f211e3c1734d6c1c3b833a37ed039ae61bc04::upgrade_service_bridge::new<SAFE>(arg0, 0x2::tx_context::sender(arg1), arg1);
        let v2 = SafeInitCap{id: 0x2::object::new(arg1)};
        0x2::transfer::transfer<SafeInitCap>(v2, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0xb3a692af64df57943e376279995f211e3c1734d6c1c3b833a37ed039ae61bc04::upgrade_service_bridge::UpgradeService<SAFE>>(v0);
    }

    public fun init_supply<T0>(arg0: &mut BridgeSafe, arg1: 0x2::coin::Coin<T0>, arg2: &mut 0x2::tx_context::TxContext) {
        assert_is_compatible(arg0);
        0xb3a692af64df57943e376279995f211e3c1734d6c1c3b833a37ed039ae61bc04::two_step_role::assert_sender_is_active_role<0xb3a692af64df57943e376279995f211e3c1734d6c1c3b833a37ed039ae61bc04::bridge_roles::OwnerRole<0xb3a692af64df57943e376279995f211e3c1734d6c1c3b833a37ed039ae61bc04::bridge_roles::BridgeSafeTag>>(0xb3a692af64df57943e376279995f211e3c1734d6c1c3b833a37ed039ae61bc04::bridge_roles::owner_role<0xb3a692af64df57943e376279995f211e3c1734d6c1c3b833a37ed039ae61bc04::bridge_roles::BridgeSafeTag>(&arg0.roles), arg2);
        let v0 = 0xb3a692af64df57943e376279995f211e3c1734d6c1c3b833a37ed039ae61bc04::utils::type_name_bytes<T0>();
        assert_token_is_whitelisted(arg0, v0);
        assert!(0xb3a692af64df57943e376279995f211e3c1734d6c1c3b833a37ed039ae61bc04::shared_structs::token_config_is_native(0x2::table::borrow<vector<u8>, 0xb3a692af64df57943e376279995f211e3c1734d6c1c3b833a37ed039ae61bc04::shared_structs::TokenConfig>(&arg0.token_cfg, v0)), 19);
        let v1 = borrow_token_cfg_mut(arg0, v0);
        0xb3a692af64df57943e376279995f211e3c1734d6c1c3b833a37ed039ae61bc04::shared_structs::add_to_token_config_total_balance(v1, 0x2::coin::value<T0>(&arg1));
        if (0x2::bag::contains<vector<u8>>(&arg0.coin_storage, v0)) {
            0x2::coin::join<T0>(0x2::bag::borrow_mut<vector<u8>, 0x2::coin::Coin<T0>>(&mut arg0.coin_storage, v0), arg1);
        } else {
            0x2::bag::add<vector<u8>, 0x2::coin::Coin<T0>>(&mut arg0.coin_storage, v0, arg1);
        };
    }

    public fun initialize(arg0: SafeInitCap, arg1: 0x8db9d9dc5cd5723ee55725869620073e28f88ddf3c360a512ebd73cb46f1903d::treasury::FromCoinCap<0x8db9d9dc5cd5723ee55725869620073e28f88ddf3c360a512ebd73cb46f1903d::bridge_token::BRIDGE_TOKEN>, arg2: &mut 0x2::tx_context::TxContext) {
        let SafeInitCap { id: v0 } = arg0;
        0x2::object::delete(v0);
        let v1 = 0x2::tx_context::sender(arg2);
        let v2 = 0x2::object::new(arg2);
        let v3 = BridgeSafe{
            id                      : v2,
            pause                   : 0xb3a692af64df57943e376279995f211e3c1734d6c1c3b833a37ed039ae61bc04::pausable::new(),
            roles                   : 0xb3a692af64df57943e376279995f211e3c1734d6c1c3b833a37ed039ae61bc04::bridge_roles::new<0xb3a692af64df57943e376279995f211e3c1734d6c1c3b833a37ed039ae61bc04::bridge_roles::BridgeSafeTag>(v1, arg2),
            bridge_addr             : v1,
            batch_size              : 10,
            batch_timeout_ms        : 5000,
            batch_settle_timeout_ms : 10000,
            batches_count           : 0,
            deposits_count          : 0,
            token_cfg               : 0x2::table::new<vector<u8>, 0xb3a692af64df57943e376279995f211e3c1734d6c1c3b833a37ed039ae61bc04::shared_structs::TokenConfig>(arg2),
            batches                 : 0x2::table::new<u64, 0xb3a692af64df57943e376279995f211e3c1734d6c1c3b833a37ed039ae61bc04::shared_structs::Batch>(arg2),
            batch_deposits          : 0x2::table::new<u64, vector<0xb3a692af64df57943e376279995f211e3c1734d6c1c3b833a37ed039ae61bc04::shared_structs::Deposit>>(arg2),
            coin_storage            : 0x2::bag::new(arg2),
            from_coin_cap           : arg1,
            compatible_versions     : 0x2::vec_set::singleton<u64>(0xb3a692af64df57943e376279995f211e3c1734d6c1c3b833a37ed039ae61bc04::bridge_version_control::current_version()),
        };
        0x2::transfer::public_transfer<0xb3a692af64df57943e376279995f211e3c1734d6c1c3b833a37ed039ae61bc04::bridge_roles::BridgeCap>(0xb3a692af64df57943e376279995f211e3c1734d6c1c3b833a37ed039ae61bc04::bridge_roles::publish_caps(0xb3a692af64df57943e376279995f211e3c1734d6c1c3b833a37ed039ae61bc04::bridge_roles::grant_witness(), 0x2::object::uid_to_inner(&v2), arg2), v1);
        0x2::transfer::share_object<BridgeSafe>(v3);
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
        !is_batch_final_internal(arg0, 0x2::table::borrow<u64, 0xb3a692af64df57943e376279995f211e3c1734d6c1c3b833a37ed039ae61bc04::shared_structs::Batch>(&arg0.batches, arg0.batches_count - 1), arg1)
    }

    fun is_batch_final_internal(arg0: &BridgeSafe, arg1: &0xb3a692af64df57943e376279995f211e3c1734d6c1c3b833a37ed039ae61bc04::shared_structs::Batch, arg2: &0x2::clock::Clock) : bool {
        0xb3a692af64df57943e376279995f211e3c1734d6c1c3b833a37ed039ae61bc04::shared_structs::batch_last_updated_timestamp_ms(arg1) + arg0.batch_settle_timeout_ms <= 0x2::clock::timestamp_ms(arg2)
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
        let v0 = 0xb3a692af64df57943e376279995f211e3c1734d6c1c3b833a37ed039ae61bc04::utils::type_name_bytes<T0>();
        if (!0x2::table::contains<vector<u8>, 0xb3a692af64df57943e376279995f211e3c1734d6c1c3b833a37ed039ae61bc04::shared_structs::TokenConfig>(&arg0.token_cfg, v0)) {
            return false
        };
        0xb3a692af64df57943e376279995f211e3c1734d6c1c3b833a37ed039ae61bc04::shared_structs::token_config_whitelisted(0x2::table::borrow<vector<u8>, 0xb3a692af64df57943e376279995f211e3c1734d6c1c3b833a37ed039ae61bc04::shared_structs::TokenConfig>(&arg0.token_cfg, v0))
    }

    public fun pause_contract(arg0: &mut BridgeSafe, arg1: &mut 0x2::tx_context::TxContext) {
        assert_is_compatible(arg0);
        0xb3a692af64df57943e376279995f211e3c1734d6c1c3b833a37ed039ae61bc04::two_step_role::assert_sender_is_active_role<0xb3a692af64df57943e376279995f211e3c1734d6c1c3b833a37ed039ae61bc04::bridge_roles::OwnerRole<0xb3a692af64df57943e376279995f211e3c1734d6c1c3b833a37ed039ae61bc04::bridge_roles::BridgeSafeTag>>(0xb3a692af64df57943e376279995f211e3c1734d6c1c3b833a37ed039ae61bc04::bridge_roles::owner_role<0xb3a692af64df57943e376279995f211e3c1734d6c1c3b833a37ed039ae61bc04::bridge_roles::BridgeSafeTag>(&arg0.roles), arg1);
        0xb3a692af64df57943e376279995f211e3c1734d6c1c3b833a37ed039ae61bc04::pausable::pause(&mut arg0.pause);
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
        assert_is_compatible(arg0);
        0xb3a692af64df57943e376279995f211e3c1734d6c1c3b833a37ed039ae61bc04::two_step_role::assert_sender_is_active_role<0xb3a692af64df57943e376279995f211e3c1734d6c1c3b833a37ed039ae61bc04::bridge_roles::OwnerRole<0xb3a692af64df57943e376279995f211e3c1734d6c1c3b833a37ed039ae61bc04::bridge_roles::BridgeSafeTag>>(0xb3a692af64df57943e376279995f211e3c1734d6c1c3b833a37ed039ae61bc04::bridge_roles::owner_role<0xb3a692af64df57943e376279995f211e3c1734d6c1c3b833a37ed039ae61bc04::bridge_roles::BridgeSafeTag>(&arg0.roles), arg1);
        let v0 = 0xb3a692af64df57943e376279995f211e3c1734d6c1c3b833a37ed039ae61bc04::utils::type_name_bytes<T0>();
        assert!(!0xb3a692af64df57943e376279995f211e3c1734d6c1c3b833a37ed039ae61bc04::shared_structs::token_config_is_mint_burn(0x2::table::borrow<vector<u8>, 0xb3a692af64df57943e376279995f211e3c1734d6c1c3b833a37ed039ae61bc04::shared_structs::TokenConfig>(&arg0.token_cfg, v0)), 22);
        unwhitelist_token(arg0, v0);
    }

    public(friend) fun roles_mut(arg0: &mut BridgeSafe) : &mut 0xb3a692af64df57943e376279995f211e3c1734d6c1c3b833a37ed039ae61bc04::bridge_roles::Roles<0xb3a692af64df57943e376279995f211e3c1734d6c1c3b833a37ed039ae61bc04::bridge_roles::BridgeSafeTag> {
        &mut arg0.roles
    }

    public fun set_batch_settle_timeout_ms(arg0: &mut BridgeSafe, arg1: u64, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        assert_is_compatible(arg0);
        0xb3a692af64df57943e376279995f211e3c1734d6c1c3b833a37ed039ae61bc04::pausable::assert_paused(&arg0.pause);
        0xb3a692af64df57943e376279995f211e3c1734d6c1c3b833a37ed039ae61bc04::two_step_role::assert_sender_is_active_role<0xb3a692af64df57943e376279995f211e3c1734d6c1c3b833a37ed039ae61bc04::bridge_roles::OwnerRole<0xb3a692af64df57943e376279995f211e3c1734d6c1c3b833a37ed039ae61bc04::bridge_roles::BridgeSafeTag>>(0xb3a692af64df57943e376279995f211e3c1734d6c1c3b833a37ed039ae61bc04::bridge_roles::owner_role<0xb3a692af64df57943e376279995f211e3c1734d6c1c3b833a37ed039ae61bc04::bridge_roles::BridgeSafeTag>(&arg0.roles), arg3);
        assert!(arg1 >= arg0.batch_timeout_ms, 2);
        assert!(!is_any_batch_in_progress_internal(arg0, arg2), 3);
        arg0.batch_settle_timeout_ms = arg1;
        0xb3a692af64df57943e376279995f211e3c1734d6c1c3b833a37ed039ae61bc04::events::emit_batch_settle_timeout_updated(arg1);
    }

    public fun set_batch_size(arg0: &mut BridgeSafe, arg1: u16, arg2: &mut 0x2::tx_context::TxContext) {
        assert_is_compatible(arg0);
        0xb3a692af64df57943e376279995f211e3c1734d6c1c3b833a37ed039ae61bc04::two_step_role::assert_sender_is_active_role<0xb3a692af64df57943e376279995f211e3c1734d6c1c3b833a37ed039ae61bc04::bridge_roles::OwnerRole<0xb3a692af64df57943e376279995f211e3c1734d6c1c3b833a37ed039ae61bc04::bridge_roles::BridgeSafeTag>>(0xb3a692af64df57943e376279995f211e3c1734d6c1c3b833a37ed039ae61bc04::bridge_roles::owner_role<0xb3a692af64df57943e376279995f211e3c1734d6c1c3b833a37ed039ae61bc04::bridge_roles::BridgeSafeTag>(&arg0.roles), arg2);
        assert!(arg1 > 0, 13);
        assert!(arg1 <= 100, 4);
        arg0.batch_size = arg1;
        0xb3a692af64df57943e376279995f211e3c1734d6c1c3b833a37ed039ae61bc04::events::emit_batch_size_updated(arg1);
    }

    public fun set_batch_timeout_ms(arg0: &mut BridgeSafe, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) {
        assert_is_compatible(arg0);
        0xb3a692af64df57943e376279995f211e3c1734d6c1c3b833a37ed039ae61bc04::two_step_role::assert_sender_is_active_role<0xb3a692af64df57943e376279995f211e3c1734d6c1c3b833a37ed039ae61bc04::bridge_roles::OwnerRole<0xb3a692af64df57943e376279995f211e3c1734d6c1c3b833a37ed039ae61bc04::bridge_roles::BridgeSafeTag>>(0xb3a692af64df57943e376279995f211e3c1734d6c1c3b833a37ed039ae61bc04::bridge_roles::owner_role<0xb3a692af64df57943e376279995f211e3c1734d6c1c3b833a37ed039ae61bc04::bridge_roles::BridgeSafeTag>(&arg0.roles), arg2);
        assert!(arg1 <= arg0.batch_settle_timeout_ms, 1);
        arg0.batch_timeout_ms = arg1;
        0xb3a692af64df57943e376279995f211e3c1734d6c1c3b833a37ed039ae61bc04::events::emit_batch_timeout_updated(arg1);
    }

    public fun set_bridge_addr(arg0: &mut BridgeSafe, arg1: address, arg2: &0x2::tx_context::TxContext) {
        assert_is_compatible(arg0);
        0xb3a692af64df57943e376279995f211e3c1734d6c1c3b833a37ed039ae61bc04::two_step_role::assert_sender_is_active_role<0xb3a692af64df57943e376279995f211e3c1734d6c1c3b833a37ed039ae61bc04::bridge_roles::OwnerRole<0xb3a692af64df57943e376279995f211e3c1734d6c1c3b833a37ed039ae61bc04::bridge_roles::BridgeSafeTag>>(0xb3a692af64df57943e376279995f211e3c1734d6c1c3b833a37ed039ae61bc04::bridge_roles::owner_role<0xb3a692af64df57943e376279995f211e3c1734d6c1c3b833a37ed039ae61bc04::bridge_roles::BridgeSafeTag>(&arg0.roles), arg2);
        arg0.bridge_addr = arg1;
        0xb3a692af64df57943e376279995f211e3c1734d6c1c3b833a37ed039ae61bc04::events::emit_bridge_transferred(arg0.bridge_addr, arg1);
    }

    public fun set_token_is_locked<T0>(arg0: &mut BridgeSafe, arg1: bool, arg2: &mut 0x2::tx_context::TxContext) {
        0xb3a692af64df57943e376279995f211e3c1734d6c1c3b833a37ed039ae61bc04::two_step_role::assert_sender_is_active_role<0xb3a692af64df57943e376279995f211e3c1734d6c1c3b833a37ed039ae61bc04::bridge_roles::OwnerRole<0xb3a692af64df57943e376279995f211e3c1734d6c1c3b833a37ed039ae61bc04::bridge_roles::BridgeSafeTag>>(0xb3a692af64df57943e376279995f211e3c1734d6c1c3b833a37ed039ae61bc04::bridge_roles::owner_role<0xb3a692af64df57943e376279995f211e3c1734d6c1c3b833a37ed039ae61bc04::bridge_roles::BridgeSafeTag>(&arg0.roles), arg2);
        let v0 = 0xb3a692af64df57943e376279995f211e3c1734d6c1c3b833a37ed039ae61bc04::utils::type_name_bytes<T0>();
        let v1 = borrow_token_cfg_mut(arg0, v0);
        let v2 = arg1 && 0xb3a692af64df57943e376279995f211e3c1734d6c1c3b833a37ed039ae61bc04::shared_structs::token_config_is_mint_burn(v1);
        assert!(!v2, 22);
        0xb3a692af64df57943e376279995f211e3c1734d6c1c3b833a37ed039ae61bc04::shared_structs::set_token_config_is_locked(v1, arg1);
        0xb3a692af64df57943e376279995f211e3c1734d6c1c3b833a37ed039ae61bc04::events::emit_token_is_locked_updated(v0, arg1);
    }

    public fun set_token_is_mint_burn<T0>(arg0: &mut BridgeSafe, arg1: bool, arg2: &mut 0x2::tx_context::TxContext) {
        assert_is_compatible(arg0);
        0xb3a692af64df57943e376279995f211e3c1734d6c1c3b833a37ed039ae61bc04::two_step_role::assert_sender_is_active_role<0xb3a692af64df57943e376279995f211e3c1734d6c1c3b833a37ed039ae61bc04::bridge_roles::OwnerRole<0xb3a692af64df57943e376279995f211e3c1734d6c1c3b833a37ed039ae61bc04::bridge_roles::BridgeSafeTag>>(0xb3a692af64df57943e376279995f211e3c1734d6c1c3b833a37ed039ae61bc04::bridge_roles::owner_role<0xb3a692af64df57943e376279995f211e3c1734d6c1c3b833a37ed039ae61bc04::bridge_roles::BridgeSafeTag>(&arg0.roles), arg2);
        let v0 = 0xb3a692af64df57943e376279995f211e3c1734d6c1c3b833a37ed039ae61bc04::utils::type_name_bytes<T0>();
        let v1 = borrow_token_cfg_mut(arg0, v0);
        let v2 = arg1 && 0xb3a692af64df57943e376279995f211e3c1734d6c1c3b833a37ed039ae61bc04::shared_structs::token_config_is_native(v1);
        assert!(!v2, 22);
        0xb3a692af64df57943e376279995f211e3c1734d6c1c3b833a37ed039ae61bc04::shared_structs::set_token_config_is_mint_burn(v1, arg1);
        0xb3a692af64df57943e376279995f211e3c1734d6c1c3b833a37ed039ae61bc04::events::emit_token_is_mint_burn_updated(v0, arg1);
    }

    public fun set_token_is_native<T0>(arg0: &mut BridgeSafe, arg1: bool, arg2: &mut 0x2::tx_context::TxContext) {
        assert_is_compatible(arg0);
        0xb3a692af64df57943e376279995f211e3c1734d6c1c3b833a37ed039ae61bc04::two_step_role::assert_sender_is_active_role<0xb3a692af64df57943e376279995f211e3c1734d6c1c3b833a37ed039ae61bc04::bridge_roles::OwnerRole<0xb3a692af64df57943e376279995f211e3c1734d6c1c3b833a37ed039ae61bc04::bridge_roles::BridgeSafeTag>>(0xb3a692af64df57943e376279995f211e3c1734d6c1c3b833a37ed039ae61bc04::bridge_roles::owner_role<0xb3a692af64df57943e376279995f211e3c1734d6c1c3b833a37ed039ae61bc04::bridge_roles::BridgeSafeTag>(&arg0.roles), arg2);
        let v0 = 0xb3a692af64df57943e376279995f211e3c1734d6c1c3b833a37ed039ae61bc04::utils::type_name_bytes<T0>();
        let v1 = borrow_token_cfg_mut(arg0, v0);
        let v2 = arg1 && 0xb3a692af64df57943e376279995f211e3c1734d6c1c3b833a37ed039ae61bc04::shared_structs::token_config_is_mint_burn(v1);
        assert!(!v2, 22);
        0xb3a692af64df57943e376279995f211e3c1734d6c1c3b833a37ed039ae61bc04::shared_structs::set_token_config_is_native(v1, arg1);
        0xb3a692af64df57943e376279995f211e3c1734d6c1c3b833a37ed039ae61bc04::events::emit_token_is_native_updated(v0, arg1);
    }

    public fun set_token_max_limit<T0>(arg0: &mut BridgeSafe, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) {
        assert_is_compatible(arg0);
        0xb3a692af64df57943e376279995f211e3c1734d6c1c3b833a37ed039ae61bc04::two_step_role::assert_sender_is_active_role<0xb3a692af64df57943e376279995f211e3c1734d6c1c3b833a37ed039ae61bc04::bridge_roles::OwnerRole<0xb3a692af64df57943e376279995f211e3c1734d6c1c3b833a37ed039ae61bc04::bridge_roles::BridgeSafeTag>>(0xb3a692af64df57943e376279995f211e3c1734d6c1c3b833a37ed039ae61bc04::bridge_roles::owner_role<0xb3a692af64df57943e376279995f211e3c1734d6c1c3b833a37ed039ae61bc04::bridge_roles::BridgeSafeTag>(&arg0.roles), arg2);
        let v0 = 0xb3a692af64df57943e376279995f211e3c1734d6c1c3b833a37ed039ae61bc04::utils::type_name_bytes<T0>();
        let v1 = borrow_token_cfg_mut(arg0, v0);
        let v2 = 0xb3a692af64df57943e376279995f211e3c1734d6c1c3b833a37ed039ae61bc04::shared_structs::token_config_min_limit(v1);
        assert!(arg1 >= v2, 15);
        0xb3a692af64df57943e376279995f211e3c1734d6c1c3b833a37ed039ae61bc04::shared_structs::set_token_config_max_limit(v1, arg1);
        0xb3a692af64df57943e376279995f211e3c1734d6c1c3b833a37ed039ae61bc04::events::emit_token_limits_updated(v0, v2, arg1);
    }

    public fun set_token_min_limit<T0>(arg0: &mut BridgeSafe, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) {
        assert_is_compatible(arg0);
        0xb3a692af64df57943e376279995f211e3c1734d6c1c3b833a37ed039ae61bc04::two_step_role::assert_sender_is_active_role<0xb3a692af64df57943e376279995f211e3c1734d6c1c3b833a37ed039ae61bc04::bridge_roles::OwnerRole<0xb3a692af64df57943e376279995f211e3c1734d6c1c3b833a37ed039ae61bc04::bridge_roles::BridgeSafeTag>>(0xb3a692af64df57943e376279995f211e3c1734d6c1c3b833a37ed039ae61bc04::bridge_roles::owner_role<0xb3a692af64df57943e376279995f211e3c1734d6c1c3b833a37ed039ae61bc04::bridge_roles::BridgeSafeTag>(&arg0.roles), arg2);
        let v0 = 0xb3a692af64df57943e376279995f211e3c1734d6c1c3b833a37ed039ae61bc04::utils::type_name_bytes<T0>();
        let v1 = borrow_token_cfg_mut(arg0, v0);
        let v2 = 0xb3a692af64df57943e376279995f211e3c1734d6c1c3b833a37ed039ae61bc04::shared_structs::token_config_max_limit(v1);
        assert!(arg1 > 0, 10);
        assert!(arg1 <= v2, 15);
        0xb3a692af64df57943e376279995f211e3c1734d6c1c3b833a37ed039ae61bc04::shared_structs::set_token_config_min_limit(v1, arg1);
        0xb3a692af64df57943e376279995f211e3c1734d6c1c3b833a37ed039ae61bc04::events::emit_token_limits_updated(v0, arg1, v2);
    }

    fun should_create_new_batch_internal(arg0: &BridgeSafe, arg1: &0x2::clock::Clock) : bool {
        if (arg0.batches_count == 0) {
            return true
        };
        let v0 = 0x2::table::borrow<u64, 0xb3a692af64df57943e376279995f211e3c1734d6c1c3b833a37ed039ae61bc04::shared_structs::Batch>(&arg0.batches, arg0.batches_count - 1);
        is_batch_progress_over_internal(arg0, 0xb3a692af64df57943e376279995f211e3c1734d6c1c3b833a37ed039ae61bc04::shared_structs::batch_deposits_count(v0), 0xb3a692af64df57943e376279995f211e3c1734d6c1c3b833a37ed039ae61bc04::shared_structs::batch_timestamp_ms(v0), arg1) || 0xb3a692af64df57943e376279995f211e3c1734d6c1c3b833a37ed039ae61bc04::shared_structs::batch_deposits_count(v0) >= arg0.batch_size
    }

    public fun start_migration(arg0: &mut BridgeSafe, arg1: &0x2::tx_context::TxContext) {
        0xb3a692af64df57943e376279995f211e3c1734d6c1c3b833a37ed039ae61bc04::two_step_role::assert_sender_is_active_role<0xb3a692af64df57943e376279995f211e3c1734d6c1c3b833a37ed039ae61bc04::bridge_roles::OwnerRole<0xb3a692af64df57943e376279995f211e3c1734d6c1c3b833a37ed039ae61bc04::bridge_roles::BridgeSafeTag>>(0xb3a692af64df57943e376279995f211e3c1734d6c1c3b833a37ed039ae61bc04::bridge_roles::owner_role<0xb3a692af64df57943e376279995f211e3c1734d6c1c3b833a37ed039ae61bc04::bridge_roles::BridgeSafeTag>(&arg0.roles), arg1);
        assert!(0x2::vec_set::length<u64>(&arg0.compatible_versions) == 1, 16);
        assert!(*0x1::vector::borrow<u64>(0x2::vec_set::keys<u64>(&arg0.compatible_versions), 0) < 0xb3a692af64df57943e376279995f211e3c1734d6c1c3b833a37ed039ae61bc04::bridge_version_control::current_version(), 14);
        0x2::vec_set::insert<u64>(&mut arg0.compatible_versions, 0xb3a692af64df57943e376279995f211e3c1734d6c1c3b833a37ed039ae61bc04::bridge_version_control::current_version());
        let v0 = MigrationStarted{compatible_versions: *0x2::vec_set::keys<u64>(&arg0.compatible_versions)};
        0x2::event::emit<MigrationStarted>(v0);
    }

    public(friend) fun subtract_token_balance<T0>(arg0: &mut BridgeSafe, arg1: u64) {
        0xb3a692af64df57943e376279995f211e3c1734d6c1c3b833a37ed039ae61bc04::shared_structs::subtract_from_token_config_total_balance(0x2::table::borrow_mut<vector<u8>, 0xb3a692af64df57943e376279995f211e3c1734d6c1c3b833a37ed039ae61bc04::shared_structs::TokenConfig>(&mut arg0.token_cfg, 0xb3a692af64df57943e376279995f211e3c1734d6c1c3b833a37ed039ae61bc04::utils::type_name_bytes<T0>()), arg1);
    }

    public fun sync_supply<T0>(arg0: &mut BridgeSafe, arg1: 0x2::coin::Coin<T0>, arg2: &mut 0x2::tx_context::TxContext) {
        assert_is_compatible(arg0);
        0xb3a692af64df57943e376279995f211e3c1734d6c1c3b833a37ed039ae61bc04::two_step_role::assert_sender_is_active_role<0xb3a692af64df57943e376279995f211e3c1734d6c1c3b833a37ed039ae61bc04::bridge_roles::OwnerRole<0xb3a692af64df57943e376279995f211e3c1734d6c1c3b833a37ed039ae61bc04::bridge_roles::BridgeSafeTag>>(0xb3a692af64df57943e376279995f211e3c1734d6c1c3b833a37ed039ae61bc04::bridge_roles::owner_role<0xb3a692af64df57943e376279995f211e3c1734d6c1c3b833a37ed039ae61bc04::bridge_roles::BridgeSafeTag>(&arg0.roles), arg2);
        let v0 = 0xb3a692af64df57943e376279995f211e3c1734d6c1c3b833a37ed039ae61bc04::utils::type_name_bytes<T0>();
        assert_token_is_whitelisted(arg0, v0);
        let v1 = 0x2::table::borrow<vector<u8>, 0xb3a692af64df57943e376279995f211e3c1734d6c1c3b833a37ed039ae61bc04::shared_structs::TokenConfig>(&arg0.token_cfg, v0);
        assert!(0xb3a692af64df57943e376279995f211e3c1734d6c1c3b833a37ed039ae61bc04::shared_structs::token_config_is_native(v1), 19);
        let v2 = 0xb3a692af64df57943e376279995f211e3c1734d6c1c3b833a37ed039ae61bc04::shared_structs::token_config_total_balance(v1);
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
        assert_is_compatible(arg0);
        0xb3a692af64df57943e376279995f211e3c1734d6c1c3b833a37ed039ae61bc04::two_step_role::begin_role_transfer<0xb3a692af64df57943e376279995f211e3c1734d6c1c3b833a37ed039ae61bc04::bridge_roles::OwnerRole<0xb3a692af64df57943e376279995f211e3c1734d6c1c3b833a37ed039ae61bc04::bridge_roles::BridgeSafeTag>>(0xb3a692af64df57943e376279995f211e3c1734d6c1c3b833a37ed039ae61bc04::bridge_roles::owner_role_mut<0xb3a692af64df57943e376279995f211e3c1734d6c1c3b833a37ed039ae61bc04::bridge_roles::BridgeSafeTag>(roles_mut(arg0)), arg1, arg2);
    }

    public(friend) fun uid(arg0: &BridgeSafe) : &0x2::object::UID {
        &arg0.id
    }

    public(friend) fun uid_mut(arg0: &mut BridgeSafe) : &mut 0x2::object::UID {
        &mut arg0.id
    }

    public fun unpause_contract(arg0: &mut BridgeSafe, arg1: &mut 0x2::tx_context::TxContext) {
        assert_is_compatible(arg0);
        0xb3a692af64df57943e376279995f211e3c1734d6c1c3b833a37ed039ae61bc04::two_step_role::assert_sender_is_active_role<0xb3a692af64df57943e376279995f211e3c1734d6c1c3b833a37ed039ae61bc04::bridge_roles::OwnerRole<0xb3a692af64df57943e376279995f211e3c1734d6c1c3b833a37ed039ae61bc04::bridge_roles::BridgeSafeTag>>(0xb3a692af64df57943e376279995f211e3c1734d6c1c3b833a37ed039ae61bc04::bridge_roles::owner_role<0xb3a692af64df57943e376279995f211e3c1734d6c1c3b833a37ed039ae61bc04::bridge_roles::BridgeSafeTag>(&arg0.roles), arg1);
        0xb3a692af64df57943e376279995f211e3c1734d6c1c3b833a37ed039ae61bc04::pausable::unpause(&mut arg0.pause);
    }

    public(friend) fun unwhitelist_token(arg0: &mut BridgeSafe, arg1: vector<u8>) {
        0xb3a692af64df57943e376279995f211e3c1734d6c1c3b833a37ed039ae61bc04::shared_structs::set_token_config_whitelisted(borrow_token_cfg_mut(arg0, arg1), false);
        0xb3a692af64df57943e376279995f211e3c1734d6c1c3b833a37ed039ae61bc04::events::emit_token_removed_from_whitelist(arg1);
    }

    public fun whitelist_token<T0>(arg0: &mut BridgeSafe, arg1: u64, arg2: u64, arg3: bool, arg4: &mut 0x2::tx_context::TxContext) {
        assert_is_compatible(arg0);
        whitelist_token_internal<T0>(arg0, arg1, arg2, true, 0x1::option::none<0x2::object::ID>(), false, arg3, arg4);
    }

    public(friend) fun whitelist_token_internal<T0>(arg0: &mut BridgeSafe, arg1: u64, arg2: u64, arg3: bool, arg4: 0x1::option::Option<0x2::object::ID>, arg5: bool, arg6: bool, arg7: &0x2::tx_context::TxContext) {
        0xb3a692af64df57943e376279995f211e3c1734d6c1c3b833a37ed039ae61bc04::two_step_role::assert_sender_is_active_role<0xb3a692af64df57943e376279995f211e3c1734d6c1c3b833a37ed039ae61bc04::bridge_roles::OwnerRole<0xb3a692af64df57943e376279995f211e3c1734d6c1c3b833a37ed039ae61bc04::bridge_roles::BridgeSafeTag>>(0xb3a692af64df57943e376279995f211e3c1734d6c1c3b833a37ed039ae61bc04::bridge_roles::owner_role<0xb3a692af64df57943e376279995f211e3c1734d6c1c3b833a37ed039ae61bc04::bridge_roles::BridgeSafeTag>(&arg0.roles), arg7);
        let v0 = arg5 && arg6;
        assert!(!v0, 22);
        assert!(arg1 > 0, 10);
        assert!(arg1 <= arg2, 15);
        let v1 = 0xb3a692af64df57943e376279995f211e3c1734d6c1c3b833a37ed039ae61bc04::utils::type_name_bytes<T0>();
        if (0x2::table::contains<vector<u8>, 0xb3a692af64df57943e376279995f211e3c1734d6c1c3b833a37ed039ae61bc04::shared_structs::TokenConfig>(&arg0.token_cfg, v1)) {
            assert_token_is_not_whitelisted(arg0, v1);
        };
        0xb3a692af64df57943e376279995f211e3c1734d6c1c3b833a37ed039ae61bc04::shared_structs::upsert_token_config(&mut arg0.token_cfg, v1, true, arg3, arg1, arg2, arg4, arg5, arg6);
        0xb3a692af64df57943e376279995f211e3c1734d6c1c3b833a37ed039ae61bc04::events::emit_token_whitelisted(v1, arg1, arg2, arg3, arg5, arg6);
    }

    // decompiled from Move bytecode v7
}

