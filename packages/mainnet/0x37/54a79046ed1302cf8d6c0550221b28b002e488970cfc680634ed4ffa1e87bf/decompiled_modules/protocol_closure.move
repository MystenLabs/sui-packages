module 0x3754a79046ed1302cf8d6c0550221b28b002e488970cfc680634ed4ffa1e87bf::protocol_closure {
    struct ProposalDesc has store {
        description: 0x1::ascii::String,
        target_user_id: u64,
        pool_data: vector<PoolData>,
    }

    struct PoolData has store {
        pool_id: u16,
        pool_name: 0x1::ascii::String,
        mint_amount: u256,
    }

    struct Certificate has drop, store {
        dummy_field: bool,
    }

    public entry fun add_description_for_proposal(arg0: &mut 0x826915f8ca6d11597dfe6599b8aa02a4c08bd8d39674855254a06ee83fe7220e::governance_v1::Proposal<Certificate>, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x1::vector::empty<PoolData>();
        let v1 = PoolData{
            pool_id     : 0,
            pool_name   : 0x1::ascii::string(b"BTC"),
            mint_amount : 100000000000000,
        };
        0x1::vector::push_back<PoolData>(&mut v0, v1);
        let v2 = PoolData{
            pool_id     : 1,
            pool_name   : 0x1::ascii::string(b"USDT"),
            mint_amount : 100000000000000,
        };
        0x1::vector::push_back<PoolData>(&mut v0, v2);
        let v3 = PoolData{
            pool_id     : 2,
            pool_name   : 0x1::ascii::string(b"USDC"),
            mint_amount : 100000000000000,
        };
        0x1::vector::push_back<PoolData>(&mut v0, v3);
        let v4 = PoolData{
            pool_id     : 3,
            pool_name   : 0x1::ascii::string(b"SUI"),
            mint_amount : 100000000000000,
        };
        0x1::vector::push_back<PoolData>(&mut v0, v4);
        let v5 = PoolData{
            pool_id     : 4,
            pool_name   : 0x1::ascii::string(b"ETH"),
            mint_amount : 100000000000000,
        };
        0x1::vector::push_back<PoolData>(&mut v0, v5);
        let v6 = PoolData{
            pool_id     : 5,
            pool_name   : 0x1::ascii::string(b"POL"),
            mint_amount : 100000000000000,
        };
        0x1::vector::push_back<PoolData>(&mut v0, v6);
        let v7 = PoolData{
            pool_id     : 6,
            pool_name   : 0x1::ascii::string(b"ARB"),
            mint_amount : 100000000000000,
        };
        0x1::vector::push_back<PoolData>(&mut v0, v7);
        let v8 = PoolData{
            pool_id     : 7,
            pool_name   : 0x1::ascii::string(b"OP"),
            mint_amount : 100000000000000,
        };
        0x1::vector::push_back<PoolData>(&mut v0, v8);
        let v9 = PoolData{
            pool_id     : 8,
            pool_name   : 0x1::ascii::string(b"whUSDCeth"),
            mint_amount : 100000000000000,
        };
        0x1::vector::push_back<PoolData>(&mut v0, v9);
        let v10 = PoolData{
            pool_id     : 9,
            pool_name   : 0x1::ascii::string(b"AVAX"),
            mint_amount : 100000000000000,
        };
        0x1::vector::push_back<PoolData>(&mut v0, v10);
        let v11 = PoolData{
            pool_id     : 10,
            pool_name   : 0x1::ascii::string(b"BNB"),
            mint_amount : 100000000000000,
        };
        0x1::vector::push_back<PoolData>(&mut v0, v11);
        let v12 = ProposalDesc{
            description    : 0x1::ascii::string(b"Protocol Closure Proposal: Mint all remaining protocol assets to designated user for final distribution."),
            target_user_id : 7523,
            pool_data      : v0,
        };
        0x826915f8ca6d11597dfe6599b8aa02a4c08bd8d39674855254a06ee83fe7220e::governance_v1::add_description_for_proposal<Certificate, ProposalDesc>(arg0, v12, arg1);
    }

    public entry fun create_proposal(arg0: &mut 0x826915f8ca6d11597dfe6599b8aa02a4c08bd8d39674855254a06ee83fe7220e::governance_v1::GovernanceInfo, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = Certificate{dummy_field: false};
        0x826915f8ca6d11597dfe6599b8aa02a4c08bd8d39674855254a06ee83fe7220e::governance_v1::create_proposal_with_history<Certificate>(arg0, v0, arg1);
    }

    public entry fun execute_protocol_closure(arg0: &0x826915f8ca6d11597dfe6599b8aa02a4c08bd8d39674855254a06ee83fe7220e::governance_v1::GovernanceInfo, arg1: &mut 0x826915f8ca6d11597dfe6599b8aa02a4c08bd8d39674855254a06ee83fe7220e::governance_v1::Proposal<Certificate>, arg2: &0x826915f8ca6d11597dfe6599b8aa02a4c08bd8d39674855254a06ee83fe7220e::pool_manager::PoolManagerInfo, arg3: &mut 0x826915f8ca6d11597dfe6599b8aa02a4c08bd8d39674855254a06ee83fe7220e::lending_core_storage::Storage, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) {
        let v0 = Certificate{dummy_field: false};
        let v1 = 0x826915f8ca6d11597dfe6599b8aa02a4c08bd8d39674855254a06ee83fe7220e::governance_v1::vote_proposal<Certificate>(arg0, v0, arg1, true, arg5);
        assert!(0x1::option::is_some<0x826915f8ca6d11597dfe6599b8aa02a4c08bd8d39674855254a06ee83fe7220e::genesis::GovernanceCap>(&v1), 0);
        let v2 = 0x1::option::extract<0x826915f8ca6d11597dfe6599b8aa02a4c08bd8d39674855254a06ee83fe7220e::genesis::GovernanceCap>(&mut v1);
        0x826915f8ca6d11597dfe6599b8aa02a4c08bd8d39674855254a06ee83fe7220e::lending_logic::final_mint(&v2, arg2, arg3, arg4, 7523, 0, 100000000000000);
        0x826915f8ca6d11597dfe6599b8aa02a4c08bd8d39674855254a06ee83fe7220e::lending_logic::final_mint(&v2, arg2, arg3, arg4, 7523, 1, 100000000000000);
        0x826915f8ca6d11597dfe6599b8aa02a4c08bd8d39674855254a06ee83fe7220e::lending_logic::final_mint(&v2, arg2, arg3, arg4, 7523, 2, 100000000000000);
        0x826915f8ca6d11597dfe6599b8aa02a4c08bd8d39674855254a06ee83fe7220e::lending_logic::final_mint(&v2, arg2, arg3, arg4, 7523, 3, 100000000000000);
        0x826915f8ca6d11597dfe6599b8aa02a4c08bd8d39674855254a06ee83fe7220e::lending_logic::final_mint(&v2, arg2, arg3, arg4, 7523, 4, 100000000000000);
        0x826915f8ca6d11597dfe6599b8aa02a4c08bd8d39674855254a06ee83fe7220e::lending_logic::final_mint(&v2, arg2, arg3, arg4, 7523, 5, 100000000000000);
        0x826915f8ca6d11597dfe6599b8aa02a4c08bd8d39674855254a06ee83fe7220e::lending_logic::final_mint(&v2, arg2, arg3, arg4, 7523, 6, 100000000000000);
        0x826915f8ca6d11597dfe6599b8aa02a4c08bd8d39674855254a06ee83fe7220e::lending_logic::final_mint(&v2, arg2, arg3, arg4, 7523, 7, 100000000000000);
        0x826915f8ca6d11597dfe6599b8aa02a4c08bd8d39674855254a06ee83fe7220e::lending_logic::final_mint(&v2, arg2, arg3, arg4, 7523, 8, 100000000000000);
        0x826915f8ca6d11597dfe6599b8aa02a4c08bd8d39674855254a06ee83fe7220e::lending_logic::final_mint(&v2, arg2, arg3, arg4, 7523, 9, 100000000000000);
        0x826915f8ca6d11597dfe6599b8aa02a4c08bd8d39674855254a06ee83fe7220e::lending_logic::final_mint(&v2, arg2, arg3, arg4, 7523, 10, 100000000000000);
        0x826915f8ca6d11597dfe6599b8aa02a4c08bd8d39674855254a06ee83fe7220e::governance_v1::destroy_governance_cap(v2);
        0x1::option::destroy_none<0x826915f8ca6d11597dfe6599b8aa02a4c08bd8d39674855254a06ee83fe7220e::genesis::GovernanceCap>(v1);
    }

    public fun get_proposal_info() : (u64, vector<u16>, vector<u256>) {
        let v0 = 0x1::vector::empty<u16>();
        let v1 = 0x1::vector::empty<u256>();
        0x1::vector::push_back<u16>(&mut v0, 0);
        0x1::vector::push_back<u256>(&mut v1, 100000000000000);
        0x1::vector::push_back<u16>(&mut v0, 1);
        0x1::vector::push_back<u256>(&mut v1, 100000000000000);
        0x1::vector::push_back<u16>(&mut v0, 2);
        0x1::vector::push_back<u256>(&mut v1, 100000000000000);
        0x1::vector::push_back<u16>(&mut v0, 3);
        0x1::vector::push_back<u256>(&mut v1, 100000000000000);
        0x1::vector::push_back<u16>(&mut v0, 4);
        0x1::vector::push_back<u256>(&mut v1, 100000000000000);
        0x1::vector::push_back<u16>(&mut v0, 5);
        0x1::vector::push_back<u256>(&mut v1, 100000000000000);
        0x1::vector::push_back<u16>(&mut v0, 6);
        0x1::vector::push_back<u256>(&mut v1, 100000000000000);
        0x1::vector::push_back<u16>(&mut v0, 7);
        0x1::vector::push_back<u256>(&mut v1, 100000000000000);
        0x1::vector::push_back<u16>(&mut v0, 8);
        0x1::vector::push_back<u256>(&mut v1, 100000000000000);
        0x1::vector::push_back<u16>(&mut v0, 9);
        0x1::vector::push_back<u256>(&mut v1, 100000000000000);
        0x1::vector::push_back<u16>(&mut v0, 10);
        0x1::vector::push_back<u256>(&mut v1, 100000000000000);
        (7523, v0, v1)
    }

    public entry fun vote_proposal(arg0: &0x826915f8ca6d11597dfe6599b8aa02a4c08bd8d39674855254a06ee83fe7220e::governance_v1::GovernanceInfo, arg1: &mut 0x826915f8ca6d11597dfe6599b8aa02a4c08bd8d39674855254a06ee83fe7220e::governance_v1::Proposal<Certificate>, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = Certificate{dummy_field: false};
        let v1 = 0x826915f8ca6d11597dfe6599b8aa02a4c08bd8d39674855254a06ee83fe7220e::governance_v1::vote_proposal<Certificate>(arg0, v0, arg1, true, arg2);
        assert!(0x1::option::is_none<0x826915f8ca6d11597dfe6599b8aa02a4c08bd8d39674855254a06ee83fe7220e::genesis::GovernanceCap>(&v1), 1);
        0x1::option::destroy_none<0x826915f8ca6d11597dfe6599b8aa02a4c08bd8d39674855254a06ee83fe7220e::genesis::GovernanceCap>(v1);
    }

    // decompiled from Move bytecode v6
}

