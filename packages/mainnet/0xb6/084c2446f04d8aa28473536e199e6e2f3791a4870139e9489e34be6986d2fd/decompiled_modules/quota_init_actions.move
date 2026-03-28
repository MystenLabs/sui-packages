module 0xb6084c2446f04d8aa28473536e199e6e2f3791a4870139e9489e34be6986d2fd::quota_init_actions {
    struct SetQuotasAction has drop, store {
        users: vector<address>,
        period_ms: u64,
        feeless_proposal_amount: u64,
        sponsor_amount: u64,
    }

    public fun add_set_quotas_spec(arg0: &mut 0x88ef34a7087d4713deabe0ac6807a06558bac9169c29baa652e31275ebb2ea88::action_spec_builder::Builder, arg1: vector<address>, arg2: u64, arg3: u64, arg4: u64) {
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
        0x88ef34a7087d4713deabe0ac6807a06558bac9169c29baa652e31275ebb2ea88::action_spec_builder::add(arg0, 0x3510687b6de0d3c29bc68191a256943aaf57902ca6f7b5a54f62ca72dc61923d::intents::new_action_spec_with_typename(0x1::type_name::with_original_ids<0xb6084c2446f04d8aa28473536e199e6e2f3791a4870139e9489e34be6986d2fd::quota_actions::SetQuotas>(), 0x2::bcs::to_bytes<SetQuotasAction>(&v1), 1));
        let v2 = 0x3510687b6de0d3c29bc68191a256943aaf57902ca6f7b5a54f62ca72dc61923d::action_events::new_builder();
        0x3510687b6de0d3c29bc68191a256943aaf57902ca6f7b5a54f62ca72dc61923d::action_events::add_vector_address(&mut v2, b"users", &arg1);
        0x3510687b6de0d3c29bc68191a256943aaf57902ca6f7b5a54f62ca72dc61923d::action_events::add_u64(&mut v2, b"period_ms", arg2);
        0x3510687b6de0d3c29bc68191a256943aaf57902ca6f7b5a54f62ca72dc61923d::action_events::add_u64(&mut v2, b"feeless_proposal_amount", arg3);
        0x3510687b6de0d3c29bc68191a256943aaf57902ca6f7b5a54f62ca72dc61923d::action_events::add_u64(&mut v2, b"sponsor_amount", arg4);
        0x3510687b6de0d3c29bc68191a256943aaf57902ca6f7b5a54f62ca72dc61923d::action_events::emit_action_params(v2, 0x88ef34a7087d4713deabe0ac6807a06558bac9169c29baa652e31275ebb2ea88::action_spec_builder::source_type(arg0), 0x88ef34a7087d4713deabe0ac6807a06558bac9169c29baa652e31275ebb2ea88::action_spec_builder::source_id(arg0), 0x88ef34a7087d4713deabe0ac6807a06558bac9169c29baa652e31275ebb2ea88::action_spec_builder::outcome_index(arg0), 0x1::string::from_ascii(0x1::type_name::into_string(0x1::type_name::with_original_ids<0xb6084c2446f04d8aa28473536e199e6e2f3791a4870139e9489e34be6986d2fd::quota_actions::SetQuotas>())), 0x88ef34a7087d4713deabe0ac6807a06558bac9169c29baa652e31275ebb2ea88::action_spec_builder::next_action_index(arg0));
    }

    // decompiled from Move bytecode v6
}

