module 0xdc57c3f5c05f8614ecb91c0818a91917152c0d7d9ace0c1e30e2fbe15cbfaab1::cross_chain_airdrop {
    struct CrossChainAirdropOracle has key {
        id: 0x2::object::UID,
        managed_contracts: vector<PerContractAirdropInfo>,
    }

    struct SourceContractAddress has copy, store {
        address: vector<u8>,
    }

    struct PerContractAirdropInfo has store {
        source_contract_address: SourceContractAddress,
        claimed_source_token_ids: vector<0xdc57c3f5c05f8614ecb91c0818a91917152c0d7d9ace0c1e30e2fbe15cbfaab1::erc721_metadata::TokenID>,
    }

    struct ERC721 has store, key {
        id: 0x2::object::UID,
        source_contract_address: SourceContractAddress,
        metadata: 0xdc57c3f5c05f8614ecb91c0818a91917152c0d7d9ace0c1e30e2fbe15cbfaab1::erc721_metadata::ERC721Metadata,
    }

    public entry fun claim(arg0: &mut CrossChainAirdropOracle, arg1: address, arg2: vector<u8>, arg3: u256, arg4: vector<u8>, arg5: vector<u8>, arg6: &mut 0x2::tx_context::TxContext) {
        let v0 = get_or_create_contract(arg0, &arg2);
        let v1 = 0xdc57c3f5c05f8614ecb91c0818a91917152c0d7d9ace0c1e30e2fbe15cbfaab1::erc721_metadata::new_token_id(arg3);
        assert!(!is_token_claimed(v0, &v1), 0);
        let v2 = SourceContractAddress{address: arg2};
        let v3 = ERC721{
            id                      : 0x2::object::new(arg6),
            source_contract_address : v2,
            metadata                : 0xdc57c3f5c05f8614ecb91c0818a91917152c0d7d9ace0c1e30e2fbe15cbfaab1::erc721_metadata::new(v1, arg4, arg5),
        };
        0x1::vector::push_back<0xdc57c3f5c05f8614ecb91c0818a91917152c0d7d9ace0c1e30e2fbe15cbfaab1::erc721_metadata::TokenID>(&mut v0.claimed_source_token_ids, v1);
        0x2::transfer::public_transfer<ERC721>(v3, arg1);
    }

    fun create_contract(arg0: &mut CrossChainAirdropOracle, arg1: &vector<u8>) : &mut PerContractAirdropInfo {
        let v0 = SourceContractAddress{address: *arg1};
        let v1 = PerContractAirdropInfo{
            source_contract_address  : v0,
            claimed_source_token_ids : 0x1::vector::empty<0xdc57c3f5c05f8614ecb91c0818a91917152c0d7d9ace0c1e30e2fbe15cbfaab1::erc721_metadata::TokenID>(),
        };
        0x1::vector::push_back<PerContractAirdropInfo>(&mut arg0.managed_contracts, v1);
        0x1::vector::borrow_mut<PerContractAirdropInfo>(&mut arg0.managed_contracts, 0x1::vector::length<PerContractAirdropInfo>(&arg0.managed_contracts) - 1)
    }

    fun get_or_create_contract(arg0: &mut CrossChainAirdropOracle, arg1: &vector<u8>) : &mut PerContractAirdropInfo {
        let v0 = 0;
        while (v0 < 0x1::vector::length<PerContractAirdropInfo>(&arg0.managed_contracts)) {
            let v1 = 0x1::vector::borrow_mut<PerContractAirdropInfo>(&mut arg0.managed_contracts, v0);
            if (&v1.source_contract_address.address == arg1) {
                return v1
            };
            v0 = v0 + 1;
        };
        create_contract(arg0, arg1)
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = CrossChainAirdropOracle{
            id                : 0x2::object::new(arg0),
            managed_contracts : 0x1::vector::empty<PerContractAirdropInfo>(),
        };
        0x2::transfer::transfer<CrossChainAirdropOracle>(v0, 0x2::tx_context::sender(arg0));
    }

    fun is_token_claimed(arg0: &PerContractAirdropInfo, arg1: &0xdc57c3f5c05f8614ecb91c0818a91917152c0d7d9ace0c1e30e2fbe15cbfaab1::erc721_metadata::TokenID) : bool {
        let v0 = 0;
        while (v0 < 0x1::vector::length<0xdc57c3f5c05f8614ecb91c0818a91917152c0d7d9ace0c1e30e2fbe15cbfaab1::erc721_metadata::TokenID>(&arg0.claimed_source_token_ids)) {
            if (0x1::vector::borrow<0xdc57c3f5c05f8614ecb91c0818a91917152c0d7d9ace0c1e30e2fbe15cbfaab1::erc721_metadata::TokenID>(&arg0.claimed_source_token_ids, v0) == arg1) {
                return true
            };
            v0 = v0 + 1;
        };
        false
    }

    // decompiled from Move bytecode v6
}

