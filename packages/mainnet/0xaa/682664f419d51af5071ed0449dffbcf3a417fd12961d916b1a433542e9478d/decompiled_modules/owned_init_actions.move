module 0xaa682664f419d51af5071ed0449dffbcf3a417fd12961d916b1a433542e9478d::owned_init_actions {
    struct WithdrawObjectAction has copy, drop, store {
        object_id: 0x2::object::ID,
        resource_name: 0x1::string::String,
    }

    struct ProvideObjectAction has copy, drop, store {
        object_id: 0x2::object::ID,
        resource_name: 0x1::string::String,
    }

    public fun add_provide_object_spec<T0: store + key>(arg0: &mut 0xaa682664f419d51af5071ed0449dffbcf3a417fd12961d916b1a433542e9478d::action_spec_builder::Builder, arg1: 0x2::object::ID, arg2: 0x1::string::String) {
        assert!(0x1::string::length(&arg2) > 0, 1);
        let v0 = ProvideObjectAction{
            object_id     : arg1,
            resource_name : arg2,
        };
        0xaa682664f419d51af5071ed0449dffbcf3a417fd12961d916b1a433542e9478d::action_spec_builder::add(arg0, 0xf6ef484a0867ccffe219fa1f4648e58f8c3fd04a4ddcfb318a27f9cc6d2f3d9::intents::new_action_spec<0xf6ef484a0867ccffe219fa1f4648e58f8c3fd04a4ddcfb318a27f9cc6d2f3d9::owned::ProvideObjectToResources<T0>>(0xf6ef484a0867ccffe219fa1f4648e58f8c3fd04a4ddcfb318a27f9cc6d2f3d9::owned::provide_object_to_resources<T0>(), 0x2::bcs::to_bytes<ProvideObjectAction>(&v0), 1));
    }

    public fun add_withdraw_object_spec<T0: store + key>(arg0: &mut 0xaa682664f419d51af5071ed0449dffbcf3a417fd12961d916b1a433542e9478d::action_spec_builder::Builder, arg1: 0x2::object::ID, arg2: 0x1::string::String) {
        assert!(0x1::string::length(&arg2) > 0, 1);
        let v0 = WithdrawObjectAction{
            object_id     : arg1,
            resource_name : arg2,
        };
        0xaa682664f419d51af5071ed0449dffbcf3a417fd12961d916b1a433542e9478d::action_spec_builder::add(arg0, 0xf6ef484a0867ccffe219fa1f4648e58f8c3fd04a4ddcfb318a27f9cc6d2f3d9::intents::new_action_spec<0xf6ef484a0867ccffe219fa1f4648e58f8c3fd04a4ddcfb318a27f9cc6d2f3d9::owned::OwnedWithdrawObject<T0>>(0xf6ef484a0867ccffe219fa1f4648e58f8c3fd04a4ddcfb318a27f9cc6d2f3d9::owned::owned_withdraw_object<T0>(), 0x2::bcs::to_bytes<WithdrawObjectAction>(&v0), 1));
    }

    // decompiled from Move bytecode v6
}

