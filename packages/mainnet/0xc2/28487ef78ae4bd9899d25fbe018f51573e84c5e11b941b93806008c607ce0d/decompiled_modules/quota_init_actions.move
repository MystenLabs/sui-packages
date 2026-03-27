module 0xc228487ef78ae4bd9899d25fbe018f51573e84c5e11b941b93806008c607ce0d::quota_init_actions {
    struct SetQuotasAction has drop, store {
        users: vector<address>,
        period_ms: u64,
        feeless_proposal_amount: u64,
        sponsor_amount: u64,
    }

    public fun add_set_quotas_spec(arg0: &mut 0xeabe417719b67991896029b26cad43d8a5138109a577c0c56f174e0577e8fe00::action_spec_builder::Builder, arg1: vector<address>, arg2: u64, arg3: u64, arg4: u64) {
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
        0xeabe417719b67991896029b26cad43d8a5138109a577c0c56f174e0577e8fe00::action_spec_builder::add(arg0, 0x988f4f9ab9540eeb476be8751ded1b396cca6a43599fadfe7126b55cff6fb356::intents::new_action_spec_with_typename(0x1::type_name::with_original_ids<0xc228487ef78ae4bd9899d25fbe018f51573e84c5e11b941b93806008c607ce0d::quota_actions::SetQuotas>(), 0x2::bcs::to_bytes<SetQuotasAction>(&v1), 1));
        let v2 = 0x988f4f9ab9540eeb476be8751ded1b396cca6a43599fadfe7126b55cff6fb356::action_events::new_builder();
        0x988f4f9ab9540eeb476be8751ded1b396cca6a43599fadfe7126b55cff6fb356::action_events::add_vector_address(&mut v2, b"users", &arg1);
        0x988f4f9ab9540eeb476be8751ded1b396cca6a43599fadfe7126b55cff6fb356::action_events::add_u64(&mut v2, b"period_ms", arg2);
        0x988f4f9ab9540eeb476be8751ded1b396cca6a43599fadfe7126b55cff6fb356::action_events::add_u64(&mut v2, b"feeless_proposal_amount", arg3);
        0x988f4f9ab9540eeb476be8751ded1b396cca6a43599fadfe7126b55cff6fb356::action_events::add_u64(&mut v2, b"sponsor_amount", arg4);
        0x988f4f9ab9540eeb476be8751ded1b396cca6a43599fadfe7126b55cff6fb356::action_events::emit_action_params(v2, 0xeabe417719b67991896029b26cad43d8a5138109a577c0c56f174e0577e8fe00::action_spec_builder::source_type(arg0), 0xeabe417719b67991896029b26cad43d8a5138109a577c0c56f174e0577e8fe00::action_spec_builder::source_id(arg0), 0xeabe417719b67991896029b26cad43d8a5138109a577c0c56f174e0577e8fe00::action_spec_builder::outcome_index(arg0), 0x1::string::from_ascii(0x1::type_name::into_string(0x1::type_name::with_original_ids<0xc228487ef78ae4bd9899d25fbe018f51573e84c5e11b941b93806008c607ce0d::quota_actions::SetQuotas>())), 0xeabe417719b67991896029b26cad43d8a5138109a577c0c56f174e0577e8fe00::action_spec_builder::next_action_index(arg0));
    }

    // decompiled from Move bytecode v6
}

