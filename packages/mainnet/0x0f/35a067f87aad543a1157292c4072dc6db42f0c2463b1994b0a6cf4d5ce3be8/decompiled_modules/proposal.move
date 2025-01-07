module 0xf35a067f87aad543a1157292c4072dc6db42f0c2463b1994b0a6cf4d5ce3be8::proposal {
    struct ProposalInfo has key {
        id: 0x2::object::UID,
        description: 0x1::ascii::String,
        create_proposal: vector<address>,
        vote_porposal: vector<address>,
        is_create_proposal: bool,
        creator: address,
    }

    struct Certificate has drop, store {
        dummy_field: bool,
    }

    public entry fun add_vote_porposal(arg0: &mut ProposalInfo, arg1: &0x826915f8ca6d11597dfe6599b8aa02a4c08bd8d39674855254a06ee83fe7220e::governance_v1::Proposal<Certificate>, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.creator == 0x2::tx_context::sender(arg2), 0);
        let v0 = 0x2::object::id<0x826915f8ca6d11597dfe6599b8aa02a4c08bd8d39674855254a06ee83fe7220e::governance_v1::Proposal<Certificate>>(arg1);
        0x1::vector::push_back<address>(&mut arg0.vote_porposal, 0x2::object::id_to_address(&v0));
    }

    public entry fun create_proposal(arg0: &mut 0x826915f8ca6d11597dfe6599b8aa02a4c08bd8d39674855254a06ee83fe7220e::governance_v1::GovernanceInfo, arg1: &mut ProposalInfo, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(arg1.creator == 0x2::tx_context::sender(arg2), 0);
        let v0 = Certificate{dummy_field: false};
        0x826915f8ca6d11597dfe6599b8aa02a4c08bd8d39674855254a06ee83fe7220e::governance_v1::create_proposal_with_history<Certificate>(arg0, v0, arg2);
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::address::from_bytes(x"79d7106ea18373fc7542b0849d5ebefc3a9daf8b664a4f82d9b35bbd0c22042d");
        let v1 = 0x1::vector::empty<address>();
        0x1::vector::push_back<address>(&mut v1, v0);
        let v2 = 0x1::vector::empty<address>();
        0x1::vector::push_back<address>(&mut v2, v0);
        let v3 = 0x2::object::new(arg0);
        let v4 = 0x2::object::uid_to_inner(&v3);
        let v5 = ProposalInfo{
            id                 : v3,
            description        : 0x1::ascii::string(b"Migrate version from v_1_0_3 to v_1_0_4"),
            create_proposal    : v1,
            vote_porposal      : v2,
            is_create_proposal : false,
            creator            : 0x2::tx_context::sender(arg0),
        };
        0x1::vector::push_back<address>(&mut v5.create_proposal, 0x2::object::id_to_address(&v4));
        0x2::transfer::share_object<ProposalInfo>(v5);
    }

    public entry fun vote_porposal(arg0: &mut 0x826915f8ca6d11597dfe6599b8aa02a4c08bd8d39674855254a06ee83fe7220e::governance_v1::GovernanceInfo, arg1: &mut 0x826915f8ca6d11597dfe6599b8aa02a4c08bd8d39674855254a06ee83fe7220e::governance_v1::Proposal<Certificate>, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = Certificate{dummy_field: false};
        let v1 = 0x826915f8ca6d11597dfe6599b8aa02a4c08bd8d39674855254a06ee83fe7220e::governance_v1::vote_proposal<Certificate>(arg0, v0, arg1, true, arg2);
        if (0x1::option::is_some<0x826915f8ca6d11597dfe6599b8aa02a4c08bd8d39674855254a06ee83fe7220e::genesis::GovernanceCap>(&v1)) {
            let v2 = 0x1::option::extract<0x826915f8ca6d11597dfe6599b8aa02a4c08bd8d39674855254a06ee83fe7220e::genesis::GovernanceCap>(&mut v1);
            0x826915f8ca6d11597dfe6599b8aa02a4c08bd8d39674855254a06ee83fe7220e::governance_v1::add_member(&v2, arg0, 0x2::address::from_bytes(b"2d8a1f9e142f4462098394765ce62e51b999b47a4bae5d15cde4f8499313e4d0"));
            0x826915f8ca6d11597dfe6599b8aa02a4c08bd8d39674855254a06ee83fe7220e::governance_v1::destroy_governance_cap(v2);
        };
        0x1::option::destroy_none<0x826915f8ca6d11597dfe6599b8aa02a4c08bd8d39674855254a06ee83fe7220e::genesis::GovernanceCap>(v1);
    }

    // decompiled from Move bytecode v6
}

