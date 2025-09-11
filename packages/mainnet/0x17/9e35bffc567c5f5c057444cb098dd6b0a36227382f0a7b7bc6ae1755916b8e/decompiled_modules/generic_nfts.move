module 0x179e35bffc567c5f5c057444cb098dd6b0a36227382f0a7b7bc6ae1755916b8e::generic_nfts {
    struct AdminCap has store, key {
        id: 0x2::object::UID,
    }

    struct MintingControl has key {
        id: 0x2::object::UID,
        tier1_minted: u64,
        tier2_minted: u64,
        tier3_minted: u64,
    }

    struct RoyaltyPolicy has key {
        id: 0x2::object::UID,
        royalty_bps: u16,
        recipient: address,
    }

    struct Generic_NFT has store, key {
        id: 0x2::object::UID,
        name: 0x1::string::String,
        description: 0x1::string::String,
        image_url: 0x1::string::String,
        metadata_url: 0x1::string::String,
        tier: 0x1::string::String,
    }

    struct CollectionInfo has key {
        id: 0x2::object::UID,
        name: 0x1::string::String,
        description: 0x1::string::String,
        project_url: 0x1::string::String,
        twitter: 0x1::string::String,
        image_url: 0x1::string::String,
    }

    struct GENERIC_NFTS has drop {
        dummy_field: bool,
    }

    public entry fun batch_mint_to_kiosk(arg0: &AdminCap, arg1: &mut MintingControl, arg2: 0x1::string::String, arg3: u64, arg4: u64, arg5: &0x2::transfer_policy::TransferPolicy<Generic_NFT>, arg6: &mut 0x2::kiosk::Kiosk, arg7: &0x2::kiosk::KioskOwnerCap, arg8: &mut 0x2::tx_context::TxContext) {
        let (v0, v1, v2, v3) = if (arg2 == 0x1::string::utf8(b"Alpha")) {
            assert!(arg1.tier1_minted + arg4 <= 100, 405);
            arg1.tier1_minted = arg1.tier1_minted + arg4;
            (0x1::string::utf8(b"The highest tier of collectible NFT..."), 0x1::string::utf8(b"https://nft.suilfg.com/images/Council.png"), 0x1::string::utf8(b"https://nft.suilfg.com/metadata/council.json"), 0x1::string::utf8(b"Awesome Alpha NFT #"))
        } else if (arg2 == 0x1::string::utf8(b"Beta")) {
            assert!(arg1.tier2_minted + arg4 <= 1000, 405);
            arg1.tier2_minted = arg1.tier2_minted + arg4;
            (0x1::string::utf8(b"A high-tier collectible NFT..."), 0x1::string::utf8(b"https://nft.suilfg.com/images/Governor.png"), 0x1::string::utf8(b"https://nft.suilfg.com/metadata/governor.json"), 0x1::string::utf8(b"Awesome Beta NFT #"))
        } else {
            assert!(arg2 == 0x1::string::utf8(b"Gamma"), 404);
            assert!(arg1.tier3_minted + arg4 <= 10000, 405);
            arg1.tier3_minted = arg1.tier3_minted + arg4;
            (0x1::string::utf8(b"A foundational collectible NFT..."), 0x1::string::utf8(b"https://nft.suilfg.com/images/Voter.png"), 0x1::string::utf8(b"https://nft.suilfg.com/metadata/voter.json"), 0x1::string::utf8(b"Awesome Gamma NFT #"))
        };
        let v4 = 0;
        while (v4 < arg4) {
            let v5 = v3;
            0x1::string::append(&mut v5, 0x1::u64::to_string(arg3 + v4));
            let v6 = Generic_NFT{
                id           : 0x2::object::new(arg8),
                name         : v5,
                description  : v0,
                image_url    : v1,
                metadata_url : v2,
                tier         : arg2,
            };
            0x2::kiosk::lock<Generic_NFT>(arg6, arg7, arg5, v6);
            v4 = v4 + 1;
        };
    }

    public entry fun create_kiosk_for_sender(arg0: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::kiosk::new(arg0);
        0x2::transfer::public_share_object<0x2::kiosk::Kiosk>(v0);
        0x2::transfer::public_transfer<0x2::kiosk::KioskOwnerCap>(v1, 0x2::tx_context::sender(arg0));
    }

    fun init(arg0: GENERIC_NFTS, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let v1 = AdminCap{id: 0x2::object::new(arg1)};
        0x2::transfer::public_transfer<AdminCap>(v1, v0);
        let v2 = MintingControl{
            id           : 0x2::object::new(arg1),
            tier1_minted : 0,
            tier2_minted : 0,
            tier3_minted : 0,
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
            name        : 0x1::string::utf8(b"My Awesome Collection"),
            description : 0x1::string::utf8(b"A multi-tiered collection of unique digital items."),
            project_url : 0x1::string::utf8(b"https://www.example.com"),
            twitter     : 0x1::string::utf8(b"https://x.com/example"),
            image_url   : 0x1::string::utf8(b"https://nft.suilfg.com/images/Council.png"),
        };
        0x2::transfer::share_object<CollectionInfo>(v4);
        let v5 = 0x2::package::claim<GENERIC_NFTS>(arg0, arg1);
        let v6 = 0x1::vector::empty<0x1::string::String>();
        let v7 = 0x1::vector::empty<0x1::string::String>();
        0x1::vector::push_back<0x1::string::String>(&mut v6, 0x1::string::utf8(b"name"));
        0x1::vector::push_back<0x1::string::String>(&mut v7, 0x1::string::utf8(b"{name}"));
        0x1::vector::push_back<0x1::string::String>(&mut v6, 0x1::string::utf8(b"description"));
        0x1::vector::push_back<0x1::string::String>(&mut v7, 0x1::string::utf8(b"{description}"));
        0x1::vector::push_back<0x1::string::String>(&mut v6, 0x1::string::utf8(b"image_url"));
        0x1::vector::push_back<0x1::string::String>(&mut v7, 0x1::string::utf8(b"{image_url}"));
        0x2::transfer::public_share_object<0x2::display::Display<Generic_NFT>>(0x2::display::new_with_fields<Generic_NFT>(&v5, v6, v7, arg1));
        let (v8, v9) = 0x2::transfer_policy::new<Generic_NFT>(&v5, arg1);
        0x2::transfer::public_share_object<0x2::transfer_policy::TransferPolicy<Generic_NFT>>(v8);
        0x2::transfer::public_transfer<0x2::transfer_policy::TransferPolicyCap<Generic_NFT>>(v9, v0);
        0x2::transfer::public_transfer<0x2::package::Publisher>(v5, v0);
    }

    public entry fun mint_one_to_wallet(arg0: &AdminCap, arg1: &mut MintingControl, arg2: 0x1::string::String, arg3: u64, arg4: address, arg5: &mut 0x2::tx_context::TxContext) {
        let (v0, v1, v2, v3) = if (arg2 == 0x1::string::utf8(b"Alpha")) {
            assert!(arg1.tier1_minted + 1 <= 100, 405);
            arg1.tier1_minted = arg1.tier1_minted + 1;
            (0x1::string::utf8(b"The highest tier of collectible NFT..."), 0x1::string::utf8(b"https://nft.suilfg.com/images/Council.png"), 0x1::string::utf8(b"https://nft.suilfg.com/metadata/council.json"), 0x1::string::utf8(b"Awesome Alpha NFT #"))
        } else if (arg2 == 0x1::string::utf8(b"Beta")) {
            assert!(arg1.tier2_minted + 1 <= 1000, 405);
            arg1.tier2_minted = arg1.tier2_minted + 1;
            (0x1::string::utf8(b"A high-tier collectible NFT..."), 0x1::string::utf8(b"https://nft.suilfg.com/images/Governor.png"), 0x1::string::utf8(b"https://nft.suilfg.com/metadata/governor.json"), 0x1::string::utf8(b"Awesome Beta NFT #"))
        } else {
            assert!(arg2 == 0x1::string::utf8(b"Gamma"), 404);
            assert!(arg1.tier3_minted + 1 <= 10000, 405);
            arg1.tier3_minted = arg1.tier3_minted + 1;
            (0x1::string::utf8(b"A foundational collectible NFT..."), 0x1::string::utf8(b"https://nft.suilfg.com/images/Voter.png"), 0x1::string::utf8(b"https://nft.suilfg.com/metadata/voter.json"), 0x1::string::utf8(b"Awesome Gamma NFT #"))
        };
        let v4 = v3;
        0x1::string::append(&mut v4, 0x1::u64::to_string(arg3));
        let v5 = Generic_NFT{
            id           : 0x2::object::new(arg5),
            name         : v4,
            description  : v0,
            image_url    : v1,
            metadata_url : v2,
            tier         : arg2,
        };
        0x2::transfer::public_transfer<Generic_NFT>(v5, arg4);
    }

    // decompiled from Move bytecode v6
}

