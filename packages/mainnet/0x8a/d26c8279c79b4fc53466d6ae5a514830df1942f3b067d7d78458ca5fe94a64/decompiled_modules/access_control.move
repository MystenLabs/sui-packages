module 0x8ad26c8279c79b4fc53466d6ae5a514830df1942f3b067d7d78458ca5fe94a64::access_control {
    struct ExecutionProgressWitness has drop {
        dummy_field: bool,
    }

    struct CapLocked has copy, drop {
        account_id: 0x2::object::ID,
        cap_type: 0x1::type_name::TypeName,
    }

    struct CapUnlocked has copy, drop {
        account_id: 0x2::object::ID,
        cap_type: 0x1::type_name::TypeName,
        resource_name: 0x1::string::String,
    }

    struct AccessControlLock<phantom T0> has drop {
        dummy_field: bool,
    }

    struct AccessControlUnlockToResources<phantom T0> has drop {
        dummy_field: bool,
    }

    struct CapKey<phantom T0> has copy, drop, store {
        dummy_field: bool,
    }

    public fun access_control_lock<T0>() : AccessControlLock<T0> {
        AccessControlLock<T0>{dummy_field: false}
    }

    public fun access_control_unlock_to_resources<T0>() : AccessControlUnlockToResources<T0> {
        AccessControlUnlockToResources<T0>{dummy_field: false}
    }

    public(friend) fun cap_key<T0>() : CapKey<T0> {
        CapKey<T0>{dummy_field: false}
    }

    public fun do_lock<T0: store, T1: store, T2: store + key, T3: drop>(arg0: &mut 0x8a7f8ce15365ff144cb808887e3c1d2484ddd7ce1b7037bdf5e299351845eada::executable::Executable<T1>, arg1: &mut 0x8a7f8ce15365ff144cb808887e3c1d2484ddd7ce1b7037bdf5e299351845eada::account::Account, arg2: &0x8a7f8ce15365ff144cb808887e3c1d2484ddd7ce1b7037bdf5e299351845eada::package_registry::PackageRegistry, arg3: T3) {
        0x8a7f8ce15365ff144cb808887e3c1d2484ddd7ce1b7037bdf5e299351845eada::intents::assert_is_account<T1>(0x8a7f8ce15365ff144cb808887e3c1d2484ddd7ce1b7037bdf5e299351845eada::executable::intent<T1>(arg0), 0x8a7f8ce15365ff144cb808887e3c1d2484ddd7ce1b7037bdf5e299351845eada::account::addr(arg1));
        let v0 = 0x1::vector::borrow<0x8a7f8ce15365ff144cb808887e3c1d2484ddd7ce1b7037bdf5e299351845eada::intents::ActionSpec>(0x8a7f8ce15365ff144cb808887e3c1d2484ddd7ce1b7037bdf5e299351845eada::intents::action_specs<T1>(0x8a7f8ce15365ff144cb808887e3c1d2484ddd7ce1b7037bdf5e299351845eada::executable::intent<T1>(arg0)), 0x8a7f8ce15365ff144cb808887e3c1d2484ddd7ce1b7037bdf5e299351845eada::executable::action_idx<T1>(arg0));
        0x8a7f8ce15365ff144cb808887e3c1d2484ddd7ce1b7037bdf5e299351845eada::action_validation::assert_action_type<AccessControlLock<T2>>(v0);
        assert!(0x8a7f8ce15365ff144cb808887e3c1d2484ddd7ce1b7037bdf5e299351845eada::intents::action_spec_version(v0) == 1, 1);
        let v1 = 0x2::bcs::new(*0x8a7f8ce15365ff144cb808887e3c1d2484ddd7ce1b7037bdf5e299351845eada::intents::action_spec_data(v0));
        0x8a7f8ce15365ff144cb808887e3c1d2484ddd7ce1b7037bdf5e299351845eada::bcs_validation::validate_all_bytes_consumed(v1);
        let v2 = ExecutionProgressWitness{dummy_field: false};
        let v3 = 0x8a7f8ce15365ff144cb808887e3c1d2484ddd7ce1b7037bdf5e299351845eada::executable_resources::take_object<T2, T1, ExecutionProgressWitness>(arg0, arg2, v2, 0x1::string::utf8(0x2::bcs::peel_vec_u8(&mut v1)));
        assert!(0x2::object::id<T2>(&v3) == 0x2::object::id_from_address(0x2::bcs::peel_address(&mut v1)), 2);
        let v4 = CapKey<T2>{dummy_field: false};
        let v5 = ExecutionProgressWitness{dummy_field: false};
        0x8a7f8ce15365ff144cb808887e3c1d2484ddd7ce1b7037bdf5e299351845eada::account::add_managed_asset<CapKey<T2>, T2, T1, ExecutionProgressWitness>(arg1, arg2, v4, v3, arg0, v5);
        let v6 = CapLocked{
            account_id : 0x2::object::id<0x8a7f8ce15365ff144cb808887e3c1d2484ddd7ce1b7037bdf5e299351845eada::account::Account>(arg1),
            cap_type   : 0x1::type_name::get<T2>(),
        };
        0x2::event::emit<CapLocked>(v6);
        let v7 = ExecutionProgressWitness{dummy_field: false};
        0x8a7f8ce15365ff144cb808887e3c1d2484ddd7ce1b7037bdf5e299351845eada::executable::increment_action_idx<T1, AccessControlLock<T2>, ExecutionProgressWitness>(arg0, arg2, v7);
    }

    public fun do_unlock_to_resources<T0: store, T1: store, T2: store + key, T3: drop>(arg0: &mut 0x8a7f8ce15365ff144cb808887e3c1d2484ddd7ce1b7037bdf5e299351845eada::executable::Executable<T1>, arg1: &mut 0x8a7f8ce15365ff144cb808887e3c1d2484ddd7ce1b7037bdf5e299351845eada::account::Account, arg2: &0x8a7f8ce15365ff144cb808887e3c1d2484ddd7ce1b7037bdf5e299351845eada::package_registry::PackageRegistry, arg3: T3, arg4: &mut 0x2::tx_context::TxContext) {
        0x8a7f8ce15365ff144cb808887e3c1d2484ddd7ce1b7037bdf5e299351845eada::intents::assert_is_account<T1>(0x8a7f8ce15365ff144cb808887e3c1d2484ddd7ce1b7037bdf5e299351845eada::executable::intent<T1>(arg0), 0x8a7f8ce15365ff144cb808887e3c1d2484ddd7ce1b7037bdf5e299351845eada::account::addr(arg1));
        let v0 = 0x1::vector::borrow<0x8a7f8ce15365ff144cb808887e3c1d2484ddd7ce1b7037bdf5e299351845eada::intents::ActionSpec>(0x8a7f8ce15365ff144cb808887e3c1d2484ddd7ce1b7037bdf5e299351845eada::intents::action_specs<T1>(0x8a7f8ce15365ff144cb808887e3c1d2484ddd7ce1b7037bdf5e299351845eada::executable::intent<T1>(arg0)), 0x8a7f8ce15365ff144cb808887e3c1d2484ddd7ce1b7037bdf5e299351845eada::executable::action_idx<T1>(arg0));
        0x8a7f8ce15365ff144cb808887e3c1d2484ddd7ce1b7037bdf5e299351845eada::action_validation::assert_action_type<AccessControlUnlockToResources<T2>>(v0);
        assert!(0x8a7f8ce15365ff144cb808887e3c1d2484ddd7ce1b7037bdf5e299351845eada::intents::action_spec_version(v0) == 1, 1);
        let v1 = 0x2::bcs::new(*0x8a7f8ce15365ff144cb808887e3c1d2484ddd7ce1b7037bdf5e299351845eada::intents::action_spec_data(v0));
        let v2 = 0x1::string::utf8(0x2::bcs::peel_vec_u8(&mut v1));
        0x8a7f8ce15365ff144cb808887e3c1d2484ddd7ce1b7037bdf5e299351845eada::bcs_validation::validate_all_bytes_consumed(v1);
        let v3 = CapKey<T2>{dummy_field: false};
        let v4 = ExecutionProgressWitness{dummy_field: false};
        let v5 = ExecutionProgressWitness{dummy_field: false};
        0x8a7f8ce15365ff144cb808887e3c1d2484ddd7ce1b7037bdf5e299351845eada::executable_resources::provide_object<T2, T1, ExecutionProgressWitness>(arg0, arg2, v5, v2, 0x8a7f8ce15365ff144cb808887e3c1d2484ddd7ce1b7037bdf5e299351845eada::account::remove_managed_asset<CapKey<T2>, T2, T1, ExecutionProgressWitness>(arg1, arg2, v3, arg0, v4), arg4);
        let v6 = CapUnlocked{
            account_id    : 0x2::object::id<0x8a7f8ce15365ff144cb808887e3c1d2484ddd7ce1b7037bdf5e299351845eada::account::Account>(arg1),
            cap_type      : 0x1::type_name::get<T2>(),
            resource_name : v2,
        };
        0x2::event::emit<CapUnlocked>(v6);
        let v7 = ExecutionProgressWitness{dummy_field: false};
        0x8a7f8ce15365ff144cb808887e3c1d2484ddd7ce1b7037bdf5e299351845eada::executable::increment_action_idx<T1, AccessControlUnlockToResources<T2>, ExecutionProgressWitness>(arg0, arg2, v7);
    }

    public fun has_lock<T0: store, T1>(arg0: &0x8a7f8ce15365ff144cb808887e3c1d2484ddd7ce1b7037bdf5e299351845eada::account::Account) : bool {
        let v0 = CapKey<T1>{dummy_field: false};
        0x8a7f8ce15365ff144cb808887e3c1d2484ddd7ce1b7037bdf5e299351845eada::account::has_managed_asset<CapKey<T1>>(arg0, v0)
    }

    public fun remove_cap<T0: store, T1: store + key, T2: drop>(arg0: &mut 0x8a7f8ce15365ff144cb808887e3c1d2484ddd7ce1b7037bdf5e299351845eada::account::Account, arg1: &0x8a7f8ce15365ff144cb808887e3c1d2484ddd7ce1b7037bdf5e299351845eada::package_registry::PackageRegistry, arg2: &0x8a7f8ce15365ff144cb808887e3c1d2484ddd7ce1b7037bdf5e299351845eada::executable::Executable<T0>, arg3: T2) : T1 {
        let v0 = CapKey<T1>{dummy_field: false};
        0x8a7f8ce15365ff144cb808887e3c1d2484ddd7ce1b7037bdf5e299351845eada::account::remove_managed_asset<CapKey<T1>, T1, T0, T2>(arg0, arg1, v0, arg2, arg3)
    }

    public fun return_cap<T0: store, T1: store + key, T2: drop>(arg0: &mut 0x8a7f8ce15365ff144cb808887e3c1d2484ddd7ce1b7037bdf5e299351845eada::account::Account, arg1: &0x8a7f8ce15365ff144cb808887e3c1d2484ddd7ce1b7037bdf5e299351845eada::package_registry::PackageRegistry, arg2: T1, arg3: &0x8a7f8ce15365ff144cb808887e3c1d2484ddd7ce1b7037bdf5e299351845eada::executable::Executable<T0>, arg4: T2) {
        let v0 = CapKey<T1>{dummy_field: false};
        0x8a7f8ce15365ff144cb808887e3c1d2484ddd7ce1b7037bdf5e299351845eada::account::add_managed_asset<CapKey<T1>, T1, T0, T2>(arg0, arg1, v0, arg2, arg3, arg4);
    }

    // decompiled from Move bytecode v6
}

