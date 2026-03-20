module 0xdc3151a00fa5556c29960b25cff314aeb459ed4838c603bdf5ce6f99c09e879b::suisynth {
    struct SUISYNTH has drop {
        dummy_field: bool,
    }

    struct SuiSynthHippo has store, key {
        id: 0x2::object::UID,
        name: 0x1::string::String,
        description: 0x1::string::String,
        image_url: 0x1::string::String,
        metadata_uri: 0x1::string::String,
        mint_number: u64,
        rarity: 0x1::string::String,
        trait_seed: vector<u8>,
        background: 0x1::string::String,
        body_color: 0x1::string::String,
        accessory: 0x1::string::String,
        expression: 0x1::string::String,
        special_glow: bool,
        sui_symbol: 0x1::string::String,
        minted_at: u64,
        minted_by: address,
    }

    struct MintRegistry has key {
        id: 0x2::object::UID,
        total_minted: u64,
        server_pubkey: vector<u8>,
        used_tickets: 0x2::table::Table<vector<u8>, bool>,
        wallet_counts: 0x2::table::Table<address, u64>,
        reserved_wallets: 0x2::vec_map::VecMap<address, u64>,
        admin: address,
        image_base_uri: 0x1::string::String,
    }

    struct AdminCap has store, key {
        id: 0x2::object::UID,
    }

    struct HippoMinted has copy, drop {
        nft_id: 0x2::object::ID,
        mint_number: u64,
        rarity: 0x1::string::String,
        minted_by: address,
        trait_seed: vector<u8>,
    }

    struct ImageUpdated has copy, drop {
        nft_id: 0x2::object::ID,
        image_url: 0x1::string::String,
    }

    fun build_nft(arg0: u64, arg1: vector<u8>, arg2: address, arg3: u64, arg4: &mut 0x2::tx_context::TxContext) : SuiSynthHippo {
        let v0 = get_rarity(arg0);
        SuiSynthHippo{
            id           : 0x2::object::new(arg4),
            name         : 0x1::string::utf8(b"SuiSynth Hippo"),
            description  : 0x1::string::utf8(b"An AI-agent-minted hippopotamus on Sui."),
            image_url    : 0x1::string::utf8(b"https://suisynth.xyz/pending.png"),
            metadata_uri : 0x1::string::utf8(b""),
            mint_number  : arg0,
            rarity       : v0,
            trait_seed   : arg1,
            background   : get_background(&arg1, &v0),
            body_color   : get_body_color(&arg1),
            accessory    : get_accessory(&arg1, &v0),
            expression   : get_expression(&arg1),
            special_glow : arg0 > 350,
            sui_symbol   : get_sui_symbol(&v0),
            minted_at    : arg3,
            minted_by    : arg2,
        }
    }

    fun build_trait_seed(arg0: address, arg1: u64, arg2: &0x2::clock::Clock) : vector<u8> {
        let v0 = 0x1::vector::empty<u8>();
        0x1::vector::append<u8>(&mut v0, 0x2::bcs::to_bytes<address>(&arg0));
        0x1::vector::append<u8>(&mut v0, 0x2::bcs::to_bytes<u64>(&arg1));
        let v1 = 0x2::clock::timestamp_ms(arg2);
        0x1::vector::append<u8>(&mut v0, 0x2::bcs::to_bytes<u64>(&v1));
        0x2::hash::blake2b256(&v0)
    }

    fun get_accessory(arg0: &vector<u8>, arg1: &0x1::string::String) : 0x1::string::String {
        let v0 = *0x1::vector::borrow<u8>(arg0, 2) % 10;
        if (*arg1 == 0x1::string::utf8(b"Legendary")) {
            return 0x1::string::utf8(b"Golden Sui Crown and Blockchain Cape")
        };
        if (*arg1 == 0x1::string::utf8(b"Epic")) {
            let v1 = v0 % 3;
            if (v1 == 0) {
                return 0x1::string::utf8(b"Neon Sui Goggles")
            };
            if (v1 == 1) {
                return 0x1::string::utf8(b"Crystal Blockchain Armor")
            };
            return 0x1::string::utf8(b"Glowing Sui Staff")
        };
        if (v0 == 0) {
            0x1::string::utf8(b"None")
        } else if (v0 == 1) {
            0x1::string::utf8(b"Flower Crown")
        } else if (v0 == 2) {
            0x1::string::utf8(b"Sui Chain Necklace")
        } else if (v0 == 3) {
            0x1::string::utf8(b"Tiny Backpack")
        } else if (v0 == 4) {
            0x1::string::utf8(b"Round Glasses")
        } else if (v0 == 5) {
            0x1::string::utf8(b"Party Hat")
        } else if (v0 == 6) {
            0x1::string::utf8(b"Scarf")
        } else if (v0 == 7) {
            0x1::string::utf8(b"Headphones")
        } else if (v0 == 8) {
            0x1::string::utf8(b"Bow Tie")
        } else {
            0x1::string::utf8(b"Sun Hat")
        }
    }

    fun get_background(arg0: &vector<u8>, arg1: &0x1::string::String) : 0x1::string::String {
        let v0 = *0x1::vector::borrow<u8>(arg0, 0) % 8;
        if (*arg1 == 0x1::string::utf8(b"Legendary")) {
            0x1::string::utf8(b"Prismatic Sui Void")
        } else if (v0 == 0) {
            0x1::string::utf8(b"Sunset Swamp")
        } else if (v0 == 1) {
            0x1::string::utf8(b"Neon Waterfall")
        } else if (v0 == 2) {
            0x1::string::utf8(b"Deep Blockchain Blue")
        } else if (v0 == 3) {
            0x1::string::utf8(b"Warm Savanna Gold")
        } else if (v0 == 4) {
            0x1::string::utf8(b"Mint Green Lagoon")
        } else if (v0 == 5) {
            0x1::string::utf8(b"Twilight Sui Sky")
        } else if (v0 == 6) {
            0x1::string::utf8(b"Cherry Blossom Bank")
        } else {
            0x1::string::utf8(b"Terracotta Dusk")
        }
    }

    fun get_body_color(arg0: &vector<u8>) : 0x1::string::String {
        let v0 = *0x1::vector::borrow<u8>(arg0, 1) % 7;
        if (v0 == 0) {
            0x1::string::utf8(b"Classic Muddy Grey")
        } else if (v0 == 1) {
            0x1::string::utf8(b"Warm Terracotta Rose")
        } else if (v0 == 2) {
            0x1::string::utf8(b"Pastel Violet")
        } else if (v0 == 3) {
            0x1::string::utf8(b"Ocean Teal")
        } else if (v0 == 4) {
            0x1::string::utf8(b"Sunset Peach")
        } else if (v0 == 5) {
            0x1::string::utf8(b"Sage Meadow Green")
        } else {
            0x1::string::utf8(b"Midnight Indigo")
        }
    }

    fun get_expression(arg0: &vector<u8>) : 0x1::string::String {
        let v0 = *0x1::vector::borrow<u8>(arg0, 3) % 8;
        if (v0 == 0) {
            0x1::string::utf8(b"Big Toothy Grin")
        } else if (v0 == 1) {
            0x1::string::utf8(b"Smug Squint")
        } else if (v0 == 2) {
            0x1::string::utf8(b"Curious Wide Eyes")
        } else if (v0 == 3) {
            0x1::string::utf8(b"Sleepy Content Smile")
        } else if (v0 == 4) {
            0x1::string::utf8(b"Excited Sparkle Eyes")
        } else if (v0 == 5) {
            0x1::string::utf8(b"Determined Brow")
        } else if (v0 == 6) {
            0x1::string::utf8(b"Cheeky Wink")
        } else {
            0x1::string::utf8(b"Peaceful Closed Eyes")
        }
    }

    fun get_rarity(arg0: u64) : 0x1::string::String {
        if (arg0 > 500) {
            0x1::string::utf8(b"Legendary")
        } else if (arg0 > 350) {
            0x1::string::utf8(b"Epic")
        } else if (arg0 > 150) {
            0x1::string::utf8(b"Rare")
        } else {
            0x1::string::utf8(b"Common")
        }
    }

    fun get_sui_symbol(arg0: &0x1::string::String) : 0x1::string::String {
        if (*arg0 == 0x1::string::utf8(b"Legendary")) {
            0x1::string::utf8(b"5x Large Golden Sui Logos")
        } else if (*arg0 == 0x1::string::utf8(b"Epic")) {
            0x1::string::utf8(b"3x Glowing Blue Sui Logos")
        } else if (*arg0 == 0x1::string::utf8(b"Rare")) {
            0x1::string::utf8(b"2x Soft Sui Logos")
        } else {
            0x1::string::utf8(b"1x Subtle Sui Logo")
        }
    }

    fun init(arg0: SUISYNTH, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let v1 = MintRegistry{
            id               : 0x2::object::new(arg1),
            total_minted     : 0,
            server_pubkey    : 0x1::vector::empty<u8>(),
            used_tickets     : 0x2::table::new<vector<u8>, bool>(arg1),
            wallet_counts    : 0x2::table::new<address, u64>(arg1),
            reserved_wallets : 0x2::vec_map::empty<address, u64>(),
            admin            : v0,
            image_base_uri   : 0x1::string::utf8(b"https://ipfs.io/ipfs/"),
        };
        0x2::vec_map::insert<address, u64>(&mut v1.reserved_wallets, @0xad70534999efc0c0b64176213cb95805e60be13dad40906b9f71ae9bfad708be, 50);
        0x2::transfer::share_object<MintRegistry>(v1);
        let v2 = AdminCap{id: 0x2::object::new(arg1)};
        0x2::transfer::transfer<AdminCap>(v2, v0);
    }

    public entry fun mint_hippo(arg0: &mut MintRegistry, arg1: vector<u8>, arg2: vector<u8>, arg3: vector<u8>, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg5);
        assert!(arg0.total_minted < 555, 1);
        let v1 = if (0x2::table::contains<address, u64>(&arg0.wallet_counts, v0)) {
            *0x2::table::borrow<address, u64>(&arg0.wallet_counts, v0)
        } else {
            0
        };
        if (!0x2::vec_map::contains<address, u64>(&arg0.reserved_wallets, &v0)) {
            assert!(v1 < 2, 2);
        };
        let v2 = 0x2::hash::blake2b256(&arg1);
        assert!(!0x2::table::contains<vector<u8>, bool>(&arg0.used_tickets, v2), 4);
        let v3 = 0x1::vector::empty<u8>();
        0x1::vector::append<u8>(&mut v3, arg1);
        0x1::vector::append<u8>(&mut v3, 0x2::bcs::to_bytes<address>(&v0));
        0x1::vector::append<u8>(&mut v3, arg3);
        assert!(0x2::ed25519::ed25519_verify(&arg2, &arg0.server_pubkey, &v3), 3);
        0x2::table::add<vector<u8>, bool>(&mut arg0.used_tickets, v2, true);
        if (0x2::table::contains<address, u64>(&arg0.wallet_counts, v0)) {
            let v4 = 0x2::table::borrow_mut<address, u64>(&mut arg0.wallet_counts, v0);
            *v4 = *v4 + 1;
        } else {
            0x2::table::add<address, u64>(&mut arg0.wallet_counts, v0, 1);
        };
        arg0.total_minted = arg0.total_minted + 1;
        let v5 = arg0.total_minted;
        let v6 = build_nft(v5, arg3, v0, 0x2::clock::timestamp_ms(arg4), arg5);
        let v7 = HippoMinted{
            nft_id      : 0x2::object::id<SuiSynthHippo>(&v6),
            mint_number : v5,
            rarity      : v6.rarity,
            minted_by   : v0,
            trait_seed  : v6.trait_seed,
        };
        0x2::event::emit<HippoMinted>(v7);
        0x2::transfer::transfer<SuiSynthHippo>(v6, v0);
    }

    public entry fun premint_batch(arg0: &AdminCap, arg1: &mut MintRegistry, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = @0xad70534999efc0c0b64176213cb95805e60be13dad40906b9f71ae9bfad708be;
        let v1 = 0;
        while (v1 < 50) {
            let v2 = arg1.total_minted + 1;
            let v3 = build_nft(v2, build_trait_seed(v0, v2, arg2), v0, 0x2::clock::timestamp_ms(arg2), arg3);
            let v4 = HippoMinted{
                nft_id      : 0x2::object::id<SuiSynthHippo>(&v3),
                mint_number : v2,
                rarity      : v3.rarity,
                minted_by   : v0,
                trait_seed  : v3.trait_seed,
            };
            0x2::event::emit<HippoMinted>(v4);
            0x2::transfer::transfer<SuiSynthHippo>(v3, v0);
            arg1.total_minted = arg1.total_minted + 1;
            v1 = v1 + 1;
        };
    }

    public entry fun set_image_base_uri(arg0: &AdminCap, arg1: &mut MintRegistry, arg2: vector<u8>) {
        arg1.image_base_uri = 0x1::string::utf8(arg2);
    }

    public entry fun set_server_pubkey(arg0: &AdminCap, arg1: &mut MintRegistry, arg2: vector<u8>) {
        arg1.server_pubkey = arg2;
    }

    public entry fun update_nft_image(arg0: &AdminCap, arg1: &mut SuiSynthHippo, arg2: vector<u8>, arg3: vector<u8>) {
        arg1.image_url = 0x1::string::utf8(arg2);
        arg1.metadata_uri = 0x1::string::utf8(arg3);
        let v0 = ImageUpdated{
            nft_id    : 0x2::object::id<SuiSynthHippo>(arg1),
            image_url : 0x1::string::utf8(arg2),
        };
        0x2::event::emit<ImageUpdated>(v0);
    }

    // decompiled from Move bytecode v6
}

