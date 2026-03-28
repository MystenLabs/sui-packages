module 0x8ad26c8279c79b4fc53466d6ae5a514830df1942f3b067d7d78458ca5fe94a64::memo_init_actions {
    struct EmitMemoAction has copy, drop, store {
        memo: 0x1::string::String,
    }

    public fun add_emit_memo_spec(arg0: &mut 0x8ad26c8279c79b4fc53466d6ae5a514830df1942f3b067d7d78458ca5fe94a64::action_spec_builder::Builder, arg1: 0x1::string::String) {
        assert!(0x1::string::length(&arg1) > 0, 1);
        assert!(0x1::string::length(&arg1) <= 0x8ad26c8279c79b4fc53466d6ae5a514830df1942f3b067d7d78458ca5fe94a64::actions_constants::max_memo_length(), 2);
        let v0 = EmitMemoAction{memo: arg1};
        0x8ad26c8279c79b4fc53466d6ae5a514830df1942f3b067d7d78458ca5fe94a64::action_spec_builder::add(arg0, 0x8a7f8ce15365ff144cb808887e3c1d2484ddd7ce1b7037bdf5e299351845eada::intents::new_action_spec_with_typename(0x1::type_name::with_original_ids<0x8ad26c8279c79b4fc53466d6ae5a514830df1942f3b067d7d78458ca5fe94a64::memo::Memo>(), 0x2::bcs::to_bytes<EmitMemoAction>(&v0), 1));
        let v1 = 0x8a7f8ce15365ff144cb808887e3c1d2484ddd7ce1b7037bdf5e299351845eada::action_events::new_builder();
        0x8a7f8ce15365ff144cb808887e3c1d2484ddd7ce1b7037bdf5e299351845eada::action_events::add_string(&mut v1, b"memo", arg1);
        0x8a7f8ce15365ff144cb808887e3c1d2484ddd7ce1b7037bdf5e299351845eada::action_events::emit_action_params(v1, 0x8ad26c8279c79b4fc53466d6ae5a514830df1942f3b067d7d78458ca5fe94a64::action_spec_builder::source_type(arg0), 0x8ad26c8279c79b4fc53466d6ae5a514830df1942f3b067d7d78458ca5fe94a64::action_spec_builder::source_id(arg0), 0x8ad26c8279c79b4fc53466d6ae5a514830df1942f3b067d7d78458ca5fe94a64::action_spec_builder::outcome_index(arg0), 0x1::string::from_ascii(0x1::type_name::into_string(0x1::type_name::with_original_ids<0x8ad26c8279c79b4fc53466d6ae5a514830df1942f3b067d7d78458ca5fe94a64::memo::Memo>())), 0x8ad26c8279c79b4fc53466d6ae5a514830df1942f3b067d7d78458ca5fe94a64::action_spec_builder::next_action_index(arg0));
    }

    // decompiled from Move bytecode v6
}

