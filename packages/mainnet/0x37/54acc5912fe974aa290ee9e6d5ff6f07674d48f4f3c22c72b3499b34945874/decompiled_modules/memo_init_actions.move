module 0x3754acc5912fe974aa290ee9e6d5ff6f07674d48f4f3c22c72b3499b34945874::memo_init_actions {
    struct EmitMemoAction has copy, drop, store {
        memo: 0x1::string::String,
    }

    public fun add_emit_memo_spec(arg0: &mut 0x3754acc5912fe974aa290ee9e6d5ff6f07674d48f4f3c22c72b3499b34945874::action_spec_builder::Builder, arg1: 0x1::string::String) {
        assert!(0x1::string::length(&arg1) > 0, 1);
        assert!(0x1::string::length(&arg1) <= 0x3754acc5912fe974aa290ee9e6d5ff6f07674d48f4f3c22c72b3499b34945874::actions_constants::max_memo_length(), 2);
        let v0 = EmitMemoAction{memo: arg1};
        0x3754acc5912fe974aa290ee9e6d5ff6f07674d48f4f3c22c72b3499b34945874::action_spec_builder::add(arg0, 0x120fdca1774a9543ace0f4a38fb06efadae8966c58de1783d6e30d8d6a50b024::intents::new_action_spec_with_typename(0x1::type_name::with_original_ids<0x3754acc5912fe974aa290ee9e6d5ff6f07674d48f4f3c22c72b3499b34945874::memo::Memo>(), 0x2::bcs::to_bytes<EmitMemoAction>(&v0), 1));
        let v1 = 0x120fdca1774a9543ace0f4a38fb06efadae8966c58de1783d6e30d8d6a50b024::action_events::new_builder();
        0x120fdca1774a9543ace0f4a38fb06efadae8966c58de1783d6e30d8d6a50b024::action_events::add_string(&mut v1, b"memo", arg1);
        0x120fdca1774a9543ace0f4a38fb06efadae8966c58de1783d6e30d8d6a50b024::action_events::emit_action_params(v1, 0x3754acc5912fe974aa290ee9e6d5ff6f07674d48f4f3c22c72b3499b34945874::action_spec_builder::source_type(arg0), 0x3754acc5912fe974aa290ee9e6d5ff6f07674d48f4f3c22c72b3499b34945874::action_spec_builder::source_id(arg0), 0x3754acc5912fe974aa290ee9e6d5ff6f07674d48f4f3c22c72b3499b34945874::action_spec_builder::outcome_index(arg0), 0x1::string::from_ascii(0x1::type_name::into_string(0x1::type_name::with_original_ids<0x3754acc5912fe974aa290ee9e6d5ff6f07674d48f4f3c22c72b3499b34945874::memo::Memo>())), 0x3754acc5912fe974aa290ee9e6d5ff6f07674d48f4f3c22c72b3499b34945874::action_spec_builder::next_action_index(arg0));
    }

    // decompiled from Move bytecode v6
}

