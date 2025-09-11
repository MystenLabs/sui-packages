module 0xf79d5ce6fec3f66461399a3c01dfba514129b8092305817058a6a0ae1b85c3fc::governance_nfts_test {
    struct AdminCap has store, key {
        id: 0x2::object::UID,
    }

    struct MintingControl has key {
        id: 0x2::object::UID,
        council_minted: u64,
        governor_minted: u64,
        voter_minted: u64,
    }

    struct AttributeKV has store {
        key: 0x1::string::String,
        value: 0x1::string::String,
    }

    struct SuiLFG_NFT has store, key {
        id: 0x2::object::UID,
        name: 0x1::string::String,
        image_url: 0x1::string::String,
        description: 0x1::string::String,
        attributes: vector<AttributeKV>,
    }

    struct CollectionInfo has key {
        id: 0x2::object::UID,
        name: 0x1::string::String,
        description: 0x1::string::String,
        project_url: 0x1::string::String,
        twitter: 0x1::string::String,
        image_url: 0x1::string::String,
    }

    struct GOVERNANCE_NFTS_TEST has drop {
        dummy_field: bool,
    }

    public entry fun batch_mint_to_kiosk(arg0: &AdminCap, arg1: &mut MintingControl, arg2: 0x1::string::String, arg3: u64, arg4: u64, arg5: &0x2::transfer_policy::TransferPolicy<SuiLFG_NFT>, arg6: &mut 0x2::kiosk::Kiosk, arg7: &0x2::kiosk::KioskOwnerCap, arg8: &mut 0x2::tx_context::TxContext) {
        if (arg2 == 0x1::string::utf8(b"Council")) {
            let v0 = arg1.council_minted;
            assert!(v0 + arg4 <= 100, 405);
            assert!(arg3 == v0 + 1, 406);
            arg1.council_minted = v0 + arg4;
            let v1 = 0;
            while (v1 < arg4) {
                let v2 = 0x1::vector::empty<AttributeKV>();
                let v3 = AttributeKV{
                    key   : 0x1::string::utf8(b"Tier"),
                    value : 0x1::string::utf8(b"Council"),
                };
                0x1::vector::push_back<AttributeKV>(&mut v2, v3);
                let v4 = AttributeKV{
                    key   : 0x1::string::utf8(b"Voting Power"),
                    value : 0x1::string::utf8(b"25x"),
                };
                0x1::vector::push_back<AttributeKV>(&mut v2, v4);
                let v5 = SuiLFG_NFT{
                    id          : 0x2::object::new(arg8),
                    name        : 0x1::string::utf8(b"SuiLFG Test Council NFT"),
                    image_url   : 0x1::string::utf8(b"https://nft.suilfg.com/images/Council.png"),
                    description : 0x1::string::utf8(b"TEST: Highest tier governance NFT for SuiLFG."),
                    attributes  : v2,
                };
                0x2::kiosk::lock<SuiLFG_NFT>(arg6, arg7, arg5, v5);
                v1 = v1 + 1;
            };
        } else if (arg2 == 0x1::string::utf8(b"Governor")) {
            let v6 = arg1.governor_minted;
            assert!(v6 + arg4 <= 1000, 405);
            assert!(arg3 == v6 + 1, 406);
            arg1.governor_minted = v6 + arg4;
            let v7 = 0;
            while (v7 < arg4) {
                let v8 = 0x1::vector::empty<AttributeKV>();
                let v9 = AttributeKV{
                    key   : 0x1::string::utf8(b"Tier"),
                    value : 0x1::string::utf8(b"Governor"),
                };
                0x1::vector::push_back<AttributeKV>(&mut v8, v9);
                let v10 = AttributeKV{
                    key   : 0x1::string::utf8(b"Voting Power"),
                    value : 0x1::string::utf8(b"5x"),
                };
                0x1::vector::push_back<AttributeKV>(&mut v8, v10);
                let v11 = SuiLFG_NFT{
                    id          : 0x2::object::new(arg8),
                    name        : 0x1::string::utf8(b"SuiLFG Test Governor NFT"),
                    image_url   : 0x1::string::utf8(b"https://nft.suilfg.com/images/Governor.png"),
                    description : 0x1::string::utf8(b"TEST: High-tier governance NFT for SuiLFG."),
                    attributes  : v8,
                };
                0x2::kiosk::lock<SuiLFG_NFT>(arg6, arg7, arg5, v11);
                v7 = v7 + 1;
            };
        } else {
            assert!(arg2 == 0x1::string::utf8(b"Voter"), 404);
            let v12 = arg1.voter_minted;
            assert!(v12 + arg4 <= 10000, 405);
            assert!(arg3 == v12 + 1, 406);
            arg1.voter_minted = v12 + arg4;
            let v13 = 0;
            while (v13 < arg4) {
                let v14 = 0x1::vector::empty<AttributeKV>();
                let v15 = AttributeKV{
                    key   : 0x1::string::utf8(b"Tier"),
                    value : 0x1::string::utf8(b"Voter"),
                };
                0x1::vector::push_back<AttributeKV>(&mut v14, v15);
                let v16 = AttributeKV{
                    key   : 0x1::string::utf8(b"Voting Power"),
                    value : 0x1::string::utf8(b"1.5x"),
                };
                0x1::vector::push_back<AttributeKV>(&mut v14, v16);
                let v17 = SuiLFG_NFT{
                    id          : 0x2::object::new(arg8),
                    name        : 0x1::string::utf8(b"SuiLFG Test Voter NFT"),
                    image_url   : 0x1::string::utf8(b"https://nft.suilfg.com/images/Voter.png"),
                    description : 0x1::string::utf8(b"TEST: Foundational governance NFT for SuiLFG."),
                    attributes  : v14,
                };
                0x2::kiosk::lock<SuiLFG_NFT>(arg6, arg7, arg5, v17);
                v13 = v13 + 1;
            };
        };
    }

    public entry fun create_kiosk_for_sender(arg0: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::kiosk::new(arg0);
        0x2::transfer::public_share_object<0x2::kiosk::Kiosk>(v0);
        0x2::transfer::public_transfer<0x2::kiosk::KioskOwnerCap>(v1, 0x2::tx_context::sender(arg0));
    }

    fun init(arg0: GOVERNANCE_NFTS_TEST, arg1: &mut 0x2::tx_context::TxContext) {
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
        let v3 = CollectionInfo{
            id          : 0x2::object::new(arg1),
            name        : 0x1::string::utf8(b"SuiLFG Test Governance NFTs"),
            description : 0x1::string::utf8(b"TEST collection for SuiLFG governance NFTs used for marketplace validation."),
            project_url : 0x1::string::utf8(b"https://www.suilfg.com"),
            twitter     : 0x1::string::utf8(b"https://x.com/SuiLFG_"),
            image_url   : 0x1::string::utf8(b"https://nft.suilfg.com/images/Council.png"),
        };
        0x2::transfer::share_object<CollectionInfo>(v3);
        let v4 = 0x2::package::claim<GOVERNANCE_NFTS_TEST>(arg0, arg1);
        let v5 = 0x1::vector::empty<0x1::string::String>();
        let v6 = 0x1::vector::empty<0x1::string::String>();
        0x1::vector::push_back<0x1::string::String>(&mut v5, 0x1::string::utf8(b"name"));
        0x1::vector::push_back<0x1::string::String>(&mut v6, 0x1::string::utf8(b"{name}"));
        0x1::vector::push_back<0x1::string::String>(&mut v5, 0x1::string::utf8(b"image_url"));
        0x1::vector::push_back<0x1::string::String>(&mut v6, 0x1::string::utf8(b"{image_url}"));
        0x1::vector::push_back<0x1::string::String>(&mut v5, 0x1::string::utf8(b"description"));
        0x1::vector::push_back<0x1::string::String>(&mut v6, 0x1::string::utf8(b"{description}"));
        0x2::transfer::public_share_object<0x2::display::Display<SuiLFG_NFT>>(0x2::display::new_with_fields<SuiLFG_NFT>(&v4, v5, v6, arg1));
        let (v7, v8) = 0x2::transfer_policy::new<SuiLFG_NFT>(&v4, arg1);
        0x2::transfer::public_share_object<0x2::transfer_policy::TransferPolicy<SuiLFG_NFT>>(v7);
        0x2::transfer::public_transfer<0x2::transfer_policy::TransferPolicyCap<SuiLFG_NFT>>(v8, v0);
        0x2::transfer::public_transfer<0x2::package::Publisher>(v4, v0);
    }

    public entry fun mint_one_to_wallet(arg0: &AdminCap, arg1: &mut MintingControl, arg2: 0x1::string::String, arg3: u64, arg4: address, arg5: &mut 0x2::tx_context::TxContext) {
        if (arg2 == 0x1::string::utf8(b"Council")) {
            assert!(arg1.council_minted + 1 <= 100, 405);
            arg1.council_minted = arg1.council_minted + 1;
            let v0 = 0x1::vector::empty<AttributeKV>();
            let v1 = AttributeKV{
                key   : 0x1::string::utf8(b"Tier"),
                value : 0x1::string::utf8(b"Council"),
            };
            0x1::vector::push_back<AttributeKV>(&mut v0, v1);
            let v2 = AttributeKV{
                key   : 0x1::string::utf8(b"Voting Power"),
                value : 0x1::string::utf8(b"25x"),
            };
            0x1::vector::push_back<AttributeKV>(&mut v0, v2);
            let v3 = SuiLFG_NFT{
                id          : 0x2::object::new(arg5),
                name        : 0x1::string::utf8(b"SuiLFG Test Council NFT"),
                image_url   : 0x1::string::utf8(b"https://nft.suilfg.com/images/Council.png"),
                description : 0x1::string::utf8(b"TEST: Highest tier governance NFT for SuiLFG."),
                attributes  : v0,
            };
            0x2::transfer::public_transfer<SuiLFG_NFT>(v3, arg4);
        } else if (arg2 == 0x1::string::utf8(b"Governor")) {
            assert!(arg1.governor_minted + 1 <= 1000, 405);
            arg1.governor_minted = arg1.governor_minted + 1;
            let v4 = 0x1::vector::empty<AttributeKV>();
            let v5 = AttributeKV{
                key   : 0x1::string::utf8(b"Tier"),
                value : 0x1::string::utf8(b"Governor"),
            };
            0x1::vector::push_back<AttributeKV>(&mut v4, v5);
            let v6 = AttributeKV{
                key   : 0x1::string::utf8(b"Voting Power"),
                value : 0x1::string::utf8(b"5x"),
            };
            0x1::vector::push_back<AttributeKV>(&mut v4, v6);
            let v7 = SuiLFG_NFT{
                id          : 0x2::object::new(arg5),
                name        : 0x1::string::utf8(b"SuiLFG Test Governor NFT"),
                image_url   : 0x1::string::utf8(b"https://nft.suilfg.com/images/Governor.png"),
                description : 0x1::string::utf8(b"TEST: High-tier governance NFT for SuiLFG."),
                attributes  : v4,
            };
            0x2::transfer::public_transfer<SuiLFG_NFT>(v7, arg4);
        } else {
            assert!(arg2 == 0x1::string::utf8(b"Voter"), 404);
            assert!(arg1.voter_minted + 1 <= 10000, 405);
            arg1.voter_minted = arg1.voter_minted + 1;
            let v8 = 0x1::vector::empty<AttributeKV>();
            let v9 = AttributeKV{
                key   : 0x1::string::utf8(b"Tier"),
                value : 0x1::string::utf8(b"Voter"),
            };
            0x1::vector::push_back<AttributeKV>(&mut v8, v9);
            let v10 = AttributeKV{
                key   : 0x1::string::utf8(b"Voting Power"),
                value : 0x1::string::utf8(b"1.5x"),
            };
            0x1::vector::push_back<AttributeKV>(&mut v8, v10);
            let v11 = SuiLFG_NFT{
                id          : 0x2::object::new(arg5),
                name        : 0x1::string::utf8(b"SuiLFG Test Voter NFT"),
                image_url   : 0x1::string::utf8(b"https://nft.suilfg.com/images/Voter.png"),
                description : 0x1::string::utf8(b"TEST: Foundational governance NFT for SuiLFG."),
                attributes  : v8,
            };
            0x2::transfer::public_transfer<SuiLFG_NFT>(v11, arg4);
        };
    }

    // decompiled from Move bytecode v6
}

