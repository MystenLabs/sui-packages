module 0xaa682664f419d51af5071ed0449dffbcf3a417fd12961d916b1a433542e9478d::transfer_init_actions {
    struct TransferObjectAction has copy, drop, store {
        recipient: address,
        resource_name: 0x1::string::String,
    }

    struct TransferToSenderAction has copy, drop, store {
        resource_name: 0x1::string::String,
    }

    struct TransferCoinAction has copy, drop, store {
        recipient: address,
        resource_name: 0x1::string::String,
    }

    struct TransferCoinToSenderAction has copy, drop, store {
        resource_name: 0x1::string::String,
    }

    public fun add_transfer_coin_spec<T0>(arg0: &mut 0xaa682664f419d51af5071ed0449dffbcf3a417fd12961d916b1a433542e9478d::action_spec_builder::Builder, arg1: address, arg2: 0x1::string::String) {
        assert!(0x1::string::length(&arg2) > 0, 1);
        assert!(has_prior_resource_reference(arg0, &arg2), 3);
        let v0 = TransferCoinAction{
            recipient     : arg1,
            resource_name : arg2,
        };
        0xaa682664f419d51af5071ed0449dffbcf3a417fd12961d916b1a433542e9478d::action_spec_builder::add(arg0, 0xf6ef484a0867ccffe219fa1f4648e58f8c3fd04a4ddcfb318a27f9cc6d2f3d9::intents::new_action_spec<0xaa682664f419d51af5071ed0449dffbcf3a417fd12961d916b1a433542e9478d::transfer::TransferCoin<T0>>(0xaa682664f419d51af5071ed0449dffbcf3a417fd12961d916b1a433542e9478d::transfer::transfer_coin<T0>(), 0x2::bcs::to_bytes<TransferCoinAction>(&v0), 1));
    }

    public fun add_transfer_coin_to_sender_spec<T0>(arg0: &mut 0xaa682664f419d51af5071ed0449dffbcf3a417fd12961d916b1a433542e9478d::action_spec_builder::Builder, arg1: 0x1::string::String) {
        assert!(0x1::string::length(&arg1) > 0, 1);
        assert!(has_prior_resource_reference(arg0, &arg1), 3);
        let v0 = TransferCoinToSenderAction{resource_name: arg1};
        0xaa682664f419d51af5071ed0449dffbcf3a417fd12961d916b1a433542e9478d::action_spec_builder::add(arg0, 0xf6ef484a0867ccffe219fa1f4648e58f8c3fd04a4ddcfb318a27f9cc6d2f3d9::intents::new_action_spec<0xaa682664f419d51af5071ed0449dffbcf3a417fd12961d916b1a433542e9478d::transfer::TransferCoinToSender<T0>>(0xaa682664f419d51af5071ed0449dffbcf3a417fd12961d916b1a433542e9478d::transfer::transfer_coin_to_sender<T0>(), 0x2::bcs::to_bytes<TransferCoinToSenderAction>(&v0), 1));
    }

    public fun add_transfer_object_spec<T0: store + key>(arg0: &mut 0xaa682664f419d51af5071ed0449dffbcf3a417fd12961d916b1a433542e9478d::action_spec_builder::Builder, arg1: address, arg2: 0x1::string::String) {
        assert!(0x1::string::length(&arg2) > 0, 1);
        assert!(has_prior_resource_reference(arg0, &arg2), 3);
        let v0 = TransferObjectAction{
            recipient     : arg1,
            resource_name : arg2,
        };
        0xaa682664f419d51af5071ed0449dffbcf3a417fd12961d916b1a433542e9478d::action_spec_builder::add(arg0, 0xf6ef484a0867ccffe219fa1f4648e58f8c3fd04a4ddcfb318a27f9cc6d2f3d9::intents::new_action_spec<0xaa682664f419d51af5071ed0449dffbcf3a417fd12961d916b1a433542e9478d::transfer::TransferObject<T0>>(0xaa682664f419d51af5071ed0449dffbcf3a417fd12961d916b1a433542e9478d::transfer::transfer_object<T0>(), 0x2::bcs::to_bytes<TransferObjectAction>(&v0), 1));
    }

    public fun add_transfer_to_sender_spec<T0: store + key>(arg0: &mut 0xaa682664f419d51af5071ed0449dffbcf3a417fd12961d916b1a433542e9478d::action_spec_builder::Builder, arg1: 0x1::string::String) {
        assert!(0x1::string::length(&arg1) > 0, 1);
        assert!(has_prior_resource_reference(arg0, &arg1), 3);
        let v0 = TransferToSenderAction{resource_name: arg1};
        0xaa682664f419d51af5071ed0449dffbcf3a417fd12961d916b1a433542e9478d::action_spec_builder::add(arg0, 0xf6ef484a0867ccffe219fa1f4648e58f8c3fd04a4ddcfb318a27f9cc6d2f3d9::intents::new_action_spec<0xaa682664f419d51af5071ed0449dffbcf3a417fd12961d916b1a433542e9478d::transfer::TransferToSender<T0>>(0xaa682664f419d51af5071ed0449dffbcf3a417fd12961d916b1a433542e9478d::transfer::transfer_to_sender<T0>(), 0x2::bcs::to_bytes<TransferToSenderAction>(&v0), 1));
    }

    fun contains_subsequence(arg0: &vector<u8>, arg1: &vector<u8>) : bool {
        let v0 = 0x1::vector::length<u8>(arg0);
        let v1 = 0x1::vector::length<u8>(arg1);
        if (v1 == 0 || v1 > v0) {
            return false
        };
        let v2 = 0;
        while (v2 + v1 <= v0) {
            let v3 = 0;
            let v4 = true;
            while (v3 < v1) {
                if (*0x1::vector::borrow<u8>(arg0, v2 + v3) != *0x1::vector::borrow<u8>(arg1, v3)) {
                    v4 = false;
                    break
                };
                v3 = v3 + 1;
            };
            if (v4) {
                return true
            };
            v2 = v2 + 1;
        };
        false
    }

    fun has_prior_resource_reference(arg0: &0xaa682664f419d51af5071ed0449dffbcf3a417fd12961d916b1a433542e9478d::action_spec_builder::Builder, arg1: &0x1::string::String) : bool {
        let v0 = 0x2::bcs::to_bytes<0x1::string::String>(arg1);
        let v1 = 0xaa682664f419d51af5071ed0449dffbcf3a417fd12961d916b1a433542e9478d::action_spec_builder::specs(arg0);
        let v2 = 0;
        while (v2 < 0x1::vector::length<0xf6ef484a0867ccffe219fa1f4648e58f8c3fd04a4ddcfb318a27f9cc6d2f3d9::intents::ActionSpec>(v1)) {
            if (contains_subsequence(0xf6ef484a0867ccffe219fa1f4648e58f8c3fd04a4ddcfb318a27f9cc6d2f3d9::intents::action_spec_data(0x1::vector::borrow<0xf6ef484a0867ccffe219fa1f4648e58f8c3fd04a4ddcfb318a27f9cc6d2f3d9::intents::ActionSpec>(v1, v2)), &v0)) {
                return true
            };
            v2 = v2 + 1;
        };
        false
    }

    // decompiled from Move bytecode v6
}

