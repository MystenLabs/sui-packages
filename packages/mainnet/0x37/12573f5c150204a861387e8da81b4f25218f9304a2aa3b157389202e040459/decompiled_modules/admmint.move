module 0x6a29b3b80de2bd69ee94b2a2f11e5bf2e3614d1cc08f1cb16eefa290bc859cb0::admmint {
    struct Minted {
        owner: address,
        count: u64,
    }

    struct AdmMint has key {
        id: 0x2::object::UID,
        number: u64,
        max_mint: u64,
        mint_per_time: u64,
        whitelist: vector<address>,
        randoms: vector<u8>,
        creator: address,
        active: bool,
        image_og: 0x1::string::String,
        image_tier1: 0x1::string::String,
        image_tier2: 0x1::string::String,
        image_tier3: 0x1::string::String,
        image_tier4: 0x1::string::String,
        image_tier5: 0x1::string::String,
        image_pfp1: 0x1::string::String,
        image_pfp2: 0x1::string::String,
        image_pfp3: 0x1::string::String,
        image_pfp4: 0x1::string::String,
    }

    public entry fun add_address_into_whitelist(arg0: &mut AdmMint, arg1: address, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.creator == 0x2::tx_context::sender(arg2), 1);
        assert!(!0x1::vector::contains<address>(&arg0.whitelist, &arg1), 3);
        0x1::vector::push_back<address>(&mut arg0.whitelist, arg1);
    }

    public entry fun create_mint(arg0: u64, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(@0xbb47b7e40f8e1f7f4cd6f15bdeceaccb2afcc103396fc70456dbc2b63f647679 == 0x2::tx_context::sender(arg2), 1);
        let v0 = AdmMint{
            id            : 0x2::object::new(arg2),
            number        : 0,
            max_mint      : arg1,
            mint_per_time : arg0,
            whitelist     : 0x1::vector::empty<address>(),
            randoms       : 0x1::vector::empty<u8>(),
            creator       : 0x2::tx_context::sender(arg2),
            active        : true,
            image_og      : 0x1::string::utf8(b"https://files.yousui.io/mint/YouSUI_NFT_OGROLE.png"),
            image_tier1   : 0x1::string::utf8(b"https://files.yousui.io/mint/YouSUI_NFT_TIER1.png"),
            image_tier2   : 0x1::string::utf8(b"https://files.yousui.io/mint/YouSUI_NFT_TIER2.png"),
            image_tier3   : 0x1::string::utf8(b"https://files.yousui.io/mint/YouSUI_NFT_TIER3.png"),
            image_tier4   : 0x1::string::utf8(b"https://files.yousui.io/mint/YouSUI_NFT_TIER4.png"),
            image_tier5   : 0x1::string::utf8(b"https://files.yousui.io/mint/YouSUI_NFT_TIER5.png"),
            image_pfp1    : 0x1::string::utf8(b"https://files.yousui.io/mint/YouSUI_NFT_PFP1.png"),
            image_pfp2    : 0x1::string::utf8(b"https://files.yousui.io/mint/YouSUI_NFT_PFP2.png"),
            image_pfp3    : 0x1::string::utf8(b"https://files.yousui.io/mint/YouSUI_NFT_PFP3.png"),
            image_pfp4    : 0x1::string::utf8(b"https://files.yousui.io/mint/YouSUI_NFT_PFP4.png"),
        };
        0x2::transfer::share_object<AdmMint>(v0);
    }

    fun get_image_url(arg0: vector<u8>, arg1: &mut AdmMint) : vector<u8> {
        let v0 = b"";
        if (arg0 == b"5") {
            v0 = *0x1::string::bytes(&arg1.image_tier5);
        };
        if (arg0 == b"4") {
            v0 = *0x1::string::bytes(&arg1.image_tier4);
        };
        if (arg0 == b"3") {
            v0 = *0x1::string::bytes(&arg1.image_tier3);
        };
        if (arg0 == b"2") {
            v0 = *0x1::string::bytes(&arg1.image_tier2);
        };
        if (arg0 == b"1") {
            v0 = *0x1::string::bytes(&arg1.image_tier1);
        };
        if (arg0 == b"og") {
            v0 = *0x1::string::bytes(&arg1.image_og);
        };
        if (arg0 == b"pfp") {
            if (arg1.number % 4 == 0) {
                v0 = *0x1::string::bytes(&arg1.image_pfp4);
            };
            if (arg1.number % 4 == 1) {
                v0 = *0x1::string::bytes(&arg1.image_pfp1);
            };
            if (arg1.number % 4 == 2) {
                v0 = *0x1::string::bytes(&arg1.image_pfp2);
            };
            if (arg1.number % 4 == 3) {
                v0 = *0x1::string::bytes(&arg1.image_pfp3);
            };
        };
        v0
    }

    fun get_type(arg0: u8) : vector<u8> {
        let v0 = b"pfp";
        if (arg0 == 0) {
            v0 = b"og";
        };
        if (arg0 == 1) {
            v0 = b"1";
        };
        if (arg0 == 2) {
            v0 = b"2";
        };
        if (arg0 == 3) {
            v0 = b"3";
        };
        if (arg0 == 4) {
            v0 = b"4";
        };
        if (arg0 == 5) {
            v0 = b"5";
        };
        v0
    }

    public entry fun mint(arg0: &mut AdmMint, arg1: &mut 0x6a29b3b80de2bd69ee94b2a2f11e5bf2e3614d1cc08f1cb16eefa290bc859cb0::nft::Infomation, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg2);
        assert!(arg0.active == true, 7);
        assert!(0x1::vector::contains<address>(&arg0.whitelist, &v0), 2);
        let v1 = 0;
        if (arg0.mint_per_time > 0) {
            while (v1 < arg0.mint_per_time) {
                v1 = v1 + 1;
                assert!(arg0.number < arg0.max_mint, 6);
                let v2 = get_type(0x1::vector::pop_back<u8>(&mut arg0.randoms) - 48);
                let v3 = get_image_url(v2, arg0);
                0x6a29b3b80de2bd69ee94b2a2f11e5bf2e3614d1cc08f1cb16eefa290bc859cb0::nft::mint(v2, v3, arg1, arg2);
                arg0.number = arg0.number + 1;
            };
        } else {
            assert!(arg0.number < arg0.max_mint, 6);
            let v4 = get_type(0x1::vector::pop_back<u8>(&mut arg0.randoms) - 48);
            let v5 = get_image_url(v4, arg0);
            0x6a29b3b80de2bd69ee94b2a2f11e5bf2e3614d1cc08f1cb16eefa290bc859cb0::nft::mint(v4, v5, arg1, arg2);
            arg0.number = arg0.number + 1;
        };
    }

    public entry fun remove_address_whitelist(arg0: &mut AdmMint, arg1: address, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.creator == 0x2::tx_context::sender(arg2), 1);
        let (v0, v1) = 0x1::vector::index_of<address>(&arg0.whitelist, &arg1);
        assert!(v0, 4);
        0x1::vector::remove<address>(&mut arg0.whitelist, v1);
    }

    public entry fun reset_whitelist(arg0: &mut AdmMint, arg1: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.creator == 0x2::tx_context::sender(arg1), 1);
        arg0.whitelist = 0x1::vector::empty<address>();
    }

    public entry fun update_active(arg0: bool, arg1: &mut AdmMint, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(arg1.creator == 0x2::tx_context::sender(arg2), 1);
        arg1.active = arg0;
    }

    public entry fun update_image(arg0: &mut AdmMint, arg1: u64, arg2: u64, arg3: 0x1::string::String, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.creator == 0x2::tx_context::sender(arg4), 1);
        if (arg1 == 0) {
            arg0.image_og = arg3;
        };
        if (arg1 == 1) {
            arg0.image_tier1 = arg3;
        };
        if (arg1 == 2) {
            arg0.image_tier2 = arg3;
        };
        if (arg1 == 3) {
            arg0.image_tier3 = arg3;
        };
        if (arg1 == 4) {
            arg0.image_tier4 = arg3;
        };
        if (arg1 == 5) {
            arg0.image_tier5 = arg3;
        };
        if (arg1 == 6) {
            if (arg2 == 1) {
                arg0.image_pfp1 = arg3;
            };
            if (arg2 == 2) {
                arg0.image_pfp2 = arg3;
            };
            if (arg2 == 3) {
                arg0.image_pfp3 = arg3;
            };
            if (arg2 == 4) {
                arg0.image_pfp4 = arg3;
            };
        };
    }

    public entry fun update_maxmint(arg0: u64, arg1: &mut AdmMint, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(arg1.creator == 0x2::tx_context::sender(arg2), 1);
        arg1.max_mint = arg0;
    }

    public entry fun update_maxmintpertime(arg0: u64, arg1: &mut AdmMint, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(arg1.creator == 0x2::tx_context::sender(arg2), 1);
        arg1.mint_per_time = arg0;
    }

    public entry fun updaterandomlist(arg0: vector<u8>, arg1: &mut AdmMint, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(arg1.creator == 0x2::tx_context::sender(arg2), 1);
        arg1.randoms = arg0;
    }

    // decompiled from Move bytecode v6
}

