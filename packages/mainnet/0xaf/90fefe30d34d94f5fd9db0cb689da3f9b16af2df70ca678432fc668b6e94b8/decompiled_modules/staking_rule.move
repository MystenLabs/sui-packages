module 0xaf90fefe30d34d94f5fd9db0cb689da3f9b16af2df70ca678432fc668b6e94b8::staking_rule {
    struct StakingRule has drop {
        dummy_field: bool,
    }

    struct Config has drop, store {
        nest_registry: address,
    }

    struct StakingProof has drop {
        nest_registry_addr: address,
    }

    public fun has_rule<T0>(arg0: &0x2::transfer_policy::TransferPolicy<T0>) : bool {
        0x2::transfer_policy::has_rule<T0, StakingRule>(arg0)
    }

    public fun add<T0>(arg0: &mut 0x2::transfer_policy::TransferPolicy<T0>, arg1: &0x2::transfer_policy::TransferPolicyCap<T0>, arg2: address) {
        let v0 = StakingRule{dummy_field: false};
        let v1 = Config{nest_registry: arg2};
        0x2::transfer_policy::add_rule<T0, StakingRule, Config>(v0, arg0, arg1, v1);
    }

    public(friend) fun create_proof(arg0: address) : StakingProof {
        StakingProof{nest_registry_addr: arg0}
    }

    public fun get_nest_registry<T0>(arg0: &0x2::transfer_policy::TransferPolicy<T0>) : address {
        let v0 = StakingRule{dummy_field: false};
        0x2::transfer_policy::get_rule<T0, StakingRule, Config>(v0, arg0).nest_registry
    }

    public fun prove<T0>(arg0: &0x2::transfer_policy::TransferPolicy<T0>, arg1: &mut 0x2::transfer_policy::TransferRequest<T0>, arg2: StakingProof) {
        let v0 = StakingRule{dummy_field: false};
        let StakingProof { nest_registry_addr: v1 } = arg2;
        assert!(v1 == 0x2::transfer_policy::get_rule<T0, StakingRule, Config>(v0, arg0).nest_registry, 1);
        let v2 = StakingRule{dummy_field: false};
        0x2::transfer_policy::add_receipt<T0, StakingRule>(v2, arg1);
    }

    public fun remove<T0>(arg0: &mut 0x2::transfer_policy::TransferPolicy<T0>, arg1: &0x2::transfer_policy::TransferPolicyCap<T0>) {
        0x2::transfer_policy::remove_rule<T0, StakingRule, Config>(arg0, arg1);
    }

    // decompiled from Move bytecode v6
}

