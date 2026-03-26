module 0xbe96f5469a522974f1226110b2753076587eeed890c01700a3bb14e528c956ee::memo_init_actions {
    struct EmitMemoAction has copy, drop, store {
        memo: 0x1::string::String,
    }

    public fun add_emit_memo_spec(arg0: &mut 0xbe96f5469a522974f1226110b2753076587eeed890c01700a3bb14e528c956ee::action_spec_builder::Builder, arg1: 0x1::string::String) {
        assert!(0x1::string::length(&arg1) > 0, 1);
        assert!(0x1::string::length(&arg1) <= 0xbe96f5469a522974f1226110b2753076587eeed890c01700a3bb14e528c956ee::actions_constants::max_memo_length(), 2);
        let v0 = EmitMemoAction{memo: arg1};
        0xbe96f5469a522974f1226110b2753076587eeed890c01700a3bb14e528c956ee::action_spec_builder::add(arg0, 0x8a0ce6b60836f32d52c7aed958f9f319cf3cb654c227cbb1806fdcaa0ad737e1::intents::new_action_spec_with_typename(0x1::type_name::with_original_ids<0xbe96f5469a522974f1226110b2753076587eeed890c01700a3bb14e528c956ee::memo::Memo>(), 0x2::bcs::to_bytes<EmitMemoAction>(&v0), 1));
        let v1 = 0x8a0ce6b60836f32d52c7aed958f9f319cf3cb654c227cbb1806fdcaa0ad737e1::action_events::new_builder();
        0x8a0ce6b60836f32d52c7aed958f9f319cf3cb654c227cbb1806fdcaa0ad737e1::action_events::add_string(&mut v1, b"memo", arg1);
        0x8a0ce6b60836f32d52c7aed958f9f319cf3cb654c227cbb1806fdcaa0ad737e1::action_events::emit_action_params(v1, 0xbe96f5469a522974f1226110b2753076587eeed890c01700a3bb14e528c956ee::action_spec_builder::source_type(arg0), 0xbe96f5469a522974f1226110b2753076587eeed890c01700a3bb14e528c956ee::action_spec_builder::source_id(arg0), 0xbe96f5469a522974f1226110b2753076587eeed890c01700a3bb14e528c956ee::action_spec_builder::outcome_index(arg0), 0x1::string::from_ascii(0x1::type_name::into_string(0x1::type_name::with_original_ids<0xbe96f5469a522974f1226110b2753076587eeed890c01700a3bb14e528c956ee::memo::Memo>())), 0xbe96f5469a522974f1226110b2753076587eeed890c01700a3bb14e528c956ee::action_spec_builder::next_action_index(arg0));
    }

    // decompiled from Move bytecode v6
}

