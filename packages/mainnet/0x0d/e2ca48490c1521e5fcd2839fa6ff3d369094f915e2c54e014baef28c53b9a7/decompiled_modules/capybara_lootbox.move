module 0xde2ca48490c1521e5fcd2839fa6ff3d369094f915e2c54e014baef28c53b9a7::capybara_lootbox {
    struct CAPYBARA_LOOTBOX has drop {
        dummy_field: bool,
    }

    struct Witness has drop {
        dummy_field: bool,
    }

    struct LootBoxAdminCap has store, key {
        id: 0x2::object::UID,
    }

    struct LootboxArgTBS has drop {
        user: 0x1::string::String,
        uid: u64,
        valid_until: u64,
        count: u64,
    }

    struct DataStorage has key {
        id: 0x2::object::UID,
        total_lootbox: u64,
        total_lootbox_opened: u64,
        ids: 0x2::table::Table<u64, bool>,
        pk: vector<u8>,
        check_signature: bool,
    }

    struct NFTLootbox has store, key {
        id: 0x2::object::UID,
        idx: u64,
    }

    struct MintLootbox has copy, drop {
        from: address,
        lootboxes: vector<0x2::object::ID>,
        lootbox_idxs: vector<u64>,
        random_id: u64,
    }

    struct OpenLootbox has copy, drop {
        from: address,
        lootbox_id: 0x2::object::ID,
        lootbox_idx: u64,
        reward: u64,
    }

    fun get_random_reward(arg0: &0x2::random::Random, arg1: &mut 0x2::tx_context::TxContext) : u64 {
        let v0 = 0x2::random::new_generator(arg0, arg1);
        let v1 = 0x2::random::generate_u8_in_range(&mut v0, 0, 100);
        let v2 = 0;
        if (v1 <= 10) {
            v2 = 15000000;
        };
        if (v1 > 10 && v1 <= 25) {
            v2 = 7500000;
        };
        if (v1 > 25 && v1 <= 55) {
            v2 = 6000000;
        };
        if (v1 > 55 && v1 <= 80) {
            v2 = 5000000;
        };
        if (v1 > 80 && v1 <= 100) {
            v2 = 4000000;
        };
        v2
    }

    fun init(arg0: CAPYBARA_LOOTBOX, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0xbc3df36be17f27ac98e3c839b2589db8475fa07b20657b08e8891e3aaf5ee5f9::collection::create_with_mint_cap<CAPYBARA_LOOTBOX, NFTLootbox>(&arg0, 0x1::option::none<u64>(), arg1);
        let v2 = v0;
        let v3 = 0x2::package::claim<CAPYBARA_LOOTBOX>(arg0, arg1);
        let v4 = Witness{dummy_field: false};
        let v5 = 0x16c5f17f2d55584a6e6daa442ccf83b4530d10546a8e7dedda9ba324e012fc40::witness::from_witness<NFTLootbox, Witness>(v4);
        let v6 = 0x1::vector::empty<0x1::string::String>();
        let v7 = &mut v6;
        0x1::vector::push_back<0x1::string::String>(v7, 0xbc3df36be17f27ac98e3c839b2589db8475fa07b20657b08e8891e3aaf5ee5f9::tags::art());
        0x1::vector::push_back<0x1::string::String>(v7, 0xbc3df36be17f27ac98e3c839b2589db8475fa07b20657b08e8891e3aaf5ee5f9::tags::collectible());
        let v8 = 0x2::display::new<NFTLootbox>(&v3, arg1);
        0x2::display::add<NFTLootbox>(&mut v8, 0x1::string::utf8(b"name"), 0x1::string::utf8(b"{name}"));
        0x2::display::add<NFTLootbox>(&mut v8, 0x1::string::utf8(b"tags"), 0x859eb18bd5b5e8cc32deb6dfb1c39941008ab3c6e27f0b8ce2364be7102bb7cb::display::from_vec(v6));
        let v9 = 0x2::object::id<0xbc3df36be17f27ac98e3c839b2589db8475fa07b20657b08e8891e3aaf5ee5f9::collection::Collection<NFTLootbox>>(&v2);
        0x2::display::add<NFTLootbox>(&mut v8, 0x1::string::utf8(b"collection_id"), 0x859eb18bd5b5e8cc32deb6dfb1c39941008ab3c6e27f0b8ce2364be7102bb7cb::display::id_to_string(&v9));
        0x2::display::update_version<NFTLootbox>(&mut v8);
        0x2::transfer::public_transfer<0x2::display::Display<NFTLootbox>>(v8, 0x2::tx_context::sender(arg1));
        let v10 = vector[@0xf322f525e7370de05cf773b522c4611b483c94533b61f2da4cb9d4f81d3ff2d];
        0xbc3df36be17f27ac98e3c839b2589db8475fa07b20657b08e8891e3aaf5ee5f9::collection::add_domain<NFTLootbox, 0xbc3df36be17f27ac98e3c839b2589db8475fa07b20657b08e8891e3aaf5ee5f9::creators::Creators>(v5, &mut v2, 0xbc3df36be17f27ac98e3c839b2589db8475fa07b20657b08e8891e3aaf5ee5f9::creators::new(0x859eb18bd5b5e8cc32deb6dfb1c39941008ab3c6e27f0b8ce2364be7102bb7cb::utils::vec_set_from_vec<address>(&v10)));
        0xbc3df36be17f27ac98e3c839b2589db8475fa07b20657b08e8891e3aaf5ee5f9::royalty_strategy_bps::create_domain_and_add_strategy<NFTLootbox>(v5, &mut v2, 0xbc3df36be17f27ac98e3c839b2589db8475fa07b20657b08e8891e3aaf5ee5f9::royalty::from_shares(0x859eb18bd5b5e8cc32deb6dfb1c39941008ab3c6e27f0b8ce2364be7102bb7cb::utils::from_vec_to_map<address, u16>(v10, vector[10000]), arg1), 100, arg1);
        let (v11, v12) = 0xe2c7a6843cb13d9549a9d2dc1c266b572ead0b4b9f090e7c3c46de2714102b43::transfer_request::init_policy<NFTLootbox>(&v3, arg1);
        let v13 = v12;
        let v14 = v11;
        0xbc3df36be17f27ac98e3c839b2589db8475fa07b20657b08e8891e3aaf5ee5f9::royalty_strategy_bps::enforce<NFTLootbox>(&mut v14, &v13);
        0xbc3df36be17f27ac98e3c839b2589db8475fa07b20657b08e8891e3aaf5ee5f9::transfer_allowlist::enforce<NFTLootbox>(&mut v14, &v13);
        let v15 = 0x1::vector::empty<0x1::string::String>();
        let v16 = &mut v15;
        0x1::vector::push_back<0x1::string::String>(v16, 0x1::string::utf8(b"name"));
        0x1::vector::push_back<0x1::string::String>(v16, 0x1::string::utf8(b"description"));
        0x1::vector::push_back<0x1::string::String>(v16, 0x1::string::utf8(b"image_url"));
        0x1::vector::push_back<0x1::string::String>(v16, 0x1::string::utf8(b"thumbnail_url"));
        let v17 = 0x1::vector::empty<0x1::string::String>();
        let v18 = &mut v17;
        0x1::vector::push_back<0x1::string::String>(v18, 0x1::string::utf8(b"Money Bag"));
        0x1::vector::push_back<0x1::string::String>(v18, 0x1::string::utf8(x"556e6c6f636b20746865206d797374657279212054686973204d6f6e657920426167204e465420636f6e7461696e7320612068696464656e206e756d626572206f6620696e2d67616d6520636f696e73e280946f70656e20697420746f2072657665616c20796f7572207265776172642120546865206d6f726520796f75206f70656e2c20746865206d6f726520796f752063616e2067726f7720796f757220636f696e2062616c616e63652e20537461727420756e6c6f636b696e6720796f7572204d6f6e6579204261677320746f64617921"));
        0x1::vector::push_back<0x1::string::String>(v18, 0x1::string::utf8(b"https://api.capybara.vip/api/nft/bag"));
        0x1::vector::push_back<0x1::string::String>(v18, 0x1::string::utf8(b"https://api.capybara.vip/api/nft/bag"));
        let v19 = 0x2::display::new_with_fields<NFTLootbox>(&v3, v15, v17, arg1);
        0x2::display::update_version<NFTLootbox>(&mut v19);
        let v20 = 0x2::address::from_bytes(0x2::address::to_bytes(@0xf322f525e7370de05cf773b522c4611b483c94533b61f2da4cb9d4f81d3ff2d));
        let v21 = DataStorage{
            id                   : 0x2::object::new(arg1),
            total_lootbox        : 0,
            total_lootbox_opened : 0,
            ids                  : 0x2::table::new<u64, bool>(arg1),
            pk                   : x"031d9cd3748b019a247773cae4c6e34abba70ba9fd25f86fff1595b012337d3150",
            check_signature      : true,
        };
        0x2::transfer::share_object<DataStorage>(v21);
        0x2::transfer::public_transfer<0x2::package::Publisher>(v3, v20);
        0x2::transfer::public_transfer<0x2::display::Display<NFTLootbox>>(v19, v20);
        0x2::transfer::public_transfer<0xbc3df36be17f27ac98e3c839b2589db8475fa07b20657b08e8891e3aaf5ee5f9::mint_cap::MintCap<NFTLootbox>>(v1, v20);
        0x2::transfer::public_transfer<0x2::transfer_policy::TransferPolicyCap<NFTLootbox>>(v13, v20);
        0x2::transfer::public_share_object<0xbc3df36be17f27ac98e3c839b2589db8475fa07b20657b08e8891e3aaf5ee5f9::collection::Collection<NFTLootbox>>(v2);
        0x2::transfer::public_share_object<0x2::transfer_policy::TransferPolicy<NFTLootbox>>(v14);
    }

    public entry fun mint_lootbox(arg0: &mut DataStorage, arg1: &0x2::clock::Clock, arg2: u64, arg3: u64, arg4: u64, arg5: vector<u8>, arg6: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg6);
        if (arg0.check_signature) {
            assert!(arg3 >= 0x2::clock::timestamp_ms(arg1) / 1000, 105);
            assert!(!0x2::table::contains<u64, bool>(&arg0.ids, arg2), 103);
            let v1 = serialize_lootbox_args(v0, arg2, arg3, arg4);
            assert!(0x2::ecdsa_k1::secp256k1_verify(&arg5, &arg0.pk, &v1, 1), 104);
        };
        0x2::table::add<u64, bool>(&mut arg0.ids, arg2, true);
        let v2 = 0x1::vector::empty<0x2::object::ID>();
        let v3 = 0x1::vector::empty<u64>();
        while (arg4 > 0) {
            arg0.total_lootbox = arg0.total_lootbox + 1;
            let v4 = new_lootbox(arg6, arg0.total_lootbox);
            0x1::vector::push_back<0x2::object::ID>(&mut v2, 0x2::object::id<NFTLootbox>(&v4));
            0x1::vector::push_back<u64>(&mut v3, v4.idx);
            0x2::transfer::public_transfer<NFTLootbox>(v4, v0);
            arg4 = arg4 - 1;
        };
        let v5 = MintLootbox{
            from         : v0,
            lootboxes    : v2,
            lootbox_idxs : v3,
            random_id    : arg2,
        };
        0x2::event::emit<MintLootbox>(v5);
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
        let v3 = OpenLootbox{
            from        : v0,
            lootbox_id  : 0x2::object::id<NFTLootbox>(&arg2),
            lootbox_idx : v2,
            reward      : get_random_reward(arg1, arg3),
        };
        0x2::event::emit<OpenLootbox>(v3);
    }

    public fun serialize_lootbox_args(arg0: address, arg1: u64, arg2: u64, arg3: u64) : vector<u8> {
        let v0 = LootboxArgTBS{
            user        : 0x2::address::to_string(arg0),
            uid         : arg1,
            valid_until : arg2,
            count       : arg3,
        };
        0x1::bcs::to_bytes<LootboxArgTBS>(&v0)
    }

    public fun update_storage(arg0: &0xde2ca48490c1521e5fcd2839fa6ff3d369094f915e2c54e014baef28c53b9a7::capybara_game_card::AdminCap, arg1: vector<u8>, arg2: bool, arg3: &mut DataStorage, arg4: &mut 0x2::tx_context::TxContext) {
        arg3.pk = arg1;
        arg3.check_signature = arg2;
    }

    // decompiled from Move bytecode v6
}

