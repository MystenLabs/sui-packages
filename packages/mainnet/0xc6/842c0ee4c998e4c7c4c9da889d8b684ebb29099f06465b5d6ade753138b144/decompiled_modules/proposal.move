module 0xc6842c0ee4c998e4c7c4c9da889d8b684ebb29099f06465b5d6ade753138b144::proposal {
    struct ProposalDesc has store {
        description: 0x1::ascii::String,
        vote_porposal: vector<address>,
    }

    struct Certificate has drop, store {
        dummy_field: bool,
    }

    public fun commit_upgrade(arg0: &mut 0x231d0ed62482f321f446dfc0ba02e01ca620df870da4c313b11e9cb4d0621d89::genesis::GovernanceGenesis, arg1: 0x2::package::UpgradeReceipt) {
        0x231d0ed62482f321f446dfc0ba02e01ca620df870da4c313b11e9cb4d0621d89::genesis::commit_upgrade(arg0, arg1);
    }

    public entry fun add_description_for_proposal(arg0: &mut 0x231d0ed62482f321f446dfc0ba02e01ca620df870da4c313b11e9cb4d0621d89::governance_v1::Proposal<Certificate>, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x1::vector::empty<address>();
        0x1::vector::push_back<address>(&mut v0, 0x2::address::from_bytes(x"79d7106ea18373fc7542b0849d5ebefc3a9daf8b664a4f82d9b35bbd0c22042d"));
        let v1 = 0x2::object::id<0x231d0ed62482f321f446dfc0ba02e01ca620df870da4c313b11e9cb4d0621d89::governance_v1::Proposal<Certificate>>(arg0);
        0x1::vector::push_back<address>(&mut v0, 0x2::object::id_to_address(&v1));
        let v2 = ProposalDesc{
            description   : 0x1::ascii::string(b"Upgrade version from v_1_1_0 to v_1_1_1"),
            vote_porposal : v0,
        };
        0x231d0ed62482f321f446dfc0ba02e01ca620df870da4c313b11e9cb4d0621d89::governance_v1::add_description_for_proposal<Certificate, ProposalDesc>(arg0, v2, arg1);
    }

    public entry fun create_proposal(arg0: &mut 0x231d0ed62482f321f446dfc0ba02e01ca620df870da4c313b11e9cb4d0621d89::governance_v1::GovernanceInfo, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = Certificate{dummy_field: false};
        0x231d0ed62482f321f446dfc0ba02e01ca620df870da4c313b11e9cb4d0621d89::governance_v1::create_proposal_with_history<Certificate>(arg0, v0, arg1);
    }

    public entry fun registe_new_feed(arg0: &mut 0x231d0ed62482f321f446dfc0ba02e01ca620df870da4c313b11e9cb4d0621d89::governance_v1::GovernanceInfo, arg1: &mut 0x231d0ed62482f321f446dfc0ba02e01ca620df870da4c313b11e9cb4d0621d89::oracle::PriceOracle, arg2: &mut 0x231d0ed62482f321f446dfc0ba02e01ca620df870da4c313b11e9cb4d0621d89::governance_v1::Proposal<Certificate>, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = Certificate{dummy_field: false};
        let v1 = 0x231d0ed62482f321f446dfc0ba02e01ca620df870da4c313b11e9cb4d0621d89::governance_v1::vote_proposal<Certificate>(arg0, v0, arg2, true, arg4);
        if (0x1::option::is_some<0x231d0ed62482f321f446dfc0ba02e01ca620df870da4c313b11e9cb4d0621d89::genesis::GovernanceCap>(&v1)) {
            let v2 = 0x1::option::extract<0x231d0ed62482f321f446dfc0ba02e01ca620df870da4c313b11e9cb4d0621d89::genesis::GovernanceCap>(&mut v1);
            0x231d0ed62482f321f446dfc0ba02e01ca620df870da4c313b11e9cb4d0621d89::oracle::register_token_price(&v2, arg1, x"e62df6c8b4a85fe1a67db44dc12de5db330f7ac66b72dc658afedf0f4a415b43", 0, 0, 0, arg3);
            0x231d0ed62482f321f446dfc0ba02e01ca620df870da4c313b11e9cb4d0621d89::oracle::register_token_price(&v2, arg1, x"2b89b9dc8fdf9f34709a5b106b472f0f39bb6ca9ce04b0fd7f2e971688e2e53b", 1, 0, 0, arg3);
            0x231d0ed62482f321f446dfc0ba02e01ca620df870da4c313b11e9cb4d0621d89::oracle::register_token_price(&v2, arg1, x"eaa020c61cc479712813461ce153894a96a6c00b21ed0cfc2798d1f9a9e9c94a", 2, 0, 0, arg3);
            0x231d0ed62482f321f446dfc0ba02e01ca620df870da4c313b11e9cb4d0621d89::oracle::register_token_price(&v2, arg1, x"23d7315113f5b1d3ba7a83604c44b94d79f4fd69af77f804fc7f920a6dc65744", 3, 0, 0, arg3);
            0x231d0ed62482f321f446dfc0ba02e01ca620df870da4c313b11e9cb4d0621d89::oracle::register_token_price(&v2, arg1, x"ff61491a931112ddf1bd8147cd1b641375f79f5825126d665480874634fd0ace", 4, 0, 0, arg3);
            0x231d0ed62482f321f446dfc0ba02e01ca620df870da4c313b11e9cb4d0621d89::oracle::register_token_price(&v2, arg1, x"5de33a9112c2b700b8d30b8a3402c103578ccfa2765696471cc672bd5cf6ac52", 5, 0, 0, arg3);
            0x231d0ed62482f321f446dfc0ba02e01ca620df870da4c313b11e9cb4d0621d89::oracle::register_token_price(&v2, arg1, x"3fa4252848f9f0a1480be62745a4629d9eb1322aebab8a791e344b3b9c1adcf5", 6, 0, 0, arg3);
            0x231d0ed62482f321f446dfc0ba02e01ca620df870da4c313b11e9cb4d0621d89::oracle::register_token_price(&v2, arg1, x"385f64d993f7b77d8182ed5003d97c60aa3361f3cecfe711544d2d59165e9bdf", 7, 0, 0, arg3);
            0x231d0ed62482f321f446dfc0ba02e01ca620df870da4c313b11e9cb4d0621d89::oracle::register_token_price(&v2, arg1, x"eaa020c61cc479712813461ce153894a96a6c00b21ed0cfc2798d1f9a9e9c94a", 8, 0, 0, arg3);
            0x231d0ed62482f321f446dfc0ba02e01ca620df870da4c313b11e9cb4d0621d89::oracle::register_token_price(&v2, arg1, x"93da3352f9f1d105fdfe4971cfa80e9dd777bfc5d0f683ebb6e1294b92137bb7", 9, 0, 0, arg3);
            0x231d0ed62482f321f446dfc0ba02e01ca620df870da4c313b11e9cb4d0621d89::oracle::register_token_price(&v2, arg1, x"2f95862b045670cd22bee3114c39763a4a08beeb663b145d283c31d7d1101c4f", 10, 0, 0, arg3);
            0x231d0ed62482f321f446dfc0ba02e01ca620df870da4c313b11e9cb4d0621d89::governance_v1::destroy_governance_cap(v2);
        };
        0x1::option::destroy_none<0x231d0ed62482f321f446dfc0ba02e01ca620df870da4c313b11e9cb4d0621d89::genesis::GovernanceCap>(v1);
    }

    public entry fun vote_porposal(arg0: &0x231d0ed62482f321f446dfc0ba02e01ca620df870da4c313b11e9cb4d0621d89::governance_v1::GovernanceInfo, arg1: &mut 0x231d0ed62482f321f446dfc0ba02e01ca620df870da4c313b11e9cb4d0621d89::governance_v1::Proposal<Certificate>, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = Certificate{dummy_field: false};
        let v1 = 0x231d0ed62482f321f446dfc0ba02e01ca620df870da4c313b11e9cb4d0621d89::governance_v1::vote_proposal<Certificate>(arg0, v0, arg1, true, arg2);
        assert!(0x1::option::is_none<0x231d0ed62482f321f446dfc0ba02e01ca620df870da4c313b11e9cb4d0621d89::genesis::GovernanceCap>(&v1), 0);
        0x1::option::destroy_none<0x231d0ed62482f321f446dfc0ba02e01ca620df870da4c313b11e9cb4d0621d89::genesis::GovernanceCap>(v1);
    }

    public fun vote_proposal_final(arg0: &0x231d0ed62482f321f446dfc0ba02e01ca620df870da4c313b11e9cb4d0621d89::governance_v1::GovernanceInfo, arg1: &mut 0x231d0ed62482f321f446dfc0ba02e01ca620df870da4c313b11e9cb4d0621d89::governance_v1::Proposal<Certificate>, arg2: &mut 0x231d0ed62482f321f446dfc0ba02e01ca620df870da4c313b11e9cb4d0621d89::genesis::GovernanceGenesis, arg3: &mut 0x2::tx_context::TxContext) : 0x2::package::UpgradeTicket {
        let v0 = Certificate{dummy_field: false};
        let v1 = 0x231d0ed62482f321f446dfc0ba02e01ca620df870da4c313b11e9cb4d0621d89::governance_v1::vote_proposal<Certificate>(arg0, v0, arg1, true, arg3);
        assert!(0x1::option::is_some<0x231d0ed62482f321f446dfc0ba02e01ca620df870da4c313b11e9cb4d0621d89::genesis::GovernanceCap>(&v1), 0);
        let v2 = 0x1::option::extract<0x231d0ed62482f321f446dfc0ba02e01ca620df870da4c313b11e9cb4d0621d89::genesis::GovernanceCap>(&mut v1);
        0x231d0ed62482f321f446dfc0ba02e01ca620df870da4c313b11e9cb4d0621d89::governance_v1::destroy_governance_cap(v2);
        0x1::option::destroy_none<0x231d0ed62482f321f446dfc0ba02e01ca620df870da4c313b11e9cb4d0621d89::genesis::GovernanceCap>(v1);
        0x231d0ed62482f321f446dfc0ba02e01ca620df870da4c313b11e9cb4d0621d89::genesis::authorize_upgrade(&v2, arg2, 0, x"c64fb5bb3b764668282be2fcc2550dc4671b1ca5a245a09044ff4e80a93b498e")
    }

    // decompiled from Move bytecode v6
}

