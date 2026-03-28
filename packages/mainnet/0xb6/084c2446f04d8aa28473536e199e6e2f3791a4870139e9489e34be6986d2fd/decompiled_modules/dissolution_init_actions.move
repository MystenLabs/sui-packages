module 0xb6084c2446f04d8aa28473536e199e6e2f3791a4870139e9489e34be6986d2fd::dissolution_init_actions {
    struct CreateDissolutionCapabilityAction has copy, drop, store {
        dummy_field: bool,
    }

    struct CreateRedemptionPoolAction has copy, drop, store {
        resource_names: vector<0x1::string::String>,
    }

    struct AddToRedemptionPoolAction has copy, drop, store {
        resource_name: 0x1::string::String,
        pool_id: address,
    }

    public fun add_add_to_redemption_pool_spec<T0>(arg0: &mut 0x88ef34a7087d4713deabe0ac6807a06558bac9169c29baa652e31275ebb2ea88::action_spec_builder::Builder, arg1: 0x1::string::String, arg2: 0x2::object::ID) {
        assert!(0x1::string::length(&arg1) > 0, 1);
        let v0 = AddToRedemptionPoolAction{
            resource_name : arg1,
            pool_id       : 0x2::object::id_to_address(&arg2),
        };
        0x88ef34a7087d4713deabe0ac6807a06558bac9169c29baa652e31275ebb2ea88::action_spec_builder::add(arg0, 0x3510687b6de0d3c29bc68191a256943aaf57902ca6f7b5a54f62ca72dc61923d::intents::new_action_spec_with_typename(0x1::type_name::with_original_ids<0xb6084c2446f04d8aa28473536e199e6e2f3791a4870139e9489e34be6986d2fd::dissolution_actions::AddToRedemptionPool<T0>>(), 0x2::bcs::to_bytes<AddToRedemptionPoolAction>(&v0), 1));
        let v1 = 0x3510687b6de0d3c29bc68191a256943aaf57902ca6f7b5a54f62ca72dc61923d::action_events::new_builder();
        0x3510687b6de0d3c29bc68191a256943aaf57902ca6f7b5a54f62ca72dc61923d::action_events::add_string(&mut v1, b"resource_name", arg1);
        0x3510687b6de0d3c29bc68191a256943aaf57902ca6f7b5a54f62ca72dc61923d::action_events::add_id(&mut v1, b"pool_id", arg2);
        0x3510687b6de0d3c29bc68191a256943aaf57902ca6f7b5a54f62ca72dc61923d::action_events::emit_action_params(v1, 0x88ef34a7087d4713deabe0ac6807a06558bac9169c29baa652e31275ebb2ea88::action_spec_builder::source_type(arg0), 0x88ef34a7087d4713deabe0ac6807a06558bac9169c29baa652e31275ebb2ea88::action_spec_builder::source_id(arg0), 0x88ef34a7087d4713deabe0ac6807a06558bac9169c29baa652e31275ebb2ea88::action_spec_builder::outcome_index(arg0), 0x1::string::from_ascii(0x1::type_name::into_string(0x1::type_name::with_original_ids<0xb6084c2446f04d8aa28473536e199e6e2f3791a4870139e9489e34be6986d2fd::dissolution_actions::AddToRedemptionPool<T0>>())), 0x88ef34a7087d4713deabe0ac6807a06558bac9169c29baa652e31275ebb2ea88::action_spec_builder::next_action_index(arg0));
    }

    public fun add_create_dissolution_capability_spec<T0>(arg0: &mut 0x88ef34a7087d4713deabe0ac6807a06558bac9169c29baa652e31275ebb2ea88::action_spec_builder::Builder) {
        0x88ef34a7087d4713deabe0ac6807a06558bac9169c29baa652e31275ebb2ea88::action_spec_builder::add(arg0, 0x3510687b6de0d3c29bc68191a256943aaf57902ca6f7b5a54f62ca72dc61923d::intents::new_action_spec_with_typename(0x1::type_name::with_original_ids<0xb6084c2446f04d8aa28473536e199e6e2f3791a4870139e9489e34be6986d2fd::dissolution_actions::CreateDissolutionCapability<T0>>(), 0x1::vector::empty<u8>(), 1));
        0x3510687b6de0d3c29bc68191a256943aaf57902ca6f7b5a54f62ca72dc61923d::action_events::emit_action_params(0x3510687b6de0d3c29bc68191a256943aaf57902ca6f7b5a54f62ca72dc61923d::action_events::new_builder(), 0x88ef34a7087d4713deabe0ac6807a06558bac9169c29baa652e31275ebb2ea88::action_spec_builder::source_type(arg0), 0x88ef34a7087d4713deabe0ac6807a06558bac9169c29baa652e31275ebb2ea88::action_spec_builder::source_id(arg0), 0x88ef34a7087d4713deabe0ac6807a06558bac9169c29baa652e31275ebb2ea88::action_spec_builder::outcome_index(arg0), 0x1::string::from_ascii(0x1::type_name::into_string(0x1::type_name::with_original_ids<0xb6084c2446f04d8aa28473536e199e6e2f3791a4870139e9489e34be6986d2fd::dissolution_actions::CreateDissolutionCapability<T0>>())), 0x88ef34a7087d4713deabe0ac6807a06558bac9169c29baa652e31275ebb2ea88::action_spec_builder::next_action_index(arg0));
    }

    public fun add_create_dissolution_capability_unshared_spec<T0>(arg0: &mut 0x88ef34a7087d4713deabe0ac6807a06558bac9169c29baa652e31275ebb2ea88::action_spec_builder::Builder) {
        0x88ef34a7087d4713deabe0ac6807a06558bac9169c29baa652e31275ebb2ea88::action_spec_builder::add(arg0, 0x3510687b6de0d3c29bc68191a256943aaf57902ca6f7b5a54f62ca72dc61923d::intents::new_action_spec_with_typename(0x1::type_name::with_original_ids<0xb6084c2446f04d8aa28473536e199e6e2f3791a4870139e9489e34be6986d2fd::dissolution_actions::CreateDissolutionCapabilityUnshared<T0>>(), 0x1::vector::empty<u8>(), 1));
        0x3510687b6de0d3c29bc68191a256943aaf57902ca6f7b5a54f62ca72dc61923d::action_events::emit_action_params(0x3510687b6de0d3c29bc68191a256943aaf57902ca6f7b5a54f62ca72dc61923d::action_events::new_builder(), 0x88ef34a7087d4713deabe0ac6807a06558bac9169c29baa652e31275ebb2ea88::action_spec_builder::source_type(arg0), 0x88ef34a7087d4713deabe0ac6807a06558bac9169c29baa652e31275ebb2ea88::action_spec_builder::source_id(arg0), 0x88ef34a7087d4713deabe0ac6807a06558bac9169c29baa652e31275ebb2ea88::action_spec_builder::outcome_index(arg0), 0x1::string::from_ascii(0x1::type_name::into_string(0x1::type_name::with_original_ids<0xb6084c2446f04d8aa28473536e199e6e2f3791a4870139e9489e34be6986d2fd::dissolution_actions::CreateDissolutionCapabilityUnshared<T0>>())), 0x88ef34a7087d4713deabe0ac6807a06558bac9169c29baa652e31275ebb2ea88::action_spec_builder::next_action_index(arg0));
    }

    public fun add_create_redemption_pool_spec<T0>(arg0: &mut 0x88ef34a7087d4713deabe0ac6807a06558bac9169c29baa652e31275ebb2ea88::action_spec_builder::Builder, arg1: vector<0x1::string::String>) {
        assert!(0x1::vector::length<0x1::string::String>(&arg1) > 0, 13906834831473377279);
        let v0 = 0;
        while (v0 < 0x1::vector::length<0x1::string::String>(&arg1)) {
            assert!(0x1::string::length(0x1::vector::borrow<0x1::string::String>(&arg1, v0)) > 0, 1);
            let v1 = v0 + 1;
            while (v1 < 0x1::vector::length<0x1::string::String>(&arg1)) {
                assert!(*0x1::vector::borrow<0x1::string::String>(&arg1, v0) != *0x1::vector::borrow<0x1::string::String>(&arg1, v1), 2);
                v1 = v1 + 1;
            };
            v0 = v0 + 1;
        };
        let v2 = CreateRedemptionPoolAction{resource_names: arg1};
        0x88ef34a7087d4713deabe0ac6807a06558bac9169c29baa652e31275ebb2ea88::action_spec_builder::add(arg0, 0x3510687b6de0d3c29bc68191a256943aaf57902ca6f7b5a54f62ca72dc61923d::intents::new_action_spec_with_typename(0x1::type_name::with_original_ids<0xb6084c2446f04d8aa28473536e199e6e2f3791a4870139e9489e34be6986d2fd::dissolution_actions::CreateRedemptionPool<T0>>(), 0x2::bcs::to_bytes<CreateRedemptionPoolAction>(&v2), 1));
        let v3 = 0x3510687b6de0d3c29bc68191a256943aaf57902ca6f7b5a54f62ca72dc61923d::action_events::new_builder();
        0x3510687b6de0d3c29bc68191a256943aaf57902ca6f7b5a54f62ca72dc61923d::action_events::add_vector_string(&mut v3, b"resource_names", &v2.resource_names);
        0x3510687b6de0d3c29bc68191a256943aaf57902ca6f7b5a54f62ca72dc61923d::action_events::emit_action_params(v3, 0x88ef34a7087d4713deabe0ac6807a06558bac9169c29baa652e31275ebb2ea88::action_spec_builder::source_type(arg0), 0x88ef34a7087d4713deabe0ac6807a06558bac9169c29baa652e31275ebb2ea88::action_spec_builder::source_id(arg0), 0x88ef34a7087d4713deabe0ac6807a06558bac9169c29baa652e31275ebb2ea88::action_spec_builder::outcome_index(arg0), 0x1::string::from_ascii(0x1::type_name::into_string(0x1::type_name::with_original_ids<0xb6084c2446f04d8aa28473536e199e6e2f3791a4870139e9489e34be6986d2fd::dissolution_actions::CreateRedemptionPool<T0>>())), 0x88ef34a7087d4713deabe0ac6807a06558bac9169c29baa652e31275ebb2ea88::action_spec_builder::next_action_index(arg0));
    }

    public fun add_share_dissolution_capability_spec(arg0: &mut 0x88ef34a7087d4713deabe0ac6807a06558bac9169c29baa652e31275ebb2ea88::action_spec_builder::Builder) {
        0x88ef34a7087d4713deabe0ac6807a06558bac9169c29baa652e31275ebb2ea88::action_spec_builder::add(arg0, 0x3510687b6de0d3c29bc68191a256943aaf57902ca6f7b5a54f62ca72dc61923d::intents::new_action_spec_with_typename(0x1::type_name::with_original_ids<0xb6084c2446f04d8aa28473536e199e6e2f3791a4870139e9489e34be6986d2fd::dissolution_actions::ShareDissolutionCapability>(), 0x1::vector::empty<u8>(), 1));
        0x3510687b6de0d3c29bc68191a256943aaf57902ca6f7b5a54f62ca72dc61923d::action_events::emit_action_params(0x3510687b6de0d3c29bc68191a256943aaf57902ca6f7b5a54f62ca72dc61923d::action_events::new_builder(), 0x88ef34a7087d4713deabe0ac6807a06558bac9169c29baa652e31275ebb2ea88::action_spec_builder::source_type(arg0), 0x88ef34a7087d4713deabe0ac6807a06558bac9169c29baa652e31275ebb2ea88::action_spec_builder::source_id(arg0), 0x88ef34a7087d4713deabe0ac6807a06558bac9169c29baa652e31275ebb2ea88::action_spec_builder::outcome_index(arg0), 0x1::string::from_ascii(0x1::type_name::into_string(0x1::type_name::with_original_ids<0xb6084c2446f04d8aa28473536e199e6e2f3791a4870139e9489e34be6986d2fd::dissolution_actions::ShareDissolutionCapability>())), 0x88ef34a7087d4713deabe0ac6807a06558bac9169c29baa652e31275ebb2ea88::action_spec_builder::next_action_index(arg0));
    }

    // decompiled from Move bytecode v6
}

