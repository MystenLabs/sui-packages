module 0x612009ac5ddbe1273f78e3c71fa1073da72da0d5605aeb40f1934fffbd9232a2::generic_nfts {
    struct AdminCap has store, key {
        id: 0x2::object::UID,
    }

    struct MintingControl has key {
        id: 0x2::object::UID,
        tier1_minted: u64,
        tier2_minted: u64,
        tier3_minted: u64,
    }

    struct Generic_NFT has store, key {
        id: 0x2::object::UID,
        name: 0x1::string::String,
        description: 0x1::string::String,
        image_url: 0x1::string::String,
        metadata_url: 0x1::string::String,
        tier: 0x1::string::String,
        edition: u64,
        attributes: vector<AttributeKV>,
    }

    struct AttributeKV has store {
        key: 0x1::string::String,
        value: 0x1::string::String,
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
        if (arg2 == 0x1::string::utf8(b"Alpha")) {
            let v0 = arg1.tier1_minted;
            assert!(v0 + arg4 <= 100, 405);
            assert!(arg3 == v0 + 1, 406);
            arg1.tier1_minted = v0 + arg4;
            let v1 = 0;
            while (v1 < arg4) {
                let v2 = 0x1::vector::empty<AttributeKV>();
                let v3 = AttributeKV{
                    key   : 0x1::string::utf8(b"Tier"),
                    value : 0x1::string::utf8(b"Alpha"),
                };
                0x1::vector::push_back<AttributeKV>(&mut v2, v3);
                let v4 = AttributeKV{
                    key   : 0x1::string::utf8(b"Power Level"),
                    value : 0x1::string::utf8(b"High"),
                };
                0x1::vector::push_back<AttributeKV>(&mut v2, v4);
                let v5 = Generic_NFT{
                    id           : 0x2::object::new(arg8),
                    name         : 0x1::string::utf8(b"Awesome Alpha NFT"),
                    description  : 0x1::string::utf8(b"The highest tier of collectible NFT..."),
                    image_url    : 0x1::string::utf8(b"https://nft.suilfg.com/images/Council.png"),
                    metadata_url : 0x1::string::utf8(b"https://nft.suilfg.com/metadata/council.json"),
                    tier         : 0x1::string::utf8(b"Alpha"),
                    edition      : arg3 + v1,
                    attributes   : v2,
                };
                0x2::kiosk::lock<Generic_NFT>(arg6, arg7, arg5, v5);
                v1 = v1 + 1;
            };
        } else if (arg2 == 0x1::string::utf8(b"Beta")) {
            let v6 = arg1.tier2_minted;
            assert!(v6 + arg4 <= 1000, 405);
            assert!(arg3 == v6 + 1, 406);
            arg1.tier2_minted = v6 + arg4;
            let v7 = 0;
            while (v7 < arg4) {
                let v8 = 0x1::vector::empty<AttributeKV>();
                let v9 = AttributeKV{
                    key   : 0x1::string::utf8(b"Tier"),
                    value : 0x1::string::utf8(b"Beta"),
                };
                0x1::vector::push_back<AttributeKV>(&mut v8, v9);
                let v10 = AttributeKV{
                    key   : 0x1::string::utf8(b"Power Level"),
                    value : 0x1::string::utf8(b"Medium"),
                };
                0x1::vector::push_back<AttributeKV>(&mut v8, v10);
                let v11 = Generic_NFT{
                    id           : 0x2::object::new(arg8),
                    name         : 0x1::string::utf8(b"Awesome Beta NFT"),
                    description  : 0x1::string::utf8(b"A high-tier collectible NFT..."),
                    image_url    : 0x1::string::utf8(b"https://nft.suilfg.com/images/Governor.png"),
                    metadata_url : 0x1::string::utf8(b"https://nft.suilfg.com/metadata/governor.json"),
                    tier         : 0x1::string::utf8(b"Beta"),
                    edition      : arg3 + v7,
                    attributes   : v8,
                };
                0x2::kiosk::lock<Generic_NFT>(arg6, arg7, arg5, v11);
                v7 = v7 + 1;
            };
        } else {
            assert!(arg2 == 0x1::string::utf8(b"Gamma"), 404);
            let v12 = arg1.tier3_minted;
            assert!(v12 + arg4 <= 10000, 405);
            assert!(arg3 == v12 + 1, 406);
            arg1.tier3_minted = v12 + arg4;
            let v13 = 0;
            while (v13 < arg4) {
                let v14 = 0x1::vector::empty<AttributeKV>();
                let v15 = AttributeKV{
                    key   : 0x1::string::utf8(b"Tier"),
                    value : 0x1::string::utf8(b"Gamma"),
                };
                0x1::vector::push_back<AttributeKV>(&mut v14, v15);
                let v16 = AttributeKV{
                    key   : 0x1::string::utf8(b"Power Level"),
                    value : 0x1::string::utf8(b"Standard"),
                };
                0x1::vector::push_back<AttributeKV>(&mut v14, v16);
                let v17 = Generic_NFT{
                    id           : 0x2::object::new(arg8),
                    name         : 0x1::string::utf8(b"Awesome Gamma NFT"),
                    description  : 0x1::string::utf8(b"A foundational collectible NFT"),
                    image_url    : 0x1::string::utf8(b"https://nft.suilfg.com/images/Voter.png"),
                    metadata_url : 0x1::string::utf8(b"https://nft.suilfg.com/metadata/voter.json"),
                    tier         : 0x1::string::utf8(b"Gamma"),
                    edition      : arg3 + v13,
                    attributes   : v14,
                };
                0x2::kiosk::lock<Generic_NFT>(arg6, arg7, arg5, v17);
                v13 = v13 + 1;
            };
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
        let v3 = CollectionInfo{
            id          : 0x2::object::new(arg1),
            name        : 0x1::string::utf8(b"My Awesome Collection"),
            description : 0x1::string::utf8(b"A multi-tiered collection of unique digital items."),
            project_url : 0x1::string::utf8(b"https://www.example.com"),
            twitter     : 0x1::string::utf8(b"https://x.com/example"),
            image_url   : 0x1::string::utf8(b"https://nft.suilfg.com/images/Council.png"),
        };
        0x2::transfer::share_object<CollectionInfo>(v3);
        let v4 = 0x2::package::claim<GENERIC_NFTS>(arg0, arg1);
        let v5 = 0x1::vector::empty<0x1::string::String>();
        let v6 = 0x1::vector::empty<0x1::string::String>();
        0x1::vector::push_back<0x1::string::String>(&mut v5, 0x1::string::utf8(b"name"));
        0x1::vector::push_back<0x1::string::String>(&mut v6, 0x1::string::utf8(b"{name}"));
        0x1::vector::push_back<0x1::string::String>(&mut v5, 0x1::string::utf8(b"description"));
        0x1::vector::push_back<0x1::string::String>(&mut v6, 0x1::string::utf8(b"{description}"));
        0x1::vector::push_back<0x1::string::String>(&mut v5, 0x1::string::utf8(b"image_url"));
        0x1::vector::push_back<0x1::string::String>(&mut v6, 0x1::string::utf8(b"{image_url}"));
        0x1::vector::push_back<0x1::string::String>(&mut v5, 0x1::string::utf8(b"external_url"));
        0x1::vector::push_back<0x1::string::String>(&mut v6, 0x1::string::utf8(b"{metadata_url}"));
        0x2::transfer::public_share_object<0x2::display::Display<Generic_NFT>>(0x2::display::new_with_fields<Generic_NFT>(&v4, v5, v6, arg1));
        let (v7, v8) = 0x2::transfer_policy::new<Generic_NFT>(&v4, arg1);
        0x2::transfer::public_share_object<0x2::transfer_policy::TransferPolicy<Generic_NFT>>(v7);
        0x2::transfer::public_transfer<0x2::transfer_policy::TransferPolicyCap<Generic_NFT>>(v8, v0);
        0x2::transfer::public_transfer<0x2::package::Publisher>(v4, v0);
    }

    public entry fun mint_one_to_wallet(arg0: &AdminCap, arg1: &mut MintingControl, arg2: 0x1::string::String, arg3: u64, arg4: address, arg5: &mut 0x2::tx_context::TxContext) {
        if (arg2 == 0x1::string::utf8(b"Alpha")) {
            let v0 = arg1.tier1_minted;
            assert!(v0 + 1 <= 100, 405);
            assert!(arg3 == v0 + 1, 406);
            arg1.tier1_minted = v0 + 1;
            let v1 = 0x1::vector::empty<AttributeKV>();
            let v2 = AttributeKV{
                key   : 0x1::string::utf8(b"Tier"),
                value : 0x1::string::utf8(b"Alpha"),
            };
            0x1::vector::push_back<AttributeKV>(&mut v1, v2);
            let v3 = AttributeKV{
                key   : 0x1::string::utf8(b"Power Level"),
                value : 0x1::string::utf8(b"High"),
            };
            0x1::vector::push_back<AttributeKV>(&mut v1, v3);
            let v4 = Generic_NFT{
                id           : 0x2::object::new(arg5),
                name         : 0x1::string::utf8(b"Awesome Alpha NFT"),
                description  : 0x1::string::utf8(b"The highest tier of collectible NFT..."),
                image_url    : 0x1::string::utf8(b"https://nft.suilfg.com/images/Council.png"),
                metadata_url : 0x1::string::utf8(b"https://nft.suilfg.com/metadata/council.json"),
                tier         : 0x1::string::utf8(b"Alpha"),
                edition      : arg3,
                attributes   : v1,
            };
            0x2::transfer::public_transfer<Generic_NFT>(v4, arg4);
        } else if (arg2 == 0x1::string::utf8(b"Beta")) {
            let v5 = arg1.tier2_minted;
            assert!(v5 + 1 <= 1000, 405);
            assert!(arg3 == v5 + 1, 406);
            arg1.tier2_minted = v5 + 1;
            let v6 = 0x1::vector::empty<AttributeKV>();
            let v7 = AttributeKV{
                key   : 0x1::string::utf8(b"Tier"),
                value : 0x1::string::utf8(b"Beta"),
            };
            0x1::vector::push_back<AttributeKV>(&mut v6, v7);
            let v8 = AttributeKV{
                key   : 0x1::string::utf8(b"Power Level"),
                value : 0x1::string::utf8(b"Medium"),
            };
            0x1::vector::push_back<AttributeKV>(&mut v6, v8);
            let v9 = Generic_NFT{
                id           : 0x2::object::new(arg5),
                name         : 0x1::string::utf8(b"Awesome Beta NFT"),
                description  : 0x1::string::utf8(b"A high-tier collectible NFT..."),
                image_url    : 0x1::string::utf8(b"https://nft.suilfg.com/images/Governor.png"),
                metadata_url : 0x1::string::utf8(b"https://nft.suilfg.com/metadata/governor.json"),
                tier         : 0x1::string::utf8(b"Beta"),
                edition      : arg3,
                attributes   : v6,
            };
            0x2::transfer::public_transfer<Generic_NFT>(v9, arg4);
        } else {
            assert!(arg2 == 0x1::string::utf8(b"Gamma"), 404);
            let v10 = arg1.tier3_minted;
            assert!(v10 + 1 <= 10000, 405);
            assert!(arg3 == v10 + 1, 406);
            arg1.tier3_minted = v10 + 1;
            let v11 = 0x1::vector::empty<AttributeKV>();
            let v12 = AttributeKV{
                key   : 0x1::string::utf8(b"Tier"),
                value : 0x1::string::utf8(b"Gamma"),
            };
            0x1::vector::push_back<AttributeKV>(&mut v11, v12);
            let v13 = AttributeKV{
                key   : 0x1::string::utf8(b"Power Level"),
                value : 0x1::string::utf8(b"Standard"),
            };
            0x1::vector::push_back<AttributeKV>(&mut v11, v13);
            let v14 = Generic_NFT{
                id           : 0x2::object::new(arg5),
                name         : 0x1::string::utf8(b"Awesome Gamma NFT"),
                description  : 0x1::string::utf8(b"A foundational collectible NFT"),
                image_url    : 0x1::string::utf8(b"https://nft.suilfg.com/images/Voter.png"),
                metadata_url : 0x1::string::utf8(b"https://nft.suilfg.com/metadata/voter.json"),
                tier         : 0x1::string::utf8(b"Gamma"),
                edition      : arg3,
                attributes   : v11,
            };
            0x2::transfer::public_transfer<Generic_NFT>(v14, arg4);
        };
    }

    // decompiled from Move bytecode v6
}

