module 0xaa682664f419d51af5071ed0449dffbcf3a417fd12961d916b1a433542e9478d::memo_init_actions {
    struct EmitMemoAction has copy, drop, store {
        memo: 0x1::string::String,
    }

    public fun add_emit_memo_spec(arg0: &mut 0xaa682664f419d51af5071ed0449dffbcf3a417fd12961d916b1a433542e9478d::action_spec_builder::Builder, arg1: 0x1::string::String) {
        assert!(0x1::string::length(&arg1) > 0, 1);
        assert!(0x1::string::length(&arg1) <= 0xaa682664f419d51af5071ed0449dffbcf3a417fd12961d916b1a433542e9478d::actions_constants::max_memo_length(), 2);
        let v0 = EmitMemoAction{memo: arg1};
        0xaa682664f419d51af5071ed0449dffbcf3a417fd12961d916b1a433542e9478d::action_spec_builder::add(arg0, 0xf6ef484a0867ccffe219fa1f4648e58f8c3fd04a4ddcfb318a27f9cc6d2f3d9::intents::new_action_spec<0xaa682664f419d51af5071ed0449dffbcf3a417fd12961d916b1a433542e9478d::memo::Memo>(0xaa682664f419d51af5071ed0449dffbcf3a417fd12961d916b1a433542e9478d::memo::memo(), 0x2::bcs::to_bytes<EmitMemoAction>(&v0), 1));
    }

    // decompiled from Move bytecode v6
}

