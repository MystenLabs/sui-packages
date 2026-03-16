module 0x8fb7295d7e5473cd74f0800d552a2299c740258290f8d6ba6f13a63b4f3c2035::access_control {
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
        recipient: address,
    }

    struct AccessControlLock<phantom T0> has drop {
        dummy_field: bool,
    }

    struct AccessControlUnlockToAddress<phantom T0> has drop {
        dummy_field: bool,
    }

    struct CapKey<phantom T0> has copy, drop, store {
        dummy_field: bool,
    }

    public fun access_control_lock<T0>() : AccessControlLock<T0> {
        AccessControlLock<T0>{dummy_field: false}
    }

    public fun access_control_unlock_to_address<T0>() : AccessControlUnlockToAddress<T0> {
        AccessControlUnlockToAddress<T0>{dummy_field: false}
    }

    public(friend) fun cap_key<T0>() : CapKey<T0> {
        CapKey<T0>{dummy_field: false}
    }

    public fun do_lock<T0: store, T1: store, T2: store + key, T3: drop>(arg0: &mut 0x7a6ec95f874af0292f624c7d8ad8a5fb95935f5e756a1d1c31530f779358eaa7::executable::Executable<T1>, arg1: &mut 0x7a6ec95f874af0292f624c7d8ad8a5fb95935f5e756a1d1c31530f779358eaa7::account::Account, arg2: &0x7a6ec95f874af0292f624c7d8ad8a5fb95935f5e756a1d1c31530f779358eaa7::package_registry::PackageRegistry, arg3: T3, arg4: T2) {
        0x7a6ec95f874af0292f624c7d8ad8a5fb95935f5e756a1d1c31530f779358eaa7::intents::assert_is_account<T1>(0x7a6ec95f874af0292f624c7d8ad8a5fb95935f5e756a1d1c31530f779358eaa7::executable::intent<T1>(arg0), 0x7a6ec95f874af0292f624c7d8ad8a5fb95935f5e756a1d1c31530f779358eaa7::account::addr(arg1));
        let v0 = 0x1::vector::borrow<0x7a6ec95f874af0292f624c7d8ad8a5fb95935f5e756a1d1c31530f779358eaa7::intents::ActionSpec>(0x7a6ec95f874af0292f624c7d8ad8a5fb95935f5e756a1d1c31530f779358eaa7::intents::action_specs<T1>(0x7a6ec95f874af0292f624c7d8ad8a5fb95935f5e756a1d1c31530f779358eaa7::executable::intent<T1>(arg0)), 0x7a6ec95f874af0292f624c7d8ad8a5fb95935f5e756a1d1c31530f779358eaa7::executable::action_idx<T1>(arg0));
        assert!(0x7a6ec95f874af0292f624c7d8ad8a5fb95935f5e756a1d1c31530f779358eaa7::intents::action_spec_version(v0) == 1, 1);
        let v1 = 0x2::bcs::new(*0x7a6ec95f874af0292f624c7d8ad8a5fb95935f5e756a1d1c31530f779358eaa7::intents::action_spec_data(v0));
        0x7a6ec95f874af0292f624c7d8ad8a5fb95935f5e756a1d1c31530f779358eaa7::bcs_validation::validate_all_bytes_consumed(v1);
        assert!(0x2::object::id<T2>(&arg4) == 0x2::object::id_from_address(0x2::bcs::peel_address(&mut v1)), 2);
        let v2 = CapKey<T2>{dummy_field: false};
        let v3 = ExecutionProgressWitness{dummy_field: false};
        0x7a6ec95f874af0292f624c7d8ad8a5fb95935f5e756a1d1c31530f779358eaa7::account::add_managed_asset<CapKey<T2>, T2, T1, ExecutionProgressWitness>(arg1, arg2, v2, arg4, arg0, v3);
        let v4 = CapLocked{
            account_id : 0x2::object::id<0x7a6ec95f874af0292f624c7d8ad8a5fb95935f5e756a1d1c31530f779358eaa7::account::Account>(arg1),
            cap_type   : 0x1::type_name::get<T2>(),
        };
        0x2::event::emit<CapLocked>(v4);
        let v5 = ExecutionProgressWitness{dummy_field: false};
        0x7a6ec95f874af0292f624c7d8ad8a5fb95935f5e756a1d1c31530f779358eaa7::executable::increment_action_idx<T1, AccessControlLock<T2>, ExecutionProgressWitness>(arg0, arg2, v5);
    }

    public fun do_unlock_to_address<T0: store, T1: store, T2: store + key, T3: drop>(arg0: &mut 0x7a6ec95f874af0292f624c7d8ad8a5fb95935f5e756a1d1c31530f779358eaa7::executable::Executable<T1>, arg1: &mut 0x7a6ec95f874af0292f624c7d8ad8a5fb95935f5e756a1d1c31530f779358eaa7::account::Account, arg2: &0x7a6ec95f874af0292f624c7d8ad8a5fb95935f5e756a1d1c31530f779358eaa7::package_registry::PackageRegistry, arg3: T3) {
        0x7a6ec95f874af0292f624c7d8ad8a5fb95935f5e756a1d1c31530f779358eaa7::intents::assert_is_account<T1>(0x7a6ec95f874af0292f624c7d8ad8a5fb95935f5e756a1d1c31530f779358eaa7::executable::intent<T1>(arg0), 0x7a6ec95f874af0292f624c7d8ad8a5fb95935f5e756a1d1c31530f779358eaa7::account::addr(arg1));
        let v0 = 0x1::vector::borrow<0x7a6ec95f874af0292f624c7d8ad8a5fb95935f5e756a1d1c31530f779358eaa7::intents::ActionSpec>(0x7a6ec95f874af0292f624c7d8ad8a5fb95935f5e756a1d1c31530f779358eaa7::intents::action_specs<T1>(0x7a6ec95f874af0292f624c7d8ad8a5fb95935f5e756a1d1c31530f779358eaa7::executable::intent<T1>(arg0)), 0x7a6ec95f874af0292f624c7d8ad8a5fb95935f5e756a1d1c31530f779358eaa7::executable::action_idx<T1>(arg0));
        assert!(0x7a6ec95f874af0292f624c7d8ad8a5fb95935f5e756a1d1c31530f779358eaa7::intents::action_spec_version(v0) == 1, 1);
        let v1 = 0x2::bcs::new(*0x7a6ec95f874af0292f624c7d8ad8a5fb95935f5e756a1d1c31530f779358eaa7::intents::action_spec_data(v0));
        let v2 = 0x2::bcs::peel_address(&mut v1);
        0x7a6ec95f874af0292f624c7d8ad8a5fb95935f5e756a1d1c31530f779358eaa7::bcs_validation::validate_all_bytes_consumed(v1);
        let v3 = CapKey<T2>{dummy_field: false};
        let v4 = ExecutionProgressWitness{dummy_field: false};
        0x2::transfer::public_transfer<T2>(0x7a6ec95f874af0292f624c7d8ad8a5fb95935f5e756a1d1c31530f779358eaa7::account::remove_managed_asset<CapKey<T2>, T2, T1, ExecutionProgressWitness>(arg1, arg2, v3, arg0, v4), v2);
        let v5 = CapUnlocked{
            account_id : 0x2::object::id<0x7a6ec95f874af0292f624c7d8ad8a5fb95935f5e756a1d1c31530f779358eaa7::account::Account>(arg1),
            cap_type   : 0x1::type_name::get<T2>(),
            recipient  : v2,
        };
        0x2::event::emit<CapUnlocked>(v5);
        let v6 = ExecutionProgressWitness{dummy_field: false};
        0x7a6ec95f874af0292f624c7d8ad8a5fb95935f5e756a1d1c31530f779358eaa7::executable::increment_action_idx<T1, AccessControlUnlockToAddress<T2>, ExecutionProgressWitness>(arg0, arg2, v6);
    }

    public fun has_lock<T0: store, T1>(arg0: &0x7a6ec95f874af0292f624c7d8ad8a5fb95935f5e756a1d1c31530f779358eaa7::account::Account) : bool {
        let v0 = CapKey<T1>{dummy_field: false};
        0x7a6ec95f874af0292f624c7d8ad8a5fb95935f5e756a1d1c31530f779358eaa7::account::has_managed_asset<CapKey<T1>>(arg0, v0)
    }

    public fun remove_cap<T0: store, T1: store + key, T2: drop>(arg0: &mut 0x7a6ec95f874af0292f624c7d8ad8a5fb95935f5e756a1d1c31530f779358eaa7::account::Account, arg1: &0x7a6ec95f874af0292f624c7d8ad8a5fb95935f5e756a1d1c31530f779358eaa7::package_registry::PackageRegistry, arg2: &0x7a6ec95f874af0292f624c7d8ad8a5fb95935f5e756a1d1c31530f779358eaa7::executable::Executable<T0>, arg3: T2) : T1 {
        let v0 = CapKey<T1>{dummy_field: false};
        0x7a6ec95f874af0292f624c7d8ad8a5fb95935f5e756a1d1c31530f779358eaa7::account::remove_managed_asset<CapKey<T1>, T1, T0, T2>(arg0, arg1, v0, arg2, arg3)
    }

    public fun return_cap<T0: store, T1: store + key, T2: drop>(arg0: &mut 0x7a6ec95f874af0292f624c7d8ad8a5fb95935f5e756a1d1c31530f779358eaa7::account::Account, arg1: &0x7a6ec95f874af0292f624c7d8ad8a5fb95935f5e756a1d1c31530f779358eaa7::package_registry::PackageRegistry, arg2: T1, arg3: &0x7a6ec95f874af0292f624c7d8ad8a5fb95935f5e756a1d1c31530f779358eaa7::executable::Executable<T0>, arg4: T2) {
        let v0 = CapKey<T1>{dummy_field: false};
        0x7a6ec95f874af0292f624c7d8ad8a5fb95935f5e756a1d1c31530f779358eaa7::account::add_managed_asset<CapKey<T1>, T1, T0, T2>(arg0, arg1, v0, arg2, arg3, arg4);
    }

    // decompiled from Move bytecode v6
}

