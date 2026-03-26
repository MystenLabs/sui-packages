module 0xbe96f5469a522974f1226110b2753076587eeed890c01700a3bb14e528c956ee::package_upgrade {
    struct ExecutionProgressWitness has drop {
        dummy_field: bool,
    }

    struct UpgradeCapLocked has copy, drop {
        account_id: 0x2::object::ID,
        package_name: 0x1::string::String,
        package_addr: address,
        delay_ms: u64,
        policy: u8,
    }

    struct UpgradeAuthorized has copy, drop {
        account_id: 0x2::object::ID,
        package_name: 0x1::string::String,
        package_addr: address,
        policy: u8,
    }

    struct UpgradeCommitted has copy, drop {
        account_id: 0x2::object::ID,
        package_name: 0x1::string::String,
        old_package_addr: address,
        new_package_addr: address,
    }

    struct UpgradePolicyRestricted has copy, drop {
        account_id: 0x2::object::ID,
        package_name: 0x1::string::String,
        old_policy: u8,
        new_policy: u8,
        made_immutable: bool,
    }

    struct UpgradeCapUnlocked has copy, drop {
        account_id: 0x2::object::ID,
        package_name: 0x1::string::String,
        package_addr: address,
        resource_name: 0x1::string::String,
    }

    struct PackageUpgrade has drop {
        dummy_field: bool,
    }

    struct PackageCommit has drop {
        dummy_field: bool,
    }

    struct PackageRestrict has drop {
        dummy_field: bool,
    }

    struct LockUpgradeCap has drop {
        dummy_field: bool,
    }

    struct UnlockUpgradeCap has drop {
        dummy_field: bool,
    }

    struct UpgradeCapKey has copy, drop, store {
        pos0: 0x1::string::String,
    }

    struct UpgradeRulesKey has copy, drop, store {
        pos0: 0x1::string::String,
    }

    struct UpgradeIndexKey has copy, drop, store {
        dummy_field: bool,
    }

    struct UpgradeRules has store {
        delay_ms: u64,
    }

    struct UpgradeIndex has store {
        packages_info: 0x2::vec_map::VecMap<0x1::string::String, address>,
    }

    public(friend) fun borrow_cap(arg0: &0x8a0ce6b60836f32d52c7aed958f9f319cf3cb654c227cbb1806fdcaa0ad737e1::account::Account, arg1: &0x8a0ce6b60836f32d52c7aed958f9f319cf3cb654c227cbb1806fdcaa0ad737e1::package_registry::PackageRegistry, arg2: address) : &0x2::package::UpgradeCap {
        let v0 = UpgradeCapKey{pos0: get_package_name(arg0, arg1, arg2)};
        0x8a0ce6b60836f32d52c7aed958f9f319cf3cb654c227cbb1806fdcaa0ad737e1::account::borrow_managed_asset_with_package_witness<UpgradeCapKey, 0x2::package::UpgradeCap>(arg0, arg1, v0, 0xbe96f5469a522974f1226110b2753076587eeed890c01700a3bb14e528c956ee::actions_version::current())
    }

    public fun do_init_commit<T0: store, T1: drop>(arg0: &mut 0x8a0ce6b60836f32d52c7aed958f9f319cf3cb654c227cbb1806fdcaa0ad737e1::executable::Executable<T0>, arg1: &mut 0x8a0ce6b60836f32d52c7aed958f9f319cf3cb654c227cbb1806fdcaa0ad737e1::account::Account, arg2: &0x8a0ce6b60836f32d52c7aed958f9f319cf3cb654c227cbb1806fdcaa0ad737e1::package_registry::PackageRegistry, arg3: 0x2::package::UpgradeReceipt, arg4: T1) {
        0x8a0ce6b60836f32d52c7aed958f9f319cf3cb654c227cbb1806fdcaa0ad737e1::intents::assert_is_account<T0>(0x8a0ce6b60836f32d52c7aed958f9f319cf3cb654c227cbb1806fdcaa0ad737e1::executable::intent<T0>(arg0), 0x8a0ce6b60836f32d52c7aed958f9f319cf3cb654c227cbb1806fdcaa0ad737e1::account::addr(arg1));
        let v0 = 0x1::vector::borrow<0x8a0ce6b60836f32d52c7aed958f9f319cf3cb654c227cbb1806fdcaa0ad737e1::intents::ActionSpec>(0x8a0ce6b60836f32d52c7aed958f9f319cf3cb654c227cbb1806fdcaa0ad737e1::intents::action_specs<T0>(0x8a0ce6b60836f32d52c7aed958f9f319cf3cb654c227cbb1806fdcaa0ad737e1::executable::intent<T0>(arg0)), 0x8a0ce6b60836f32d52c7aed958f9f319cf3cb654c227cbb1806fdcaa0ad737e1::executable::action_idx<T0>(arg0));
        0x8a0ce6b60836f32d52c7aed958f9f319cf3cb654c227cbb1806fdcaa0ad737e1::action_validation::assert_action_type<PackageCommit>(v0);
        assert!(0x8a0ce6b60836f32d52c7aed958f9f319cf3cb654c227cbb1806fdcaa0ad737e1::intents::action_spec_version(v0) == 1, 3);
        let v1 = 0x2::bcs::new(*0x8a0ce6b60836f32d52c7aed958f9f319cf3cb654c227cbb1806fdcaa0ad737e1::intents::action_spec_data(v0));
        let v2 = 0x1::string::utf8(0x2::bcs::peel_vec_u8(&mut v1));
        0x8a0ce6b60836f32d52c7aed958f9f319cf3cb654c227cbb1806fdcaa0ad737e1::bcs_validation::validate_all_bytes_consumed(v1);
        assert!(0x1::string::length(&v2) > 0, 7);
        let v3 = UpgradeCapKey{pos0: v2};
        let v4 = ExecutionProgressWitness{dummy_field: false};
        let v5 = 0x8a0ce6b60836f32d52c7aed958f9f319cf3cb654c227cbb1806fdcaa0ad737e1::account::borrow_managed_asset_mut<UpgradeCapKey, 0x2::package::UpgradeCap, T0, ExecutionProgressWitness>(arg1, arg2, v3, arg0, v4);
        assert!(0x2::object::id<0x2::package::UpgradeCap>(v5) == 0x2::object::id_from_address(0x2::bcs::peel_address(&mut v1)), 9);
        assert!(0x2::package::receipt_cap(&arg3) == 0x2::object::id<0x2::package::UpgradeCap>(v5), 4);
        let v6 = 0x2::package::upgrade_package(v5);
        assert!(0x2::object::id_to_address(&v6) == @0x0, 10);
        0x2::package::commit_upgrade(v5, arg3);
        let v7 = 0x2::package::upgrade_package(v5);
        let v8 = 0x2::object::id_to_address(&v7);
        let v9 = UpgradeIndexKey{dummy_field: false};
        let v10 = ExecutionProgressWitness{dummy_field: false};
        let v11 = 0x8a0ce6b60836f32d52c7aed958f9f319cf3cb654c227cbb1806fdcaa0ad737e1::account::borrow_managed_data_mut<UpgradeIndexKey, UpgradeIndex, T0, ExecutionProgressWitness>(arg1, arg2, v9, arg0, v10);
        *0x2::vec_map::get_mut<0x1::string::String, address>(&mut v11.packages_info, &v2) = v8;
        let v12 = UpgradeCommitted{
            account_id       : 0x2::object::id<0x8a0ce6b60836f32d52c7aed958f9f319cf3cb654c227cbb1806fdcaa0ad737e1::account::Account>(arg1),
            package_name     : v2,
            old_package_addr : *0x2::vec_map::get<0x1::string::String, address>(&v11.packages_info, &v2),
            new_package_addr : v8,
        };
        0x2::event::emit<UpgradeCommitted>(v12);
        let v13 = ExecutionProgressWitness{dummy_field: false};
        0x8a0ce6b60836f32d52c7aed958f9f319cf3cb654c227cbb1806fdcaa0ad737e1::executable::increment_action_idx<T0, PackageCommit, ExecutionProgressWitness>(arg0, arg2, v13);
    }

    public fun do_init_lock_upgrade_cap<T0: store, T1: drop>(arg0: &mut 0x8a0ce6b60836f32d52c7aed958f9f319cf3cb654c227cbb1806fdcaa0ad737e1::executable::Executable<T0>, arg1: &mut 0x8a0ce6b60836f32d52c7aed958f9f319cf3cb654c227cbb1806fdcaa0ad737e1::account::Account, arg2: &0x8a0ce6b60836f32d52c7aed958f9f319cf3cb654c227cbb1806fdcaa0ad737e1::package_registry::PackageRegistry, arg3: T1) {
        0x8a0ce6b60836f32d52c7aed958f9f319cf3cb654c227cbb1806fdcaa0ad737e1::intents::assert_is_account<T0>(0x8a0ce6b60836f32d52c7aed958f9f319cf3cb654c227cbb1806fdcaa0ad737e1::executable::intent<T0>(arg0), 0x8a0ce6b60836f32d52c7aed958f9f319cf3cb654c227cbb1806fdcaa0ad737e1::account::addr(arg1));
        let v0 = 0x1::vector::borrow<0x8a0ce6b60836f32d52c7aed958f9f319cf3cb654c227cbb1806fdcaa0ad737e1::intents::ActionSpec>(0x8a0ce6b60836f32d52c7aed958f9f319cf3cb654c227cbb1806fdcaa0ad737e1::intents::action_specs<T0>(0x8a0ce6b60836f32d52c7aed958f9f319cf3cb654c227cbb1806fdcaa0ad737e1::executable::intent<T0>(arg0)), 0x8a0ce6b60836f32d52c7aed958f9f319cf3cb654c227cbb1806fdcaa0ad737e1::executable::action_idx<T0>(arg0));
        0x8a0ce6b60836f32d52c7aed958f9f319cf3cb654c227cbb1806fdcaa0ad737e1::action_validation::assert_action_type<LockUpgradeCap>(v0);
        assert!(0x8a0ce6b60836f32d52c7aed958f9f319cf3cb654c227cbb1806fdcaa0ad737e1::intents::action_spec_version(v0) == 1, 3);
        let v1 = 0x2::bcs::new(*0x8a0ce6b60836f32d52c7aed958f9f319cf3cb654c227cbb1806fdcaa0ad737e1::intents::action_spec_data(v0));
        let v2 = 0x1::string::utf8(0x2::bcs::peel_vec_u8(&mut v1));
        let v3 = 0x2::bcs::peel_u64(&mut v1);
        0x8a0ce6b60836f32d52c7aed958f9f319cf3cb654c227cbb1806fdcaa0ad737e1::bcs_validation::validate_all_bytes_consumed(v1);
        assert!(0x1::string::length(&v2) > 0, 7);
        assert!(!has_cap(arg1, v2), 0);
        let v4 = ExecutionProgressWitness{dummy_field: false};
        let v5 = 0x8a0ce6b60836f32d52c7aed958f9f319cf3cb654c227cbb1806fdcaa0ad737e1::executable_resources::take_object<0x2::package::UpgradeCap, T0, ExecutionProgressWitness>(arg0, arg2, v4, 0x1::string::utf8(0x2::bcs::peel_vec_u8(&mut v1)));
        assert!(0x2::object::id<0x2::package::UpgradeCap>(&v5) == 0x2::object::id_from_address(0x2::bcs::peel_address(&mut v1)), 9);
        let v6 = 0x2::package::upgrade_package(&v5);
        let v7 = 0x2::object::id_to_address(&v6);
        let v8 = UpgradeIndexKey{dummy_field: false};
        if (!0x8a0ce6b60836f32d52c7aed958f9f319cf3cb654c227cbb1806fdcaa0ad737e1::account::has_managed_data<UpgradeIndexKey>(arg1, v8)) {
            let v9 = UpgradeIndexKey{dummy_field: false};
            let v10 = UpgradeIndex{packages_info: 0x2::vec_map::empty<0x1::string::String, address>()};
            let v11 = ExecutionProgressWitness{dummy_field: false};
            0x8a0ce6b60836f32d52c7aed958f9f319cf3cb654c227cbb1806fdcaa0ad737e1::account::add_managed_data<UpgradeIndexKey, UpgradeIndex, T0, ExecutionProgressWitness>(arg1, arg2, v9, v10, arg0, v11);
        };
        let v12 = UpgradeIndexKey{dummy_field: false};
        let v13 = ExecutionProgressWitness{dummy_field: false};
        let v14 = 0x8a0ce6b60836f32d52c7aed958f9f319cf3cb654c227cbb1806fdcaa0ad737e1::account::borrow_managed_data_mut<UpgradeIndexKey, UpgradeIndex, T0, ExecutionProgressWitness>(arg1, arg2, v12, arg0, v13);
        assert!(!0x2::vec_map::contains<0x1::string::String, address>(&v14.packages_info, &v2), 8);
        0x2::vec_map::insert<0x1::string::String, address>(&mut v14.packages_info, v2, v7);
        let v15 = UpgradeCapKey{pos0: v2};
        let v16 = ExecutionProgressWitness{dummy_field: false};
        0x8a0ce6b60836f32d52c7aed958f9f319cf3cb654c227cbb1806fdcaa0ad737e1::account::add_managed_asset<UpgradeCapKey, 0x2::package::UpgradeCap, T0, ExecutionProgressWitness>(arg1, arg2, v15, v5, arg0, v16);
        let v17 = UpgradeRulesKey{pos0: v2};
        let v18 = UpgradeRules{delay_ms: v3};
        let v19 = ExecutionProgressWitness{dummy_field: false};
        0x8a0ce6b60836f32d52c7aed958f9f319cf3cb654c227cbb1806fdcaa0ad737e1::account::add_managed_data<UpgradeRulesKey, UpgradeRules, T0, ExecutionProgressWitness>(arg1, arg2, v17, v18, arg0, v19);
        let v20 = UpgradeCapLocked{
            account_id   : 0x2::object::id<0x8a0ce6b60836f32d52c7aed958f9f319cf3cb654c227cbb1806fdcaa0ad737e1::account::Account>(arg1),
            package_name : v2,
            package_addr : v7,
            delay_ms     : v3,
            policy       : 0x2::package::upgrade_policy(&v5),
        };
        0x2::event::emit<UpgradeCapLocked>(v20);
        let v21 = ExecutionProgressWitness{dummy_field: false};
        0x8a0ce6b60836f32d52c7aed958f9f319cf3cb654c227cbb1806fdcaa0ad737e1::executable::increment_action_idx<T0, LockUpgradeCap, ExecutionProgressWitness>(arg0, arg2, v21);
    }

    public fun do_init_restrict<T0: store, T1: drop>(arg0: &mut 0x8a0ce6b60836f32d52c7aed958f9f319cf3cb654c227cbb1806fdcaa0ad737e1::executable::Executable<T0>, arg1: &mut 0x8a0ce6b60836f32d52c7aed958f9f319cf3cb654c227cbb1806fdcaa0ad737e1::account::Account, arg2: &0x8a0ce6b60836f32d52c7aed958f9f319cf3cb654c227cbb1806fdcaa0ad737e1::package_registry::PackageRegistry, arg3: T1) {
        0x8a0ce6b60836f32d52c7aed958f9f319cf3cb654c227cbb1806fdcaa0ad737e1::intents::assert_is_account<T0>(0x8a0ce6b60836f32d52c7aed958f9f319cf3cb654c227cbb1806fdcaa0ad737e1::executable::intent<T0>(arg0), 0x8a0ce6b60836f32d52c7aed958f9f319cf3cb654c227cbb1806fdcaa0ad737e1::account::addr(arg1));
        let v0 = 0x1::vector::borrow<0x8a0ce6b60836f32d52c7aed958f9f319cf3cb654c227cbb1806fdcaa0ad737e1::intents::ActionSpec>(0x8a0ce6b60836f32d52c7aed958f9f319cf3cb654c227cbb1806fdcaa0ad737e1::intents::action_specs<T0>(0x8a0ce6b60836f32d52c7aed958f9f319cf3cb654c227cbb1806fdcaa0ad737e1::executable::intent<T0>(arg0)), 0x8a0ce6b60836f32d52c7aed958f9f319cf3cb654c227cbb1806fdcaa0ad737e1::executable::action_idx<T0>(arg0));
        0x8a0ce6b60836f32d52c7aed958f9f319cf3cb654c227cbb1806fdcaa0ad737e1::action_validation::assert_action_type<PackageRestrict>(v0);
        assert!(0x8a0ce6b60836f32d52c7aed958f9f319cf3cb654c227cbb1806fdcaa0ad737e1::intents::action_spec_version(v0) == 1, 3);
        let v1 = 0x2::bcs::new(*0x8a0ce6b60836f32d52c7aed958f9f319cf3cb654c227cbb1806fdcaa0ad737e1::intents::action_spec_data(v0));
        let v2 = 0x1::string::utf8(0x2::bcs::peel_vec_u8(&mut v1));
        let v3 = 0x2::bcs::peel_u8(&mut v1);
        0x8a0ce6b60836f32d52c7aed958f9f319cf3cb654c227cbb1806fdcaa0ad737e1::bcs_validation::validate_all_bytes_consumed(v1);
        assert!(0x1::string::length(&v2) > 0, 7);
        assert!(is_valid_restrict_policy(v3), 5);
        let v4 = UpgradeCapKey{pos0: v2};
        let v5 = ExecutionProgressWitness{dummy_field: false};
        let v6 = 0x8a0ce6b60836f32d52c7aed958f9f319cf3cb654c227cbb1806fdcaa0ad737e1::account::borrow_managed_asset_mut<UpgradeCapKey, 0x2::package::UpgradeCap, T0, ExecutionProgressWitness>(arg1, arg2, v4, arg0, v5);
        assert!(0x2::object::id<0x2::package::UpgradeCap>(v6) == 0x2::object::id_from_address(0x2::bcs::peel_address(&mut v1)), 9);
        let v7 = 0x2::package::upgrade_policy(v6);
        assert!(v3 > v7, 6);
        let v8 = if (v3 == immutable_policy()) {
            let v9 = UpgradeCapKey{pos0: v2};
            let v10 = ExecutionProgressWitness{dummy_field: false};
            0x2::package::make_immutable(0x8a0ce6b60836f32d52c7aed958f9f319cf3cb654c227cbb1806fdcaa0ad737e1::account::remove_managed_asset<UpgradeCapKey, 0x2::package::UpgradeCap, T0, ExecutionProgressWitness>(arg1, arg2, v9, arg0, v10));
            let v11 = UpgradeRulesKey{pos0: v2};
            let v12 = ExecutionProgressWitness{dummy_field: false};
            let UpgradeRules {  } = 0x8a0ce6b60836f32d52c7aed958f9f319cf3cb654c227cbb1806fdcaa0ad737e1::account::remove_managed_data<UpgradeRulesKey, UpgradeRules, T0, ExecutionProgressWitness>(arg1, arg2, v11, arg0, v12);
            let v13 = UpgradeIndexKey{dummy_field: false};
            let v14 = ExecutionProgressWitness{dummy_field: false};
            let (_, _) = 0x2::vec_map::remove<0x1::string::String, address>(&mut 0x8a0ce6b60836f32d52c7aed958f9f319cf3cb654c227cbb1806fdcaa0ad737e1::account::borrow_managed_data_mut<UpgradeIndexKey, UpgradeIndex, T0, ExecutionProgressWitness>(arg1, arg2, v13, arg0, v14).packages_info, &v2);
            true
        } else {
            let v17 = UpgradeCapKey{pos0: v2};
            let v18 = ExecutionProgressWitness{dummy_field: false};
            if (v3 == 0x2::package::additive_policy()) {
                0x2::package::only_additive_upgrades(0x8a0ce6b60836f32d52c7aed958f9f319cf3cb654c227cbb1806fdcaa0ad737e1::account::borrow_managed_asset_mut<UpgradeCapKey, 0x2::package::UpgradeCap, T0, ExecutionProgressWitness>(arg1, arg2, v17, arg0, v18));
            } else {
                0x2::package::only_dep_upgrades(0x8a0ce6b60836f32d52c7aed958f9f319cf3cb654c227cbb1806fdcaa0ad737e1::account::borrow_managed_asset_mut<UpgradeCapKey, 0x2::package::UpgradeCap, T0, ExecutionProgressWitness>(arg1, arg2, v17, arg0, v18));
            };
            false
        };
        let v19 = UpgradePolicyRestricted{
            account_id     : 0x2::object::id<0x8a0ce6b60836f32d52c7aed958f9f319cf3cb654c227cbb1806fdcaa0ad737e1::account::Account>(arg1),
            package_name   : v2,
            old_policy     : v7,
            new_policy     : v3,
            made_immutable : v8,
        };
        0x2::event::emit<UpgradePolicyRestricted>(v19);
        let v20 = ExecutionProgressWitness{dummy_field: false};
        0x8a0ce6b60836f32d52c7aed958f9f319cf3cb654c227cbb1806fdcaa0ad737e1::executable::increment_action_idx<T0, PackageRestrict, ExecutionProgressWitness>(arg0, arg2, v20);
    }

    public fun do_init_unlock_upgrade_cap<T0: store, T1: drop>(arg0: &mut 0x8a0ce6b60836f32d52c7aed958f9f319cf3cb654c227cbb1806fdcaa0ad737e1::executable::Executable<T0>, arg1: &mut 0x8a0ce6b60836f32d52c7aed958f9f319cf3cb654c227cbb1806fdcaa0ad737e1::account::Account, arg2: &0x8a0ce6b60836f32d52c7aed958f9f319cf3cb654c227cbb1806fdcaa0ad737e1::package_registry::PackageRegistry, arg3: T1, arg4: &mut 0x2::tx_context::TxContext) {
        0x8a0ce6b60836f32d52c7aed958f9f319cf3cb654c227cbb1806fdcaa0ad737e1::intents::assert_is_account<T0>(0x8a0ce6b60836f32d52c7aed958f9f319cf3cb654c227cbb1806fdcaa0ad737e1::executable::intent<T0>(arg0), 0x8a0ce6b60836f32d52c7aed958f9f319cf3cb654c227cbb1806fdcaa0ad737e1::account::addr(arg1));
        let v0 = 0x1::vector::borrow<0x8a0ce6b60836f32d52c7aed958f9f319cf3cb654c227cbb1806fdcaa0ad737e1::intents::ActionSpec>(0x8a0ce6b60836f32d52c7aed958f9f319cf3cb654c227cbb1806fdcaa0ad737e1::intents::action_specs<T0>(0x8a0ce6b60836f32d52c7aed958f9f319cf3cb654c227cbb1806fdcaa0ad737e1::executable::intent<T0>(arg0)), 0x8a0ce6b60836f32d52c7aed958f9f319cf3cb654c227cbb1806fdcaa0ad737e1::executable::action_idx<T0>(arg0));
        0x8a0ce6b60836f32d52c7aed958f9f319cf3cb654c227cbb1806fdcaa0ad737e1::action_validation::assert_action_type<UnlockUpgradeCap>(v0);
        assert!(0x8a0ce6b60836f32d52c7aed958f9f319cf3cb654c227cbb1806fdcaa0ad737e1::intents::action_spec_version(v0) == 1, 3);
        let v1 = 0x2::bcs::new(*0x8a0ce6b60836f32d52c7aed958f9f319cf3cb654c227cbb1806fdcaa0ad737e1::intents::action_spec_data(v0));
        let v2 = 0x1::string::utf8(0x2::bcs::peel_vec_u8(&mut v1));
        let v3 = 0x1::string::utf8(0x2::bcs::peel_vec_u8(&mut v1));
        0x8a0ce6b60836f32d52c7aed958f9f319cf3cb654c227cbb1806fdcaa0ad737e1::bcs_validation::validate_all_bytes_consumed(v1);
        assert!(0x1::string::length(&v2) > 0, 7);
        let v4 = UpgradeCapKey{pos0: v2};
        let v5 = ExecutionProgressWitness{dummy_field: false};
        let v6 = 0x8a0ce6b60836f32d52c7aed958f9f319cf3cb654c227cbb1806fdcaa0ad737e1::account::remove_managed_asset<UpgradeCapKey, 0x2::package::UpgradeCap, T0, ExecutionProgressWitness>(arg1, arg2, v4, arg0, v5);
        assert!(0x2::object::id<0x2::package::UpgradeCap>(&v6) == 0x2::object::id_from_address(0x2::bcs::peel_address(&mut v1)), 9);
        let v7 = 0x2::package::upgrade_package(&v6);
        let v8 = UpgradeRulesKey{pos0: v2};
        let v9 = ExecutionProgressWitness{dummy_field: false};
        let UpgradeRules {  } = 0x8a0ce6b60836f32d52c7aed958f9f319cf3cb654c227cbb1806fdcaa0ad737e1::account::remove_managed_data<UpgradeRulesKey, UpgradeRules, T0, ExecutionProgressWitness>(arg1, arg2, v8, arg0, v9);
        let v10 = UpgradeIndexKey{dummy_field: false};
        let v11 = ExecutionProgressWitness{dummy_field: false};
        let (_, _) = 0x2::vec_map::remove<0x1::string::String, address>(&mut 0x8a0ce6b60836f32d52c7aed958f9f319cf3cb654c227cbb1806fdcaa0ad737e1::account::borrow_managed_data_mut<UpgradeIndexKey, UpgradeIndex, T0, ExecutionProgressWitness>(arg1, arg2, v10, arg0, v11).packages_info, &v2);
        let v14 = ExecutionProgressWitness{dummy_field: false};
        0x8a0ce6b60836f32d52c7aed958f9f319cf3cb654c227cbb1806fdcaa0ad737e1::executable_resources::provide_object<0x2::package::UpgradeCap, T0, ExecutionProgressWitness>(arg0, arg2, v14, v3, v6, arg4);
        let v15 = UpgradeCapUnlocked{
            account_id    : 0x2::object::id<0x8a0ce6b60836f32d52c7aed958f9f319cf3cb654c227cbb1806fdcaa0ad737e1::account::Account>(arg1),
            package_name  : v2,
            package_addr  : 0x2::object::id_to_address(&v7),
            resource_name : v3,
        };
        0x2::event::emit<UpgradeCapUnlocked>(v15);
        let v16 = ExecutionProgressWitness{dummy_field: false};
        0x8a0ce6b60836f32d52c7aed958f9f319cf3cb654c227cbb1806fdcaa0ad737e1::executable::increment_action_idx<T0, UnlockUpgradeCap, ExecutionProgressWitness>(arg0, arg2, v16);
    }

    public fun do_init_upgrade<T0: store, T1: drop>(arg0: &mut 0x8a0ce6b60836f32d52c7aed958f9f319cf3cb654c227cbb1806fdcaa0ad737e1::executable::Executable<T0>, arg1: &mut 0x8a0ce6b60836f32d52c7aed958f9f319cf3cb654c227cbb1806fdcaa0ad737e1::account::Account, arg2: &0x8a0ce6b60836f32d52c7aed958f9f319cf3cb654c227cbb1806fdcaa0ad737e1::package_registry::PackageRegistry, arg3: &0x2::clock::Clock, arg4: T1) : 0x2::package::UpgradeTicket {
        0x8a0ce6b60836f32d52c7aed958f9f319cf3cb654c227cbb1806fdcaa0ad737e1::intents::assert_is_account<T0>(0x8a0ce6b60836f32d52c7aed958f9f319cf3cb654c227cbb1806fdcaa0ad737e1::executable::intent<T0>(arg0), 0x8a0ce6b60836f32d52c7aed958f9f319cf3cb654c227cbb1806fdcaa0ad737e1::account::addr(arg1));
        let v0 = 0x1::vector::borrow<0x8a0ce6b60836f32d52c7aed958f9f319cf3cb654c227cbb1806fdcaa0ad737e1::intents::ActionSpec>(0x8a0ce6b60836f32d52c7aed958f9f319cf3cb654c227cbb1806fdcaa0ad737e1::intents::action_specs<T0>(0x8a0ce6b60836f32d52c7aed958f9f319cf3cb654c227cbb1806fdcaa0ad737e1::executable::intent<T0>(arg0)), 0x8a0ce6b60836f32d52c7aed958f9f319cf3cb654c227cbb1806fdcaa0ad737e1::executable::action_idx<T0>(arg0));
        0x8a0ce6b60836f32d52c7aed958f9f319cf3cb654c227cbb1806fdcaa0ad737e1::action_validation::assert_action_type<PackageUpgrade>(v0);
        assert!(0x8a0ce6b60836f32d52c7aed958f9f319cf3cb654c227cbb1806fdcaa0ad737e1::intents::action_spec_version(v0) == 1, 3);
        let v1 = 0x2::bcs::new(*0x8a0ce6b60836f32d52c7aed958f9f319cf3cb654c227cbb1806fdcaa0ad737e1::intents::action_spec_data(v0));
        let v2 = 0x1::string::utf8(0x2::bcs::peel_vec_u8(&mut v1));
        0x8a0ce6b60836f32d52c7aed958f9f319cf3cb654c227cbb1806fdcaa0ad737e1::bcs_validation::validate_all_bytes_consumed(v1);
        assert!(0x1::string::length(&v2) > 0, 7);
        let v3 = UpgradeRulesKey{pos0: v2};
        let v4 = ExecutionProgressWitness{dummy_field: false};
        assert!(0x2::clock::timestamp_ms(arg3) >= 0x8a0ce6b60836f32d52c7aed958f9f319cf3cb654c227cbb1806fdcaa0ad737e1::intents::creation_time<T0>(0x8a0ce6b60836f32d52c7aed958f9f319cf3cb654c227cbb1806fdcaa0ad737e1::executable::intent<T0>(arg0)) + 0x8a0ce6b60836f32d52c7aed958f9f319cf3cb654c227cbb1806fdcaa0ad737e1::account::borrow_managed_data_mut<UpgradeRulesKey, UpgradeRules, T0, ExecutionProgressWitness>(arg1, arg2, v3, arg0, v4).delay_ms, 1);
        let v5 = UpgradeCapKey{pos0: v2};
        let v6 = ExecutionProgressWitness{dummy_field: false};
        let v7 = 0x8a0ce6b60836f32d52c7aed958f9f319cf3cb654c227cbb1806fdcaa0ad737e1::account::borrow_managed_asset_mut<UpgradeCapKey, 0x2::package::UpgradeCap, T0, ExecutionProgressWitness>(arg1, arg2, v5, arg0, v6);
        assert!(0x2::object::id<0x2::package::UpgradeCap>(v7) == 0x2::object::id_from_address(0x2::bcs::peel_address(&mut v1)), 9);
        let v8 = 0x2::package::upgrade_policy(v7);
        let v9 = 0x2::package::upgrade_package(v7);
        let v10 = 0x2::package::authorize_upgrade(v7, v8, 0x2::bcs::peel_vec_u8(&mut v1));
        let v11 = UpgradeAuthorized{
            account_id   : 0x2::object::id<0x8a0ce6b60836f32d52c7aed958f9f319cf3cb654c227cbb1806fdcaa0ad737e1::account::Account>(arg1),
            package_name : v2,
            package_addr : 0x2::object::id_to_address(&v9),
            policy       : v8,
        };
        0x2::event::emit<UpgradeAuthorized>(v11);
        let v12 = ExecutionProgressWitness{dummy_field: false};
        0x8a0ce6b60836f32d52c7aed958f9f319cf3cb654c227cbb1806fdcaa0ad737e1::executable::increment_action_idx<T0, PackageUpgrade, ExecutionProgressWitness>(arg0, arg2, v12);
        v10
    }

    public fun get_cap_package(arg0: &0x8a0ce6b60836f32d52c7aed958f9f319cf3cb654c227cbb1806fdcaa0ad737e1::account::Account, arg1: &0x8a0ce6b60836f32d52c7aed958f9f319cf3cb654c227cbb1806fdcaa0ad737e1::package_registry::PackageRegistry, arg2: 0x1::string::String) : address {
        let v0 = UpgradeCapKey{pos0: arg2};
        let v1 = 0x2::package::upgrade_package(0x8a0ce6b60836f32d52c7aed958f9f319cf3cb654c227cbb1806fdcaa0ad737e1::account::borrow_managed_asset_with_package_witness<UpgradeCapKey, 0x2::package::UpgradeCap>(arg0, arg1, v0, 0xbe96f5469a522974f1226110b2753076587eeed890c01700a3bb14e528c956ee::actions_version::current()));
        0x2::object::id_to_address(&v1)
    }

    public fun get_cap_policy(arg0: &0x8a0ce6b60836f32d52c7aed958f9f319cf3cb654c227cbb1806fdcaa0ad737e1::account::Account, arg1: &0x8a0ce6b60836f32d52c7aed958f9f319cf3cb654c227cbb1806fdcaa0ad737e1::package_registry::PackageRegistry, arg2: 0x1::string::String) : u8 {
        let v0 = UpgradeCapKey{pos0: arg2};
        0x2::package::upgrade_policy(0x8a0ce6b60836f32d52c7aed958f9f319cf3cb654c227cbb1806fdcaa0ad737e1::account::borrow_managed_asset_with_package_witness<UpgradeCapKey, 0x2::package::UpgradeCap>(arg0, arg1, v0, 0xbe96f5469a522974f1226110b2753076587eeed890c01700a3bb14e528c956ee::actions_version::current()))
    }

    public fun get_cap_version(arg0: &0x8a0ce6b60836f32d52c7aed958f9f319cf3cb654c227cbb1806fdcaa0ad737e1::account::Account, arg1: &0x8a0ce6b60836f32d52c7aed958f9f319cf3cb654c227cbb1806fdcaa0ad737e1::package_registry::PackageRegistry, arg2: 0x1::string::String) : u64 {
        let v0 = UpgradeCapKey{pos0: arg2};
        0x2::package::version(0x8a0ce6b60836f32d52c7aed958f9f319cf3cb654c227cbb1806fdcaa0ad737e1::account::borrow_managed_asset_with_package_witness<UpgradeCapKey, 0x2::package::UpgradeCap>(arg0, arg1, v0, 0xbe96f5469a522974f1226110b2753076587eeed890c01700a3bb14e528c956ee::actions_version::current()))
    }

    public fun get_package_addr(arg0: &0x8a0ce6b60836f32d52c7aed958f9f319cf3cb654c227cbb1806fdcaa0ad737e1::account::Account, arg1: &0x8a0ce6b60836f32d52c7aed958f9f319cf3cb654c227cbb1806fdcaa0ad737e1::package_registry::PackageRegistry, arg2: 0x1::string::String) : address {
        let v0 = UpgradeIndexKey{dummy_field: false};
        *0x2::vec_map::get<0x1::string::String, address>(&0x8a0ce6b60836f32d52c7aed958f9f319cf3cb654c227cbb1806fdcaa0ad737e1::account::borrow_managed_data_with_package_witness<UpgradeIndexKey, UpgradeIndex>(arg0, arg1, v0, 0xbe96f5469a522974f1226110b2753076587eeed890c01700a3bb14e528c956ee::actions_version::current()).packages_info, &arg2)
    }

    public fun get_package_name(arg0: &0x8a0ce6b60836f32d52c7aed958f9f319cf3cb654c227cbb1806fdcaa0ad737e1::account::Account, arg1: &0x8a0ce6b60836f32d52c7aed958f9f319cf3cb654c227cbb1806fdcaa0ad737e1::package_registry::PackageRegistry, arg2: address) : 0x1::string::String {
        let v0 = UpgradeIndexKey{dummy_field: false};
        let v1 = 0x8a0ce6b60836f32d52c7aed958f9f319cf3cb654c227cbb1806fdcaa0ad737e1::account::borrow_managed_data_with_package_witness<UpgradeIndexKey, UpgradeIndex>(arg0, arg1, v0, 0xbe96f5469a522974f1226110b2753076587eeed890c01700a3bb14e528c956ee::actions_version::current());
        let v2 = 0;
        while (v2 < 0x2::vec_map::length<0x1::string::String, address>(&v1.packages_info)) {
            let (v3, v4) = 0x2::vec_map::get_entry_by_idx<0x1::string::String, address>(&v1.packages_info, v2);
            if (v4 == &arg2) {
                return *v3
            };
            v2 = v2 + 1;
        };
        abort 2
    }

    public fun get_packages_info(arg0: &0x8a0ce6b60836f32d52c7aed958f9f319cf3cb654c227cbb1806fdcaa0ad737e1::account::Account, arg1: &0x8a0ce6b60836f32d52c7aed958f9f319cf3cb654c227cbb1806fdcaa0ad737e1::package_registry::PackageRegistry) : &0x2::vec_map::VecMap<0x1::string::String, address> {
        let v0 = UpgradeIndexKey{dummy_field: false};
        &0x8a0ce6b60836f32d52c7aed958f9f319cf3cb654c227cbb1806fdcaa0ad737e1::account::borrow_managed_data_with_package_witness<UpgradeIndexKey, UpgradeIndex>(arg0, arg1, v0, 0xbe96f5469a522974f1226110b2753076587eeed890c01700a3bb14e528c956ee::actions_version::current()).packages_info
    }

    public fun get_time_delay(arg0: &0x8a0ce6b60836f32d52c7aed958f9f319cf3cb654c227cbb1806fdcaa0ad737e1::account::Account, arg1: &0x8a0ce6b60836f32d52c7aed958f9f319cf3cb654c227cbb1806fdcaa0ad737e1::package_registry::PackageRegistry, arg2: 0x1::string::String) : u64 {
        let v0 = UpgradeRulesKey{pos0: arg2};
        0x8a0ce6b60836f32d52c7aed958f9f319cf3cb654c227cbb1806fdcaa0ad737e1::account::borrow_managed_data_with_package_witness<UpgradeRulesKey, UpgradeRules>(arg0, arg1, v0, 0xbe96f5469a522974f1226110b2753076587eeed890c01700a3bb14e528c956ee::actions_version::current()).delay_ms
    }

    public fun has_cap(arg0: &0x8a0ce6b60836f32d52c7aed958f9f319cf3cb654c227cbb1806fdcaa0ad737e1::account::Account, arg1: 0x1::string::String) : bool {
        let v0 = UpgradeCapKey{pos0: arg1};
        0x8a0ce6b60836f32d52c7aed958f9f319cf3cb654c227cbb1806fdcaa0ad737e1::account::has_managed_asset<UpgradeCapKey>(arg0, v0)
    }

    public fun immutable_policy() : u8 {
        255
    }

    public fun is_package_managed(arg0: &0x8a0ce6b60836f32d52c7aed958f9f319cf3cb654c227cbb1806fdcaa0ad737e1::account::Account, arg1: &0x8a0ce6b60836f32d52c7aed958f9f319cf3cb654c227cbb1806fdcaa0ad737e1::package_registry::PackageRegistry, arg2: address) : bool {
        let v0 = UpgradeIndexKey{dummy_field: false};
        if (!0x8a0ce6b60836f32d52c7aed958f9f319cf3cb654c227cbb1806fdcaa0ad737e1::account::has_managed_data<UpgradeIndexKey>(arg0, v0)) {
            return false
        };
        let v1 = UpgradeIndexKey{dummy_field: false};
        let v2 = 0x8a0ce6b60836f32d52c7aed958f9f319cf3cb654c227cbb1806fdcaa0ad737e1::account::borrow_managed_data_with_package_witness<UpgradeIndexKey, UpgradeIndex>(arg0, arg1, v1, 0xbe96f5469a522974f1226110b2753076587eeed890c01700a3bb14e528c956ee::actions_version::current());
        let v3 = 0;
        while (v3 < 0x2::vec_map::length<0x1::string::String, address>(&v2.packages_info)) {
            let (_, v5) = 0x2::vec_map::get_entry_by_idx<0x1::string::String, address>(&v2.packages_info, v3);
            if (v5 == &arg2) {
                return true
            };
            v3 = v3 + 1;
        };
        false
    }

    public fun is_valid_restrict_policy(arg0: u8) : bool {
        if (arg0 == 0x2::package::additive_policy()) {
            true
        } else if (arg0 == 0x2::package::dep_only_policy()) {
            true
        } else {
            arg0 == immutable_policy()
        }
    }

    public fun lock_cap(arg0: 0x8a0ce6b60836f32d52c7aed958f9f319cf3cb654c227cbb1806fdcaa0ad737e1::account::Auth, arg1: &mut 0x8a0ce6b60836f32d52c7aed958f9f319cf3cb654c227cbb1806fdcaa0ad737e1::account::Account, arg2: &0x8a0ce6b60836f32d52c7aed958f9f319cf3cb654c227cbb1806fdcaa0ad737e1::package_registry::PackageRegistry, arg3: 0x2::package::UpgradeCap, arg4: 0x1::string::String, arg5: u64) {
        0x8a0ce6b60836f32d52c7aed958f9f319cf3cb654c227cbb1806fdcaa0ad737e1::account::verify(arg1, arg0);
        assert!(0x1::string::length(&arg4) > 0, 7);
        assert!(!has_cap(arg1, arg4), 0);
        let v0 = 0x2::package::upgrade_package(&arg3);
        let v1 = 0x2::object::id_to_address(&v0);
        let v2 = UpgradeIndexKey{dummy_field: false};
        if (!0x8a0ce6b60836f32d52c7aed958f9f319cf3cb654c227cbb1806fdcaa0ad737e1::account::has_managed_data<UpgradeIndexKey>(arg1, v2)) {
            let v3 = UpgradeIndexKey{dummy_field: false};
            let v4 = UpgradeIndex{packages_info: 0x2::vec_map::empty<0x1::string::String, address>()};
            0x8a0ce6b60836f32d52c7aed958f9f319cf3cb654c227cbb1806fdcaa0ad737e1::account::add_managed_data_with_package_witness<UpgradeIndexKey, UpgradeIndex>(arg1, arg2, v3, v4, 0xbe96f5469a522974f1226110b2753076587eeed890c01700a3bb14e528c956ee::actions_version::current());
        };
        let v5 = UpgradeIndexKey{dummy_field: false};
        let v6 = 0x8a0ce6b60836f32d52c7aed958f9f319cf3cb654c227cbb1806fdcaa0ad737e1::account::borrow_managed_data_mut_with_package_witness<UpgradeIndexKey, UpgradeIndex>(arg1, arg2, v5, 0xbe96f5469a522974f1226110b2753076587eeed890c01700a3bb14e528c956ee::actions_version::current());
        assert!(!0x2::vec_map::contains<0x1::string::String, address>(&v6.packages_info, &arg4), 8);
        0x2::vec_map::insert<0x1::string::String, address>(&mut v6.packages_info, arg4, v1);
        let v7 = UpgradeCapKey{pos0: arg4};
        0x8a0ce6b60836f32d52c7aed958f9f319cf3cb654c227cbb1806fdcaa0ad737e1::account::add_managed_asset_with_package_witness<UpgradeCapKey, 0x2::package::UpgradeCap>(arg1, arg2, v7, arg3, 0xbe96f5469a522974f1226110b2753076587eeed890c01700a3bb14e528c956ee::actions_version::current());
        let v8 = UpgradeRulesKey{pos0: arg4};
        let v9 = UpgradeRules{delay_ms: arg5};
        0x8a0ce6b60836f32d52c7aed958f9f319cf3cb654c227cbb1806fdcaa0ad737e1::account::add_managed_data_with_package_witness<UpgradeRulesKey, UpgradeRules>(arg1, arg2, v8, v9, 0xbe96f5469a522974f1226110b2753076587eeed890c01700a3bb14e528c956ee::actions_version::current());
        let v10 = UpgradeCapLocked{
            account_id   : 0x2::object::id<0x8a0ce6b60836f32d52c7aed958f9f319cf3cb654c227cbb1806fdcaa0ad737e1::account::Account>(arg1),
            package_name : arg4,
            package_addr : v1,
            delay_ms     : arg5,
            policy       : 0x2::package::upgrade_policy(&arg3),
        };
        0x2::event::emit<UpgradeCapLocked>(v10);
    }

    public fun lock_upgrade_cap_marker() : LockUpgradeCap {
        LockUpgradeCap{dummy_field: false}
    }

    public fun package_commit_marker() : PackageCommit {
        PackageCommit{dummy_field: false}
    }

    public fun package_restrict_marker() : PackageRestrict {
        PackageRestrict{dummy_field: false}
    }

    public fun package_upgrade_marker() : PackageUpgrade {
        PackageUpgrade{dummy_field: false}
    }

    public fun unlock_upgrade_cap_marker() : UnlockUpgradeCap {
        UnlockUpgradeCap{dummy_field: false}
    }

    // decompiled from Move bytecode v6
}

