module 0x645ed7b0aca572af3197ce0b8914edbb909bca88b0920d8ccdbca241961d21ce::capybara_lootbox {
    struct CAPYBARA_LOOTBOX has drop {
        dummy_field: bool,
    }

    struct LootBoxAdminCap has store, key {
        id: 0x2::object::UID,
    }

    struct LootboxArgTBS has drop {
        user: address,
        uid: u64,
    }

    struct DataStorage has key {
        id: 0x2::object::UID,
        total_lootbox: u64,
        total_lootbox_opened: u64,
        total_fruit_minted: u64,
        total_fruit_exchanged: u64,
        total_capybara: u64,
        ids: 0x2::table::Table<u64, bool>,
        pk: vector<u8>,
        check_signature: bool,
    }

    struct NFTFruit has store, key {
        id: 0x2::object::UID,
        idx: u64,
        fruit_type: 0x1::string::String,
    }

    struct NFTLootbox has store, key {
        id: 0x2::object::UID,
        idx: u64,
    }

    struct CapybaraNFT has store, key {
        id: 0x2::object::UID,
        idx: u64,
    }

    struct MintLootbox has copy, drop {
        from: address,
        lootbox_id: 0x2::object::ID,
        lootbox_idx: u64,
    }

    struct OpenLootbox has copy, drop {
        from: address,
        lootbox_id: 0x2::object::ID,
        lootbox_idx: u64,
        fruit_id: 0x2::object::ID,
        fruit_idx: u64,
    }

    struct AdminMintFruit has copy, drop {
        fruit_id: 0x2::object::ID,
        fruit_idx: u64,
    }

    struct MintCapybara has copy, drop {
        from: address,
        nft_id: 0x2::object::ID,
        nft_idx: u64,
    }

    public fun exchange_fruits_to_capybara(arg0: &mut DataStorage, arg1: NFTFruit, arg2: NFTFruit, arg3: NFTFruit, arg4: NFTFruit, arg5: NFTFruit, arg6: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg6);
        let NFTFruit {
            id         : v1,
            idx        : _,
            fruit_type : v3,
        } = arg1;
        assert!(v3 == 0x1::string::utf8(b"Lemon"), 3);
        let NFTFruit {
            id         : v4,
            idx        : _,
            fruit_type : v6,
        } = arg2;
        assert!(v6 == 0x1::string::utf8(b"Strawberry"), 3);
        let NFTFruit {
            id         : v7,
            idx        : _,
            fruit_type : v9,
        } = arg3;
        assert!(v9 == 0x1::string::utf8(b"Banana"), 3);
        let NFTFruit {
            id         : v10,
            idx        : _,
            fruit_type : v12,
        } = arg4;
        assert!(v12 == 0x1::string::utf8(b"Watermelon"), 3);
        let NFTFruit {
            id         : v13,
            idx        : _,
            fruit_type : v15,
        } = arg5;
        assert!(v15 == 0x1::string::utf8(b"Mushroom"), 3);
        0x2::object::delete(v1);
        0x2::object::delete(v4);
        0x2::object::delete(v7);
        0x2::object::delete(v10);
        0x2::object::delete(v13);
        arg0.total_fruit_exchanged = arg0.total_fruit_exchanged + 5;
        arg0.total_capybara = arg0.total_capybara + 1;
        let v16 = CapybaraNFT{
            id  : 0x2::object::new(arg6),
            idx : arg0.total_capybara,
        };
        let v17 = MintCapybara{
            from    : v0,
            nft_id  : 0x2::object::id<CapybaraNFT>(&v16),
            nft_idx : v16.idx,
        };
        0x2::event::emit<MintCapybara>(v17);
        0x2::transfer::public_transfer<CapybaraNFT>(v16, v0);
    }

    fun get_random_fruit(arg0: &0x2::random::Random, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) : NFTFruit {
        let v0 = 0x2::random::new_generator(arg0, arg2);
        let v1 = 0x2::random::generate_u8_in_range(&mut v0, 0, 200);
        let v2 = b"";
        if (v1 <= 3) {
            v2 = b"Mushroom";
        };
        if (v1 > 3 && v1 <= 20) {
            v2 = b"Watermelon";
        };
        if (v1 > 20 && v1 <= 50) {
            v2 = b"Banana";
        };
        if (v1 > 50 && v1 <= 100) {
            v2 = b"Strawberry";
        };
        if (v1 > 100 && v1 <= 200) {
            v2 = b"Lemon";
        };
        NFTFruit{
            id         : 0x2::object::new(arg2),
            idx        : arg1,
            fruit_type : 0x1::string::utf8(v2),
        }
    }

    fun init(arg0: CAPYBARA_LOOTBOX, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::package::claim<CAPYBARA_LOOTBOX>(arg0, arg1);
        let v1 = 0x1::vector::empty<0x1::string::String>();
        let v2 = &mut v1;
        0x1::vector::push_back<0x1::string::String>(v2, 0x1::string::utf8(b"name"));
        0x1::vector::push_back<0x1::string::String>(v2, 0x1::string::utf8(b"image_url"));
        0x1::vector::push_back<0x1::string::String>(v2, 0x1::string::utf8(b"thumbnail_url"));
        let v3 = 0x1::vector::empty<0x1::string::String>();
        let v4 = &mut v3;
        0x1::vector::push_back<0x1::string::String>(v4, 0x1::string::utf8(b"Capybara NFT {fruit_type} fruit"));
        0x1::vector::push_back<0x1::string::String>(v4, 0x1::string::utf8(b"https://capybara_static.8gen.team/{fruit_type}.png"));
        0x1::vector::push_back<0x1::string::String>(v4, 0x1::string::utf8(b"https://capybara_static.8gen.team/{fruit_type}_preview.png"));
        let v5 = 0x2::display::new_with_fields<NFTFruit>(&v0, v1, v3, arg1);
        0x2::display::update_version<NFTFruit>(&mut v5);
        let v6 = 0x1::vector::empty<0x1::string::String>();
        let v7 = &mut v6;
        0x1::vector::push_back<0x1::string::String>(v7, 0x1::string::utf8(b"name"));
        0x1::vector::push_back<0x1::string::String>(v7, 0x1::string::utf8(b"image_url"));
        0x1::vector::push_back<0x1::string::String>(v7, 0x1::string::utf8(b"thumbnail_url"));
        let v8 = 0x1::vector::empty<0x1::string::String>();
        let v9 = &mut v8;
        0x1::vector::push_back<0x1::string::String>(v9, 0x1::string::utf8(b"Capybara NFT Lootbox number {idx}"));
        0x1::vector::push_back<0x1::string::String>(v9, 0x1::string::utf8(b"https://capybara_static.8gen.team/lootbox.png"));
        0x1::vector::push_back<0x1::string::String>(v9, 0x1::string::utf8(b"https://capybara_static.8gen.team/lootbox_preview.png"));
        let v10 = 0x2::display::new_with_fields<NFTLootbox>(&v0, v6, v8, arg1);
        0x2::display::update_version<NFTLootbox>(&mut v10);
        let v11 = 0x1::vector::empty<0x1::string::String>();
        let v12 = &mut v11;
        0x1::vector::push_back<0x1::string::String>(v12, 0x1::string::utf8(b"name"));
        0x1::vector::push_back<0x1::string::String>(v12, 0x1::string::utf8(b"image_url"));
        0x1::vector::push_back<0x1::string::String>(v12, 0x1::string::utf8(b"thumbnail_url"));
        let v13 = 0x1::vector::empty<0x1::string::String>();
        let v14 = &mut v13;
        0x1::vector::push_back<0x1::string::String>(v14, 0x1::string::utf8(b"Capybara NFT {idx}"));
        0x1::vector::push_back<0x1::string::String>(v14, 0x1::string::utf8(b"https://capybara_static.8gen.team/capybara.png"));
        0x1::vector::push_back<0x1::string::String>(v14, 0x1::string::utf8(b"https://capybara_static.8gen.team/capybara_preview.png"));
        let v15 = 0x2::display::new_with_fields<CapybaraNFT>(&v0, v11, v13, arg1);
        0x2::display::update_version<CapybaraNFT>(&mut v15);
        let v16 = 0x2::address::from_bytes(0x2::address::to_bytes(@0x3a1a0722453ff6da8a9695ef9588bd0ef57e60df8eee12f45cb792a170f179e1));
        let v17 = DataStorage{
            id                    : 0x2::object::new(arg1),
            total_lootbox         : 0,
            total_lootbox_opened  : 0,
            total_fruit_minted    : 0,
            total_fruit_exchanged : 0,
            total_capybara        : 0,
            ids                   : 0x2::table::new<u64, bool>(arg1),
            pk                    : x"035229dff81f3e3f5a1526b92908752395d96bf6b41cc253b2ad5bebe503149cf2",
            check_signature       : false,
        };
        let v18 = LootBoxAdminCap{id: 0x2::object::new(arg1)};
        0x2::transfer::share_object<DataStorage>(v17);
        0x2::transfer::public_transfer<LootBoxAdminCap>(v18, v16);
        0x2::transfer::public_transfer<0x2::package::Publisher>(v0, v16);
        0x2::transfer::public_transfer<0x2::display::Display<NFTFruit>>(v5, v16);
        0x2::transfer::public_transfer<0x2::display::Display<NFTLootbox>>(v10, v16);
        0x2::transfer::public_transfer<0x2::display::Display<CapybaraNFT>>(v15, v16);
    }

    public fun mint_fruit_by_admin(arg0: &0x645ed7b0aca572af3197ce0b8914edbb909bca88b0920d8ccdbca241961d21ce::capybara_game_card::AdminCap, arg1: &mut DataStorage, arg2: vector<0x1::string::String>, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0;
        while (v0 < 0x1::vector::length<0x1::string::String>(&arg2)) {
            arg1.total_fruit_minted = arg1.total_fruit_minted + 1;
            let v1 = NFTFruit{
                id         : 0x2::object::new(arg3),
                idx        : arg1.total_fruit_minted,
                fruit_type : *0x1::vector::borrow<0x1::string::String>(&arg2, v0),
            };
            let v2 = AdminMintFruit{
                fruit_id  : 0x2::object::id<NFTFruit>(&v1),
                fruit_idx : v1.idx,
            };
            0x2::event::emit<AdminMintFruit>(v2);
            0x2::transfer::public_transfer<NFTFruit>(v1, 0x2::tx_context::sender(arg3));
            v0 = v0 + 1;
        };
    }

    public entry fun mint_lootbox(arg0: &mut DataStorage, arg1: u64, arg2: vector<u8>, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg3);
        if (arg0.check_signature) {
            assert!(!0x2::table::contains<u64, bool>(&arg0.ids, arg1), 103);
            let v1 = serialize_lootbox_args(v0, arg1);
            assert!(0x2::ecdsa_k1::secp256k1_verify(&arg2, &arg0.pk, &v1, 1), 104);
        };
        arg0.total_lootbox = arg0.total_lootbox + 1;
        let v2 = new_lootbox(arg3, arg0.total_lootbox);
        0x2::table::add<u64, bool>(&mut arg0.ids, arg1, true);
        let v3 = MintLootbox{
            from        : v0,
            lootbox_id  : 0x2::object::id<NFTLootbox>(&v2),
            lootbox_idx : v2.idx,
        };
        0x2::event::emit<MintLootbox>(v3);
        0x2::transfer::public_transfer<NFTLootbox>(v2, v0);
    }

    fun new_lootbox(arg0: &mut 0x2::tx_context::TxContext, arg1: u64) : NFTLootbox {
        NFTLootbox{
            id  : 0x2::object::new(arg0),
            idx : arg1,
        }
    }

    public entry fun open_lootbox(arg0: &mut DataStorage, arg1: &0x2::random::Random, arg2: NFTLootbox, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg3);
        let NFTLootbox {
            id  : v1,
            idx : v2,
        } = arg2;
        0x2::object::delete(v1);
        arg0.total_lootbox_opened = arg0.total_lootbox_opened + 1;
        arg0.total_fruit_minted = arg0.total_fruit_minted + 1;
        let v3 = get_random_fruit(arg1, arg0.total_fruit_minted, arg3);
        let v4 = OpenLootbox{
            from        : v0,
            lootbox_id  : 0x2::object::id<NFTLootbox>(&arg2),
            lootbox_idx : v2,
            fruit_id    : 0x2::object::id<NFTFruit>(&v3),
            fruit_idx   : v3.idx,
        };
        0x2::event::emit<OpenLootbox>(v4);
        0x2::transfer::public_transfer<NFTFruit>(v3, v0);
    }

    public fun serialize_lootbox_args(arg0: address, arg1: u64) : vector<u8> {
        let v0 = LootboxArgTBS{
            user : arg0,
            uid  : arg1,
        };
        0x1::bcs::to_bytes<LootboxArgTBS>(&v0)
    }

    public fun update_storage(arg0: &0x645ed7b0aca572af3197ce0b8914edbb909bca88b0920d8ccdbca241961d21ce::capybara_game_card::AdminCap, arg1: vector<u8>, arg2: bool, arg3: &mut DataStorage, arg4: &mut 0x2::tx_context::TxContext) {
        arg3.pk = arg1;
        arg3.check_signature = arg2;
    }

    // decompiled from Move bytecode v6
}

