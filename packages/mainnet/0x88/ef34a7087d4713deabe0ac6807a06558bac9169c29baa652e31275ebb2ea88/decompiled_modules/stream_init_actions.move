module 0x88ef34a7087d4713deabe0ac6807a06558bac9169c29baa652e31275ebb2ea88::stream_init_actions {
    struct CreateStreamAction has copy, drop, store {
        vault_name: 0x1::string::String,
        beneficiary: address,
        amount_per_iteration: u64,
        start_time: 0x1::option::Option<u64>,
        iterations_total: u64,
        iteration_period_ms: u64,
        claim_window_ms: 0x1::option::Option<u64>,
    }

    public fun add_create_stream_spec<T0>(arg0: &mut 0x88ef34a7087d4713deabe0ac6807a06558bac9169c29baa652e31275ebb2ea88::action_spec_builder::Builder, arg1: 0x1::string::String, arg2: address, arg3: u64, arg4: 0x1::option::Option<u64>, arg5: u64, arg6: u64, arg7: 0x1::option::Option<u64>) {
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
        0x88ef34a7087d4713deabe0ac6807a06558bac9169c29baa652e31275ebb2ea88::action_spec_builder::add(arg0, 0x3510687b6de0d3c29bc68191a256943aaf57902ca6f7b5a54f62ca72dc61923d::intents::new_action_spec_with_typename(0x1::type_name::with_original_ids<0x88ef34a7087d4713deabe0ac6807a06558bac9169c29baa652e31275ebb2ea88::vault::CreateStream<T0>>(), 0x2::bcs::to_bytes<CreateStreamAction>(&v0), 1));
        let v1 = 0x3510687b6de0d3c29bc68191a256943aaf57902ca6f7b5a54f62ca72dc61923d::action_events::new_builder();
        0x3510687b6de0d3c29bc68191a256943aaf57902ca6f7b5a54f62ca72dc61923d::action_events::add_string(&mut v1, b"vault_name", arg1);
        0x3510687b6de0d3c29bc68191a256943aaf57902ca6f7b5a54f62ca72dc61923d::action_events::add_address(&mut v1, b"beneficiary", arg2);
        0x3510687b6de0d3c29bc68191a256943aaf57902ca6f7b5a54f62ca72dc61923d::action_events::add_u64(&mut v1, b"amount_per_iteration", arg3);
        0x3510687b6de0d3c29bc68191a256943aaf57902ca6f7b5a54f62ca72dc61923d::action_events::add_option_u64(&mut v1, b"start_time", arg4);
        0x3510687b6de0d3c29bc68191a256943aaf57902ca6f7b5a54f62ca72dc61923d::action_events::add_u64(&mut v1, b"iterations_total", arg5);
        0x3510687b6de0d3c29bc68191a256943aaf57902ca6f7b5a54f62ca72dc61923d::action_events::add_u64(&mut v1, b"iteration_period_ms", arg6);
        0x3510687b6de0d3c29bc68191a256943aaf57902ca6f7b5a54f62ca72dc61923d::action_events::add_option_u64(&mut v1, b"claim_window_ms", arg7);
        0x3510687b6de0d3c29bc68191a256943aaf57902ca6f7b5a54f62ca72dc61923d::action_events::emit_action_params(v1, 0x88ef34a7087d4713deabe0ac6807a06558bac9169c29baa652e31275ebb2ea88::action_spec_builder::source_type(arg0), 0x88ef34a7087d4713deabe0ac6807a06558bac9169c29baa652e31275ebb2ea88::action_spec_builder::source_id(arg0), 0x88ef34a7087d4713deabe0ac6807a06558bac9169c29baa652e31275ebb2ea88::action_spec_builder::outcome_index(arg0), 0x1::string::from_ascii(0x1::type_name::into_string(0x1::type_name::with_original_ids<0x88ef34a7087d4713deabe0ac6807a06558bac9169c29baa652e31275ebb2ea88::vault::CreateStream<T0>>())), 0x88ef34a7087d4713deabe0ac6807a06558bac9169c29baa652e31275ebb2ea88::action_spec_builder::next_action_index(arg0));
    }

    // decompiled from Move bytecode v6
}

