module 0xc228487ef78ae4bd9899d25fbe018f51573e84c5e11b941b93806008c607ce0d::dissolution_init_actions {
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

    public fun add_add_to_redemption_pool_spec<T0>(arg0: &mut 0xeabe417719b67991896029b26cad43d8a5138109a577c0c56f174e0577e8fe00::action_spec_builder::Builder, arg1: 0x1::string::String, arg2: 0x2::object::ID) {
        assert!(0x1::string::length(&arg1) > 0, 1);
        let v0 = AddToRedemptionPoolAction{
            resource_name : arg1,
            pool_id       : 0x2::object::id_to_address(&arg2),
        };
        0xeabe417719b67991896029b26cad43d8a5138109a577c0c56f174e0577e8fe00::action_spec_builder::add(arg0, 0x988f4f9ab9540eeb476be8751ded1b396cca6a43599fadfe7126b55cff6fb356::intents::new_action_spec_with_typename(0x1::type_name::with_original_ids<0xc228487ef78ae4bd9899d25fbe018f51573e84c5e11b941b93806008c607ce0d::dissolution_actions::AddToRedemptionPool<T0>>(), 0x2::bcs::to_bytes<AddToRedemptionPoolAction>(&v0), 1));
        let v1 = 0x988f4f9ab9540eeb476be8751ded1b396cca6a43599fadfe7126b55cff6fb356::action_events::new_builder();
        0x988f4f9ab9540eeb476be8751ded1b396cca6a43599fadfe7126b55cff6fb356::action_events::add_string(&mut v1, b"resource_name", arg1);
        0x988f4f9ab9540eeb476be8751ded1b396cca6a43599fadfe7126b55cff6fb356::action_events::add_id(&mut v1, b"pool_id", arg2);
        0x988f4f9ab9540eeb476be8751ded1b396cca6a43599fadfe7126b55cff6fb356::action_events::emit_action_params(v1, 0xeabe417719b67991896029b26cad43d8a5138109a577c0c56f174e0577e8fe00::action_spec_builder::source_type(arg0), 0xeabe417719b67991896029b26cad43d8a5138109a577c0c56f174e0577e8fe00::action_spec_builder::source_id(arg0), 0xeabe417719b67991896029b26cad43d8a5138109a577c0c56f174e0577e8fe00::action_spec_builder::outcome_index(arg0), 0x1::string::from_ascii(0x1::type_name::into_string(0x1::type_name::with_original_ids<0xc228487ef78ae4bd9899d25fbe018f51573e84c5e11b941b93806008c607ce0d::dissolution_actions::AddToRedemptionPool<T0>>())), 0xeabe417719b67991896029b26cad43d8a5138109a577c0c56f174e0577e8fe00::action_spec_builder::next_action_index(arg0));
    }

    public fun add_create_dissolution_capability_spec<T0>(arg0: &mut 0xeabe417719b67991896029b26cad43d8a5138109a577c0c56f174e0577e8fe00::action_spec_builder::Builder) {
        0xeabe417719b67991896029b26cad43d8a5138109a577c0c56f174e0577e8fe00::action_spec_builder::add(arg0, 0x988f4f9ab9540eeb476be8751ded1b396cca6a43599fadfe7126b55cff6fb356::intents::new_action_spec_with_typename(0x1::type_name::with_original_ids<0xc228487ef78ae4bd9899d25fbe018f51573e84c5e11b941b93806008c607ce0d::dissolution_actions::CreateDissolutionCapability<T0>>(), 0x1::vector::empty<u8>(), 1));
        0x988f4f9ab9540eeb476be8751ded1b396cca6a43599fadfe7126b55cff6fb356::action_events::emit_action_params(0x988f4f9ab9540eeb476be8751ded1b396cca6a43599fadfe7126b55cff6fb356::action_events::new_builder(), 0xeabe417719b67991896029b26cad43d8a5138109a577c0c56f174e0577e8fe00::action_spec_builder::source_type(arg0), 0xeabe417719b67991896029b26cad43d8a5138109a577c0c56f174e0577e8fe00::action_spec_builder::source_id(arg0), 0xeabe417719b67991896029b26cad43d8a5138109a577c0c56f174e0577e8fe00::action_spec_builder::outcome_index(arg0), 0x1::string::from_ascii(0x1::type_name::into_string(0x1::type_name::with_original_ids<0xc228487ef78ae4bd9899d25fbe018f51573e84c5e11b941b93806008c607ce0d::dissolution_actions::CreateDissolutionCapability<T0>>())), 0xeabe417719b67991896029b26cad43d8a5138109a577c0c56f174e0577e8fe00::action_spec_builder::next_action_index(arg0));
    }

    public fun add_create_dissolution_capability_unshared_spec<T0>(arg0: &mut 0xeabe417719b67991896029b26cad43d8a5138109a577c0c56f174e0577e8fe00::action_spec_builder::Builder) {
        0xeabe417719b67991896029b26cad43d8a5138109a577c0c56f174e0577e8fe00::action_spec_builder::add(arg0, 0x988f4f9ab9540eeb476be8751ded1b396cca6a43599fadfe7126b55cff6fb356::intents::new_action_spec_with_typename(0x1::type_name::with_original_ids<0xc228487ef78ae4bd9899d25fbe018f51573e84c5e11b941b93806008c607ce0d::dissolution_actions::CreateDissolutionCapabilityUnshared<T0>>(), 0x1::vector::empty<u8>(), 1));
        0x988f4f9ab9540eeb476be8751ded1b396cca6a43599fadfe7126b55cff6fb356::action_events::emit_action_params(0x988f4f9ab9540eeb476be8751ded1b396cca6a43599fadfe7126b55cff6fb356::action_events::new_builder(), 0xeabe417719b67991896029b26cad43d8a5138109a577c0c56f174e0577e8fe00::action_spec_builder::source_type(arg0), 0xeabe417719b67991896029b26cad43d8a5138109a577c0c56f174e0577e8fe00::action_spec_builder::source_id(arg0), 0xeabe417719b67991896029b26cad43d8a5138109a577c0c56f174e0577e8fe00::action_spec_builder::outcome_index(arg0), 0x1::string::from_ascii(0x1::type_name::into_string(0x1::type_name::with_original_ids<0xc228487ef78ae4bd9899d25fbe018f51573e84c5e11b941b93806008c607ce0d::dissolution_actions::CreateDissolutionCapabilityUnshared<T0>>())), 0xeabe417719b67991896029b26cad43d8a5138109a577c0c56f174e0577e8fe00::action_spec_builder::next_action_index(arg0));
    }

    public fun add_create_redemption_pool_spec<T0>(arg0: &mut 0xeabe417719b67991896029b26cad43d8a5138109a577c0c56f174e0577e8fe00::action_spec_builder::Builder, arg1: vector<0x1::string::String>) {
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
        0xeabe417719b67991896029b26cad43d8a5138109a577c0c56f174e0577e8fe00::action_spec_builder::add(arg0, 0x988f4f9ab9540eeb476be8751ded1b396cca6a43599fadfe7126b55cff6fb356::intents::new_action_spec_with_typename(0x1::type_name::with_original_ids<0xc228487ef78ae4bd9899d25fbe018f51573e84c5e11b941b93806008c607ce0d::dissolution_actions::CreateRedemptionPool<T0>>(), 0x2::bcs::to_bytes<CreateRedemptionPoolAction>(&v2), 1));
        let v3 = 0x988f4f9ab9540eeb476be8751ded1b396cca6a43599fadfe7126b55cff6fb356::action_events::new_builder();
        0x988f4f9ab9540eeb476be8751ded1b396cca6a43599fadfe7126b55cff6fb356::action_events::add_vector_string(&mut v3, b"resource_names", &v2.resource_names);
        0x988f4f9ab9540eeb476be8751ded1b396cca6a43599fadfe7126b55cff6fb356::action_events::emit_action_params(v3, 0xeabe417719b67991896029b26cad43d8a5138109a577c0c56f174e0577e8fe00::action_spec_builder::source_type(arg0), 0xeabe417719b67991896029b26cad43d8a5138109a577c0c56f174e0577e8fe00::action_spec_builder::source_id(arg0), 0xeabe417719b67991896029b26cad43d8a5138109a577c0c56f174e0577e8fe00::action_spec_builder::outcome_index(arg0), 0x1::string::from_ascii(0x1::type_name::into_string(0x1::type_name::with_original_ids<0xc228487ef78ae4bd9899d25fbe018f51573e84c5e11b941b93806008c607ce0d::dissolution_actions::CreateRedemptionPool<T0>>())), 0xeabe417719b67991896029b26cad43d8a5138109a577c0c56f174e0577e8fe00::action_spec_builder::next_action_index(arg0));
    }

    public fun add_share_dissolution_capability_spec(arg0: &mut 0xeabe417719b67991896029b26cad43d8a5138109a577c0c56f174e0577e8fe00::action_spec_builder::Builder) {
        0xeabe417719b67991896029b26cad43d8a5138109a577c0c56f174e0577e8fe00::action_spec_builder::add(arg0, 0x988f4f9ab9540eeb476be8751ded1b396cca6a43599fadfe7126b55cff6fb356::intents::new_action_spec_with_typename(0x1::type_name::with_original_ids<0xc228487ef78ae4bd9899d25fbe018f51573e84c5e11b941b93806008c607ce0d::dissolution_actions::ShareDissolutionCapability>(), 0x1::vector::empty<u8>(), 1));
        0x988f4f9ab9540eeb476be8751ded1b396cca6a43599fadfe7126b55cff6fb356::action_events::emit_action_params(0x988f4f9ab9540eeb476be8751ded1b396cca6a43599fadfe7126b55cff6fb356::action_events::new_builder(), 0xeabe417719b67991896029b26cad43d8a5138109a577c0c56f174e0577e8fe00::action_spec_builder::source_type(arg0), 0xeabe417719b67991896029b26cad43d8a5138109a577c0c56f174e0577e8fe00::action_spec_builder::source_id(arg0), 0xeabe417719b67991896029b26cad43d8a5138109a577c0c56f174e0577e8fe00::action_spec_builder::outcome_index(arg0), 0x1::string::from_ascii(0x1::type_name::into_string(0x1::type_name::with_original_ids<0xc228487ef78ae4bd9899d25fbe018f51573e84c5e11b941b93806008c607ce0d::dissolution_actions::ShareDissolutionCapability>())), 0xeabe417719b67991896029b26cad43d8a5138109a577c0c56f174e0577e8fe00::action_spec_builder::next_action_index(arg0));
    }

    // decompiled from Move bytecode v6
}

