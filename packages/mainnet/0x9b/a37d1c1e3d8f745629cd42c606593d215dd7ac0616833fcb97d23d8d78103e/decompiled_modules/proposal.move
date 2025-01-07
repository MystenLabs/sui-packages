module 0x9ba37d1c1e3d8f745629cd42c606593d215dd7ac0616833fcb97d23d8d78103e::proposal {
    struct ProposalDesc has store {
        description: 0x1::ascii::String,
        vote_porposal: vector<address>,
    }

    struct Certificate has drop, store {
        dummy_field: bool,
    }

    public entry fun add_description_for_proposal(arg0: &mut 0xbc7259cfb37020c8c4d32e516498acaa1b02ef960ca8b45db22a5cf74dc2973f::governance_v1::Proposal<Certificate>, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x1::vector::empty<address>();
        0x1::vector::push_back<address>(&mut v0, 0x2::address::from_bytes(x"79d7106ea18373fc7542b0849d5ebefc3a9daf8b664a4f82d9b35bbd0c22042d"));
        let v1 = 0x2::object::id<0xbc7259cfb37020c8c4d32e516498acaa1b02ef960ca8b45db22a5cf74dc2973f::governance_v1::Proposal<Certificate>>(arg0);
        0x1::vector::push_back<address>(&mut v0, 0x2::object::id_to_address(&v1));
        let v2 = ProposalDesc{
            description   : 0x1::ascii::string(b"Upgrade version from v_1_1_0 to v_1_1_1"),
            vote_porposal : v0,
        };
        0xbc7259cfb37020c8c4d32e516498acaa1b02ef960ca8b45db22a5cf74dc2973f::governance_v1::add_description_for_proposal<Certificate, ProposalDesc>(arg0, v2, arg1);
    }

    public fun commit_upgrade(arg0: &mut 0xbc7259cfb37020c8c4d32e516498acaa1b02ef960ca8b45db22a5cf74dc2973f::genesis::GovernanceGenesis, arg1: 0x2::package::UpgradeReceipt) {
        0xbc7259cfb37020c8c4d32e516498acaa1b02ef960ca8b45db22a5cf74dc2973f::genesis::commit_upgrade(arg0, arg1);
    }

    public entry fun create_proposal(arg0: &mut 0xbc7259cfb37020c8c4d32e516498acaa1b02ef960ca8b45db22a5cf74dc2973f::governance_v1::GovernanceInfo, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = Certificate{dummy_field: false};
        0xbc7259cfb37020c8c4d32e516498acaa1b02ef960ca8b45db22a5cf74dc2973f::governance_v1::create_proposal_with_history<Certificate>(arg0, v0, arg1);
    }

    public entry fun registe_new_feed(arg0: &mut 0xbc7259cfb37020c8c4d32e516498acaa1b02ef960ca8b45db22a5cf74dc2973f::governance_v1::GovernanceInfo, arg1: &mut 0xbc7259cfb37020c8c4d32e516498acaa1b02ef960ca8b45db22a5cf74dc2973f::oracle::PriceOracle, arg2: &mut 0xbc7259cfb37020c8c4d32e516498acaa1b02ef960ca8b45db22a5cf74dc2973f::governance_v1::Proposal<Certificate>, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = Certificate{dummy_field: false};
        let v1 = 0xbc7259cfb37020c8c4d32e516498acaa1b02ef960ca8b45db22a5cf74dc2973f::governance_v1::vote_proposal<Certificate>(arg0, v0, arg2, true, arg4);
        if (0x1::option::is_some<0xbc7259cfb37020c8c4d32e516498acaa1b02ef960ca8b45db22a5cf74dc2973f::genesis::GovernanceCap>(&v1)) {
            let v2 = 0x1::option::extract<0xbc7259cfb37020c8c4d32e516498acaa1b02ef960ca8b45db22a5cf74dc2973f::genesis::GovernanceCap>(&mut v1);
            0xbc7259cfb37020c8c4d32e516498acaa1b02ef960ca8b45db22a5cf74dc2973f::oracle::register_token_price(&v2, arg1, x"9a62b4863bdeaabdc9500fce769cf7e72d5585eeb28a6d26e4cafadc13f76ab2", 0, 0, 0, arg3);
            0xbc7259cfb37020c8c4d32e516498acaa1b02ef960ca8b45db22a5cf74dc2973f::oracle::register_token_price(&v2, arg1, x"985e3db9f93f76ee8bace7c3dd5cc676a096accd5d9e09e9ae0fb6e492b14572", 1, 0, 0, arg3);
            0xbc7259cfb37020c8c4d32e516498acaa1b02ef960ca8b45db22a5cf74dc2973f::oracle::register_token_price(&v2, arg1, x"5dec622733a204ca27f5a90d8c2fad453cc6665186fd5dff13a83d0b6c9027ab", 2, 0, 0, arg3);
            0xbc7259cfb37020c8c4d32e516498acaa1b02ef960ca8b45db22a5cf74dc2973f::oracle::register_token_price(&v2, arg1, x"801dbc2f0053d34734814b2d6df491ce7807a725fe9a01ad74a07e9c51396c37", 3, 0, 0, arg3);
            0xbc7259cfb37020c8c4d32e516498acaa1b02ef960ca8b45db22a5cf74dc2973f::oracle::register_token_price(&v2, arg1, x"9193fd47f9a0ab99b6e365a464c8a9ae30e6150fc37ed2a89c1586631f6fc4ab", 4, 0, 0, arg3);
            0xbc7259cfb37020c8c4d32e516498acaa1b02ef960ca8b45db22a5cf74dc2973f::oracle::register_token_price(&v2, arg1, x"5e1129a654b3024ce1061645b4d1ca731bc759e2459e7fb8ac01d4d6f9bab301", 5, 0, 0, arg3);
            0xbc7259cfb37020c8c4d32e516498acaa1b02ef960ca8b45db22a5cf74dc2973f::oracle::register_token_price(&v2, arg1, x"6e31a26e9f903db7b18919d4bdd7b7634ee890bc631bf116e6f9f24ab16f1315", 6, 0, 0, arg3);
            0xbc7259cfb37020c8c4d32e516498acaa1b02ef960ca8b45db22a5cf74dc2973f::oracle::register_token_price(&v2, arg1, x"8267a85a21bb527ad4545bc29452cca715d3a1aa8975e4ef1e77f9862c9a9244", 7, 0, 0, arg3);
            0xbc7259cfb37020c8c4d32e516498acaa1b02ef960ca8b45db22a5cf74dc2973f::oracle::register_token_price(&v2, arg1, x"5dec622733a204ca27f5a90d8c2fad453cc6665186fd5dff13a83d0b6c9027ab", 8, 0, 0, arg3);
            0xbc7259cfb37020c8c4d32e516498acaa1b02ef960ca8b45db22a5cf74dc2973f::oracle::register_token_price(&v2, arg1, x"29e37978cb1c9501bda5d7c105f24f0058bc1668637e307fbc290dba48cb918d", 9, 0, 0, arg3);
            0xbc7259cfb37020c8c4d32e516498acaa1b02ef960ca8b45db22a5cf74dc2973f::oracle::register_token_price(&v2, arg1, x"9c6e77f0ecfc46aac395e21c52ccb96518f85acacae743c5b47f4ca5e29826c3", 10, 0, 0, arg3);
            0xbc7259cfb37020c8c4d32e516498acaa1b02ef960ca8b45db22a5cf74dc2973f::governance_v1::destroy_governance_cap(v2);
        };
        0x1::option::destroy_none<0xbc7259cfb37020c8c4d32e516498acaa1b02ef960ca8b45db22a5cf74dc2973f::genesis::GovernanceCap>(v1);
    }

    public entry fun vote_porposal(arg0: &0xbc7259cfb37020c8c4d32e516498acaa1b02ef960ca8b45db22a5cf74dc2973f::governance_v1::GovernanceInfo, arg1: &mut 0xbc7259cfb37020c8c4d32e516498acaa1b02ef960ca8b45db22a5cf74dc2973f::governance_v1::Proposal<Certificate>, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = Certificate{dummy_field: false};
        let v1 = 0xbc7259cfb37020c8c4d32e516498acaa1b02ef960ca8b45db22a5cf74dc2973f::governance_v1::vote_proposal<Certificate>(arg0, v0, arg1, true, arg2);
        assert!(0x1::option::is_none<0xbc7259cfb37020c8c4d32e516498acaa1b02ef960ca8b45db22a5cf74dc2973f::genesis::GovernanceCap>(&v1), 0);
        0x1::option::destroy_none<0xbc7259cfb37020c8c4d32e516498acaa1b02ef960ca8b45db22a5cf74dc2973f::genesis::GovernanceCap>(v1);
    }

    public fun vote_proposal_final(arg0: &0xbc7259cfb37020c8c4d32e516498acaa1b02ef960ca8b45db22a5cf74dc2973f::governance_v1::GovernanceInfo, arg1: &mut 0xbc7259cfb37020c8c4d32e516498acaa1b02ef960ca8b45db22a5cf74dc2973f::governance_v1::Proposal<Certificate>, arg2: &mut 0xbc7259cfb37020c8c4d32e516498acaa1b02ef960ca8b45db22a5cf74dc2973f::genesis::GovernanceGenesis, arg3: &mut 0x2::tx_context::TxContext) : 0x2::package::UpgradeTicket {
        let v0 = Certificate{dummy_field: false};
        let v1 = 0xbc7259cfb37020c8c4d32e516498acaa1b02ef960ca8b45db22a5cf74dc2973f::governance_v1::vote_proposal<Certificate>(arg0, v0, arg1, true, arg3);
        assert!(0x1::option::is_some<0xbc7259cfb37020c8c4d32e516498acaa1b02ef960ca8b45db22a5cf74dc2973f::genesis::GovernanceCap>(&v1), 0);
        let v2 = 0x1::option::extract<0xbc7259cfb37020c8c4d32e516498acaa1b02ef960ca8b45db22a5cf74dc2973f::genesis::GovernanceCap>(&mut v1);
        0xbc7259cfb37020c8c4d32e516498acaa1b02ef960ca8b45db22a5cf74dc2973f::governance_v1::destroy_governance_cap(v2);
        0x1::option::destroy_none<0xbc7259cfb37020c8c4d32e516498acaa1b02ef960ca8b45db22a5cf74dc2973f::genesis::GovernanceCap>(v1);
        0xbc7259cfb37020c8c4d32e516498acaa1b02ef960ca8b45db22a5cf74dc2973f::genesis::authorize_upgrade(&v2, arg2, 0, x"c64fb5bb3b764668282be2fcc2550dc4671b1ca5a245a09044ff4e80a93b498e")
    }

    // decompiled from Move bytecode v6
}

