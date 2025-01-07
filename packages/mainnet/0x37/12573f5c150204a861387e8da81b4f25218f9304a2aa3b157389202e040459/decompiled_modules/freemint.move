module 0x6a29b3b80de2bd69ee94b2a2f11e5bf2e3614d1cc08f1cb16eefa290bc859cb0::freemint {
    struct Minted {
        owner: address,
        count: u64,
    }

    struct FreeMint has key {
        id: 0x2::object::UID,
        number: u64,
        max_mint: u64,
        mint_per_address: u64,
        is_whitelist: bool,
        whitelist: vector<address>,
        mints: 0x2::table::Table<address, u64>,
        randoms: vector<u8>,
        name: 0x1::string::String,
        creator: address,
    }

    public entry fun freemint(arg0: &mut FreeMint, arg1: &mut 0x6a29b3b80de2bd69ee94b2a2f11e5bf2e3614d1cc08f1cb16eefa290bc859cb0::nft::Infomation, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg2);
        if (arg0.is_whitelist == true) {
            assert!(0x1::vector::contains<address>(&arg0.whitelist, &v0), 2);
        };
        let v1 = 0x2::tx_context::sender(arg2);
        let v2 = 0;
        let v3 = true;
        let v4 = 0;
        if (0x2::table::contains<address, u64>(&arg0.mints, v1)) {
            v3 = false;
            v2 = *0x2::table::borrow<address, u64>(&mut arg0.mints, v1);
        };
        if (arg0.mint_per_address > 0) {
            while (v4 < arg0.mint_per_address) {
                v4 = v4 + 1;
                assert!(arg0.number < arg0.max_mint, 6);
                assert!(v2 <= arg0.mint_per_address, 5);
                let v5 = get_type(0x1::vector::pop_back<u8>(&mut arg0.randoms) - 48);
                let v6 = get_image_url(v5, arg0);
                0x6a29b3b80de2bd69ee94b2a2f11e5bf2e3614d1cc08f1cb16eefa290bc859cb0::nft::mint(v5, v6, arg1, arg2);
                arg0.number = arg0.number + 1;
                v2 = v2 + 1;
            };
        } else {
            assert!(arg0.number < arg0.max_mint, 6);
            let v7 = get_type(0x1::vector::pop_back<u8>(&mut arg0.randoms) - 48);
            let v8 = get_image_url(v7, arg0);
            0x6a29b3b80de2bd69ee94b2a2f11e5bf2e3614d1cc08f1cb16eefa290bc859cb0::nft::mint(v7, v8, arg1, arg2);
            arg0.number = arg0.number + 1;
            v2 = v2 + 1;
        };
        if (v3) {
            0x2::table::add<address, u64>(&mut arg0.mints, v1, v2);
        } else {
            0x2::table::remove<address, u64>(&mut arg0.mints, v1);
            0x2::table::add<address, u64>(&mut arg0.mints, v1, v2);
        };
    }

    public entry fun add_address_into_whitelist(arg0: &mut FreeMint, arg1: address, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.creator == 0x2::tx_context::sender(arg2), 1);
        assert!(!0x1::vector::contains<address>(&arg0.whitelist, &arg1), 3);
        0x1::vector::push_back<address>(&mut arg0.whitelist, arg1);
    }

    public entry fun add_whitelist(arg0: &mut FreeMint, arg1: vector<address>, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.creator == 0x2::tx_context::sender(arg2), 1);
        let v0 = 0;
        while (v0 < 0x1::vector::length<address>(&arg1)) {
            let v1 = *0x1::vector::borrow<address>(&arg1, v0);
            if (!0x1::vector::contains<address>(&arg0.whitelist, &v1)) {
                0x1::vector::push_back<address>(&mut arg0.whitelist, v1);
            };
            v0 = v0 + 1;
        };
    }

    public entry fun create_freemint(arg0: &mut FreeMint, arg1: 0x1::string::String, arg2: u64, arg3: u64, arg4: bool, arg5: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.creator == 0x2::tx_context::sender(arg5), 1);
        let v0 = FreeMint{
            id               : 0x2::object::new(arg5),
            number           : 0,
            max_mint         : arg3,
            mint_per_address : arg2,
            is_whitelist     : arg4,
            whitelist        : 0x1::vector::empty<address>(),
            mints            : 0x2::table::new<address, u64>(arg5),
            randoms          : 0x1::vector::empty<u8>(),
            name             : arg1,
            creator          : 0x2::tx_context::sender(arg5),
        };
        0x2::transfer::share_object<FreeMint>(v0);
    }

    fun get_image_url(arg0: vector<u8>, arg1: &mut FreeMint) : vector<u8> {
        let v0 = b"";
        if (arg0 == b"og") {
            v0 = b"https://files.yousui.io/mint/YouSUI_NFT_OGROLE.png";
        };
        if (arg0 == b"pfp") {
            if (arg1.number % 4 == 0) {
                v0 = b"https://files.yousui.io/mint/YouSUI_NFT_PFP4.png";
            };
            if (arg1.number % 4 == 1) {
                v0 = b"https://files.yousui.io/mint/YouSUI_NFT_PFP1.png";
            };
            if (arg1.number % 4 == 2) {
                v0 = b"https://files.yousui.io/mint/YouSUI_NFT_PFP2.png";
            };
            if (arg1.number % 4 == 3) {
                v0 = b"https://files.yousui.io/mint/YouSUI_NFT_PFP3.png";
            };
        };
        v0
    }

    fun get_type(arg0: u8) : vector<u8> {
        let v0 = b"pfp";
        if (arg0 == 0) {
            v0 = b"og";
        };
        if (arg0 == 5) {
            v0 = b"5";
        };
        v0
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = FreeMint{
            id               : 0x2::object::new(arg0),
            number           : 0,
            max_mint         : 2000,
            mint_per_address : 5,
            is_whitelist     : false,
            whitelist        : 0x1::vector::empty<address>(),
            mints            : 0x2::table::new<address, u64>(arg0),
            randoms          : b"11111111111111111111111111111111111111111111111111111111111111111111111111111101111111111111110111111111101111111111111111151115111111111111111111111111111101111111111111111111111111111111111511111111511111111511111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111110111111111511111111111111111111111111111511111111111111111111111111111111111111111111111115110111111111111111111111111111111111111111111111101111111111111111111011111111111111511111111111111111111111111111111111151111111111111151111111111111111111111111111111111111511111111111111111111111111111111111111111111111011115111111111111111111111111111151111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111110111151111111111111111111111111111111511111151111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111011111111111111151111111111111111111111111111111111111111111111111111111111151111111111111115111110111111111111111111111111511111111111111511111111111111111111111111511111111111111111111111111111111111111111115110111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111101111011111111111111511111151111111111111111111111111111111111111111111115111111111111111111111111111111111111111511111111111101111111111111111111111111111111111111111111111111111111111111111111111111111111111115111151111111111111111110111115111111111115111111111111111111511111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111151111111111111111111111111511111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111151111111111111111111111111115111111111111111111111111111111101111111111111111111111111111111111111111111111111111111111111111111110111111111111111111111111111111111111111111011111111511111111111115111111111111111111151111111111111111111111111111111111111",
            name             : 0x1::string::utf8(b"Free Mint"),
            creator          : 0x2::tx_context::sender(arg0),
        };
        0x2::transfer::share_object<FreeMint>(v0);
    }

    public entry fun remove_address_whitelist(arg0: &mut FreeMint, arg1: address, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.creator == 0x2::tx_context::sender(arg2), 1);
        let (v0, v1) = 0x1::vector::index_of<address>(&arg0.whitelist, &arg1);
        assert!(v0, 4);
        0x1::vector::remove<address>(&mut arg0.whitelist, v1);
    }

    public entry fun reset_whitelist(arg0: &mut FreeMint, arg1: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.creator == 0x2::tx_context::sender(arg1), 1);
        arg0.whitelist = 0x1::vector::empty<address>();
    }

    public entry fun update_maxmint(arg0: u64, arg1: &mut FreeMint, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(arg1.creator == 0x2::tx_context::sender(arg2), 1);
        arg1.max_mint = arg0;
    }

    public entry fun update_maxmintperaddress(arg0: u64, arg1: &mut FreeMint, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(arg1.creator == 0x2::tx_context::sender(arg2), 1);
        arg1.mint_per_address = arg0;
    }

    public entry fun updaterandomlist(arg0: vector<u8>, arg1: &mut FreeMint, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(arg1.creator == 0x2::tx_context::sender(arg2), 1);
        arg1.randoms = arg0;
    }

    // decompiled from Move bytecode v6
}

