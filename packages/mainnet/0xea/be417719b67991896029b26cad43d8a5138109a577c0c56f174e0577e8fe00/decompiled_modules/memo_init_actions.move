module 0xeabe417719b67991896029b26cad43d8a5138109a577c0c56f174e0577e8fe00::memo_init_actions {
    struct EmitMemoAction has copy, drop, store {
        memo: 0x1::string::String,
    }

    public fun add_emit_memo_spec(arg0: &mut 0xeabe417719b67991896029b26cad43d8a5138109a577c0c56f174e0577e8fe00::action_spec_builder::Builder, arg1: 0x1::string::String) {
        assert!(0x1::string::length(&arg1) > 0, 1);
        assert!(0x1::string::length(&arg1) <= 0xeabe417719b67991896029b26cad43d8a5138109a577c0c56f174e0577e8fe00::actions_constants::max_memo_length(), 2);
        let v0 = EmitMemoAction{memo: arg1};
        0xeabe417719b67991896029b26cad43d8a5138109a577c0c56f174e0577e8fe00::action_spec_builder::add(arg0, 0x988f4f9ab9540eeb476be8751ded1b396cca6a43599fadfe7126b55cff6fb356::intents::new_action_spec_with_typename(0x1::type_name::with_original_ids<0xeabe417719b67991896029b26cad43d8a5138109a577c0c56f174e0577e8fe00::memo::Memo>(), 0x2::bcs::to_bytes<EmitMemoAction>(&v0), 1));
        let v1 = 0x988f4f9ab9540eeb476be8751ded1b396cca6a43599fadfe7126b55cff6fb356::action_events::new_builder();
        0x988f4f9ab9540eeb476be8751ded1b396cca6a43599fadfe7126b55cff6fb356::action_events::add_string(&mut v1, b"memo", arg1);
        0x988f4f9ab9540eeb476be8751ded1b396cca6a43599fadfe7126b55cff6fb356::action_events::emit_action_params(v1, 0xeabe417719b67991896029b26cad43d8a5138109a577c0c56f174e0577e8fe00::action_spec_builder::source_type(arg0), 0xeabe417719b67991896029b26cad43d8a5138109a577c0c56f174e0577e8fe00::action_spec_builder::source_id(arg0), 0xeabe417719b67991896029b26cad43d8a5138109a577c0c56f174e0577e8fe00::action_spec_builder::outcome_index(arg0), 0x1::string::from_ascii(0x1::type_name::into_string(0x1::type_name::with_original_ids<0xeabe417719b67991896029b26cad43d8a5138109a577c0c56f174e0577e8fe00::memo::Memo>())), 0xeabe417719b67991896029b26cad43d8a5138109a577c0c56f174e0577e8fe00::action_spec_builder::next_action_index(arg0));
    }

    // decompiled from Move bytecode v6
}

