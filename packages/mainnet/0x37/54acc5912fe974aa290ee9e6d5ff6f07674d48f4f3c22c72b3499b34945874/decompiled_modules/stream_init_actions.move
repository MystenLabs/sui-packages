module 0x3754acc5912fe974aa290ee9e6d5ff6f07674d48f4f3c22c72b3499b34945874::stream_init_actions {
    struct CreateStreamAction has copy, drop, store {
        vault_name: 0x1::string::String,
        beneficiary: address,
        amount_per_iteration: u64,
        start_time: 0x1::option::Option<u64>,
        iterations_total: u64,
        iteration_period_ms: u64,
        claim_window_ms: 0x1::option::Option<u64>,
    }

    public fun add_create_stream_spec<T0>(arg0: &mut 0x3754acc5912fe974aa290ee9e6d5ff6f07674d48f4f3c22c72b3499b34945874::action_spec_builder::Builder, arg1: 0x1::string::String, arg2: address, arg3: u64, arg4: 0x1::option::Option<u64>, arg5: u64, arg6: u64, arg7: 0x1::option::Option<u64>) {
        assert!(arg2 != @0x0, 2);
        assert!(arg3 > 0, 1);
        assert!(arg5 > 0, 1);
        assert!(arg6 > 0, 1);
        let v0 = CreateStreamAction{
            vault_name           : arg1,
            beneficiary          : arg2,
            amount_per_iteration : arg3,
            start_time           : arg4,
            iterations_total     : arg5,
            iteration_period_ms  : arg6,
            claim_window_ms      : arg7,
        };
        0x3754acc5912fe974aa290ee9e6d5ff6f07674d48f4f3c22c72b3499b34945874::action_spec_builder::add(arg0, 0x120fdca1774a9543ace0f4a38fb06efadae8966c58de1783d6e30d8d6a50b024::intents::new_action_spec_with_typename(0x1::type_name::with_original_ids<0x3754acc5912fe974aa290ee9e6d5ff6f07674d48f4f3c22c72b3499b34945874::vault::CreateStream<T0>>(), 0x2::bcs::to_bytes<CreateStreamAction>(&v0), 1));
        let v1 = 0x120fdca1774a9543ace0f4a38fb06efadae8966c58de1783d6e30d8d6a50b024::action_events::new_builder();
        0x120fdca1774a9543ace0f4a38fb06efadae8966c58de1783d6e30d8d6a50b024::action_events::add_string(&mut v1, b"vault_name", arg1);
        0x120fdca1774a9543ace0f4a38fb06efadae8966c58de1783d6e30d8d6a50b024::action_events::add_address(&mut v1, b"beneficiary", arg2);
        0x120fdca1774a9543ace0f4a38fb06efadae8966c58de1783d6e30d8d6a50b024::action_events::add_u64(&mut v1, b"amount_per_iteration", arg3);
        0x120fdca1774a9543ace0f4a38fb06efadae8966c58de1783d6e30d8d6a50b024::action_events::add_option_u64(&mut v1, b"start_time", arg4);
        0x120fdca1774a9543ace0f4a38fb06efadae8966c58de1783d6e30d8d6a50b024::action_events::add_u64(&mut v1, b"iterations_total", arg5);
        0x120fdca1774a9543ace0f4a38fb06efadae8966c58de1783d6e30d8d6a50b024::action_events::add_u64(&mut v1, b"iteration_period_ms", arg6);
        0x120fdca1774a9543ace0f4a38fb06efadae8966c58de1783d6e30d8d6a50b024::action_events::add_option_u64(&mut v1, b"claim_window_ms", arg7);
        0x120fdca1774a9543ace0f4a38fb06efadae8966c58de1783d6e30d8d6a50b024::action_events::emit_action_params(v1, 0x3754acc5912fe974aa290ee9e6d5ff6f07674d48f4f3c22c72b3499b34945874::action_spec_builder::source_type(arg0), 0x3754acc5912fe974aa290ee9e6d5ff6f07674d48f4f3c22c72b3499b34945874::action_spec_builder::source_id(arg0), 0x3754acc5912fe974aa290ee9e6d5ff6f07674d48f4f3c22c72b3499b34945874::action_spec_builder::outcome_index(arg0), 0x1::string::from_ascii(0x1::type_name::into_string(0x1::type_name::with_original_ids<0x3754acc5912fe974aa290ee9e6d5ff6f07674d48f4f3c22c72b3499b34945874::vault::CreateStream<T0>>())), 0x3754acc5912fe974aa290ee9e6d5ff6f07674d48f4f3c22c72b3499b34945874::action_spec_builder::next_action_index(arg0));
    }

    // decompiled from Move bytecode v6
}

