module 0xd8ef52a9f445528bbec8be91e0254e8ae77261a04c48395a4e0d065f1b8e90b6::seafi_nft {
    struct SEAFI_NFT has drop {
        dummy_field: bool,
    }

    struct AdminCap has store, key {
        id: 0x2::object::UID,
    }

    struct TreasureCap has store, key {
        id: 0x2::object::UID,
    }

    struct SeaFiNFT has store, key {
        id: 0x2::object::UID,
        gen_id: u128,
    }

    struct Config has store, key {
        id: 0x2::object::UID,
        version: u64,
        admin: address,
        name: 0x1::string::String,
        fee_balance: 0x2::balance::Balance<0x2::sui::SUI>,
        paused: bool,
        start_time: u64,
        end_time: u64,
        mint_fee: u64,
        total: u128,
        remaining: u128,
        total_sold: u128,
        wl_manager: vector<address>,
        whitelisted: 0x2::table::Table<address, bool>,
        participants: 0x2::table::Table<address, bool>,
    }

    struct UpdateStartEndTimeEvent has copy, drop {
        campaign_id: 0x2::object::ID,
        start_time: u64,
        end_time: u64,
    }

    struct UpdateCampaignNameEvent has copy, drop {
        campaign_id: 0x2::object::ID,
        name: vector<u8>,
    }

    struct AddWhiteListEvent has copy, drop {
        campaign_id: 0x2::object::ID,
        users: vector<address>,
    }

    struct RemoveWhiteListEvent has copy, drop {
        campaign_id: 0x2::object::ID,
        users: vector<address>,
    }

    struct StartPauseEvent has copy, drop {
        campaign_id: 0x2::object::ID,
        paused: bool,
    }

    struct AddWlManagerEvent has copy, drop {
        users: vector<address>,
    }

    struct RemoveWlManagerEvent has copy, drop {
        users: vector<address>,
    }

    struct NFTConfigEvent has copy, drop {
        campaign_id: 0x2::object::ID,
        fee: u64,
        total: u128,
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

    public fun add_whitelist(arg0: &mut Config, arg1: vector<address>, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.version == 1, 1002);
        let v0 = 0x2::tx_context::sender(arg2);
        assert!(0x1::vector::contains<address>(&arg0.wl_manager, &v0), 1004);
        let v1 = 0;
        while (v1 < 0x1::vector::length<address>(&arg1)) {
            let v2 = *0x1::vector::borrow<address>(&arg1, v1);
            if (!0x2::table::contains<address, bool>(&arg0.whitelisted, v2)) {
                0x2::table::add<address, bool>(&mut arg0.whitelisted, v2, true);
            };
            v1 = v1 + 1;
        };
        let v3 = AddWhiteListEvent{
            campaign_id : 0x2::object::id<Config>(arg0),
            users       : arg1,
        };
        0x2::event::emit<AddWhiteListEvent>(v3);
    }

    public fun add_whitelist_manager(arg0: &AdminCap, arg1: &mut Config, arg2: vector<address>) {
        assert!(arg1.version == 1, 1002);
        let v0 = 0;
        while (v0 < 0x1::vector::length<address>(&arg2)) {
            let v1 = 0x1::vector::borrow<address>(&arg2, v0);
            if (!0x1::vector::contains<address>(&arg1.wl_manager, v1)) {
                0x1::vector::push_back<address>(&mut arg1.wl_manager, *v1);
            };
            v0 = v0 + 1;
        };
        let v2 = AddWlManagerEvent{users: arg2};
        0x2::event::emit<AddWlManagerEvent>(v2);
    }

    public fun burn(arg0: &Config, arg1: SeaFiNFT, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.version == 1, 1002);
        let SeaFiNFT {
            id     : v0,
            gen_id : v1,
        } = arg1;
        0x2::object::delete(v0);
        let v2 = BurnedEvent{
            owner       : 0x2::tx_context::sender(arg2),
            campaign_id : 0x2::object::id<Config>(arg0),
            nft_id      : 0x2::object::id<SeaFiNFT>(&arg1),
            gen_id      : v1,
        };
        0x2::event::emit<BurnedEvent>(v2);
    }

    public fun change_fee_manager(arg0: TreasureCap, arg1: address) {
        0x2::transfer::public_transfer<TreasureCap>(arg0, arg1);
    }

    fun init(arg0: SEAFI_NFT, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let v1 = 0x2::package::claim<SEAFI_NFT>(arg0, arg1);
        let v2 = setup_nft_display(&v1, arg1);
        0x2::transfer::public_transfer<0x2::package::Publisher>(v1, v0);
        0x2::transfer::public_transfer<0x2::display::Display<SeaFiNFT>>(v2, v0);
        let v3 = AdminCap{id: 0x2::object::new(arg1)};
        0x2::transfer::public_transfer<AdminCap>(v3, v0);
        let v4 = TreasureCap{id: 0x2::object::new(arg1)};
        0x2::transfer::public_transfer<TreasureCap>(v4, v0);
        let v5 = Config{
            id           : 0x2::object::new(arg1),
            version      : 1,
            admin        : v0,
            name         : 0x1::string::utf8(b""),
            fee_balance  : 0x2::balance::zero<0x2::sui::SUI>(),
            paused       : true,
            start_time   : 0,
            end_time     : 0,
            mint_fee     : 10000000,
            total        : 0,
            remaining    : 0,
            total_sold   : 0,
            wl_manager   : 0x1::vector::empty<address>(),
            whitelisted  : 0x2::table::new<address, bool>(arg1),
            participants : 0x2::table::new<address, bool>(arg1),
        };
        0x2::transfer::public_share_object<Config>(v5);
    }

    public fun migrate(arg0: &AdminCap, arg1: &mut Config) {
        assert!(arg1.version < 1, 1001);
        arg1.version = 1;
    }

    public fun mint(arg0: &mut Config, arg1: 0x2::coin::Coin<0x2::sui::SUI>, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.version == 1, 1002);
        assert!(!arg0.paused, 1003);
        let v0 = 0x2::clock::timestamp_ms(arg2);
        assert!(v0 >= arg0.start_time, 1006);
        assert!(v0 <= arg0.end_time, 1010);
        let v1 = 0x2::tx_context::sender(arg3);
        assert!(0x2::table::contains<address, bool>(&arg0.whitelisted, v1), 1009);
        assert!(arg0.remaining > 0, 1005);
        assert!(!0x2::table::contains<address, bool>(&arg0.participants, v1), 1007);
        assert!(0x2::coin::value<0x2::sui::SUI>(&arg1) == arg0.mint_fee, 1000);
        0x2::balance::join<0x2::sui::SUI>(&mut arg0.fee_balance, 0x2::coin::into_balance<0x2::sui::SUI>(arg1));
        arg0.total_sold = arg0.total_sold + 1;
        arg0.remaining = arg0.remaining - 1;
        0x2::table::add<address, bool>(&mut arg0.participants, v1, true);
        let v2 = SeaFiNFT{
            id     : 0x2::object::new(arg3),
            gen_id : arg0.total_sold,
        };
        let v3 = MintedEvent{
            user        : v1,
            campaign_id : 0x2::object::id<Config>(arg0),
            nft_id      : 0x2::object::id<SeaFiNFT>(&v2),
            gen_id      : arg0.total_sold,
        };
        0x2::event::emit<MintedEvent>(v3);
        0x2::transfer::public_transfer<SeaFiNFT>(v2, v1);
    }

    public fun pause(arg0: &AdminCap, arg1: &mut Config, arg2: bool) {
        assert!(arg1.version == 1, 1002);
        assert!(arg2 != arg1.paused, 1008);
        arg1.paused = arg2;
        let v0 = StartPauseEvent{
            campaign_id : 0x2::object::id<Config>(arg1),
            paused      : arg2,
        };
        0x2::event::emit<StartPauseEvent>(v0);
    }

    public fun remove_whitelist(arg0: &mut Config, arg1: vector<address>, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.version == 1, 1002);
        let v0 = 0x2::tx_context::sender(arg2);
        assert!(0x1::vector::contains<address>(&arg0.wl_manager, &v0), 1004);
        let v1 = 0;
        while (v1 < 0x1::vector::length<address>(&arg1)) {
            let v2 = *0x1::vector::borrow<address>(&arg1, v1);
            if (0x2::table::contains<address, bool>(&arg0.whitelisted, v2)) {
                0x2::table::remove<address, bool>(&mut arg0.whitelisted, v2);
            };
            v1 = v1 + 1;
        };
        let v3 = RemoveWhiteListEvent{
            campaign_id : 0x2::object::id<Config>(arg0),
            users       : arg1,
        };
        0x2::event::emit<RemoveWhiteListEvent>(v3);
    }

    public fun remove_whitelist_manager(arg0: &AdminCap, arg1: &mut Config, arg2: vector<address>) {
        assert!(arg1.version == 1, 1002);
        let v0 = 0;
        while (v0 < 0x1::vector::length<address>(&arg2)) {
            let v1 = 0x1::vector::borrow<address>(&arg2, v0);
            if (0x1::vector::contains<address>(&arg1.wl_manager, v1)) {
                let (_, v3) = 0x1::vector::index_of<address>(&arg1.wl_manager, v1);
                0x1::vector::remove<address>(&mut arg1.wl_manager, v3);
            };
            v0 = v0 + 1;
        };
        let v4 = RemoveWlManagerEvent{users: arg2};
        0x2::event::emit<RemoveWlManagerEvent>(v4);
    }

    public fun self_mint(arg0: &AdminCap, arg1: &mut Config, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(arg1.version == 1, 1002);
        assert!(!arg1.paused, 1003);
        let v0 = 0x2::tx_context::sender(arg2);
        let v1 = SeaFiNFT{
            id     : 0x2::object::new(arg2),
            gen_id : arg1.total_sold,
        };
        let v2 = MintedEvent{
            user        : v0,
            campaign_id : 0x2::object::id<Config>(arg1),
            nft_id      : 0x2::object::id<SeaFiNFT>(&v1),
            gen_id      : arg1.total_sold,
        };
        0x2::event::emit<MintedEvent>(v2);
        0x2::transfer::public_transfer<SeaFiNFT>(v1, v0);
    }

    fun setup_nft_display(arg0: &0x2::package::Publisher, arg1: &mut 0x2::tx_context::TxContext) : 0x2::display::Display<SeaFiNFT> {
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
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"SEAFI - SeaFi Asset"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"https://assets.thebirds.ai/nfts/quest-hub/seafi/{gen_id}.json"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"https://assets.thebirds.ai/nfts/quest-hub/seafi/{gen_id}.png"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"https://assets.thebirds.ai/nfts/quest-hub/seafi/{gen_id}-thumbnail.jpg"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"Project Launches, Smart Trading, Yield Optimization, and AI-Driven Innovation empowering the growth of Web3."));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"https://x.com/SeaFi_AI"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"SeaFi"));
        let v4 = 0x2::display::new_with_fields<SeaFiNFT>(arg0, v0, v2, arg1);
        0x2::display::update_version<SeaFiNFT>(&mut v4);
        v4
    }

    public fun update_name(arg0: &AdminCap, arg1: &mut Config, arg2: vector<u8>) {
        assert!(arg1.version == 1, 1002);
        arg1.name = 0x1::string::utf8(arg2);
        let v0 = UpdateCampaignNameEvent{
            campaign_id : 0x2::object::id<Config>(arg1),
            name        : arg2,
        };
        0x2::event::emit<UpdateCampaignNameEvent>(v0);
    }

    public fun update_nft_config(arg0: &AdminCap, arg1: &mut Config, arg2: u64, arg3: u128) {
        assert!(arg1.version == 1, 1002);
        arg1.mint_fee = arg2;
        arg1.total = arg3;
        arg1.remaining = arg1.total - arg1.total - arg1.remaining;
        let v0 = NFTConfigEvent{
            campaign_id : 0x2::object::id<Config>(arg1),
            fee         : arg2,
            total       : arg3,
        };
        0x2::event::emit<NFTConfigEvent>(v0);
    }

    public fun update_start_end_time(arg0: &AdminCap, arg1: &mut Config, arg2: u64, arg3: u64) {
        assert!(arg1.version == 1, 1002);
        assert!(arg2 < arg3, 1008);
        arg1.start_time = arg2;
        arg1.end_time = arg3;
        let v0 = UpdateStartEndTimeEvent{
            campaign_id : 0x2::object::id<Config>(arg1),
            start_time  : arg2,
            end_time    : arg3,
        };
        0x2::event::emit<UpdateStartEndTimeEvent>(v0);
    }

    public fun withdraw_fee(arg0: &TreasureCap, arg1: &mut Config, arg2: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::take<0x2::sui::SUI>(&mut arg1.fee_balance, 0x2::balance::value<0x2::sui::SUI>(&arg1.fee_balance), arg2), 0x2::tx_context::sender(arg2));
    }

    // decompiled from Move bytecode v6
}

