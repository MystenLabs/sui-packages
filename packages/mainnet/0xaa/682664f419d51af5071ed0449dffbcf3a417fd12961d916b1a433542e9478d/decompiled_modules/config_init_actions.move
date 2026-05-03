module 0xaa682664f419d51af5071ed0449dffbcf3a417fd12961d916b1a433542e9478d::config_init_actions {
    struct SetAuthorizationLevelAction has copy, drop, store {
        level: u8,
    }

    struct AddDepAction has copy, drop, store {
        addr: address,
        name: 0x1::string::String,
        version: u64,
    }

    struct RemoveDepAction has copy, drop, store {
        addr: address,
    }

    public fun add_add_dep_spec(arg0: &mut 0xaa682664f419d51af5071ed0449dffbcf3a417fd12961d916b1a433542e9478d::action_spec_builder::Builder, arg1: address, arg2: 0x1::string::String, arg3: u64) {
        assert!(0x1::string::length(&arg2) > 0, 2);
        assert!(arg1 != @0x0, 3);
        let v0 = AddDepAction{
            addr    : arg1,
            name    : arg2,
            version : arg3,
        };
        let v1 = 0x2::bcs::to_bytes<AddDepAction>(&v0);
        assert!(0x1::vector::length<u8>(&v1) <= 0xf6ef484a0867ccffe219fa1f4648e58f8c3fd04a4ddcfb318a27f9cc6d2f3d9::constants::max_action_data_size(), 4);
        0xaa682664f419d51af5071ed0449dffbcf3a417fd12961d916b1a433542e9478d::action_spec_builder::add(arg0, 0xf6ef484a0867ccffe219fa1f4648e58f8c3fd04a4ddcfb318a27f9cc6d2f3d9::intents::new_action_spec<0xf6ef484a0867ccffe219fa1f4648e58f8c3fd04a4ddcfb318a27f9cc6d2f3d9::config::ConfigAddDep>(0xf6ef484a0867ccffe219fa1f4648e58f8c3fd04a4ddcfb318a27f9cc6d2f3d9::config::config_add_dep(), v1, 1));
    }

    public fun add_remove_dep_spec(arg0: &mut 0xaa682664f419d51af5071ed0449dffbcf3a417fd12961d916b1a433542e9478d::action_spec_builder::Builder, arg1: address) {
        let v0 = RemoveDepAction{addr: arg1};
        0xaa682664f419d51af5071ed0449dffbcf3a417fd12961d916b1a433542e9478d::action_spec_builder::add(arg0, 0xf6ef484a0867ccffe219fa1f4648e58f8c3fd04a4ddcfb318a27f9cc6d2f3d9::intents::new_action_spec<0xf6ef484a0867ccffe219fa1f4648e58f8c3fd04a4ddcfb318a27f9cc6d2f3d9::config::ConfigRemoveDep>(0xf6ef484a0867ccffe219fa1f4648e58f8c3fd04a4ddcfb318a27f9cc6d2f3d9::config::config_remove_dep(), 0x2::bcs::to_bytes<RemoveDepAction>(&v0), 1));
    }

    public fun add_set_authorization_level_spec(arg0: &mut 0xaa682664f419d51af5071ed0449dffbcf3a417fd12961d916b1a433542e9478d::action_spec_builder::Builder, arg1: u8) {
        assert!(arg1 <= 2, 1);
        let v0 = SetAuthorizationLevelAction{level: arg1};
        0xaa682664f419d51af5071ed0449dffbcf3a417fd12961d916b1a433542e9478d::action_spec_builder::add(arg0, 0xf6ef484a0867ccffe219fa1f4648e58f8c3fd04a4ddcfb318a27f9cc6d2f3d9::intents::new_action_spec<0xf6ef484a0867ccffe219fa1f4648e58f8c3fd04a4ddcfb318a27f9cc6d2f3d9::config::ConfigSetAuthorizationLevel>(0xf6ef484a0867ccffe219fa1f4648e58f8c3fd04a4ddcfb318a27f9cc6d2f3d9::config::config_set_authorization_level(), 0x2::bcs::to_bytes<SetAuthorizationLevelAction>(&v0), 1));
    }

    // decompiled from Move bytecode v6
}

