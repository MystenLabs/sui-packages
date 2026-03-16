module 0x7a6ec95f874af0292f624c7d8ad8a5fb95935f5e756a1d1c31530f779358eaa7::owned {
    struct ExecutionProgressWitness has drop {
        dummy_field: bool,
    }

    struct WithdrawObjectActionStaged has copy, drop {
        account_id: 0x2::object::ID,
        object_id: 0x2::object::ID,
        resource_name: 0x1::string::String,
    }

    struct ObjectWithdrawn has copy, drop {
        account_id: 0x2::object::ID,
        object_id: 0x2::object::ID,
        object_type: 0x1::string::String,
        resource_name: 0x1::string::String,
    }

    struct OwnedWithdrawObject<phantom T0> has drop {
        dummy_field: bool,
    }

    struct WithdrawObjectAction has drop, store {
        object_id: 0x2::object::ID,
        resource_name: 0x1::string::String,
    }

    public fun destroy_withdraw_object_action(arg0: WithdrawObjectAction) {
        let WithdrawObjectAction {
            object_id     : _,
            resource_name : _,
        } = arg0;
    }

    public fun do_withdraw_object<T0: store, T1: store + key, T2: drop>(arg0: &mut 0x7a6ec95f874af0292f624c7d8ad8a5fb95935f5e756a1d1c31530f779358eaa7::executable::Executable<T0>, arg1: &mut 0x7a6ec95f874af0292f624c7d8ad8a5fb95935f5e756a1d1c31530f779358eaa7::account::Account, arg2: &0x7a6ec95f874af0292f624c7d8ad8a5fb95935f5e756a1d1c31530f779358eaa7::package_registry::PackageRegistry, arg3: 0x2::transfer::Receiving<T1>, arg4: T2, arg5: &mut 0x2::tx_context::TxContext) {
        let v0 = ExecutionProgressWitness{dummy_field: false};
        0x7a6ec95f874af0292f624c7d8ad8a5fb95935f5e756a1d1c31530f779358eaa7::account::assert_execution_authorized<T0, ExecutionProgressWitness>(arg1, arg2, arg0, v0);
        let v1 = 0x1::vector::borrow<0x7a6ec95f874af0292f624c7d8ad8a5fb95935f5e756a1d1c31530f779358eaa7::intents::ActionSpec>(0x7a6ec95f874af0292f624c7d8ad8a5fb95935f5e756a1d1c31530f779358eaa7::intents::action_specs<T0>(0x7a6ec95f874af0292f624c7d8ad8a5fb95935f5e756a1d1c31530f779358eaa7::executable::intent<T0>(arg0)), 0x7a6ec95f874af0292f624c7d8ad8a5fb95935f5e756a1d1c31530f779358eaa7::executable::action_idx<T0>(arg0));
        assert!(0x7a6ec95f874af0292f624c7d8ad8a5fb95935f5e756a1d1c31530f779358eaa7::intents::action_spec_version(v1) == 1, 3);
        let v2 = 0x2::bcs::new(*0x7a6ec95f874af0292f624c7d8ad8a5fb95935f5e756a1d1c31530f779358eaa7::intents::action_spec_data(v1));
        let v3 = 0x2::object::id_from_address(0x2::bcs::peel_address(&mut v2));
        let v4 = 0x1::string::utf8(0x2::bcs::peel_vec_u8(&mut v2));
        0x7a6ec95f874af0292f624c7d8ad8a5fb95935f5e756a1d1c31530f779358eaa7::bcs_validation::validate_all_bytes_consumed(v2);
        assert!(0x2::transfer::receiving_object_id<T1>(&arg3) == v3, 0);
        let v5 = ExecutionProgressWitness{dummy_field: false};
        0x7a6ec95f874af0292f624c7d8ad8a5fb95935f5e756a1d1c31530f779358eaa7::executable_resources::provide_object<T1, T0, ExecutionProgressWitness>(arg0, arg2, v5, v4, 0x7a6ec95f874af0292f624c7d8ad8a5fb95935f5e756a1d1c31530f779358eaa7::account::receive<T1>(arg1, arg3), arg5);
        let v6 = ObjectWithdrawn{
            account_id    : 0x2::object::id<0x7a6ec95f874af0292f624c7d8ad8a5fb95935f5e756a1d1c31530f779358eaa7::account::Account>(arg1),
            object_id     : v3,
            object_type   : 0x1::string::from_ascii(0x1::type_name::into_string(0x1::type_name::get<T1>())),
            resource_name : v4,
        };
        0x2::event::emit<ObjectWithdrawn>(v6);
        let v7 = ExecutionProgressWitness{dummy_field: false};
        0x7a6ec95f874af0292f624c7d8ad8a5fb95935f5e756a1d1c31530f779358eaa7::executable::increment_action_idx<T0, OwnedWithdrawObject<T1>, ExecutionProgressWitness>(arg0, arg2, v7);
    }

    public fun new_withdraw_object<T0, T1: store + key, T2: drop>(arg0: &mut 0x7a6ec95f874af0292f624c7d8ad8a5fb95935f5e756a1d1c31530f779358eaa7::intents::Intent<T0>, arg1: &0x7a6ec95f874af0292f624c7d8ad8a5fb95935f5e756a1d1c31530f779358eaa7::account::Account, arg2: 0x2::object::ID, arg3: 0x1::string::String, arg4: T2) {
        0x7a6ec95f874af0292f624c7d8ad8a5fb95935f5e756a1d1c31530f779358eaa7::intents::assert_is_account<T0>(arg0, 0x7a6ec95f874af0292f624c7d8ad8a5fb95935f5e756a1d1c31530f779358eaa7::account::addr(arg1));
        let v0 = WithdrawObjectAction{
            object_id     : arg2,
            resource_name : arg3,
        };
        0x7a6ec95f874af0292f624c7d8ad8a5fb95935f5e756a1d1c31530f779358eaa7::intents::add_typed_action<T0, OwnedWithdrawObject<T1>, T2>(arg0, owned_withdraw_object<T1>(), 0x2::bcs::to_bytes<WithdrawObjectAction>(&v0), arg4);
        let v1 = WithdrawObjectActionStaged{
            account_id    : 0x2::object::id<0x7a6ec95f874af0292f624c7d8ad8a5fb95935f5e756a1d1c31530f779358eaa7::account::Account>(arg1),
            object_id     : arg2,
            resource_name : arg3,
        };
        0x2::event::emit<WithdrawObjectActionStaged>(v1);
        destroy_withdraw_object_action(v0);
    }

    public(friend) fun owned_withdraw_object<T0>() : OwnedWithdrawObject<T0> {
        OwnedWithdrawObject<T0>{dummy_field: false}
    }

    // decompiled from Move bytecode v6
}

