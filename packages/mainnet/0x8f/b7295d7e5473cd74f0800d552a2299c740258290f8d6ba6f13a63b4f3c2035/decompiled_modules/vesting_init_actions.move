module 0x8fb7295d7e5473cd74f0800d552a2299c740258290f8d6ba6f13a63b4f3c2035::vesting_init_actions {
    struct CreateVestingAction has copy, drop, store {
        beneficiary: address,
        amount_per_iteration: u64,
        start_time: 0x1::option::Option<u64>,
        iterations_total: u64,
        iteration_period_ms: u64,
        is_cancellable: bool,
        resource_name: 0x1::string::String,
    }

    struct CancelVestingAction has copy, drop, store {
        vesting_id: address,
        resource_name: 0x1::string::String,
    }

    public fun add_cancel_vesting_spec<T0>(arg0: &mut 0x8fb7295d7e5473cd74f0800d552a2299c740258290f8d6ba6f13a63b4f3c2035::action_spec_builder::Builder, arg1: address, arg2: 0x1::string::String) {
        let v0 = CancelVestingAction{
            vesting_id    : arg1,
            resource_name : arg2,
        };
        0x8fb7295d7e5473cd74f0800d552a2299c740258290f8d6ba6f13a63b4f3c2035::action_spec_builder::add(arg0, 0x7a6ec95f874af0292f624c7d8ad8a5fb95935f5e756a1d1c31530f779358eaa7::intents::new_action_spec_with_typename(0x1::type_name::with_original_ids<0x8fb7295d7e5473cd74f0800d552a2299c740258290f8d6ba6f13a63b4f3c2035::vesting::CancelVesting<T0>>(), 0x2::bcs::to_bytes<CancelVestingAction>(&v0), 1));
        let v1 = 0x7a6ec95f874af0292f624c7d8ad8a5fb95935f5e756a1d1c31530f779358eaa7::action_events::new_builder();
        0x7a6ec95f874af0292f624c7d8ad8a5fb95935f5e756a1d1c31530f779358eaa7::action_events::add_address(&mut v1, b"vesting_id", arg1);
        0x7a6ec95f874af0292f624c7d8ad8a5fb95935f5e756a1d1c31530f779358eaa7::action_events::add_string(&mut v1, b"resource_name", arg2);
        0x7a6ec95f874af0292f624c7d8ad8a5fb95935f5e756a1d1c31530f779358eaa7::action_events::emit_action_params(v1, 0x8fb7295d7e5473cd74f0800d552a2299c740258290f8d6ba6f13a63b4f3c2035::action_spec_builder::source_type(arg0), 0x8fb7295d7e5473cd74f0800d552a2299c740258290f8d6ba6f13a63b4f3c2035::action_spec_builder::source_id(arg0), 0x8fb7295d7e5473cd74f0800d552a2299c740258290f8d6ba6f13a63b4f3c2035::action_spec_builder::outcome_index(arg0), 0x1::string::from_ascii(0x1::type_name::into_string(0x1::type_name::with_original_ids<0x8fb7295d7e5473cd74f0800d552a2299c740258290f8d6ba6f13a63b4f3c2035::vesting::CancelVesting<T0>>())), 0x8fb7295d7e5473cd74f0800d552a2299c740258290f8d6ba6f13a63b4f3c2035::action_spec_builder::next_action_index(arg0));
    }

    public fun add_create_vesting_spec<T0>(arg0: &mut 0x8fb7295d7e5473cd74f0800d552a2299c740258290f8d6ba6f13a63b4f3c2035::action_spec_builder::Builder, arg1: address, arg2: u64, arg3: 0x1::option::Option<u64>, arg4: u64, arg5: u64, arg6: bool, arg7: 0x1::string::String) {
        assert!(arg1 != @0x0, 1);
        let v0 = CreateVestingAction{
            beneficiary          : arg1,
            amount_per_iteration : arg2,
            start_time           : arg3,
            iterations_total     : arg4,
            iteration_period_ms  : arg5,
            is_cancellable       : arg6,
            resource_name        : arg7,
        };
        0x8fb7295d7e5473cd74f0800d552a2299c740258290f8d6ba6f13a63b4f3c2035::action_spec_builder::add(arg0, 0x7a6ec95f874af0292f624c7d8ad8a5fb95935f5e756a1d1c31530f779358eaa7::intents::new_action_spec_with_typename(0x1::type_name::with_original_ids<0x8fb7295d7e5473cd74f0800d552a2299c740258290f8d6ba6f13a63b4f3c2035::vesting::CreateVesting<T0>>(), 0x2::bcs::to_bytes<CreateVestingAction>(&v0), 1));
        let v1 = 0x7a6ec95f874af0292f624c7d8ad8a5fb95935f5e756a1d1c31530f779358eaa7::action_events::new_builder();
        0x7a6ec95f874af0292f624c7d8ad8a5fb95935f5e756a1d1c31530f779358eaa7::action_events::add_address(&mut v1, b"beneficiary", arg1);
        0x7a6ec95f874af0292f624c7d8ad8a5fb95935f5e756a1d1c31530f779358eaa7::action_events::add_u64(&mut v1, b"amount_per_iteration", arg2);
        0x7a6ec95f874af0292f624c7d8ad8a5fb95935f5e756a1d1c31530f779358eaa7::action_events::add_option_u64(&mut v1, b"start_time", arg3);
        0x7a6ec95f874af0292f624c7d8ad8a5fb95935f5e756a1d1c31530f779358eaa7::action_events::add_u64(&mut v1, b"iterations_total", arg4);
        0x7a6ec95f874af0292f624c7d8ad8a5fb95935f5e756a1d1c31530f779358eaa7::action_events::add_u64(&mut v1, b"iteration_period_ms", arg5);
        0x7a6ec95f874af0292f624c7d8ad8a5fb95935f5e756a1d1c31530f779358eaa7::action_events::add_bool(&mut v1, b"is_cancellable", arg6);
        0x7a6ec95f874af0292f624c7d8ad8a5fb95935f5e756a1d1c31530f779358eaa7::action_events::add_string(&mut v1, b"resource_name", arg7);
        0x7a6ec95f874af0292f624c7d8ad8a5fb95935f5e756a1d1c31530f779358eaa7::action_events::emit_action_params(v1, 0x8fb7295d7e5473cd74f0800d552a2299c740258290f8d6ba6f13a63b4f3c2035::action_spec_builder::source_type(arg0), 0x8fb7295d7e5473cd74f0800d552a2299c740258290f8d6ba6f13a63b4f3c2035::action_spec_builder::source_id(arg0), 0x8fb7295d7e5473cd74f0800d552a2299c740258290f8d6ba6f13a63b4f3c2035::action_spec_builder::outcome_index(arg0), 0x1::string::from_ascii(0x1::type_name::into_string(0x1::type_name::with_original_ids<0x8fb7295d7e5473cd74f0800d552a2299c740258290f8d6ba6f13a63b4f3c2035::vesting::CreateVesting<T0>>())), 0x8fb7295d7e5473cd74f0800d552a2299c740258290f8d6ba6f13a63b4f3c2035::action_spec_builder::next_action_index(arg0));
    }

    // decompiled from Move bytecode v6
}

