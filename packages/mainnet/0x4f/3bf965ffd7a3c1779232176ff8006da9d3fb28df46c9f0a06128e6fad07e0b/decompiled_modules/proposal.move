module 0x4f3bf965ffd7a3c1779232176ff8006da9d3fb28df46c9f0a06128e6fad07e0b::proposal {
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
        0x1::vector::push_back<address>(&mut v0, 0x2::address::from_bytes(x"ee633dc3fd1218d3bd9703fb9b98e6c8d7fdd8c8bf1ca2645ee40d65fb533a3e"));
        0x1::vector::push_back<address>(&mut v0, 0x2::address::from_bytes(x"e5a189b1858b207f2cf8c05a09d75bae4271c7a9a8f84a8c199c6896dc7c37e6"));
        0x1::vector::push_back<address>(&mut v0, 0x2::address::from_bytes(x"42afbffd3479b06f40c5576799b02ea300df36cf967adcd1ae15445270f572e2"));
        0x1::vector::push_back<address>(&mut v0, 0x2::address::from_bytes(x"aeab97f96cf9877fee2883315d459552b2b921edc16d7ceac6eab944dd88919c"));
        0x1::vector::push_back<address>(&mut v0, 0x2::address::from_bytes(x"ffee67f1fc55a72caab7d150abef55625ac6420ca43c5798f5d52db31fb800a7"));
        0x1::vector::push_back<address>(&mut v0, 0x2::address::from_bytes(x"0000000000000000000000000000000000000000000000000000000000000006"));
        let v1 = 0x2::object::id<0x826915f8ca6d11597dfe6599b8aa02a4c08bd8d39674855254a06ee83fe7220e::governance_v1::Proposal<Certificate>>(arg0);
        0x1::vector::push_back<address>(&mut v0, 0x2::object::id_to_address(&v1));
        let v2 = ProposalDesc{
            description   : 0x1::ascii::string(b"Add avax mainnet."),
            vote_porposal : v0,
        };
        0x826915f8ca6d11597dfe6599b8aa02a4c08bd8d39674855254a06ee83fe7220e::governance_v1::add_description_for_proposal<Certificate, ProposalDesc>(arg0, v2, arg1);
    }

    public entry fun create_proposal(arg0: &mut 0x826915f8ca6d11597dfe6599b8aa02a4c08bd8d39674855254a06ee83fe7220e::governance_v1::GovernanceInfo, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = Certificate{dummy_field: false};
        0x826915f8ca6d11597dfe6599b8aa02a4c08bd8d39674855254a06ee83fe7220e::governance_v1::create_proposal_with_history<Certificate>(arg0, v0, arg1);
    }

    public entry fun vote_porposal(arg0: &mut 0x826915f8ca6d11597dfe6599b8aa02a4c08bd8d39674855254a06ee83fe7220e::governance_v1::GovernanceInfo, arg1: &mut 0x826915f8ca6d11597dfe6599b8aa02a4c08bd8d39674855254a06ee83fe7220e::pool_manager::PoolManagerInfo, arg2: &mut 0x826915f8ca6d11597dfe6599b8aa02a4c08bd8d39674855254a06ee83fe7220e::user_manager::UserManagerInfo, arg3: &mut 0x826915f8ca6d11597dfe6599b8aa02a4c08bd8d39674855254a06ee83fe7220e::lending_core_storage::Storage, arg4: &mut 0x826915f8ca6d11597dfe6599b8aa02a4c08bd8d39674855254a06ee83fe7220e::oracle::PriceOracle, arg5: &mut 0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::state::State, arg6: &mut 0x826915f8ca6d11597dfe6599b8aa02a4c08bd8d39674855254a06ee83fe7220e::wormhole_adapter_core::CoreState, arg7: &0x2::clock::Clock, arg8: &mut 0x826915f8ca6d11597dfe6599b8aa02a4c08bd8d39674855254a06ee83fe7220e::governance_v1::Proposal<Certificate>, arg9: &mut 0x2::tx_context::TxContext) {
        let v0 = Certificate{dummy_field: false};
        let v1 = 0x826915f8ca6d11597dfe6599b8aa02a4c08bd8d39674855254a06ee83fe7220e::governance_v1::vote_proposal<Certificate>(arg0, v0, arg8, true, arg9);
        if (0x1::option::is_some<0x826915f8ca6d11597dfe6599b8aa02a4c08bd8d39674855254a06ee83fe7220e::genesis::GovernanceCap>(&v1)) {
            let v2 = 0x1::option::extract<0x826915f8ca6d11597dfe6599b8aa02a4c08bd8d39674855254a06ee83fe7220e::genesis::GovernanceCap>(&mut v1);
            0x826915f8ca6d11597dfe6599b8aa02a4c08bd8d39674855254a06ee83fe7220e::lending_core_storage::register_new_reserve(&v2, arg3, arg7, 10, false, false, 0, 230000000000000000000000000, 500000000000, 0, 660000000000000000000000000, 1330000000000000000000000000, 0, 70000000000000000000000000, 3000000000000000000000000000, 800000000000000000000000000, arg9);
            0x826915f8ca6d11597dfe6599b8aa02a4c08bd8d39674855254a06ee83fe7220e::user_manager::register_dola_chain_id(&v2, arg2, 4, 2);
            0x826915f8ca6d11597dfe6599b8aa02a4c08bd8d39674855254a06ee83fe7220e::wormhole_adapter_core::register_remote_bridge(&v2, arg6, 4, x"000000000000000000000000b4da6261c07330c6cb216159dc38fa3b302bc8b5");
            0x826915f8ca6d11597dfe6599b8aa02a4c08bd8d39674855254a06ee83fe7220e::pool_manager::register_pool_id(&v2, arg1, 0x1::ascii::string(b"BNB"), 10, arg9);
            let v3 = 0x826915f8ca6d11597dfe6599b8aa02a4c08bd8d39674855254a06ee83fe7220e::dola_address::create_dola_address(4, x"0000000000000000000000000000000000000000");
            0x826915f8ca6d11597dfe6599b8aa02a4c08bd8d39674855254a06ee83fe7220e::pool_manager::register_pool(&v2, arg1, v3, 10);
            0x826915f8ca6d11597dfe6599b8aa02a4c08bd8d39674855254a06ee83fe7220e::pool_manager::set_pool_weight(&v2, arg1, v3, 1);
            0x826915f8ca6d11597dfe6599b8aa02a4c08bd8d39674855254a06ee83fe7220e::oracle::register_token_price(&v2, arg4, x"2f95862b045670cd22bee3114c39763a4a08beeb663b145d283c31d7d1101c4f", 10, 21183192800, 8, arg7);
            0x826915f8ca6d11597dfe6599b8aa02a4c08bd8d39674855254a06ee83fe7220e::wormhole_adapter_core::remote_add_relayer(&v2, arg5, arg6, 4, x"252cde02ec05bb96381fec47dcc8c58c49499681", 0x2::coin::zero<0x2::sui::SUI>(arg9), arg7);
            0x826915f8ca6d11597dfe6599b8aa02a4c08bd8d39674855254a06ee83fe7220e::governance_v1::destroy_governance_cap(v2);
        };
        0x1::option::destroy_none<0x826915f8ca6d11597dfe6599b8aa02a4c08bd8d39674855254a06ee83fe7220e::genesis::GovernanceCap>(v1);
    }

    // decompiled from Move bytecode v6
}

