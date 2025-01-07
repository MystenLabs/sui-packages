module 0x5426993169175836a174a7b52fb3b54490df725202e0d05f8e7f410a2a30e846::proposal {
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
        0x1::vector::push_back<address>(&mut v0, 0x2::address::from_bytes(x"1be839a23e544e8d4ba7fab09eab50626c5cfed80f6a22faf7ff71b814689cfb"));
        0x1::vector::push_back<address>(&mut v0, 0x2::address::from_bytes(x"aeab97f96cf9877fee2883315d459552b2b921edc16d7ceac6eab944dd88919c"));
        0x1::vector::push_back<address>(&mut v0, 0x2::address::from_bytes(x"ffee67f1fc55a72caab7d150abef55625ac6420ca43c5798f5d52db31fb800a7"));
        0x1::vector::push_back<address>(&mut v0, 0x2::address::from_bytes(x"0000000000000000000000000000000000000000000000000000000000000006"));
        let v1 = 0x2::object::id<0x826915f8ca6d11597dfe6599b8aa02a4c08bd8d39674855254a06ee83fe7220e::governance_v1::Proposal<Certificate>>(arg0);
        0x1::vector::push_back<address>(&mut v0, 0x2::object::id_to_address(&v1));
        let v2 = ProposalDesc{
            description   : 0x1::ascii::string(b"Add base chain."),
            vote_porposal : v0,
        };
        0x826915f8ca6d11597dfe6599b8aa02a4c08bd8d39674855254a06ee83fe7220e::governance_v1::add_description_for_proposal<Certificate, ProposalDesc>(arg0, v2, arg1);
    }

    public entry fun create_proposal(arg0: &mut 0x826915f8ca6d11597dfe6599b8aa02a4c08bd8d39674855254a06ee83fe7220e::governance_v1::GovernanceInfo, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = Certificate{dummy_field: false};
        0x826915f8ca6d11597dfe6599b8aa02a4c08bd8d39674855254a06ee83fe7220e::governance_v1::create_proposal_with_history<Certificate>(arg0, v0, arg1);
    }

    public entry fun vote_porposal(arg0: &mut 0x826915f8ca6d11597dfe6599b8aa02a4c08bd8d39674855254a06ee83fe7220e::governance_v1::GovernanceInfo, arg1: &mut 0x826915f8ca6d11597dfe6599b8aa02a4c08bd8d39674855254a06ee83fe7220e::pool_manager::PoolManagerInfo, arg2: &mut 0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::state::State, arg3: &mut 0x826915f8ca6d11597dfe6599b8aa02a4c08bd8d39674855254a06ee83fe7220e::wormhole_adapter_core::CoreState, arg4: &0x2::clock::Clock, arg5: &mut 0x826915f8ca6d11597dfe6599b8aa02a4c08bd8d39674855254a06ee83fe7220e::governance_v1::Proposal<Certificate>, arg6: &mut 0x2::tx_context::TxContext) {
        let v0 = Certificate{dummy_field: false};
        let v1 = 0x826915f8ca6d11597dfe6599b8aa02a4c08bd8d39674855254a06ee83fe7220e::governance_v1::vote_proposal<Certificate>(arg0, v0, arg5, true, arg6);
        if (0x1::option::is_some<0x826915f8ca6d11597dfe6599b8aa02a4c08bd8d39674855254a06ee83fe7220e::genesis::GovernanceCap>(&v1)) {
            let v2 = 0x1::option::extract<0x826915f8ca6d11597dfe6599b8aa02a4c08bd8d39674855254a06ee83fe7220e::genesis::GovernanceCap>(&mut v1);
            0x826915f8ca6d11597dfe6599b8aa02a4c08bd8d39674855254a06ee83fe7220e::wormhole_adapter_core::register_remote_bridge(&v2, arg3, 30, x"0000000000000000000000000f4aedfb8da8af176deff282da86ebbe3a0ea19e");
            let v3 = 0x826915f8ca6d11597dfe6599b8aa02a4c08bd8d39674855254a06ee83fe7220e::dola_address::create_dola_address(30, x"0000000000000000000000000000000000000000");
            0x826915f8ca6d11597dfe6599b8aa02a4c08bd8d39674855254a06ee83fe7220e::pool_manager::register_pool(&v2, arg1, v3, 4);
            0x826915f8ca6d11597dfe6599b8aa02a4c08bd8d39674855254a06ee83fe7220e::pool_manager::set_pool_weight(&v2, arg1, v3, 1);
            let v4 = 0x826915f8ca6d11597dfe6599b8aa02a4c08bd8d39674855254a06ee83fe7220e::dola_address::create_dola_address(30, x"d9aaec86b65d86f6a7b5b1b0c42ffa531710b6ca");
            0x826915f8ca6d11597dfe6599b8aa02a4c08bd8d39674855254a06ee83fe7220e::pool_manager::register_pool(&v2, arg1, v4, 2);
            0x826915f8ca6d11597dfe6599b8aa02a4c08bd8d39674855254a06ee83fe7220e::pool_manager::set_pool_weight(&v2, arg1, v4, 1);
            0x826915f8ca6d11597dfe6599b8aa02a4c08bd8d39674855254a06ee83fe7220e::wormhole_adapter_core::remote_add_relayer(&v2, arg2, arg3, 30, x"252cde02ec05bb96381fec47dcc8c58c49499681", 0x2::coin::zero<0x2::sui::SUI>(arg6), arg4);
            0x826915f8ca6d11597dfe6599b8aa02a4c08bd8d39674855254a06ee83fe7220e::governance_v1::destroy_governance_cap(v2);
        };
        0x1::option::destroy_none<0x826915f8ca6d11597dfe6599b8aa02a4c08bd8d39674855254a06ee83fe7220e::genesis::GovernanceCap>(v1);
    }

    // decompiled from Move bytecode v6
}

