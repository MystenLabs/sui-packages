module 0x632753c0a4f817afa1a042c91b8970519983c07cfeb0dba2b7f822413539f71d::transfer_rule {
    struct TransferRule has drop {
        dummy_field: bool,
    }

    struct Config has drop, store {
        royalty_bps: u16,
        min_royalty: u64,
        nest_registry: address,
    }

    struct StakingProof has drop {
        nest_registry_addr: address,
    }

    public fun has_rule<T0>(arg0: &0x2::transfer_policy::TransferPolicy<T0>) : bool {
        0x2::transfer_policy::has_rule<T0, TransferRule>(arg0)
    }

    public fun add<T0>(arg0: &mut 0x2::transfer_policy::TransferPolicy<T0>, arg1: &0x2::transfer_policy::TransferPolicyCap<T0>, arg2: u16, arg3: u64, arg4: address) {
        assert!(arg2 <= 10000, 2);
        let v0 = TransferRule{dummy_field: false};
        let v1 = Config{
            royalty_bps   : arg2,
            min_royalty   : arg3,
            nest_registry : arg4,
        };
        0x2::transfer_policy::add_rule<T0, TransferRule, Config>(v0, arg0, arg1, v1);
    }

    public fun calculate_royalty<T0>(arg0: &0x2::transfer_policy::TransferPolicy<T0>, arg1: u64) : u64 {
        let v0 = TransferRule{dummy_field: false};
        let v1 = 0x2::transfer_policy::get_rule<T0, TransferRule, Config>(v0, arg0);
        let v2 = (((arg1 as u128) * (v1.royalty_bps as u128) / 10000) as u64);
        let v3 = v2;
        if (v2 < v1.min_royalty) {
            v3 = v1.min_royalty;
        };
        v3
    }

    public(friend) fun create_proof(arg0: address) : StakingProof {
        StakingProof{nest_registry_addr: arg0}
    }

    public fun get_nest_registry<T0>(arg0: &0x2::transfer_policy::TransferPolicy<T0>) : address {
        let v0 = TransferRule{dummy_field: false};
        0x2::transfer_policy::get_rule<T0, TransferRule, Config>(v0, arg0).nest_registry
    }

    public fun get_royalty_config<T0>(arg0: &0x2::transfer_policy::TransferPolicy<T0>) : (u16, u64) {
        let v0 = TransferRule{dummy_field: false};
        let v1 = 0x2::transfer_policy::get_rule<T0, TransferRule, Config>(v0, arg0);
        (v1.royalty_bps, v1.min_royalty)
    }

    public fun pay<T0>(arg0: &mut 0x2::transfer_policy::TransferPolicy<T0>, arg1: &mut 0x2::transfer_policy::TransferRequest<T0>, arg2: &mut 0x2::coin::Coin<0x2::sui::SUI>, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = TransferRule{dummy_field: false};
        let v1 = 0x2::transfer_policy::get_rule<T0, TransferRule, Config>(v0, arg0);
        let v2 = 0x2::transfer_policy::paid<T0>(arg1);
        let v3 = (((v2 as u128) * (v1.royalty_bps as u128) / 10000) as u64);
        let v4 = v3;
        if (v3 < v1.min_royalty) {
            v4 = v1.min_royalty;
        };
        if (v2 == 0) {
            v4 = 0;
        };
        if (v4 > 0) {
            assert!(0x2::coin::value<0x2::sui::SUI>(arg2) >= v4, 1);
            let v5 = TransferRule{dummy_field: false};
            0x2::transfer_policy::add_to_balance<T0, TransferRule>(v5, arg0, 0x2::coin::split<0x2::sui::SUI>(arg2, v4, arg3));
        };
        let v6 = TransferRule{dummy_field: false};
        0x2::transfer_policy::add_receipt<T0, TransferRule>(v6, arg1);
    }

    public fun prove_staking<T0>(arg0: &0x2::transfer_policy::TransferPolicy<T0>, arg1: &mut 0x2::transfer_policy::TransferRequest<T0>, arg2: StakingProof) {
        let v0 = TransferRule{dummy_field: false};
        let StakingProof { nest_registry_addr: v1 } = arg2;
        assert!(v1 == 0x2::transfer_policy::get_rule<T0, TransferRule, Config>(v0, arg0).nest_registry, 3);
        let v2 = TransferRule{dummy_field: false};
        0x2::transfer_policy::add_receipt<T0, TransferRule>(v2, arg1);
    }

    public fun remove<T0>(arg0: &mut 0x2::transfer_policy::TransferPolicy<T0>, arg1: &0x2::transfer_policy::TransferPolicyCap<T0>) {
        0x2::transfer_policy::remove_rule<T0, TransferRule, Config>(arg0, arg1);
    }

    public fun update_royalty<T0>(arg0: &mut 0x2::transfer_policy::TransferPolicy<T0>, arg1: &0x2::transfer_policy::TransferPolicyCap<T0>, arg2: u16, arg3: u64, arg4: address) {
        remove<T0>(arg0, arg1);
        add<T0>(arg0, arg1, arg2, arg3, arg4);
    }

    // decompiled from Move bytecode v6
}

