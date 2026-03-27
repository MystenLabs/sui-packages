module 0x3754acc5912fe974aa290ee9e6d5ff6f07674d48f4f3c22c72b3499b34945874::vesting_init_actions {
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

    public fun add_cancel_vesting_spec<T0>(arg0: &mut 0x3754acc5912fe974aa290ee9e6d5ff6f07674d48f4f3c22c72b3499b34945874::action_spec_builder::Builder, arg1: address, arg2: 0x1::string::String) {
        let v0 = CancelVestingAction{
            vesting_id    : arg1,
            resource_name : arg2,
        };
        0x3754acc5912fe974aa290ee9e6d5ff6f07674d48f4f3c22c72b3499b34945874::action_spec_builder::add(arg0, 0x120fdca1774a9543ace0f4a38fb06efadae8966c58de1783d6e30d8d6a50b024::intents::new_action_spec_with_typename(0x1::type_name::with_original_ids<0x3754acc5912fe974aa290ee9e6d5ff6f07674d48f4f3c22c72b3499b34945874::vesting::CancelVesting<T0>>(), 0x2::bcs::to_bytes<CancelVestingAction>(&v0), 1));
        let v1 = 0x120fdca1774a9543ace0f4a38fb06efadae8966c58de1783d6e30d8d6a50b024::action_events::new_builder();
        0x120fdca1774a9543ace0f4a38fb06efadae8966c58de1783d6e30d8d6a50b024::action_events::add_address(&mut v1, b"vesting_id", arg1);
        0x120fdca1774a9543ace0f4a38fb06efadae8966c58de1783d6e30d8d6a50b024::action_events::add_string(&mut v1, b"resource_name", arg2);
        0x120fdca1774a9543ace0f4a38fb06efadae8966c58de1783d6e30d8d6a50b024::action_events::emit_action_params(v1, 0x3754acc5912fe974aa290ee9e6d5ff6f07674d48f4f3c22c72b3499b34945874::action_spec_builder::source_type(arg0), 0x3754acc5912fe974aa290ee9e6d5ff6f07674d48f4f3c22c72b3499b34945874::action_spec_builder::source_id(arg0), 0x3754acc5912fe974aa290ee9e6d5ff6f07674d48f4f3c22c72b3499b34945874::action_spec_builder::outcome_index(arg0), 0x1::string::from_ascii(0x1::type_name::into_string(0x1::type_name::with_original_ids<0x3754acc5912fe974aa290ee9e6d5ff6f07674d48f4f3c22c72b3499b34945874::vesting::CancelVesting<T0>>())), 0x3754acc5912fe974aa290ee9e6d5ff6f07674d48f4f3c22c72b3499b34945874::action_spec_builder::next_action_index(arg0));
    }

    public fun add_create_vesting_spec<T0>(arg0: &mut 0x3754acc5912fe974aa290ee9e6d5ff6f07674d48f4f3c22c72b3499b34945874::action_spec_builder::Builder, arg1: address, arg2: u64, arg3: 0x1::option::Option<u64>, arg4: u64, arg5: u64, arg6: bool, arg7: 0x1::string::String) {
        assert!(arg1 != @0x0, 1);
        assert!(arg2 > 0, 2);
        assert!(arg4 > 0, 2);
        assert!(arg5 > 0, 2);
        let v0 = CreateVestingAction{
            beneficiary          : arg1,
            amount_per_iteration : arg2,
            start_time           : arg3,
            iterations_total     : arg4,
            iteration_period_ms  : arg5,
            is_cancellable       : arg6,
            resource_name        : arg7,
        };
        0x3754acc5912fe974aa290ee9e6d5ff6f07674d48f4f3c22c72b3499b34945874::action_spec_builder::add(arg0, 0x120fdca1774a9543ace0f4a38fb06efadae8966c58de1783d6e30d8d6a50b024::intents::new_action_spec_with_typename(0x1::type_name::with_original_ids<0x3754acc5912fe974aa290ee9e6d5ff6f07674d48f4f3c22c72b3499b34945874::vesting::CreateVesting<T0>>(), 0x2::bcs::to_bytes<CreateVestingAction>(&v0), 1));
        let v1 = 0x120fdca1774a9543ace0f4a38fb06efadae8966c58de1783d6e30d8d6a50b024::action_events::new_builder();
        0x120fdca1774a9543ace0f4a38fb06efadae8966c58de1783d6e30d8d6a50b024::action_events::add_address(&mut v1, b"beneficiary", arg1);
        0x120fdca1774a9543ace0f4a38fb06efadae8966c58de1783d6e30d8d6a50b024::action_events::add_u64(&mut v1, b"amount_per_iteration", arg2);
        0x120fdca1774a9543ace0f4a38fb06efadae8966c58de1783d6e30d8d6a50b024::action_events::add_option_u64(&mut v1, b"start_time", arg3);
        0x120fdca1774a9543ace0f4a38fb06efadae8966c58de1783d6e30d8d6a50b024::action_events::add_u64(&mut v1, b"iterations_total", arg4);
        0x120fdca1774a9543ace0f4a38fb06efadae8966c58de1783d6e30d8d6a50b024::action_events::add_u64(&mut v1, b"iteration_period_ms", arg5);
        0x120fdca1774a9543ace0f4a38fb06efadae8966c58de1783d6e30d8d6a50b024::action_events::add_bool(&mut v1, b"is_cancellable", arg6);
        0x120fdca1774a9543ace0f4a38fb06efadae8966c58de1783d6e30d8d6a50b024::action_events::add_string(&mut v1, b"resource_name", arg7);
        0x120fdca1774a9543ace0f4a38fb06efadae8966c58de1783d6e30d8d6a50b024::action_events::emit_action_params(v1, 0x3754acc5912fe974aa290ee9e6d5ff6f07674d48f4f3c22c72b3499b34945874::action_spec_builder::source_type(arg0), 0x3754acc5912fe974aa290ee9e6d5ff6f07674d48f4f3c22c72b3499b34945874::action_spec_builder::source_id(arg0), 0x3754acc5912fe974aa290ee9e6d5ff6f07674d48f4f3c22c72b3499b34945874::action_spec_builder::outcome_index(arg0), 0x1::string::from_ascii(0x1::type_name::into_string(0x1::type_name::with_original_ids<0x3754acc5912fe974aa290ee9e6d5ff6f07674d48f4f3c22c72b3499b34945874::vesting::CreateVesting<T0>>())), 0x3754acc5912fe974aa290ee9e6d5ff6f07674d48f4f3c22c72b3499b34945874::action_spec_builder::next_action_index(arg0));
    }

    // decompiled from Move bytecode v6
}

