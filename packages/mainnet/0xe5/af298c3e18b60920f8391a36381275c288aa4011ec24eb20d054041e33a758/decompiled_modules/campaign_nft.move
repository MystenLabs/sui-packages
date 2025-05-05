module 0x7e4fbd6cf7e75e98c67a27fbf1c1183c6328b5478ce108b55de8eef542ddb414::campaign_nft {
    struct CAMPAIGN_NFT has drop {
        dummy_field: bool,
    }

    struct AdminCap has store, key {
        id: 0x2::object::UID,
    }

    struct TreasureCap has store, key {
        id: 0x2::object::UID,
    }

    struct CampaignNFT has store, key {
        id: 0x2::object::UID,
        xid: u128,
        type: u16,
        type_name: 0x1::string::String,
        sub_type: u8,
        sub_type_name: 0x1::string::String,
        gen_id: u128,
    }

    struct CampaignConfig has store, key {
        id: 0x2::object::UID,
        version: u64,
        validator: 0x1::option::Option<vector<u8>>,
        total_sold: u128,
        paused: bool,
        start_time: u64,
        end_time: u64,
        wl_manager: vector<address>,
        whitelisted: 0x2::table::Table<address, bool>,
        participants: 0x2::table::Table<address, bool>,
        nonce: 0x2::table::Table<address, u128>,
    }

    struct NFTConfig has store, key {
        id: 0x2::object::UID,
        fee: u64,
        total: u128,
        remaining: u128,
        total_type: u16,
        type_name: 0x2::table::Table<u16, 0x1::string::String>,
        total_sub_type: u8,
        sub_type_name: 0x2::table::Table<u8, 0x1::string::String>,
    }

    struct FeePool<phantom T0> has store, key {
        id: 0x2::object::UID,
        total_sold: u64,
        total_mint_fee: 0x2::balance::Balance<T0>,
    }

    struct CreateFeePoolEvent has copy, drop {
        id: 0x2::object::ID,
        total_sold: u64,
        total_mint_fee: u64,
        token_type: 0x1::type_name::TypeName,
    }

    struct UpdateNFTType has copy, drop {
        type: u16,
        old_name: 0x1::string::String,
        name: 0x1::string::String,
    }

    struct UpdateNFTSubType has copy, drop {
        sub_type: u8,
        old_name: 0x1::string::String,
        name: 0x1::string::String,
    }

    struct UpdateStartEndTime has copy, drop {
        start_time: u64,
        end_time: u64,
    }

    struct AddWhiteListEvent has copy, drop {
        users: vector<address>,
    }

    struct RemoveWhiteListEvent has copy, drop {
        users: vector<address>,
    }

    struct StartPauseEvent has copy, drop {
        paused: bool,
    }

    struct AddWlManagerEvent has copy, drop {
        users: vector<address>,
    }

    struct RemoveWlManagerEvent has copy, drop {
        users: vector<address>,
    }

    struct NFTConfigEvent has copy, drop {
        fee: u64,
        total_type: u16,
        total_sub_type: u8,
        total: u128,
    }

    struct MintedEvent has copy, drop {
        user: address,
        pool_id: 0x2::object::ID,
        id: 0x2::object::ID,
        xid: u128,
        type: u16,
        sub_type: u8,
        gen_id: u128,
    }

    struct BurnedEvent has copy, drop {
        owner: address,
        id: 0x2::object::ID,
        xid: u128,
        type: u16,
        type_name: 0x1::string::String,
        sub_type: u8,
        sub_type_name: 0x1::string::String,
        gen_id: u128,
    }

    public fun add_whitelist(arg0: &mut CampaignConfig, arg1: vector<address>, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.version == 2, 1002);
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
        let v3 = AddWhiteListEvent{users: arg1};
        0x2::event::emit<AddWhiteListEvent>(v3);
    }

    public fun add_whitelist_manager(arg0: &AdminCap, arg1: &mut CampaignConfig, arg2: vector<address>) {
        assert!(arg1.version == 2, 1002);
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

    public fun burn(arg0: &CampaignConfig, arg1: CampaignNFT, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.version == 2, 1002);
        let CampaignNFT {
            id            : v0,
            xid           : v1,
            type          : v2,
            type_name     : v3,
            sub_type      : v4,
            sub_type_name : v5,
            gen_id        : v6,
        } = arg1;
        0x2::object::delete(v0);
        let v7 = BurnedEvent{
            owner         : 0x2::tx_context::sender(arg2),
            id            : 0x2::object::id<CampaignNFT>(&arg1),
            xid           : v1,
            type          : v2,
            type_name     : v3,
            sub_type      : v4,
            sub_type_name : v5,
            gen_id        : v6,
        };
        0x2::event::emit<BurnedEvent>(v7);
    }

    public fun buy(arg0: &mut CampaignConfig, arg1: &mut NFTConfig, arg2: &mut FeePool<0x2::sui::SUI>, arg3: 0x2::coin::Coin<0x2::sui::SUI>, arg4: &0x2::clock::Clock, arg5: &0x2::random::Random, arg6: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.version == 2, 1002);
        assert!(!arg0.paused, 1003);
        let v0 = 0x2::clock::timestamp_ms(arg4);
        assert!(v0 >= arg0.start_time, 1009);
        assert!(v0 <= arg0.end_time, 1013);
        let v1 = 0x2::tx_context::sender(arg6);
        assert!(0x2::table::contains<address, bool>(&arg0.whitelisted, v1), 1012);
        assert!(arg1.remaining > 0, 1005);
        assert!(!0x2::table::contains<address, bool>(&arg0.participants, v1), 1010);
        assert!(0x2::coin::value<0x2::sui::SUI>(&arg3) == arg1.fee, 1000);
        0x2::balance::join<0x2::sui::SUI>(&mut arg2.total_mint_fee, 0x2::coin::into_balance<0x2::sui::SUI>(arg3));
        arg2.total_sold = arg2.total_sold + 1;
        arg1.remaining = arg1.remaining - 1;
        0x2::table::add<address, bool>(&mut arg0.participants, v1, true);
        let v2 = 0x2::random::new_generator(arg5, arg6);
        let v3 = 0x2::random::generate_u16_in_range(&mut v2, 0, arg1.total_type - 1);
        let v4 = 0x2::random::generate_u8_in_range(&mut v2, 0, arg1.total_sub_type - 1);
        let v5 = arg0.total_sold;
        let v6 = CampaignNFT{
            id            : 0x2::object::new(arg6),
            xid           : arg0.total_sold,
            type          : v3,
            type_name     : *0x2::table::borrow<u16, 0x1::string::String>(&arg1.type_name, v3),
            sub_type      : v4,
            sub_type_name : *0x2::table::borrow<u8, 0x1::string::String>(&arg1.sub_type_name, v4),
            gen_id        : v5,
        };
        arg0.total_sold = arg0.total_sold + 1;
        let v7 = MintedEvent{
            user     : v1,
            pool_id  : 0x2::object::id<FeePool<0x2::sui::SUI>>(arg2),
            id       : 0x2::object::id<CampaignNFT>(&v6),
            xid      : v6.xid,
            type     : v3,
            sub_type : v4,
            gen_id   : v5,
        };
        0x2::event::emit<MintedEvent>(v7);
        0x2::transfer::public_transfer<CampaignNFT>(v6, v1);
    }

    public fun change_fee_manager(arg0: TreasureCap, arg1: address) {
        0x2::transfer::public_transfer<TreasureCap>(arg0, arg1);
    }

    public fun create_fee_pool<T0>(arg0: &AdminCap, arg1: &CampaignConfig, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(arg1.version == 2, 1002);
        let v0 = FeePool<T0>{
            id             : 0x2::object::new(arg2),
            total_sold     : 0,
            total_mint_fee : 0x2::balance::zero<T0>(),
        };
        let v1 = CreateFeePoolEvent{
            id             : 0x2::object::id<FeePool<T0>>(&v0),
            total_sold     : v0.total_sold,
            total_mint_fee : 0x2::balance::value<T0>(&v0.total_mint_fee),
            token_type     : 0x1::type_name::get<T0>(),
        };
        0x2::event::emit<CreateFeePoolEvent>(v1);
        0x2::transfer::public_share_object<FeePool<T0>>(v0);
    }

    public fun info(arg0: &CampaignNFT) : (u128, u16, u8, u128) {
        (arg0.xid, arg0.type, arg0.sub_type, arg0.gen_id)
    }

    fun init(arg0: CAMPAIGN_NFT, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let v1 = 0x2::package::claim<CAMPAIGN_NFT>(arg0, arg1);
        let v2 = setup_nft_display(&v1, arg1);
        0x2::transfer::public_transfer<0x2::package::Publisher>(v1, v0);
        0x2::transfer::public_transfer<0x2::display::Display<CampaignNFT>>(v2, v0);
        let v3 = AdminCap{id: 0x2::object::new(arg1)};
        0x2::transfer::public_transfer<AdminCap>(v3, v0);
        let v4 = TreasureCap{id: 0x2::object::new(arg1)};
        0x2::transfer::public_transfer<TreasureCap>(v4, v0);
        let v5 = CampaignConfig{
            id           : 0x2::object::new(arg1),
            version      : 2,
            validator    : 0x1::option::none<vector<u8>>(),
            total_sold   : 0,
            paused       : true,
            start_time   : 0,
            end_time     : 0,
            wl_manager   : 0x1::vector::empty<address>(),
            whitelisted  : 0x2::table::new<address, bool>(arg1),
            participants : 0x2::table::new<address, bool>(arg1),
            nonce        : 0x2::table::new<address, u128>(arg1),
        };
        0x2::transfer::public_share_object<CampaignConfig>(v5);
        let v6 = NFTConfig{
            id             : 0x2::object::new(arg1),
            fee            : 10000000,
            total          : 100,
            remaining      : 100,
            total_type     : 4,
            type_name      : 0x2::table::new<u16, 0x1::string::String>(arg1),
            total_sub_type : 5,
            sub_type_name  : 0x2::table::new<u8, 0x1::string::String>(arg1),
        };
        let v7 = &mut v6;
        init_name(v7);
        0x2::transfer::public_share_object<NFTConfig>(v6);
    }

    fun init_name(arg0: &mut NFTConfig) {
        0x2::table::add<u16, 0x1::string::String>(&mut arg0.type_name, 0, 0x1::string::utf8(b"pool-bird"));
        0x2::table::add<u16, 0x1::string::String>(&mut arg0.type_name, 1, 0x1::string::utf8(b"doctor-bird"));
        0x2::table::add<u16, 0x1::string::String>(&mut arg0.type_name, 2, 0x1::string::utf8(b"iron-bird"));
        0x2::table::add<u16, 0x1::string::String>(&mut arg0.type_name, 3, 0x1::string::utf8(b"thunder-bird"));
        0x2::table::add<u8, 0x1::string::String>(&mut arg0.sub_type_name, 0, 0x1::string::utf8(b"common"));
        0x2::table::add<u8, 0x1::string::String>(&mut arg0.sub_type_name, 1, 0x1::string::utf8(b"rare"));
        0x2::table::add<u8, 0x1::string::String>(&mut arg0.sub_type_name, 2, 0x1::string::utf8(b"epic"));
        0x2::table::add<u8, 0x1::string::String>(&mut arg0.sub_type_name, 3, 0x1::string::utf8(b"legend"));
        0x2::table::add<u8, 0x1::string::String>(&mut arg0.sub_type_name, 4, 0x1::string::utf8(b"mythic"));
    }

    public fun migrate(arg0: &AdminCap, arg1: &mut CampaignConfig) {
        assert!(arg1.version < 2, 1001);
        arg1.version = 2;
    }

    public fun mint<T0>(arg0: &mut CampaignConfig, arg1: &mut NFTConfig, arg2: &mut FeePool<T0>, arg3: 0x2::coin::Coin<T0>, arg4: vector<u8>, arg5: vector<u8>, arg6: &0x2::clock::Clock, arg7: &mut 0x2::tx_context::TxContext) : CampaignNFT {
        assert!(arg0.version == 2, 1002);
        verify_signature(arg4, arg5, &arg0.validator);
        let v0 = 0x2::tx_context::sender(arg7);
        let v1 = 0x2::bcs::new(arg5);
        let v2 = 0x2::bcs::peel_u16(&mut v1);
        let v3 = 0x2::bcs::peel_u8(&mut v1);
        let v4 = 0x2::bcs::peel_u128(&mut v1);
        let v5 = 0x2::bcs::peel_u128(&mut v1);
        assert!(v0 == 0x2::bcs::peel_address(&mut v1), 1004);
        assert!(0x2::bcs::peel_u64(&mut v1) > 0x2::clock::timestamp_ms(arg6), 1008);
        assert!(0x2::bcs::peel_address(&mut v1) == 0x2::object::id_address<FeePool<T0>>(arg2), 1006);
        let v6 = if (0x2::table::contains<address, u128>(&arg0.nonce, v0)) {
            0x2::table::borrow_mut<address, u128>(&mut arg0.nonce, v0)
        } else {
            0x2::table::add<address, u128>(&mut arg0.nonce, v0, 0);
            0x2::table::borrow_mut<address, u128>(&mut arg0.nonce, v0)
        };
        assert!(*v6 < v5, 1014);
        *v6 = v5;
        assert!(0x2::coin::value<T0>(&arg3) == 0x2::bcs::peel_u64(&mut v1), 1000);
        0x2::balance::join<T0>(&mut arg2.total_mint_fee, 0x2::coin::into_balance<T0>(arg3));
        arg2.total_sold = arg2.total_sold + 1;
        let v7 = CampaignNFT{
            id            : 0x2::object::new(arg7),
            xid           : 0x2::bcs::peel_u128(&mut v1),
            type          : v2,
            type_name     : *0x2::table::borrow<u16, 0x1::string::String>(&arg1.type_name, v2),
            sub_type      : v3,
            sub_type_name : *0x2::table::borrow<u8, 0x1::string::String>(&arg1.sub_type_name, v3),
            gen_id        : v4,
        };
        let v8 = MintedEvent{
            user     : v0,
            pool_id  : 0x2::object::id<FeePool<T0>>(arg2),
            id       : 0x2::object::id<CampaignNFT>(&v7),
            xid      : v7.xid,
            type     : v2,
            sub_type : v3,
            gen_id   : v4,
        };
        0x2::event::emit<MintedEvent>(v8);
        v7
    }

    public fun pause(arg0: &AdminCap, arg1: &mut CampaignConfig, arg2: bool) {
        assert!(arg1.version == 2, 1002);
        assert!(arg2 != arg1.paused, 1011);
        arg1.paused = arg2;
        let v0 = StartPauseEvent{paused: arg2};
        0x2::event::emit<StartPauseEvent>(v0);
    }

    public fun remove_whitelist(arg0: &mut CampaignConfig, arg1: vector<address>, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.version == 2, 1002);
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
        let v3 = RemoveWhiteListEvent{users: arg1};
        0x2::event::emit<RemoveWhiteListEvent>(v3);
    }

    public fun remove_whitelist_manager(arg0: &AdminCap, arg1: &mut CampaignConfig, arg2: vector<address>) {
        assert!(arg1.version == 2, 1002);
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

    public fun set_validator(arg0: &AdminCap, arg1: &mut CampaignConfig, arg2: vector<u8>) {
        assert!(arg1.version == 2, 1002);
        0x1::option::swap_or_fill<vector<u8>>(&mut arg1.validator, arg2);
    }

    fun setup_nft_display(arg0: &0x2::package::Publisher, arg1: &mut 0x2::tx_context::TxContext) : 0x2::display::Display<CampaignNFT> {
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
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"BIRD - BIRDS GameFi Asset"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"https://assets.thebirds.ai/nft/bird/{type}/{xid}.json"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"https://assets.thebirds.ai/nfts/birds/{type_name}/{sub_type_name}/{gen_id}.webp"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"https://assets.thebirds.ai/nfts/birds/{type_name}/{sub_type_name}/{gen_id}-thumbnail.jpg"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"The leading meme coin & GameFi Telegram mini-app on the SuiNetwork"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"https://x.com/TheBirdsDogs"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"Bird Labs"));
        let v4 = 0x2::display::new_with_fields<CampaignNFT>(arg0, v0, v2, arg1);
        0x2::display::update_version<CampaignNFT>(&mut v4);
        v4
    }

    public fun update_nft_config(arg0: &AdminCap, arg1: &mut CampaignConfig, arg2: &mut NFTConfig, arg3: u64, arg4: u16, arg5: u8, arg6: u128) {
        assert!(arg1.version == 2, 1002);
        arg2.fee = arg3;
        arg2.total_type = arg4;
        arg2.total_sub_type = arg5;
        arg2.total = arg6;
        arg2.remaining = arg2.total - arg2.total - arg2.remaining;
        let v0 = NFTConfigEvent{
            fee            : arg3,
            total_type     : arg4,
            total_sub_type : arg5,
            total          : arg6,
        };
        0x2::event::emit<NFTConfigEvent>(v0);
    }

    public fun update_nft_sub_type(arg0: &AdminCap, arg1: &mut CampaignConfig, arg2: &mut NFTConfig, arg3: u8, arg4: vector<u8>) {
        assert!(arg1.version == 2, 1002);
        assert!(arg3 <= arg2.total_sub_type, 1011);
        let v0 = if (arg3 == arg2.total_sub_type) {
            arg2.total_sub_type = arg2.total_sub_type + 1;
            0x1::string::utf8(arg4)
        } else {
            0x2::table::remove<u8, 0x1::string::String>(&mut arg2.sub_type_name, arg3)
        };
        0x2::table::add<u8, 0x1::string::String>(&mut arg2.sub_type_name, arg3, 0x1::string::utf8(arg4));
        let v1 = UpdateNFTSubType{
            sub_type : arg3,
            old_name : v0,
            name     : 0x1::string::utf8(arg4),
        };
        0x2::event::emit<UpdateNFTSubType>(v1);
    }

    public fun update_nft_type(arg0: &AdminCap, arg1: &mut CampaignConfig, arg2: &mut NFTConfig, arg3: u16, arg4: vector<u8>) {
        assert!(arg1.version == 2, 1002);
        assert!(arg3 <= arg2.total_type, 1011);
        let v0 = if (arg3 == arg2.total_type) {
            arg2.total_type = arg2.total_type + 1;
            0x1::string::utf8(arg4)
        } else {
            0x2::table::remove<u16, 0x1::string::String>(&mut arg2.type_name, arg3)
        };
        0x2::table::add<u16, 0x1::string::String>(&mut arg2.type_name, arg3, 0x1::string::utf8(arg4));
        let v1 = UpdateNFTType{
            type     : arg3,
            old_name : v0,
            name     : 0x1::string::utf8(arg4),
        };
        0x2::event::emit<UpdateNFTType>(v1);
    }

    public fun update_start_end_time(arg0: &AdminCap, arg1: &mut CampaignConfig, arg2: u64, arg3: u64) {
        assert!(arg1.version == 2, 1002);
        assert!(arg2 < arg3, 1011);
        arg1.start_time = arg2;
        arg1.end_time = arg3;
        let v0 = UpdateStartEndTime{
            start_time : arg2,
            end_time   : arg3,
        };
        0x2::event::emit<UpdateStartEndTime>(v0);
    }

    fun verify_signature(arg0: vector<u8>, arg1: vector<u8>, arg2: &0x1::option::Option<vector<u8>>) {
        assert!(0x1::option::is_some<vector<u8>>(arg2), 1015);
        assert!(0x2::ed25519::ed25519_verify(&arg0, 0x1::option::borrow<vector<u8>>(arg2), &arg1), 1007);
    }

    public fun withdraw_fee<T0>(arg0: &TreasureCap, arg1: &mut FeePool<T0>, arg2: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::take<T0>(&mut arg1.total_mint_fee, 0x2::balance::value<T0>(&arg1.total_mint_fee), arg2), 0x2::tx_context::sender(arg2));
    }

    // decompiled from Move bytecode v6
}

