module 0x15117aa7c866b990c78a4d91ffaaf7f702ba6eef56ff5f97fd68139ee720f758::staking_rule {
    struct Rule has drop {
        dummy_field: bool,
    }

    struct Config has drop, store {
        nest_registry: address,
    }

    struct StakingProof has drop {
        nest_registry: address,
    }

    public fun add<T0>(arg0: &mut 0x2::transfer_policy::TransferPolicy<T0>, arg1: &0x2::transfer_policy::TransferPolicyCap<T0>, arg2: address) {
        let v0 = Rule{dummy_field: false};
        let v1 = Config{nest_registry: arg2};
        0x2::transfer_policy::add_rule<T0, Rule, Config>(v0, arg0, arg1, v1);
    }

    public fun create_proof(arg0: address) : StakingProof {
        StakingProof{nest_registry: arg0}
    }

    public fun prove<T0>(arg0: &0x2::transfer_policy::TransferPolicy<T0>, arg1: &mut 0x2::transfer_policy::TransferRequest<T0>, arg2: StakingProof) {
        let v0 = Rule{dummy_field: false};
        let StakingProof { nest_registry: v1 } = arg2;
        assert!(v1 == 0x2::transfer_policy::get_rule<T0, Rule, Config>(v0, arg0).nest_registry, 0);
        let v2 = Rule{dummy_field: false};
        0x2::transfer_policy::add_receipt<T0, Rule>(v2, arg1);
    }

    public fun update_nest_registry<T0>(arg0: &mut 0x2::transfer_policy::TransferPolicy<T0>, arg1: &0x2::transfer_policy::TransferPolicyCap<T0>, arg2: address) {
        0x2::transfer_policy::remove_rule<T0, Rule, Config>(arg0, arg1);
        let v0 = Rule{dummy_field: false};
        let v1 = Config{nest_registry: arg2};
        0x2::transfer_policy::add_rule<T0, Rule, Config>(v0, arg0, arg1, v1);
    }

    // decompiled from Move bytecode v6
}

