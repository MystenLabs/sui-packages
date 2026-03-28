module 0x88ef34a7087d4713deabe0ac6807a06558bac9169c29baa652e31275ebb2ea88::owned_init_actions {
    struct WithdrawObjectAction has copy, drop, store {
        object_id: 0x2::object::ID,
        resource_name: 0x1::string::String,
    }

    public fun add_provide_object_spec<T0: store + key>(arg0: &mut 0x88ef34a7087d4713deabe0ac6807a06558bac9169c29baa652e31275ebb2ea88::action_spec_builder::Builder, arg1: 0x1::string::String) {
        assert!(0x1::string::length(&arg1) > 0, 1);
        0x88ef34a7087d4713deabe0ac6807a06558bac9169c29baa652e31275ebb2ea88::action_spec_builder::add(arg0, 0x3510687b6de0d3c29bc68191a256943aaf57902ca6f7b5a54f62ca72dc61923d::intents::new_action_spec_with_typename(0x1::type_name::with_original_ids<0x3510687b6de0d3c29bc68191a256943aaf57902ca6f7b5a54f62ca72dc61923d::owned::ProvideObjectToResources<T0>>(), 0x2::bcs::to_bytes<0x1::string::String>(&arg1), 1));
        let v0 = 0x3510687b6de0d3c29bc68191a256943aaf57902ca6f7b5a54f62ca72dc61923d::action_events::new_builder();
        0x3510687b6de0d3c29bc68191a256943aaf57902ca6f7b5a54f62ca72dc61923d::action_events::add_string(&mut v0, b"resource_name", arg1);
        0x3510687b6de0d3c29bc68191a256943aaf57902ca6f7b5a54f62ca72dc61923d::action_events::emit_action_params(v0, 0x88ef34a7087d4713deabe0ac6807a06558bac9169c29baa652e31275ebb2ea88::action_spec_builder::source_type(arg0), 0x88ef34a7087d4713deabe0ac6807a06558bac9169c29baa652e31275ebb2ea88::action_spec_builder::source_id(arg0), 0x88ef34a7087d4713deabe0ac6807a06558bac9169c29baa652e31275ebb2ea88::action_spec_builder::outcome_index(arg0), 0x1::string::from_ascii(0x1::type_name::into_string(0x1::type_name::with_original_ids<0x3510687b6de0d3c29bc68191a256943aaf57902ca6f7b5a54f62ca72dc61923d::owned::ProvideObjectToResources<T0>>())), 0x88ef34a7087d4713deabe0ac6807a06558bac9169c29baa652e31275ebb2ea88::action_spec_builder::next_action_index(arg0));
    }

    public fun add_withdraw_object_spec<T0: store + key>(arg0: &mut 0x88ef34a7087d4713deabe0ac6807a06558bac9169c29baa652e31275ebb2ea88::action_spec_builder::Builder, arg1: 0x2::object::ID, arg2: 0x1::string::String) {
        assert!(0x1::string::length(&arg2) > 0, 1);
        let v0 = WithdrawObjectAction{
            object_id     : arg1,
            resource_name : arg2,
        };
        0x88ef34a7087d4713deabe0ac6807a06558bac9169c29baa652e31275ebb2ea88::action_spec_builder::add(arg0, 0x3510687b6de0d3c29bc68191a256943aaf57902ca6f7b5a54f62ca72dc61923d::intents::new_action_spec_with_typename(0x1::type_name::with_original_ids<0x3510687b6de0d3c29bc68191a256943aaf57902ca6f7b5a54f62ca72dc61923d::owned::OwnedWithdrawObject<T0>>(), 0x2::bcs::to_bytes<WithdrawObjectAction>(&v0), 1));
        let v1 = 0x3510687b6de0d3c29bc68191a256943aaf57902ca6f7b5a54f62ca72dc61923d::action_events::new_builder();
        0x3510687b6de0d3c29bc68191a256943aaf57902ca6f7b5a54f62ca72dc61923d::action_events::add_id(&mut v1, b"object_id", arg1);
        0x3510687b6de0d3c29bc68191a256943aaf57902ca6f7b5a54f62ca72dc61923d::action_events::add_string(&mut v1, b"resource_name", arg2);
        0x3510687b6de0d3c29bc68191a256943aaf57902ca6f7b5a54f62ca72dc61923d::action_events::emit_action_params(v1, 0x88ef34a7087d4713deabe0ac6807a06558bac9169c29baa652e31275ebb2ea88::action_spec_builder::source_type(arg0), 0x88ef34a7087d4713deabe0ac6807a06558bac9169c29baa652e31275ebb2ea88::action_spec_builder::source_id(arg0), 0x88ef34a7087d4713deabe0ac6807a06558bac9169c29baa652e31275ebb2ea88::action_spec_builder::outcome_index(arg0), 0x1::string::from_ascii(0x1::type_name::into_string(0x1::type_name::with_original_ids<0x3510687b6de0d3c29bc68191a256943aaf57902ca6f7b5a54f62ca72dc61923d::owned::OwnedWithdrawObject<T0>>())), 0x88ef34a7087d4713deabe0ac6807a06558bac9169c29baa652e31275ebb2ea88::action_spec_builder::next_action_index(arg0));
    }

    // decompiled from Move bytecode v6
}

