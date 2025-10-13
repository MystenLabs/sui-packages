module 0x2f3281814fed3db82a520e4cca0ef941be88670a58361d2ed8482ffad0df856a::jacuzzi {
    struct JACUZZI has drop {
        dummy_field: bool,
    }

    struct AdminCap has store, key {
        id: 0x2::object::UID,
    }

    struct JacuzziNFT has key {
        id: 0x2::object::UID,
        type: 0x1::string::String,
        gen_id: u128,
    }

    struct Config has store, key {
        id: 0x2::object::UID,
        version: u64,
        admin: address,
        name: 0x1::string::String,
        paused: bool,
        gen_ids: 0x2::table::Table<u8, u128>,
        wl_manager: 0x2::vec_set::VecSet<address>,
        whitelisted: 0x2::table::Table<u8, 0x2::vec_set::VecSet<address>>,
    }

    struct UpdateCampaignNameEvent has copy, drop {
        campaign_id: 0x2::object::ID,
        name: 0x1::string::String,
    }

    struct StartPauseEvent has copy, drop {
        campaign_id: 0x2::object::ID,
        paused: bool,
    }

    struct MintedEvent has copy, drop {
        user: address,
        campaign_id: 0x2::object::ID,
        nft_id: 0x2::object::ID,
        gen_id: u128,
    }

    struct BurnedEvent has copy, drop {
        owner: address,
        campaign_id: 0x2::object::ID,
        nft_id: 0x2::object::ID,
        gen_id: u128,
    }

    struct AddWhiteListEvent has copy, drop {
        campaign_id: 0x2::object::ID,
        users: vector<address>,
    }

    struct RemoveWhiteListEvent has copy, drop {
        campaign_id: 0x2::object::ID,
        users: vector<address>,
    }

    struct AddWlManagerEvent has copy, drop {
        users: vector<address>,
    }

    struct RemoveWlManagerEvent has copy, drop {
        users: vector<address>,
    }

    public fun add_whitelist(arg0: &mut Config, arg1: u8, arg2: vector<address>, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.version == 1, 1002);
        let v0 = 0x2::tx_context::sender(arg3);
        assert!(0x2::vec_set::contains<address>(&arg0.wl_manager, &v0), 1006);
        let v1 = 0;
        let v2 = 0x2::table::borrow_mut<u8, 0x2::vec_set::VecSet<address>>(&mut arg0.whitelisted, arg1);
        while (v1 < 0x1::vector::length<address>(&arg2)) {
            let v3 = 0x1::vector::borrow<address>(&arg2, v1);
            if (!0x2::vec_set::contains<address>(v2, v3)) {
                0x2::vec_set::insert<address>(v2, *v3);
            };
            v1 = v1 + 1;
        };
        let v4 = AddWhiteListEvent{
            campaign_id : 0x2::object::id<Config>(arg0),
            users       : arg2,
        };
        0x2::event::emit<AddWhiteListEvent>(v4);
    }

    public fun add_whitelist_manager(arg0: &AdminCap, arg1: &mut Config, arg2: vector<address>) {
        assert!(arg1.version == 1, 1002);
        let v0 = 0;
        while (v0 < 0x1::vector::length<address>(&arg2)) {
            let v1 = 0x1::vector::borrow<address>(&arg2, v0);
            if (!0x2::vec_set::contains<address>(&arg1.wl_manager, v1)) {
                0x2::vec_set::insert<address>(&mut arg1.wl_manager, *v1);
            };
            v0 = v0 + 1;
        };
        let v2 = AddWlManagerEvent{users: arg2};
        0x2::event::emit<AddWlManagerEvent>(v2);
    }

    public fun burn(arg0: &Config, arg1: JacuzziNFT, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.version == 1, 1002);
        let JacuzziNFT {
            id     : v0,
            type   : _,
            gen_id : v2,
        } = arg1;
        0x2::object::delete(v0);
        let v3 = BurnedEvent{
            owner       : 0x2::tx_context::sender(arg2),
            campaign_id : 0x2::object::id<Config>(arg0),
            nft_id      : 0x2::object::id<JacuzziNFT>(&arg1),
            gen_id      : v2,
        };
        0x2::event::emit<BurnedEvent>(v3);
    }

    fun init(arg0: JACUZZI, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let v1 = 0x2::package::claim<JACUZZI>(arg0, arg1);
        let v2 = setup_nft_display(&v1, arg1);
        0x2::transfer::public_transfer<0x2::package::Publisher>(v1, v0);
        0x2::transfer::public_transfer<0x2::display::Display<JacuzziNFT>>(v2, v0);
        let v3 = AdminCap{id: 0x2::object::new(arg1)};
        0x2::transfer::public_transfer<AdminCap>(v3, v0);
        let v4 = Config{
            id          : 0x2::object::new(arg1),
            version     : 1,
            admin       : v0,
            name        : 0x1::string::utf8(b""),
            paused      : true,
            gen_ids     : 0x2::table::new<u8, u128>(arg1),
            wl_manager  : 0x2::vec_set::empty<address>(),
            whitelisted : 0x2::table::new<u8, 0x2::vec_set::VecSet<address>>(arg1),
        };
        0x2::transfer::public_share_object<Config>(v4);
    }

    public fun migrate(arg0: &AdminCap, arg1: &mut Config) {
        assert!(arg1.version < 1, 1001);
        arg1.version = 1;
    }

    public fun mint(arg0: &mut Config, arg1: u8, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.version == 1, 1002);
        assert!(!arg0.paused, 1003);
        let v0 = 0x2::tx_context::sender(arg2);
        if (arg1 > 3 || arg1 < 1) {
            abort 1005
        };
        let (v1, v2) = if (arg1 == 1) {
            let v3 = 0x2::table::borrow_mut<u8, 0x2::vec_set::VecSet<address>>(&mut arg0.whitelisted, arg1);
            assert!(0x2::vec_set::contains<address>(v3, &v0), 1004);
            0x2::vec_set::remove<address>(v3, &v0);
            let v4 = if (0x2::table::contains<u8, u128>(&arg0.gen_ids, 1)) {
                0x2::table::remove<u8, u128>(&mut arg0.gen_ids, 1)
            } else {
                0
            };
            0x2::table::add<u8, u128>(&mut arg0.gen_ids, 1, v4 + 1);
            (0x1::string::utf8(b"chunnin"), v4)
        } else if (arg1 == 2) {
            let v5 = 0x2::table::borrow_mut<u8, 0x2::vec_set::VecSet<address>>(&mut arg0.whitelisted, arg1);
            assert!(0x2::vec_set::contains<address>(v5, &v0), 1004);
            0x2::vec_set::remove<address>(v5, &v0);
            let v6 = if (0x2::table::contains<u8, u128>(&arg0.gen_ids, 2)) {
                0x2::table::remove<u8, u128>(&mut arg0.gen_ids, 2)
            } else {
                0
            };
            0x2::table::add<u8, u128>(&mut arg0.gen_ids, 2, v6 + 1);
            (0x1::string::utf8(b"jonin"), v6)
        } else {
            let v7 = 0x2::table::borrow_mut<u8, 0x2::vec_set::VecSet<address>>(&mut arg0.whitelisted, arg1);
            assert!(0x2::vec_set::contains<address>(v7, &v0), 1004);
            0x2::vec_set::remove<address>(v7, &v0);
            let v8 = if (0x2::table::contains<u8, u128>(&arg0.gen_ids, 3)) {
                0x2::table::remove<u8, u128>(&mut arg0.gen_ids, 3)
            } else {
                0
            };
            0x2::table::add<u8, u128>(&mut arg0.gen_ids, 3, v8 + 1);
            (0x1::string::utf8(b"kage"), v8)
        };
        let v9 = JacuzziNFT{
            id     : 0x2::object::new(arg2),
            type   : v1,
            gen_id : v2,
        };
        let v10 = MintedEvent{
            user        : v0,
            campaign_id : 0x2::object::id<Config>(arg0),
            nft_id      : 0x2::object::id<JacuzziNFT>(&v9),
            gen_id      : v2,
        };
        0x2::event::emit<MintedEvent>(v10);
        0x2::transfer::transfer<JacuzziNFT>(v9, v0);
    }

    public fun pause(arg0: &AdminCap, arg1: &mut Config, arg2: bool) {
        assert!(arg1.version == 1, 1002);
        assert!(arg2 != arg1.paused, 1005);
        arg1.paused = arg2;
        let v0 = StartPauseEvent{
            campaign_id : 0x2::object::id<Config>(arg1),
            paused      : arg2,
        };
        0x2::event::emit<StartPauseEvent>(v0);
    }

    public fun remove_whitelist(arg0: &mut Config, arg1: u8, arg2: vector<address>, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.version == 1, 1002);
        let v0 = 0x2::tx_context::sender(arg3);
        assert!(0x2::vec_set::contains<address>(&arg0.wl_manager, &v0), 1006);
        let v1 = 0x2::table::borrow_mut<u8, 0x2::vec_set::VecSet<address>>(&mut arg0.whitelisted, arg1);
        let v2 = 0;
        while (v2 < 0x1::vector::length<address>(&arg2)) {
            let v3 = 0x1::vector::borrow<address>(&arg2, v2);
            if (0x2::vec_set::contains<address>(v1, v3)) {
                0x2::vec_set::remove<address>(v1, v3);
            };
            v2 = v2 + 1;
        };
        let v4 = RemoveWhiteListEvent{
            campaign_id : 0x2::object::id<Config>(arg0),
            users       : arg2,
        };
        0x2::event::emit<RemoveWhiteListEvent>(v4);
    }

    public fun remove_whitelist_manager(arg0: &AdminCap, arg1: &mut Config, arg2: vector<address>) {
        assert!(arg1.version == 1, 1002);
        let v0 = 0;
        while (v0 < 0x1::vector::length<address>(&arg2)) {
            let v1 = 0x1::vector::borrow<address>(&arg2, v0);
            if (0x2::vec_set::contains<address>(&arg1.wl_manager, v1)) {
                0x2::vec_set::remove<address>(&mut arg1.wl_manager, v1);
            };
            v0 = v0 + 1;
        };
        let v2 = RemoveWlManagerEvent{users: arg2};
        0x2::event::emit<RemoveWlManagerEvent>(v2);
    }

    fun setup_nft_display(arg0: &0x2::package::Publisher, arg1: &mut 0x2::tx_context::TxContext) : 0x2::display::Display<JacuzziNFT> {
        let v0 = 0x1::vector::empty<0x1::string::String>();
        let v1 = &mut v0;
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"name"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"link"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"image_url"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"thumbnail_url"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"description"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"project_url"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"creator"));
        let v2 = 0x1::vector::empty<0x1::string::String>();
        let v3 = &mut v2;
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"Ferra Jacuzzi Badge"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"https://assets.ferra.ag/nfts/campaigns/jacuzzi-badges/{type}/{gen_id}.json"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"https://assets.ferra.ag/nfts/campaigns/jacuzzi-badges/{type}/{gen_id}.png"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"https://assets.ferra.ag/nfts/campaigns/jacuzzi-badges/{type}/{gen_id}-thumbnail.jpg"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"Utility Soulbound NFT, permanently tied to your Sui wallet as Proof of LP achievement in Ferra's early mainnet stage."));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"https://ferra.ag/"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"Ferra"));
        let v4 = 0x2::display::new_with_fields<JacuzziNFT>(arg0, v0, v2, arg1);
        0x2::display::update_version<JacuzziNFT>(&mut v4);
        v4
    }

    public fun update_name(arg0: &AdminCap, arg1: &mut Config, arg2: 0x1::string::String) {
        assert!(arg1.version == 1, 1002);
        arg1.name = arg2;
        let v0 = UpdateCampaignNameEvent{
            campaign_id : 0x2::object::id<Config>(arg1),
            name        : arg2,
        };
        0x2::event::emit<UpdateCampaignNameEvent>(v0);
    }

    // decompiled from Move bytecode v6
}

