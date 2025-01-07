module 0x1141fafa045c16999416121245d68298ac41343601b249d1f678a2857c1b3416::proposal {
    struct ProposalDesc has store {
        description: 0x1::ascii::String,
        vote_porposal: vector<address>,
    }

    struct Certificate has drop, store {
        dummy_field: bool,
    }

    public entry fun add_description_for_proposal(arg0: &mut 0x826915f8ca6d11597dfe6599b8aa02a4c08bd8d39674855254a06ee83fe7220e::governance_v1::Proposal<Certificate>, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x1::vector::empty<address>();
        0x1::vector::push_back<address>(&mut v0, 0x2::address::from_bytes(x"79d7106ea18373fc7542b0849d5ebefc3a9daf8b664a4f82d9b35bbd0c22042d"));
        let v1 = 0x2::object::id<0x826915f8ca6d11597dfe6599b8aa02a4c08bd8d39674855254a06ee83fe7220e::governance_v1::Proposal<Certificate>>(arg0);
        0x1::vector::push_back<address>(&mut v0, 0x2::object::id_to_address(&v1));
        let v2 = ProposalDesc{
            description   : 0x1::ascii::string(b"Migrate matic to pol"),
            vote_porposal : v0,
        };
        0x826915f8ca6d11597dfe6599b8aa02a4c08bd8d39674855254a06ee83fe7220e::governance_v1::add_description_for_proposal<Certificate, ProposalDesc>(arg0, v2, arg1);
    }

    public entry fun create_proposal(arg0: &mut 0x826915f8ca6d11597dfe6599b8aa02a4c08bd8d39674855254a06ee83fe7220e::governance_v1::GovernanceInfo, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = Certificate{dummy_field: false};
        0x826915f8ca6d11597dfe6599b8aa02a4c08bd8d39674855254a06ee83fe7220e::governance_v1::create_proposal_with_history<Certificate>(arg0, v0, arg1);
    }

    public entry fun vote_porposal(arg0: &mut 0x826915f8ca6d11597dfe6599b8aa02a4c08bd8d39674855254a06ee83fe7220e::governance_v1::GovernanceInfo, arg1: &mut 0x826915f8ca6d11597dfe6599b8aa02a4c08bd8d39674855254a06ee83fe7220e::oracle::PriceOracle, arg2: &mut 0x826915f8ca6d11597dfe6599b8aa02a4c08bd8d39674855254a06ee83fe7220e::governance_v1::Proposal<Certificate>, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = Certificate{dummy_field: false};
        let v1 = 0x826915f8ca6d11597dfe6599b8aa02a4c08bd8d39674855254a06ee83fe7220e::governance_v1::vote_proposal<Certificate>(arg0, v0, arg2, true, arg4);
        if (0x1::option::is_some<0x826915f8ca6d11597dfe6599b8aa02a4c08bd8d39674855254a06ee83fe7220e::genesis::GovernanceCap>(&v1)) {
            let v2 = 0x1::option::extract<0x826915f8ca6d11597dfe6599b8aa02a4c08bd8d39674855254a06ee83fe7220e::genesis::GovernanceCap>(&mut v1);
            0x826915f8ca6d11597dfe6599b8aa02a4c08bd8d39674855254a06ee83fe7220e::oracle::register_token_price(&v2, arg1, x"ffd11c5a1cfd42f80afb2df4d9f264c15f956d68153335374ec10722edd70472", 5, 0, 0, arg3);
            0x826915f8ca6d11597dfe6599b8aa02a4c08bd8d39674855254a06ee83fe7220e::governance_v1::destroy_governance_cap(v2);
        };
        0x1::option::destroy_none<0x826915f8ca6d11597dfe6599b8aa02a4c08bd8d39674855254a06ee83fe7220e::genesis::GovernanceCap>(v1);
    }

    // decompiled from Move bytecode v6
}

