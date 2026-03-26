module 0x3cc22293978bd3279959469f781629dd92337c3cb83ae33b9d14addeb788febb::quota_init_actions {
    struct SetQuotasAction has drop, store {
        users: vector<address>,
        period_ms: u64,
        feeless_proposal_amount: u64,
        sponsor_amount: u64,
    }

    public fun add_set_quotas_spec(arg0: &mut 0xbe96f5469a522974f1226110b2753076587eeed890c01700a3bb14e528c956ee::action_spec_builder::Builder, arg1: vector<address>, arg2: u64, arg3: u64, arg4: u64) {
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
        0xbe96f5469a522974f1226110b2753076587eeed890c01700a3bb14e528c956ee::action_spec_builder::add(arg0, 0x8a0ce6b60836f32d52c7aed958f9f319cf3cb654c227cbb1806fdcaa0ad737e1::intents::new_action_spec_with_typename(0x1::type_name::with_original_ids<0x3cc22293978bd3279959469f781629dd92337c3cb83ae33b9d14addeb788febb::quota_actions::SetQuotas>(), 0x2::bcs::to_bytes<SetQuotasAction>(&v1), 1));
        let v2 = 0x8a0ce6b60836f32d52c7aed958f9f319cf3cb654c227cbb1806fdcaa0ad737e1::action_events::new_builder();
        0x8a0ce6b60836f32d52c7aed958f9f319cf3cb654c227cbb1806fdcaa0ad737e1::action_events::add_vector_address(&mut v2, b"users", &arg1);
        0x8a0ce6b60836f32d52c7aed958f9f319cf3cb654c227cbb1806fdcaa0ad737e1::action_events::add_u64(&mut v2, b"period_ms", arg2);
        0x8a0ce6b60836f32d52c7aed958f9f319cf3cb654c227cbb1806fdcaa0ad737e1::action_events::add_u64(&mut v2, b"feeless_proposal_amount", arg3);
        0x8a0ce6b60836f32d52c7aed958f9f319cf3cb654c227cbb1806fdcaa0ad737e1::action_events::add_u64(&mut v2, b"sponsor_amount", arg4);
        0x8a0ce6b60836f32d52c7aed958f9f319cf3cb654c227cbb1806fdcaa0ad737e1::action_events::emit_action_params(v2, 0xbe96f5469a522974f1226110b2753076587eeed890c01700a3bb14e528c956ee::action_spec_builder::source_type(arg0), 0xbe96f5469a522974f1226110b2753076587eeed890c01700a3bb14e528c956ee::action_spec_builder::source_id(arg0), 0xbe96f5469a522974f1226110b2753076587eeed890c01700a3bb14e528c956ee::action_spec_builder::outcome_index(arg0), 0x1::string::from_ascii(0x1::type_name::into_string(0x1::type_name::with_original_ids<0x3cc22293978bd3279959469f781629dd92337c3cb83ae33b9d14addeb788febb::quota_actions::SetQuotas>())), 0xbe96f5469a522974f1226110b2753076587eeed890c01700a3bb14e528c956ee::action_spec_builder::next_action_index(arg0));
    }

    // decompiled from Move bytecode v6
}

