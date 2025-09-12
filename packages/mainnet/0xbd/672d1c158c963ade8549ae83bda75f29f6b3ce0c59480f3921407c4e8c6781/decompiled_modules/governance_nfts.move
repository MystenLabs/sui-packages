module 0xbd672d1c158c963ade8549ae83bda75f29f6b3ce0c59480f3921407c4e8c6781::governance_nfts {
    struct AdminCap has store, key {
        id: 0x2::object::UID,
    }

    struct MintingControl has key {
        id: 0x2::object::UID,
        council_minted: u64,
        governor_minted: u64,
        voter_minted: u64,
    }

    struct SuiLFG_NFT has store, key {
        id: 0x2::object::UID,
        name: 0x1::string::String,
        image_url: 0x1::string::String,
        description: 0x1::string::String,
        attributes: vector<AttributeKV>,
    }

    struct AttributeKV has drop, store {
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

    struct GOVERNANCE_NFTS has drop {
        dummy_field: bool,
    }

    public fun batch_mint_to_kiosk(arg0: &AdminCap, arg1: &mut MintingControl, arg2: u8, arg3: u64, arg4: u64, arg5: &0x2::transfer_policy::TransferPolicy<SuiLFG_NFT>, arg6: &mut 0x2::kiosk::Kiosk, arg7: &0x2::kiosk::KioskOwnerCap, arg8: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = if (arg2 == 0) {
            let v0 = &mut arg1.council_minted;
            (v0, 100)
        } else {
            let (v2, v3) = if (arg2 == 1) {
                (&mut arg1.governor_minted, 1000)
            } else {
                (&mut arg1.voter_minted, 10000)
            };
            let v0 = v2;
            (v0, v3)
        };
        assert!(*v0 + arg4 <= v1, 405);
        assert!(arg3 == *v0 + 1, 406);
        *v0 = *v0 + arg4;
        let (v4, v5, v6) = get_tier_metadata(arg2);
        let v7 = 0;
        while (v7 < arg4) {
            let v8 = SuiLFG_NFT{
                id          : 0x2::object::new(arg8),
                name        : v4,
                image_url   : 0x1::string::utf8(v5),
                description : v6,
                attributes  : create_tier_attributes(arg2),
            };
            0x2::kiosk::lock<SuiLFG_NFT>(arg6, arg7, arg5, v8);
            v7 = v7 + 1;
        };
    }

    public fun create_kiosk_for_sender(arg0: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::kiosk::new(arg0);
        0x2::transfer::public_share_object<0x2::kiosk::Kiosk>(v0);
        0x2::transfer::public_transfer<0x2::kiosk::KioskOwnerCap>(v1, 0x2::tx_context::sender(arg0));
    }

    fun create_tier_attributes(arg0: u8) : vector<AttributeKV> {
        let v0 = 0x1::vector::empty<AttributeKV>();
        if (arg0 == 0) {
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
        } else if (arg0 == 1) {
            let v3 = AttributeKV{
                key   : 0x1::string::utf8(b"Tier"),
                value : 0x1::string::utf8(b"Governor"),
            };
            0x1::vector::push_back<AttributeKV>(&mut v0, v3);
            let v4 = AttributeKV{
                key   : 0x1::string::utf8(b"Voting Power"),
                value : 0x1::string::utf8(b"5x"),
            };
            0x1::vector::push_back<AttributeKV>(&mut v0, v4);
        } else {
            let v5 = AttributeKV{
                key   : 0x1::string::utf8(b"Tier"),
                value : 0x1::string::utf8(b"Voter"),
            };
            0x1::vector::push_back<AttributeKV>(&mut v0, v5);
            let v6 = AttributeKV{
                key   : 0x1::string::utf8(b"Voting Power"),
                value : 0x1::string::utf8(b"1.5x"),
            };
            0x1::vector::push_back<AttributeKV>(&mut v0, v6);
        };
        v0
    }

    fun get_tier_metadata(arg0: u8) : (0x1::string::String, vector<u8>, 0x1::string::String) {
        if (arg0 == 0) {
            (0x1::string::utf8(b"SuiLFG Council NFT"), b"https://nft.suilfg.com/images/Council.png", 0x1::string::utf8(b"The highest tier of governance NFT..."))
        } else if (arg0 == 1) {
            (0x1::string::utf8(b"SuiLFG Governor NFT"), b"https://nft.suilfg.com/images/Governor.png", 0x1::string::utf8(b"A high-tier governance NFT..."))
        } else {
            (0x1::string::utf8(b"SuiLFG Voter NFT"), b"https://nft.suilfg.com/images/Voter.png", 0x1::string::utf8(b"A foundational SuiLFG governance NFT"))
        }
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
        let v3 = CollectionInfo{
            id          : 0x2::object::new(arg1),
            name        : 0x1::string::utf8(b"SuiLFG Governance NFTs"),
            description : 0x1::string::utf8(b"A multi-tiered governance NFT collection."),
            project_url : 0x1::string::utf8(b"https://www.suilfg.com"),
            twitter     : 0x1::string::utf8(b"https://x.com/SuiLFG_"),
            image_url   : 0x1::string::utf8(b"https://nft.suilfg.com/images/Council.png"),
        };
        0x2::transfer::share_object<CollectionInfo>(v3);
        let v4 = 0x2::package::claim<GOVERNANCE_NFTS>(arg0, arg1);
        let v5 = 0x1::vector::empty<0x1::string::String>();
        let v6 = 0x1::vector::empty<0x1::string::String>();
        0x1::vector::push_back<0x1::string::String>(&mut v5, 0x1::string::utf8(b"name"));
        0x1::vector::push_back<0x1::string::String>(&mut v6, 0x1::string::utf8(b"{name}"));
        0x1::vector::push_back<0x1::string::String>(&mut v5, 0x1::string::utf8(b"image_url"));
        0x1::vector::push_back<0x1::string::String>(&mut v6, 0x1::string::utf8(b"{image_url}"));
        0x1::vector::push_back<0x1::string::String>(&mut v5, 0x1::string::utf8(b"description"));
        0x1::vector::push_back<0x1::string::String>(&mut v6, 0x1::string::utf8(b"{description}"));
        0x1::vector::push_back<0x1::string::String>(&mut v5, 0x1::string::utf8(b"url"));
        0x1::vector::push_back<0x1::string::String>(&mut v6, 0x1::string::utf8(b"https://nft.suilfg.com/metadata/{id}.json"));
        0x2::transfer::public_share_object<0x2::display::Display<SuiLFG_NFT>>(0x2::display::new_with_fields<SuiLFG_NFT>(&v4, v5, v6, arg1));
        let (v7, v8) = 0x2::transfer_policy::new<SuiLFG_NFT>(&v4, arg1);
        0x2::transfer::public_share_object<0x2::transfer_policy::TransferPolicy<SuiLFG_NFT>>(v7);
        0x2::transfer::public_transfer<0x2::transfer_policy::TransferPolicyCap<SuiLFG_NFT>>(v8, v0);
        0x2::transfer::public_transfer<0x2::package::Publisher>(v4, v0);
    }

    public fun mint_one_to_wallet(arg0: &AdminCap, arg1: &mut MintingControl, arg2: u8, arg3: u64, arg4: address, arg5: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = if (arg2 == 0) {
            let v0 = &mut arg1.council_minted;
            (v0, 100)
        } else {
            let (v2, v3) = if (arg2 == 1) {
                (&mut arg1.governor_minted, 1000)
            } else {
                (&mut arg1.voter_minted, 10000)
            };
            let v0 = v2;
            (v0, v3)
        };
        assert!(*v0 + 1 <= v1, 405);
        assert!(arg3 == *v0 + 1, 406);
        *v0 = *v0 + 1;
        let (v4, v5, v6) = get_tier_metadata(arg2);
        let v7 = SuiLFG_NFT{
            id          : 0x2::object::new(arg5),
            name        : v4,
            image_url   : 0x1::string::utf8(v5),
            description : v6,
            attributes  : create_tier_attributes(arg2),
        };
        0x2::transfer::public_transfer<SuiLFG_NFT>(v7, arg4);
    }

    // decompiled from Move bytecode v6
}

