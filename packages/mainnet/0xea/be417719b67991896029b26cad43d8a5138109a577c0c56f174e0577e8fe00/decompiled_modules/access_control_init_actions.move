module 0xeabe417719b67991896029b26cad43d8a5138109a577c0c56f174e0577e8fe00::access_control_init_actions {
    struct LockAction has copy, drop, store {
        expected_id: 0x2::object::ID,
        resource_name: 0x1::string::String,
    }

    struct UnlockToResourcesAction has copy, drop, store {
        resource_name: 0x1::string::String,
    }

    public fun add_lock_spec<T0>(arg0: &mut 0xeabe417719b67991896029b26cad43d8a5138109a577c0c56f174e0577e8fe00::action_spec_builder::Builder, arg1: 0x2::object::ID, arg2: 0x1::string::String) {
        let v0 = LockAction{
            expected_id   : arg1,
            resource_name : arg2,
        };
        0xeabe417719b67991896029b26cad43d8a5138109a577c0c56f174e0577e8fe00::action_spec_builder::add(arg0, 0x988f4f9ab9540eeb476be8751ded1b396cca6a43599fadfe7126b55cff6fb356::intents::new_action_spec_with_typename(0x1::type_name::with_original_ids<0xeabe417719b67991896029b26cad43d8a5138109a577c0c56f174e0577e8fe00::access_control::AccessControlLock<T0>>(), 0x2::bcs::to_bytes<LockAction>(&v0), 1));
        let v1 = 0x988f4f9ab9540eeb476be8751ded1b396cca6a43599fadfe7126b55cff6fb356::action_events::new_builder();
        0x988f4f9ab9540eeb476be8751ded1b396cca6a43599fadfe7126b55cff6fb356::action_events::add_id(&mut v1, b"expected_id", arg1);
        0x988f4f9ab9540eeb476be8751ded1b396cca6a43599fadfe7126b55cff6fb356::action_events::add_string(&mut v1, b"resource_name", v0.resource_name);
        0x988f4f9ab9540eeb476be8751ded1b396cca6a43599fadfe7126b55cff6fb356::action_events::emit_action_params(v1, 0xeabe417719b67991896029b26cad43d8a5138109a577c0c56f174e0577e8fe00::action_spec_builder::source_type(arg0), 0xeabe417719b67991896029b26cad43d8a5138109a577c0c56f174e0577e8fe00::action_spec_builder::source_id(arg0), 0xeabe417719b67991896029b26cad43d8a5138109a577c0c56f174e0577e8fe00::action_spec_builder::outcome_index(arg0), 0x1::string::from_ascii(0x1::type_name::into_string(0x1::type_name::with_original_ids<0xeabe417719b67991896029b26cad43d8a5138109a577c0c56f174e0577e8fe00::access_control::AccessControlLock<T0>>())), 0xeabe417719b67991896029b26cad43d8a5138109a577c0c56f174e0577e8fe00::action_spec_builder::next_action_index(arg0));
    }

    public fun add_unlock_to_resources_spec<T0>(arg0: &mut 0xeabe417719b67991896029b26cad43d8a5138109a577c0c56f174e0577e8fe00::action_spec_builder::Builder, arg1: 0x1::string::String) {
        let v0 = UnlockToResourcesAction{resource_name: arg1};
        0xeabe417719b67991896029b26cad43d8a5138109a577c0c56f174e0577e8fe00::action_spec_builder::add(arg0, 0x988f4f9ab9540eeb476be8751ded1b396cca6a43599fadfe7126b55cff6fb356::intents::new_action_spec_with_typename(0x1::type_name::with_original_ids<0xeabe417719b67991896029b26cad43d8a5138109a577c0c56f174e0577e8fe00::access_control::AccessControlUnlockToResources<T0>>(), 0x2::bcs::to_bytes<UnlockToResourcesAction>(&v0), 1));
        let v1 = 0x988f4f9ab9540eeb476be8751ded1b396cca6a43599fadfe7126b55cff6fb356::action_events::new_builder();
        0x988f4f9ab9540eeb476be8751ded1b396cca6a43599fadfe7126b55cff6fb356::action_events::add_string(&mut v1, b"resource_name", v0.resource_name);
        0x988f4f9ab9540eeb476be8751ded1b396cca6a43599fadfe7126b55cff6fb356::action_events::emit_action_params(v1, 0xeabe417719b67991896029b26cad43d8a5138109a577c0c56f174e0577e8fe00::action_spec_builder::source_type(arg0), 0xeabe417719b67991896029b26cad43d8a5138109a577c0c56f174e0577e8fe00::action_spec_builder::source_id(arg0), 0xeabe417719b67991896029b26cad43d8a5138109a577c0c56f174e0577e8fe00::action_spec_builder::outcome_index(arg0), 0x1::string::from_ascii(0x1::type_name::into_string(0x1::type_name::with_original_ids<0xeabe417719b67991896029b26cad43d8a5138109a577c0c56f174e0577e8fe00::access_control::AccessControlUnlockToResources<T0>>())), 0xeabe417719b67991896029b26cad43d8a5138109a577c0c56f174e0577e8fe00::action_spec_builder::next_action_index(arg0));
    }

    // decompiled from Move bytecode v6
}

