module 0x8a0ce6b60836f32d52c7aed958f9f319cf3cb654c227cbb1806fdcaa0ad737e1::config {
    struct ExecutionProgressWitness has drop {
        dummy_field: bool,
    }

    struct AuthorizationLevelChanged has copy, drop {
        account_id: 0x2::object::ID,
        new_level: u8,
    }

    struct DepAdded has copy, drop {
        account_id: 0x2::object::ID,
        package_addr: address,
        package_name: 0x1::string::String,
        version: u64,
    }

    struct DepRemoved has copy, drop {
        account_id: 0x2::object::ID,
        package_addr: address,
    }

    struct ConfigSetAuthorizationLevel has drop {
        dummy_field: bool,
    }

    struct ConfigAddDep has drop {
        dummy_field: bool,
    }

    struct ConfigRemoveDep has drop {
        dummy_field: bool,
    }

    struct SetAuthorizationLevelIntent has drop {
        dummy_field: bool,
    }

    struct AddDepIntent has drop {
        dummy_field: bool,
    }

    struct RemoveDepIntent has drop {
        dummy_field: bool,
    }

    struct SetAuthorizationLevelAction has copy, drop, store {
        level: u8,
    }

    struct AddDepAction has copy, drop, store {
        addr: address,
        name: 0x1::string::String,
        version: u64,
    }

    struct RemoveDepAction has copy, drop, store {
        addr: address,
    }

    public fun config_add_dep() : ConfigAddDep {
        ConfigAddDep{dummy_field: false}
    }

    public fun config_remove_dep() : ConfigRemoveDep {
        ConfigRemoveDep{dummy_field: false}
    }

    public fun config_set_authorization_level() : ConfigSetAuthorizationLevel {
        ConfigSetAuthorizationLevel{dummy_field: false}
    }

    public fun do_add_dep<T0: store, T1: store, T2: drop>(arg0: &mut 0x8a0ce6b60836f32d52c7aed958f9f319cf3cb654c227cbb1806fdcaa0ad737e1::executable::Executable<T1>, arg1: &mut 0x8a0ce6b60836f32d52c7aed958f9f319cf3cb654c227cbb1806fdcaa0ad737e1::account::Account, arg2: &0x8a0ce6b60836f32d52c7aed958f9f319cf3cb654c227cbb1806fdcaa0ad737e1::package_registry::PackageRegistry, arg3: T2) {
        let v0 = ExecutionProgressWitness{dummy_field: false};
        0x8a0ce6b60836f32d52c7aed958f9f319cf3cb654c227cbb1806fdcaa0ad737e1::account::assert_execution_authorized<T1, ExecutionProgressWitness>(arg1, arg2, arg0, v0);
        let v1 = 0x1::vector::borrow<0x8a0ce6b60836f32d52c7aed958f9f319cf3cb654c227cbb1806fdcaa0ad737e1::intents::ActionSpec>(0x8a0ce6b60836f32d52c7aed958f9f319cf3cb654c227cbb1806fdcaa0ad737e1::intents::action_specs<T1>(0x8a0ce6b60836f32d52c7aed958f9f319cf3cb654c227cbb1806fdcaa0ad737e1::executable::intent<T1>(arg0)), 0x8a0ce6b60836f32d52c7aed958f9f319cf3cb654c227cbb1806fdcaa0ad737e1::executable::action_idx<T1>(arg0));
        0x8a0ce6b60836f32d52c7aed958f9f319cf3cb654c227cbb1806fdcaa0ad737e1::action_validation::assert_action_type<ConfigAddDep>(v1);
        assert!(0x8a0ce6b60836f32d52c7aed958f9f319cf3cb654c227cbb1806fdcaa0ad737e1::intents::action_spec_version(v1) == 1, 1);
        let v2 = 0x2::bcs::new(*0x8a0ce6b60836f32d52c7aed958f9f319cf3cb654c227cbb1806fdcaa0ad737e1::intents::action_spec_data(v1));
        let v3 = 0x2::bcs::peel_address(&mut v2);
        let v4 = 0x1::string::utf8(0x2::bcs::peel_vec_u8(&mut v2));
        let v5 = 0x2::bcs::peel_u64(&mut v2);
        0x8a0ce6b60836f32d52c7aed958f9f319cf3cb654c227cbb1806fdcaa0ad737e1::bcs_validation::validate_all_bytes_consumed(v2);
        if (0x8a0ce6b60836f32d52c7aed958f9f319cf3cb654c227cbb1806fdcaa0ad737e1::deps::authorization_level(0x8a0ce6b60836f32d52c7aed958f9f319cf3cb654c227cbb1806fdcaa0ad737e1::account::deps(arg1)) == 0x8a0ce6b60836f32d52c7aed958f9f319cf3cb654c227cbb1806fdcaa0ad737e1::deps::auth_level_global_only()) {
            assert!(0x8a0ce6b60836f32d52c7aed958f9f319cf3cb654c227cbb1806fdcaa0ad737e1::package_registry::contains_package_addr(arg2, v3), 10);
        };
        let v6 = 0x8a0ce6b60836f32d52c7aed958f9f319cf3cb654c227cbb1806fdcaa0ad737e1::account::dep_names_mut(arg1);
        assert!(!0x2::vec_map::contains<0x1::string::String, address>(v6, &v4), 0x8a0ce6b60836f32d52c7aed958f9f319cf3cb654c227cbb1806fdcaa0ad737e1::deps::e_dep_name_already_exists());
        0x2::vec_map::insert<0x1::string::String, address>(v6, v4, v3);
        0x8a0ce6b60836f32d52c7aed958f9f319cf3cb654c227cbb1806fdcaa0ad737e1::deps::add_dep_no_auth_check(0x8a0ce6b60836f32d52c7aed958f9f319cf3cb654c227cbb1806fdcaa0ad737e1::account::account_deps_mut(arg1), v3, v4, v5);
        let v7 = DepAdded{
            account_id   : 0x2::object::id<0x8a0ce6b60836f32d52c7aed958f9f319cf3cb654c227cbb1806fdcaa0ad737e1::account::Account>(arg1),
            package_addr : v3,
            package_name : v4,
            version      : v5,
        };
        0x2::event::emit<DepAdded>(v7);
        let v8 = ExecutionProgressWitness{dummy_field: false};
        0x8a0ce6b60836f32d52c7aed958f9f319cf3cb654c227cbb1806fdcaa0ad737e1::executable::increment_action_idx<T1, ConfigAddDep, ExecutionProgressWitness>(arg0, arg2, v8);
    }

    public fun do_remove_dep<T0: store, T1: store, T2: drop>(arg0: &mut 0x8a0ce6b60836f32d52c7aed958f9f319cf3cb654c227cbb1806fdcaa0ad737e1::executable::Executable<T1>, arg1: &mut 0x8a0ce6b60836f32d52c7aed958f9f319cf3cb654c227cbb1806fdcaa0ad737e1::account::Account, arg2: &0x8a0ce6b60836f32d52c7aed958f9f319cf3cb654c227cbb1806fdcaa0ad737e1::package_registry::PackageRegistry, arg3: T2) {
        let v0 = ExecutionProgressWitness{dummy_field: false};
        0x8a0ce6b60836f32d52c7aed958f9f319cf3cb654c227cbb1806fdcaa0ad737e1::account::assert_execution_authorized<T1, ExecutionProgressWitness>(arg1, arg2, arg0, v0);
        let v1 = 0x1::vector::borrow<0x8a0ce6b60836f32d52c7aed958f9f319cf3cb654c227cbb1806fdcaa0ad737e1::intents::ActionSpec>(0x8a0ce6b60836f32d52c7aed958f9f319cf3cb654c227cbb1806fdcaa0ad737e1::intents::action_specs<T1>(0x8a0ce6b60836f32d52c7aed958f9f319cf3cb654c227cbb1806fdcaa0ad737e1::executable::intent<T1>(arg0)), 0x8a0ce6b60836f32d52c7aed958f9f319cf3cb654c227cbb1806fdcaa0ad737e1::executable::action_idx<T1>(arg0));
        0x8a0ce6b60836f32d52c7aed958f9f319cf3cb654c227cbb1806fdcaa0ad737e1::action_validation::assert_action_type<ConfigRemoveDep>(v1);
        assert!(0x8a0ce6b60836f32d52c7aed958f9f319cf3cb654c227cbb1806fdcaa0ad737e1::intents::action_spec_version(v1) == 1, 1);
        let v2 = 0x2::bcs::new(*0x8a0ce6b60836f32d52c7aed958f9f319cf3cb654c227cbb1806fdcaa0ad737e1::intents::action_spec_data(v1));
        let v3 = 0x2::bcs::peel_address(&mut v2);
        0x8a0ce6b60836f32d52c7aed958f9f319cf3cb654c227cbb1806fdcaa0ad737e1::bcs_validation::validate_all_bytes_consumed(v2);
        let v4 = 0x8a0ce6b60836f32d52c7aed958f9f319cf3cb654c227cbb1806fdcaa0ad737e1::deps::remove_dep(0x8a0ce6b60836f32d52c7aed958f9f319cf3cb654c227cbb1806fdcaa0ad737e1::account::account_deps_mut(arg1), v3);
        let v5 = 0x8a0ce6b60836f32d52c7aed958f9f319cf3cb654c227cbb1806fdcaa0ad737e1::deps::dep_name(&v4);
        let v6 = 0x8a0ce6b60836f32d52c7aed958f9f319cf3cb654c227cbb1806fdcaa0ad737e1::account::dep_names_mut(arg1);
        if (0x2::vec_map::contains<0x1::string::String, address>(v6, &v5)) {
            let (_, _) = 0x2::vec_map::remove<0x1::string::String, address>(v6, &v5);
        };
        let v9 = DepRemoved{
            account_id   : 0x2::object::id<0x8a0ce6b60836f32d52c7aed958f9f319cf3cb654c227cbb1806fdcaa0ad737e1::account::Account>(arg1),
            package_addr : v3,
        };
        0x2::event::emit<DepRemoved>(v9);
        let v10 = ExecutionProgressWitness{dummy_field: false};
        0x8a0ce6b60836f32d52c7aed958f9f319cf3cb654c227cbb1806fdcaa0ad737e1::executable::increment_action_idx<T1, ConfigRemoveDep, ExecutionProgressWitness>(arg0, arg2, v10);
    }

    public fun do_set_authorization_level<T0: store, T1: store, T2: drop>(arg0: &mut 0x8a0ce6b60836f32d52c7aed958f9f319cf3cb654c227cbb1806fdcaa0ad737e1::executable::Executable<T1>, arg1: &mut 0x8a0ce6b60836f32d52c7aed958f9f319cf3cb654c227cbb1806fdcaa0ad737e1::account::Account, arg2: &0x8a0ce6b60836f32d52c7aed958f9f319cf3cb654c227cbb1806fdcaa0ad737e1::package_registry::PackageRegistry, arg3: T2) {
        let v0 = 0x1::vector::borrow<0x8a0ce6b60836f32d52c7aed958f9f319cf3cb654c227cbb1806fdcaa0ad737e1::intents::ActionSpec>(0x8a0ce6b60836f32d52c7aed958f9f319cf3cb654c227cbb1806fdcaa0ad737e1::intents::action_specs<T1>(0x8a0ce6b60836f32d52c7aed958f9f319cf3cb654c227cbb1806fdcaa0ad737e1::executable::intent<T1>(arg0)), 0x8a0ce6b60836f32d52c7aed958f9f319cf3cb654c227cbb1806fdcaa0ad737e1::executable::action_idx<T1>(arg0));
        0x8a0ce6b60836f32d52c7aed958f9f319cf3cb654c227cbb1806fdcaa0ad737e1::action_validation::assert_action_type<ConfigSetAuthorizationLevel>(v0);
        assert!(0x8a0ce6b60836f32d52c7aed958f9f319cf3cb654c227cbb1806fdcaa0ad737e1::intents::action_spec_version(v0) == 1, 1);
        let v1 = 0x2::bcs::new(*0x8a0ce6b60836f32d52c7aed958f9f319cf3cb654c227cbb1806fdcaa0ad737e1::intents::action_spec_data(v0));
        let v2 = 0x2::bcs::peel_u8(&mut v1);
        0x8a0ce6b60836f32d52c7aed958f9f319cf3cb654c227cbb1806fdcaa0ad737e1::bcs_validation::validate_all_bytes_consumed(v1);
        assert!(v2 <= 0x8a0ce6b60836f32d52c7aed958f9f319cf3cb654c227cbb1806fdcaa0ad737e1::constants::auth_level_permissive(), 11);
        let v3 = ExecutionProgressWitness{dummy_field: false};
        0x8a0ce6b60836f32d52c7aed958f9f319cf3cb654c227cbb1806fdcaa0ad737e1::deps::set_authorization_level(0x8a0ce6b60836f32d52c7aed958f9f319cf3cb654c227cbb1806fdcaa0ad737e1::account::deps_mut<T1, ExecutionProgressWitness>(arg1, arg2, arg0, v3), v2);
        let v4 = AuthorizationLevelChanged{
            account_id : 0x2::object::id<0x8a0ce6b60836f32d52c7aed958f9f319cf3cb654c227cbb1806fdcaa0ad737e1::account::Account>(arg1),
            new_level  : v2,
        };
        0x2::event::emit<AuthorizationLevelChanged>(v4);
        let v5 = ExecutionProgressWitness{dummy_field: false};
        0x8a0ce6b60836f32d52c7aed958f9f319cf3cb654c227cbb1806fdcaa0ad737e1::executable::increment_action_idx<T1, ConfigSetAuthorizationLevel, ExecutionProgressWitness>(arg0, arg2, v5);
    }

    public fun new_set_authorization_level_action(arg0: u8) : SetAuthorizationLevelAction {
        assert!(arg0 <= 0x8a0ce6b60836f32d52c7aed958f9f319cf3cb654c227cbb1806fdcaa0ad737e1::constants::auth_level_permissive(), 11);
        SetAuthorizationLevelAction{level: arg0}
    }

    // decompiled from Move bytecode v6
}

