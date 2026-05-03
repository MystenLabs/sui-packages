module 0x12cb3c69cbbfb1e8e647993dd8a83b4624a81c815ee867af8f5c5be3933e0839::dissolution_init_actions {
    public fun add_add_to_redemption_pool_spec<T0>(arg0: &mut 0xaa682664f419d51af5071ed0449dffbcf3a417fd12961d916b1a433542e9478d::action_spec_builder::Builder, arg1: 0x1::string::String, arg2: 0x2::object::ID) {
        assert!(0x1::string::length(&arg1) > 0, 1);
        let v0 = 0x12cb3c69cbbfb1e8e647993dd8a83b4624a81c815ee867af8f5c5be3933e0839::dissolution_actions::new_add_to_redemption_pool(arg1, arg2);
        0xaa682664f419d51af5071ed0449dffbcf3a417fd12961d916b1a433542e9478d::action_spec_builder::add(arg0, 0xf6ef484a0867ccffe219fa1f4648e58f8c3fd04a4ddcfb318a27f9cc6d2f3d9::intents::new_action_spec<0x12cb3c69cbbfb1e8e647993dd8a83b4624a81c815ee867af8f5c5be3933e0839::dissolution_actions::AddToRedemptionPool<T0>>(0x12cb3c69cbbfb1e8e647993dd8a83b4624a81c815ee867af8f5c5be3933e0839::dissolution_actions::add_to_redemption_pool_marker<T0>(), 0x2::bcs::to_bytes<0x12cb3c69cbbfb1e8e647993dd8a83b4624a81c815ee867af8f5c5be3933e0839::dissolution_actions::AddToRedemptionPoolAction>(&v0), 1));
        let v1 = 0xf6ef484a0867ccffe219fa1f4648e58f8c3fd04a4ddcfb318a27f9cc6d2f3d9::action_events::new_builder();
        0xf6ef484a0867ccffe219fa1f4648e58f8c3fd04a4ddcfb318a27f9cc6d2f3d9::action_events::add_string(&mut v1, b"resource_name", arg1);
        0xf6ef484a0867ccffe219fa1f4648e58f8c3fd04a4ddcfb318a27f9cc6d2f3d9::action_events::add_id(&mut v1, b"pool_id", arg2);
        0xf6ef484a0867ccffe219fa1f4648e58f8c3fd04a4ddcfb318a27f9cc6d2f3d9::action_events::emit_action_params(v1, 0xaa682664f419d51af5071ed0449dffbcf3a417fd12961d916b1a433542e9478d::action_spec_builder::source_type(arg0), 0xaa682664f419d51af5071ed0449dffbcf3a417fd12961d916b1a433542e9478d::action_spec_builder::source_id(arg0), 0xaa682664f419d51af5071ed0449dffbcf3a417fd12961d916b1a433542e9478d::action_spec_builder::outcome_index(arg0), 0x1::string::from_ascii(0x1::type_name::into_string(0x1::type_name::with_original_ids<0x12cb3c69cbbfb1e8e647993dd8a83b4624a81c815ee867af8f5c5be3933e0839::dissolution_actions::AddToRedemptionPool<T0>>())), 0xaa682664f419d51af5071ed0449dffbcf3a417fd12961d916b1a433542e9478d::action_spec_builder::next_action_index(arg0));
    }

    public fun add_create_dissolution_capability_spec<T0>(arg0: &mut 0xaa682664f419d51af5071ed0449dffbcf3a417fd12961d916b1a433542e9478d::action_spec_builder::Builder) {
        0xaa682664f419d51af5071ed0449dffbcf3a417fd12961d916b1a433542e9478d::action_spec_builder::add(arg0, 0xf6ef484a0867ccffe219fa1f4648e58f8c3fd04a4ddcfb318a27f9cc6d2f3d9::intents::new_action_spec<0x12cb3c69cbbfb1e8e647993dd8a83b4624a81c815ee867af8f5c5be3933e0839::dissolution_actions::CreateDissolutionCapability<T0>>(0x12cb3c69cbbfb1e8e647993dd8a83b4624a81c815ee867af8f5c5be3933e0839::dissolution_actions::create_dissolution_capability_marker<T0>(), 0x1::vector::empty<u8>(), 1));
        0xf6ef484a0867ccffe219fa1f4648e58f8c3fd04a4ddcfb318a27f9cc6d2f3d9::action_events::emit_action_params(0xf6ef484a0867ccffe219fa1f4648e58f8c3fd04a4ddcfb318a27f9cc6d2f3d9::action_events::new_builder(), 0xaa682664f419d51af5071ed0449dffbcf3a417fd12961d916b1a433542e9478d::action_spec_builder::source_type(arg0), 0xaa682664f419d51af5071ed0449dffbcf3a417fd12961d916b1a433542e9478d::action_spec_builder::source_id(arg0), 0xaa682664f419d51af5071ed0449dffbcf3a417fd12961d916b1a433542e9478d::action_spec_builder::outcome_index(arg0), 0x1::string::from_ascii(0x1::type_name::into_string(0x1::type_name::with_original_ids<0x12cb3c69cbbfb1e8e647993dd8a83b4624a81c815ee867af8f5c5be3933e0839::dissolution_actions::CreateDissolutionCapability<T0>>())), 0xaa682664f419d51af5071ed0449dffbcf3a417fd12961d916b1a433542e9478d::action_spec_builder::next_action_index(arg0));
    }

    public fun add_create_dissolution_capability_unshared_spec<T0>(arg0: &mut 0xaa682664f419d51af5071ed0449dffbcf3a417fd12961d916b1a433542e9478d::action_spec_builder::Builder) {
        0xaa682664f419d51af5071ed0449dffbcf3a417fd12961d916b1a433542e9478d::action_spec_builder::add(arg0, 0xf6ef484a0867ccffe219fa1f4648e58f8c3fd04a4ddcfb318a27f9cc6d2f3d9::intents::new_action_spec<0x12cb3c69cbbfb1e8e647993dd8a83b4624a81c815ee867af8f5c5be3933e0839::dissolution_actions::CreateDissolutionCapabilityUnshared<T0>>(0x12cb3c69cbbfb1e8e647993dd8a83b4624a81c815ee867af8f5c5be3933e0839::dissolution_actions::create_dissolution_capability_unshared_marker<T0>(), 0x1::vector::empty<u8>(), 1));
        0xf6ef484a0867ccffe219fa1f4648e58f8c3fd04a4ddcfb318a27f9cc6d2f3d9::action_events::emit_action_params(0xf6ef484a0867ccffe219fa1f4648e58f8c3fd04a4ddcfb318a27f9cc6d2f3d9::action_events::new_builder(), 0xaa682664f419d51af5071ed0449dffbcf3a417fd12961d916b1a433542e9478d::action_spec_builder::source_type(arg0), 0xaa682664f419d51af5071ed0449dffbcf3a417fd12961d916b1a433542e9478d::action_spec_builder::source_id(arg0), 0xaa682664f419d51af5071ed0449dffbcf3a417fd12961d916b1a433542e9478d::action_spec_builder::outcome_index(arg0), 0x1::string::from_ascii(0x1::type_name::into_string(0x1::type_name::with_original_ids<0x12cb3c69cbbfb1e8e647993dd8a83b4624a81c815ee867af8f5c5be3933e0839::dissolution_actions::CreateDissolutionCapabilityUnshared<T0>>())), 0xaa682664f419d51af5071ed0449dffbcf3a417fd12961d916b1a433542e9478d::action_spec_builder::next_action_index(arg0));
    }

    public fun add_create_redemption_pool_from_unshared_capability_spec<T0>(arg0: &mut 0xaa682664f419d51af5071ed0449dffbcf3a417fd12961d916b1a433542e9478d::action_spec_builder::Builder, arg1: vector<0x1::string::String>) {
        validate_resource_names(&arg1);
        let v0 = 0x12cb3c69cbbfb1e8e647993dd8a83b4624a81c815ee867af8f5c5be3933e0839::dissolution_actions::new_create_redemption_pool_from_unshared_capability(arg1);
        0xaa682664f419d51af5071ed0449dffbcf3a417fd12961d916b1a433542e9478d::action_spec_builder::add(arg0, 0xf6ef484a0867ccffe219fa1f4648e58f8c3fd04a4ddcfb318a27f9cc6d2f3d9::intents::new_action_spec<0x12cb3c69cbbfb1e8e647993dd8a83b4624a81c815ee867af8f5c5be3933e0839::dissolution_actions::CreateRedemptionPool<T0>>(0x12cb3c69cbbfb1e8e647993dd8a83b4624a81c815ee867af8f5c5be3933e0839::dissolution_actions::create_redemption_pool_marker<T0>(), 0x2::bcs::to_bytes<0x12cb3c69cbbfb1e8e647993dd8a83b4624a81c815ee867af8f5c5be3933e0839::dissolution_actions::CreateRedemptionPoolAction>(&v0), 1));
        let v1 = 0xf6ef484a0867ccffe219fa1f4648e58f8c3fd04a4ddcfb318a27f9cc6d2f3d9::action_events::new_builder();
        0xf6ef484a0867ccffe219fa1f4648e58f8c3fd04a4ddcfb318a27f9cc6d2f3d9::action_events::add_vector_string(&mut v1, b"resource_names", &arg1);
        0xf6ef484a0867ccffe219fa1f4648e58f8c3fd04a4ddcfb318a27f9cc6d2f3d9::action_events::emit_action_params(v1, 0xaa682664f419d51af5071ed0449dffbcf3a417fd12961d916b1a433542e9478d::action_spec_builder::source_type(arg0), 0xaa682664f419d51af5071ed0449dffbcf3a417fd12961d916b1a433542e9478d::action_spec_builder::source_id(arg0), 0xaa682664f419d51af5071ed0449dffbcf3a417fd12961d916b1a433542e9478d::action_spec_builder::outcome_index(arg0), 0x1::string::from_ascii(0x1::type_name::into_string(0x1::type_name::with_original_ids<0x12cb3c69cbbfb1e8e647993dd8a83b4624a81c815ee867af8f5c5be3933e0839::dissolution_actions::CreateRedemptionPool<T0>>())), 0xaa682664f419d51af5071ed0449dffbcf3a417fd12961d916b1a433542e9478d::action_spec_builder::next_action_index(arg0));
    }

    public fun add_create_redemption_pool_spec<T0>(arg0: &mut 0xaa682664f419d51af5071ed0449dffbcf3a417fd12961d916b1a433542e9478d::action_spec_builder::Builder, arg1: 0x2::object::ID, arg2: vector<0x1::string::String>) {
        validate_resource_names(&arg2);
        let v0 = 0x12cb3c69cbbfb1e8e647993dd8a83b4624a81c815ee867af8f5c5be3933e0839::dissolution_actions::new_create_redemption_pool(arg1, arg2);
        0xaa682664f419d51af5071ed0449dffbcf3a417fd12961d916b1a433542e9478d::action_spec_builder::add(arg0, 0xf6ef484a0867ccffe219fa1f4648e58f8c3fd04a4ddcfb318a27f9cc6d2f3d9::intents::new_action_spec<0x12cb3c69cbbfb1e8e647993dd8a83b4624a81c815ee867af8f5c5be3933e0839::dissolution_actions::CreateRedemptionPool<T0>>(0x12cb3c69cbbfb1e8e647993dd8a83b4624a81c815ee867af8f5c5be3933e0839::dissolution_actions::create_redemption_pool_marker<T0>(), 0x2::bcs::to_bytes<0x12cb3c69cbbfb1e8e647993dd8a83b4624a81c815ee867af8f5c5be3933e0839::dissolution_actions::CreateRedemptionPoolAction>(&v0), 1));
        let v1 = 0xf6ef484a0867ccffe219fa1f4648e58f8c3fd04a4ddcfb318a27f9cc6d2f3d9::action_events::new_builder();
        0xf6ef484a0867ccffe219fa1f4648e58f8c3fd04a4ddcfb318a27f9cc6d2f3d9::action_events::add_id(&mut v1, b"capability_id", arg1);
        0xf6ef484a0867ccffe219fa1f4648e58f8c3fd04a4ddcfb318a27f9cc6d2f3d9::action_events::add_vector_string(&mut v1, b"resource_names", &arg2);
        0xf6ef484a0867ccffe219fa1f4648e58f8c3fd04a4ddcfb318a27f9cc6d2f3d9::action_events::emit_action_params(v1, 0xaa682664f419d51af5071ed0449dffbcf3a417fd12961d916b1a433542e9478d::action_spec_builder::source_type(arg0), 0xaa682664f419d51af5071ed0449dffbcf3a417fd12961d916b1a433542e9478d::action_spec_builder::source_id(arg0), 0xaa682664f419d51af5071ed0449dffbcf3a417fd12961d916b1a433542e9478d::action_spec_builder::outcome_index(arg0), 0x1::string::from_ascii(0x1::type_name::into_string(0x1::type_name::with_original_ids<0x12cb3c69cbbfb1e8e647993dd8a83b4624a81c815ee867af8f5c5be3933e0839::dissolution_actions::CreateRedemptionPool<T0>>())), 0xaa682664f419d51af5071ed0449dffbcf3a417fd12961d916b1a433542e9478d::action_spec_builder::next_action_index(arg0));
    }

    public fun add_share_dissolution_capability_spec(arg0: &mut 0xaa682664f419d51af5071ed0449dffbcf3a417fd12961d916b1a433542e9478d::action_spec_builder::Builder) {
        0xaa682664f419d51af5071ed0449dffbcf3a417fd12961d916b1a433542e9478d::action_spec_builder::add(arg0, 0xf6ef484a0867ccffe219fa1f4648e58f8c3fd04a4ddcfb318a27f9cc6d2f3d9::intents::new_action_spec<0x12cb3c69cbbfb1e8e647993dd8a83b4624a81c815ee867af8f5c5be3933e0839::dissolution_actions::ShareDissolutionCapability>(0x12cb3c69cbbfb1e8e647993dd8a83b4624a81c815ee867af8f5c5be3933e0839::dissolution_actions::share_dissolution_capability_marker(), 0x1::vector::empty<u8>(), 1));
        0xf6ef484a0867ccffe219fa1f4648e58f8c3fd04a4ddcfb318a27f9cc6d2f3d9::action_events::emit_action_params(0xf6ef484a0867ccffe219fa1f4648e58f8c3fd04a4ddcfb318a27f9cc6d2f3d9::action_events::new_builder(), 0xaa682664f419d51af5071ed0449dffbcf3a417fd12961d916b1a433542e9478d::action_spec_builder::source_type(arg0), 0xaa682664f419d51af5071ed0449dffbcf3a417fd12961d916b1a433542e9478d::action_spec_builder::source_id(arg0), 0xaa682664f419d51af5071ed0449dffbcf3a417fd12961d916b1a433542e9478d::action_spec_builder::outcome_index(arg0), 0x1::string::from_ascii(0x1::type_name::into_string(0x1::type_name::with_original_ids<0x12cb3c69cbbfb1e8e647993dd8a83b4624a81c815ee867af8f5c5be3933e0839::dissolution_actions::ShareDissolutionCapability>())), 0xaa682664f419d51af5071ed0449dffbcf3a417fd12961d916b1a433542e9478d::action_spec_builder::next_action_index(arg0));
    }

    fun validate_resource_names(arg0: &vector<0x1::string::String>) {
        assert!(0x1::vector::length<0x1::string::String>(arg0) > 0, 13906834981797232639);
        let v0 = 0;
        while (v0 < 0x1::vector::length<0x1::string::String>(arg0)) {
            assert!(0x1::string::length(0x1::vector::borrow<0x1::string::String>(arg0, v0)) > 0, 1);
            let v1 = v0 + 1;
            while (v1 < 0x1::vector::length<0x1::string::String>(arg0)) {
                assert!(*0x1::vector::borrow<0x1::string::String>(arg0, v0) != *0x1::vector::borrow<0x1::string::String>(arg0, v1), 2);
                v1 = v1 + 1;
            };
            v0 = v0 + 1;
        };
    }

    // decompiled from Move bytecode v6
}

