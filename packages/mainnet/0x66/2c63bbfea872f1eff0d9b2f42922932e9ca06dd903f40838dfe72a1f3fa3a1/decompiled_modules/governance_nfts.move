module 0x662c63bbfea872f1eff0d9b2f42922932e9ca06dd903f40838dfe72a1f3fa3a1::governance_nfts {
    struct AdminCap has store, key {
        id: 0x2::object::UID,
    }

    struct MintingControl has key {
        id: 0x2::object::UID,
        council_minted: u64,
        governor_minted: u64,
        voter_minted: u64,
    }

    struct RoyaltyPolicy has key {
        id: 0x2::object::UID,
        royalty_bps: u16,
        recipient: address,
    }

    struct SuiLFG_NFT has store, key {
        id: 0x2::object::UID,
        name: 0x1::string::String,
        description: 0x1::string::String,
        url: 0x2::url::Url,
        image_url: 0x2::url::Url,
        tier: 0x1::string::String,
    }

    struct CollectionInfo has key {
        id: 0x2::object::UID,
        name: 0x1::string::String,
        description: 0x1::string::String,
        project_url: 0x2::url::Url,
        twitter: 0x2::url::Url,
        image_url: 0x2::url::Url,
    }

    struct GOVERNANCE_NFTS has drop {
        dummy_field: bool,
    }

    public entry fun airdrop_nfts(arg0: vector<SuiLFG_NFT>, arg1: vector<address>) {
        assert!(0x1::vector::length<SuiLFG_NFT>(&arg0) == 0x1::vector::length<address>(&arg1), 406);
        while (0x1::vector::length<SuiLFG_NFT>(&arg0) > 0) {
            0x2::transfer::public_transfer<SuiLFG_NFT>(0x1::vector::pop_back<SuiLFG_NFT>(&mut arg0), 0x1::vector::pop_back<address>(&mut arg1));
        };
        0x1::vector::destroy_empty<SuiLFG_NFT>(arg0);
        0x1::vector::destroy_empty<address>(arg1);
    }

    public entry fun batch_mint_nfts(arg0: &AdminCap, arg1: &mut MintingControl, arg2: 0x1::string::String, arg3: u64, arg4: u64, arg5: address, arg6: &mut 0x2::tx_context::TxContext) {
        let (v0, v1, v2, v3) = if (arg2 == 0x1::string::utf8(b"Council")) {
            assert!(arg1.council_minted + arg4 <= 100, 405);
            arg1.council_minted = arg1.council_minted + arg4;
            (0x1::string::utf8(b"The highest tier of governance NFT..."), 0x2::url::new_unsafe_from_bytes(b"https://gateway.pinata.cloud/ipfs/bafybeiepd3hik7kfhmexce7gctgieaarav6azuhnn6h2lynrvymip4qpci/Council.png"), 0x2::url::new_unsafe_from_bytes(b"https://gateway.pinata.cloud/ipfs/bafybeiefchevmhuyixgxnk42p5ez6yb5gxxojidmhjoywqgyeuayf6hxju/council.json"), 0x1::string::utf8(b"SuiLFG Council NFT #"))
        } else if (arg2 == 0x1::string::utf8(b"Governor")) {
            assert!(arg1.governor_minted + arg4 <= 1000, 405);
            arg1.governor_minted = arg1.governor_minted + arg4;
            (0x1::string::utf8(b"A high-tier governance NFT..."), 0x2::url::new_unsafe_from_bytes(b"https://gateway.pinata.cloud/ipfs/bafybeiepd3hik7kfhmexce7gctgieaarav6azuhnn6h2lynrvymip4qpci/Governor.png"), 0x2::url::new_unsafe_from_bytes(b"https://gateway.pinata.cloud/ipfs/bafybeiefchevmhuyixgxnk42p5ez6yb5gxxojidmhjoywqgyeuayf6hxju/governor.json"), 0x1::string::utf8(b"SuiLFG Governor NFT #"))
        } else {
            assert!(arg2 == 0x1::string::utf8(b"Voter"), 404);
            assert!(arg1.voter_minted + arg4 <= 10000, 405);
            arg1.voter_minted = arg1.voter_minted + arg4;
            (0x1::string::utf8(b"A foundational governance NFT..."), 0x2::url::new_unsafe_from_bytes(b"https://gateway.pinata.cloud/ipfs/bafybeiepd3hik7kfhmexce7gctgieaarav6azuhnn6h2lynrvymip4qpci/Voter.png"), 0x2::url::new_unsafe_from_bytes(b"https://gateway.pinata.cloud/ipfs/bafybeiefchevmhuyixgxnk42p5ez6yb5gxxojidmhjoywqgyeuayf6hxju/voter.json"), 0x1::string::utf8(b"SuiLFG Voter NFT #"))
        };
        let v4 = 0;
        while (v4 < arg4) {
            let v5 = v3;
            0x1::string::append(&mut v5, 0x1::u64::to_string(arg3 + v4));
            let v6 = SuiLFG_NFT{
                id          : 0x2::object::new(arg6),
                name        : v5,
                description : v0,
                url         : v2,
                image_url   : v1,
                tier        : arg2,
            };
            0x2::transfer::public_transfer<SuiLFG_NFT>(v6, arg5);
            v4 = v4 + 1;
        };
    }

    fun init(arg0: GOVERNANCE_NFTS, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let v1 = AdminCap{id: 0x2::object::new(arg1)};
        0x2::transfer::public_transfer<AdminCap>(v1, v0);
        let v2 = MintingControl{
            id              : 0x2::object::new(arg1),
            council_minted  : 0,
            governor_minted : 0,
            voter_minted    : 0,
        };
        0x2::transfer::share_object<MintingControl>(v2);
        let v3 = RoyaltyPolicy{
            id          : 0x2::object::new(arg1),
            royalty_bps : 500,
            recipient   : v0,
        };
        0x2::transfer::share_object<RoyaltyPolicy>(v3);
        let v4 = CollectionInfo{
            id          : 0x2::object::new(arg1),
            name        : 0x1::string::utf8(b"SuiLFG Governance NFTs"),
            description : 0x1::string::utf8(b"A multi-tiered NFT collection granting governance power in the SuiLFG prediction market."),
            project_url : 0x2::url::new_unsafe_from_bytes(b"https://www.suilfg.com"),
            twitter     : 0x2::url::new_unsafe_from_bytes(b"https://x.com/SuiLFG_"),
            image_url   : 0x2::url::new_unsafe_from_bytes(b"https://gateway.pinata.cloud/ipfs/bafybeiepd3hik7kfhmexce7gctgieaarav6azuhnn6h2lynrvymip4qpci/Council.png"),
        };
        0x2::transfer::share_object<CollectionInfo>(v4);
    }

    // decompiled from Move bytecode v6
}

