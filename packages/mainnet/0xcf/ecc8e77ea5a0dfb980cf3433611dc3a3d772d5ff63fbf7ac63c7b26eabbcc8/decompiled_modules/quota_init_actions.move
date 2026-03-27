module 0xcfecc8e77ea5a0dfb980cf3433611dc3a3d772d5ff63fbf7ac63c7b26eabbcc8::quota_init_actions {
    struct SetQuotasAction has drop, store {
        users: vector<address>,
        period_ms: u64,
        feeless_proposal_amount: u64,
        sponsor_amount: u64,
    }

    public fun add_set_quotas_spec(arg0: &mut 0x3754acc5912fe974aa290ee9e6d5ff6f07674d48f4f3c22c72b3499b34945874::action_spec_builder::Builder, arg1: vector<address>, arg2: u64, arg3: u64, arg4: u64) {
        let v0 = arg3 == 0 && arg4 == 0;
        if (!v0) {
            assert!(arg2 > 0, 1);
        };
        let v1 = SetQuotasAction{
            users                   : arg1,
            period_ms               : arg2,
            feeless_proposal_amount : arg3,
            sponsor_amount          : arg4,
        };
        0x3754acc5912fe974aa290ee9e6d5ff6f07674d48f4f3c22c72b3499b34945874::action_spec_builder::add(arg0, 0x120fdca1774a9543ace0f4a38fb06efadae8966c58de1783d6e30d8d6a50b024::intents::new_action_spec_with_typename(0x1::type_name::with_original_ids<0xcfecc8e77ea5a0dfb980cf3433611dc3a3d772d5ff63fbf7ac63c7b26eabbcc8::quota_actions::SetQuotas>(), 0x2::bcs::to_bytes<SetQuotasAction>(&v1), 1));
        let v2 = 0x120fdca1774a9543ace0f4a38fb06efadae8966c58de1783d6e30d8d6a50b024::action_events::new_builder();
        0x120fdca1774a9543ace0f4a38fb06efadae8966c58de1783d6e30d8d6a50b024::action_events::add_vector_address(&mut v2, b"users", &arg1);
        0x120fdca1774a9543ace0f4a38fb06efadae8966c58de1783d6e30d8d6a50b024::action_events::add_u64(&mut v2, b"period_ms", arg2);
        0x120fdca1774a9543ace0f4a38fb06efadae8966c58de1783d6e30d8d6a50b024::action_events::add_u64(&mut v2, b"feeless_proposal_amount", arg3);
        0x120fdca1774a9543ace0f4a38fb06efadae8966c58de1783d6e30d8d6a50b024::action_events::add_u64(&mut v2, b"sponsor_amount", arg4);
        0x120fdca1774a9543ace0f4a38fb06efadae8966c58de1783d6e30d8d6a50b024::action_events::emit_action_params(v2, 0x3754acc5912fe974aa290ee9e6d5ff6f07674d48f4f3c22c72b3499b34945874::action_spec_builder::source_type(arg0), 0x3754acc5912fe974aa290ee9e6d5ff6f07674d48f4f3c22c72b3499b34945874::action_spec_builder::source_id(arg0), 0x3754acc5912fe974aa290ee9e6d5ff6f07674d48f4f3c22c72b3499b34945874::action_spec_builder::outcome_index(arg0), 0x1::string::from_ascii(0x1::type_name::into_string(0x1::type_name::with_original_ids<0xcfecc8e77ea5a0dfb980cf3433611dc3a3d772d5ff63fbf7ac63c7b26eabbcc8::quota_actions::SetQuotas>())), 0x3754acc5912fe974aa290ee9e6d5ff6f07674d48f4f3c22c72b3499b34945874::action_spec_builder::next_action_index(arg0));
    }

    // decompiled from Move bytecode v6
}

