module 0x3607d74b9141ed61882e77cf367038f782cd29ad4c5687e25652809fd97e7ade::suimon_nft {
    struct SUIMON_NFT has drop {
        dummy_field: bool,
    }

    struct AdminCap has store, key {
        id: 0x2::object::UID,
    }

    struct MintConfig has key {
        id: 0x2::object::UID,
        tier1_price: u64,
        tier2_price: u64,
        tier3_price: u64,
        tier4_price: u64,
        tier1_minted: u64,
        tier2_minted: u64,
        tier3_minted: u64,
        tier4_minted: u64,
        next_token_id: u64,
        treasury: address,
        paused: bool,
    }

    struct SuimonNFT has store, key {
        id: 0x2::object::UID,
        name: 0x1::string::String,
        image_url: 0x1::string::String,
        description: 0x1::string::String,
        tier: u8,
        token_id: u64,
    }

    struct MintEvent has copy, drop {
        nft_id: address,
        name: 0x1::string::String,
        tier: u8,
        token_id: u64,
        recipient: address,
    }

    public entry fun admin_mint(arg0: &AdminCap, arg1: &mut MintConfig, arg2: u8, arg3: vector<u8>, arg4: vector<u8>, arg5: vector<u8>, arg6: address, arg7: &mut 0x2::tx_context::TxContext) {
        let v0 = create_nft(arg1, arg2, arg3, arg4, arg5, arg7);
        let v1 = MintEvent{
            nft_id    : 0x2::object::uid_to_address(&v0.id),
            name      : v0.name,
            tier      : v0.tier,
            token_id  : v0.token_id,
            recipient : arg6,
        };
        0x2::event::emit<MintEvent>(v1);
        0x2::transfer::public_transfer<SuimonNFT>(v0, arg6);
    }

    fun create_nft(arg0: &mut MintConfig, arg1: u8, arg2: vector<u8>, arg3: vector<u8>, arg4: vector<u8>, arg5: &mut 0x2::tx_context::TxContext) : SuimonNFT {
        assert!(arg1 >= 1 && arg1 <= 4, 2);
        let v0 = arg0.next_token_id;
        arg0.next_token_id = arg0.next_token_id + 1;
        increment_minted(arg0, arg1);
        SuimonNFT{
            id          : 0x2::object::new(arg5),
            name        : 0x1::string::utf8(arg2),
            image_url   : 0x1::string::utf8(arg3),
            description : 0x1::string::utf8(arg4),
            tier        : arg1,
            token_id    : v0,
        }
    }

    fun increment_minted(arg0: &mut MintConfig, arg1: u8) {
        if (arg1 == 1) {
            arg0.tier1_minted = arg0.tier1_minted + 1;
        } else if (arg1 == 2) {
            arg0.tier2_minted = arg0.tier2_minted + 1;
        } else if (arg1 == 3) {
            arg0.tier3_minted = arg0.tier3_minted + 1;
        } else {
            assert!(arg1 == 4, 2);
            arg0.tier4_minted = arg0.tier4_minted + 1;
        };
    }

    fun init(arg0: SUIMON_NFT, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::package::claim<SUIMON_NFT>(arg0, arg1);
        let v1 = 0x2::tx_context::sender(arg1);
        let v2 = 0x1::vector::empty<0x1::string::String>();
        let v3 = &mut v2;
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"name"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"description"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"image_url"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"tier"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"token_id"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"project_url"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"creator"));
        let v4 = 0x1::vector::empty<0x1::string::String>();
        let v5 = &mut v4;
        0x1::vector::push_back<0x1::string::String>(v5, 0x1::string::utf8(b"{name}"));
        0x1::vector::push_back<0x1::string::String>(v5, 0x1::string::utf8(b"{description}"));
        0x1::vector::push_back<0x1::string::String>(v5, 0x1::string::utf8(b"{image_url}"));
        0x1::vector::push_back<0x1::string::String>(v5, 0x1::string::utf8(b"{tier}"));
        0x1::vector::push_back<0x1::string::String>(v5, 0x1::string::utf8(b"{token_id}"));
        0x1::vector::push_back<0x1::string::String>(v5, 0x1::string::utf8(b"https://cutforsuimon.com"));
        0x1::vector::push_back<0x1::string::String>(v5, 0x1::string::utf8(b"Suimon Labs"));
        let v6 = 0x2::display::new_with_fields<SuimonNFT>(&v0, v2, v4, arg1);
        0x2::display::update_version<SuimonNFT>(&mut v6);
        let (v7, v8) = 0x2::transfer_policy::new<SuimonNFT>(&v0, arg1);
        let v9 = AdminCap{id: 0x2::object::new(arg1)};
        let v10 = MintConfig{
            id            : 0x2::object::new(arg1),
            tier1_price   : 100000000,
            tier2_price   : 2000000000,
            tier3_price   : 5000000000,
            tier4_price   : 10000000000,
            tier1_minted  : 0,
            tier2_minted  : 0,
            tier3_minted  : 0,
            tier4_minted  : 0,
            next_token_id : 1,
            treasury      : v1,
            paused        : false,
        };
        0x2::transfer::transfer<AdminCap>(v9, v1);
        0x2::transfer::public_transfer<0x2::transfer_policy::TransferPolicyCap<SuimonNFT>>(v8, v1);
        0x2::transfer::public_share_object<0x2::transfer_policy::TransferPolicy<SuimonNFT>>(v7);
        0x2::transfer::share_object<MintConfig>(v10);
        0x2::transfer::public_transfer<0x2::display::Display<SuimonNFT>>(v6, v1);
        0x2::transfer::public_transfer<0x2::package::Publisher>(v0, v1);
    }

    public entry fun mint(arg0: &mut MintConfig, arg1: u8, arg2: vector<u8>, arg3: vector<u8>, arg4: vector<u8>, arg5: 0x2::coin::Coin<0x2::sui::SUI>, arg6: &mut 0x2::tx_context::TxContext) {
        assert!(!arg0.paused, 3);
        let v0 = tier_price(arg0, arg1);
        assert!(0x2::coin::value<0x2::sui::SUI>(&arg5) >= v0, 0);
        assert!(tier_minted(arg0, arg1) < tier_max(arg1), 1);
        let v1 = 0x2::coin::value<0x2::sui::SUI>(&arg5);
        if (v1 > v0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::split<0x2::sui::SUI>(&mut arg5, v1 - v0, arg6), 0x2::tx_context::sender(arg6));
        };
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(arg5, arg0.treasury);
        let v2 = create_nft(arg0, arg1, arg2, arg3, arg4, arg6);
        let v3 = 0x2::tx_context::sender(arg6);
        let v4 = MintEvent{
            nft_id    : 0x2::object::uid_to_address(&v2.id),
            name      : v2.name,
            tier      : v2.tier,
            token_id  : v2.token_id,
            recipient : v3,
        };
        0x2::event::emit<MintEvent>(v4);
        0x2::transfer::public_transfer<SuimonNFT>(v2, v3);
    }

    public entry fun set_paused(arg0: &AdminCap, arg1: &mut MintConfig, arg2: bool) {
        arg1.paused = arg2;
    }

    public entry fun set_tier_price(arg0: &AdminCap, arg1: &mut MintConfig, arg2: u8, arg3: u64) {
        if (arg2 == 1) {
            arg1.tier1_price = arg3;
        } else if (arg2 == 2) {
            arg1.tier2_price = arg3;
        } else if (arg2 == 3) {
            arg1.tier3_price = arg3;
        } else {
            assert!(arg2 == 4, 2);
            arg1.tier4_price = arg3;
        };
    }

    public entry fun set_treasury(arg0: &AdminCap, arg1: &mut MintConfig, arg2: address) {
        arg1.treasury = arg2;
    }

    fun tier_max(arg0: u8) : u64 {
        if (arg0 == 1) {
            30
        } else if (arg0 == 2) {
            30
        } else if (arg0 == 3) {
            30
        } else {
            assert!(arg0 == 4, 2);
            50
        }
    }

    fun tier_minted(arg0: &MintConfig, arg1: u8) : u64 {
        if (arg1 == 1) {
            arg0.tier1_minted
        } else if (arg1 == 2) {
            arg0.tier2_minted
        } else if (arg1 == 3) {
            arg0.tier3_minted
        } else {
            assert!(arg1 == 4, 2);
            arg0.tier4_minted
        }
    }

    fun tier_price(arg0: &MintConfig, arg1: u8) : u64 {
        if (arg1 == 1) {
            arg0.tier1_price
        } else if (arg1 == 2) {
            arg0.tier2_price
        } else if (arg1 == 3) {
            arg0.tier3_price
        } else {
            assert!(arg1 == 4, 2);
            arg0.tier4_price
        }
    }

    // decompiled from Move bytecode v7
}

