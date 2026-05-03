module 0xaa682664f419d51af5071ed0449dffbcf3a417fd12961d916b1a433542e9478d::access_control_init_actions {
    struct LockAction has copy, drop, store {
        expected_id: 0x2::object::ID,
        resource_name: 0x1::string::String,
    }

    struct UnlockToResourcesAction has copy, drop, store {
        expected_id: 0x2::object::ID,
        resource_name: 0x1::string::String,
    }

    public fun add_lock_spec<T0>(arg0: &mut 0xaa682664f419d51af5071ed0449dffbcf3a417fd12961d916b1a433542e9478d::action_spec_builder::Builder, arg1: 0x2::object::ID, arg2: 0x1::string::String) {
        let v0 = LockAction{
            expected_id   : arg1,
            resource_name : arg2,
        };
        0xaa682664f419d51af5071ed0449dffbcf3a417fd12961d916b1a433542e9478d::action_spec_builder::add(arg0, 0xf6ef484a0867ccffe219fa1f4648e58f8c3fd04a4ddcfb318a27f9cc6d2f3d9::intents::new_action_spec<0xaa682664f419d51af5071ed0449dffbcf3a417fd12961d916b1a433542e9478d::access_control::AccessControlLock<T0>>(0xaa682664f419d51af5071ed0449dffbcf3a417fd12961d916b1a433542e9478d::access_control::access_control_lock<T0>(), 0x2::bcs::to_bytes<LockAction>(&v0), 1));
    }

    public fun add_unlock_to_resources_spec<T0>(arg0: &mut 0xaa682664f419d51af5071ed0449dffbcf3a417fd12961d916b1a433542e9478d::action_spec_builder::Builder, arg1: 0x2::object::ID, arg2: 0x1::string::String) {
        let v0 = UnlockToResourcesAction{
            expected_id   : arg1,
            resource_name : arg2,
        };
        0xaa682664f419d51af5071ed0449dffbcf3a417fd12961d916b1a433542e9478d::action_spec_builder::add(arg0, 0xf6ef484a0867ccffe219fa1f4648e58f8c3fd04a4ddcfb318a27f9cc6d2f3d9::intents::new_action_spec<0xaa682664f419d51af5071ed0449dffbcf3a417fd12961d916b1a433542e9478d::access_control::AccessControlUnlockToResources<T0>>(0xaa682664f419d51af5071ed0449dffbcf3a417fd12961d916b1a433542e9478d::access_control::access_control_unlock_to_resources<T0>(), 0x2::bcs::to_bytes<UnlockToResourcesAction>(&v0), 1));
    }

    // decompiled from Move bytecode v6
}

