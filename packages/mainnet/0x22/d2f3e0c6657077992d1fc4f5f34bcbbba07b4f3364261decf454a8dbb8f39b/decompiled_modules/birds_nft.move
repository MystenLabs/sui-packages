module 0x22d2f3e0c6657077992d1fc4f5f34bcbbba07b4f3364261decf454a8dbb8f39b::birds_nft {
    struct BIRDS_NFT has drop {
        dummy_field: bool,
    }

    struct AdminCap has store, key {
        id: 0x2::object::UID,
    }

    struct BirdNFT has store, key {
        id: 0x2::object::UID,
        type: u8,
        sub_type: u8,
    }

    struct BirdConfig has store, key {
        id: 0x2::object::UID,
        total_type: u8,
        total_sub_type: u8,
    }

    struct SaleBirdType has copy, store {
        fee: u64,
        total: u128,
        remaining: u128,
    }

    struct SaleState has store {
        start_time: u64,
        end_time: u64,
        sale_types: vector<SaleBirdType>,
        whitelisted: 0x2::table::Table<address, bool>,
        participants: 0x2::table::Table<address, vector<u8>>,
    }

    struct SaleConfig has store, key {
        id: 0x2::object::UID,
        paused: bool,
        fee_balance: 0x2::balance::Balance<0x2::sui::SUI>,
        publicS: SaleState,
        privateS: SaleState,
        wl_manager: vector<address>,
        fee_manager: address,
    }

    struct CreateTypeEvent has copy, drop {
        whitelist: bool,
        sale_config: address,
        fee: u64,
        total: u128,
    }

    struct UpdateTypeEvent has copy, drop {
        whitelist: bool,
        sale_config: address,
        new_fee: u64,
        new_total: u128,
    }

    struct UpdateStartEndTime has copy, drop {
        whitelist: bool,
        sale_config: address,
        start_time: u64,
        end_time: u64,
    }

    struct AddWhiteListEvent has copy, drop {
        sale_config: address,
        users: vector<address>,
    }

    struct RemoveWhiteListEvent has copy, drop {
        sale_config: address,
        users: vector<address>,
    }

    struct StartPauseEvent has copy, drop {
        sale_config: address,
        paused: bool,
    }

    struct AddWlManagerEvent has copy, drop {
        sale_config: address,
        users: vector<address>,
    }

    struct RemoveWlManagerEvent has copy, drop {
        sale_config: address,
        users: vector<address>,
    }

    struct UpdateBirdConfigEvent has copy, drop {
        bird_config: address,
        total_type: u8,
        total_sub_type: u8,
    }

    struct MintedEvent has copy, drop {
        user: address,
        id: 0x2::object::ID,
        nft_type: u8,
        sub_type: u16,
    }

    struct BurnedEvent has copy, drop {
        owner: address,
        id: 0x2::object::ID,
        type: u8,
        sub_type: u16,
    }

    public fun addWhitelist(arg0: &mut SaleConfig, arg1: vector<address>, arg2: &0x22d2f3e0c6657077992d1fc4f5f34bcbbba07b4f3364261decf454a8dbb8f39b::version::Version, arg3: &mut 0x2::tx_context::TxContext) {
        0x22d2f3e0c6657077992d1fc4f5f34bcbbba07b4f3364261decf454a8dbb8f39b::version::checkVersion(arg2, 1);
        let v0 = 0x2::tx_context::sender(arg3);
        assert!(0x1::vector::contains<address>(&arg0.wl_manager, &v0), 1006);
        let v1 = &mut arg0.privateS;
        let v2 = 0;
        while (v2 < 0x1::vector::length<address>(&arg1)) {
            let v3 = *0x1::vector::borrow<address>(&arg1, v2);
            if (!0x2::table::contains<address, bool>(&v1.whitelisted, v3)) {
                0x2::table::add<address, bool>(&mut v1.whitelisted, v3, true);
            };
            v2 = v2 + 1;
        };
        let v4 = AddWhiteListEvent{
            sale_config : 0x2::object::id_address<SaleConfig>(arg0),
            users       : arg1,
        };
        0x2::event::emit<AddWhiteListEvent>(v4);
    }

    public fun addWlManager(arg0: &AdminCap, arg1: &mut SaleConfig, arg2: vector<address>, arg3: &0x22d2f3e0c6657077992d1fc4f5f34bcbbba07b4f3364261decf454a8dbb8f39b::version::Version) {
        0x22d2f3e0c6657077992d1fc4f5f34bcbbba07b4f3364261decf454a8dbb8f39b::version::checkVersion(arg3, 1);
        let v0 = 0;
        while (v0 < 0x1::vector::length<address>(&arg2)) {
            let v1 = 0x1::vector::borrow<address>(&arg2, v0);
            if (!0x1::vector::contains<address>(&arg1.wl_manager, v1)) {
                0x1::vector::push_back<address>(&mut arg1.wl_manager, *v1);
            };
            v0 = v0 + 1;
        };
        let v2 = AddWlManagerEvent{
            sale_config : 0x2::object::id_address<SaleConfig>(arg1),
            users       : arg2,
        };
        0x2::event::emit<AddWlManagerEvent>(v2);
    }

    public fun burn(arg0: BirdNFT, arg1: &mut 0x2::tx_context::TxContext, arg2: &0x22d2f3e0c6657077992d1fc4f5f34bcbbba07b4f3364261decf454a8dbb8f39b::version::Version) {
        0x22d2f3e0c6657077992d1fc4f5f34bcbbba07b4f3364261decf454a8dbb8f39b::version::checkVersion(arg2, 1);
        let BirdNFT {
            id       : v0,
            type     : v1,
            sub_type : v2,
        } = arg0;
        0x2::object::delete(v0);
        let v3 = BurnedEvent{
            owner    : 0x2::tx_context::sender(arg1),
            id       : 0x2::object::id<BirdNFT>(&arg0),
            type     : v1,
            sub_type : (v2 as u16),
        };
        0x2::event::emit<BurnedEvent>(v3);
    }

    public fun buy_bird(arg0: &0x2::random::Random, arg1: &mut SaleConfig, arg2: &BirdConfig, arg3: u8, arg4: 0x2::coin::Coin<0x2::sui::SUI>, arg5: &0x2::clock::Clock, arg6: &0x22d2f3e0c6657077992d1fc4f5f34bcbbba07b4f3364261decf454a8dbb8f39b::version::Version, arg7: &mut 0x2::tx_context::TxContext) : BirdNFT {
        0x22d2f3e0c6657077992d1fc4f5f34bcbbba07b4f3364261decf454a8dbb8f39b::version::checkVersion(arg6, 1);
        assert!(!arg1.paused, 1004);
        assert!(arg3 >= 0 && arg3 <= arg2.total_type, 1005);
        let v0 = 0x2::clock::timestamp_ms(arg5);
        assert!(v0 >= arg1.privateS.start_time, 1009);
        assert!(v0 <= arg1.publicS.end_time, 1013);
        let v1 = true;
        let v2 = &mut arg1.privateS;
        if (v0 >= arg1.publicS.start_time && v0 <= arg1.publicS.end_time) {
            v2 = &mut arg1.publicS;
            v1 = false;
        };
        let v3 = 0x2::tx_context::sender(arg7);
        assert!(v1 && 0x2::table::contains<address, bool>(&v2.whitelisted, v3) || !v1, 1012);
        let v4 = 0x1::vector::borrow_mut<SaleBirdType>(&mut v2.sale_types, (arg3 as u64));
        assert!(v4.remaining > 0, 1007);
        assert!(!0x1::vector::contains<u8>(0x2::table::borrow<address, vector<u8>>(&v2.participants, v3), &arg3), 1010);
        assert!(0x2::coin::value<0x2::sui::SUI>(&arg4) == v4.fee, 1000);
        0x2::balance::join<0x2::sui::SUI>(&mut arg1.fee_balance, 0x2::coin::into_balance<0x2::sui::SUI>(arg4));
        v4.remaining = v4.remaining - 1;
        if (0x2::table::contains<address, vector<u8>>(&v2.participants, v3)) {
            0x1::vector::push_back<u8>(0x2::table::borrow_mut<address, vector<u8>>(&mut v2.participants, v3), arg3);
        } else {
            let v5 = 0x1::vector::empty<u8>();
            0x1::vector::push_back<u8>(&mut v5, arg3);
            0x2::table::add<address, vector<u8>>(&mut v2.participants, v3, v5);
        };
        let v6 = 0x2::random::new_generator(arg0, arg7);
        let v7 = 0x2::random::generate_u16_in_range(&mut v6, 0, (arg2.total_sub_type as u16));
        let v8 = BirdNFT{
            id       : 0x2::object::new(arg7),
            type     : arg3,
            sub_type : (v7 as u8),
        };
        let v9 = MintedEvent{
            user     : v3,
            id       : 0x2::object::id<BirdNFT>(&v8),
            nft_type : arg3,
            sub_type : v7,
        };
        0x2::event::emit<MintedEvent>(v9);
        v8
    }

    public fun createType(arg0: &AdminCap, arg1: bool, arg2: &mut SaleConfig, arg3: u64, arg4: u128, arg5: &0x22d2f3e0c6657077992d1fc4f5f34bcbbba07b4f3364261decf454a8dbb8f39b::version::Version) {
        0x22d2f3e0c6657077992d1fc4f5f34bcbbba07b4f3364261decf454a8dbb8f39b::version::checkVersion(arg5, 1);
        let v0 = SaleBirdType{
            fee       : arg3,
            total     : arg4,
            remaining : arg4,
        };
        if (arg1) {
            0x1::vector::push_back<SaleBirdType>(&mut arg2.privateS.sale_types, v0);
        } else {
            0x1::vector::push_back<SaleBirdType>(&mut arg2.publicS.sale_types, v0);
        };
        let v1 = CreateTypeEvent{
            whitelist   : arg1,
            sale_config : 0x2::object::id_address<SaleConfig>(arg2),
            fee         : arg3,
            total       : arg4,
        };
        0x2::event::emit<CreateTypeEvent>(v1);
    }

    fun init(arg0: BIRDS_NFT, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::package::claim<BIRDS_NFT>(arg0, arg1);
        let v1 = setupNft(&v0, arg1);
        let v2 = 0x2::tx_context::sender(arg1);
        0x2::transfer::public_transfer<0x2::package::Publisher>(v0, v2);
        0x2::transfer::public_transfer<0x2::display::Display<BirdNFT>>(v1, v2);
        let v3 = AdminCap{id: 0x2::object::new(arg1)};
        0x2::transfer::public_transfer<AdminCap>(v3, v2);
        let v4 = BirdConfig{
            id             : 0x2::object::new(arg1),
            total_type     : 0,
            total_sub_type : 0,
        };
        0x2::transfer::public_share_object<BirdConfig>(v4);
        let v5 = SaleState{
            start_time   : 0,
            end_time     : 0,
            sale_types   : 0x1::vector::empty<SaleBirdType>(),
            whitelisted  : 0x2::table::new<address, bool>(arg1),
            participants : 0x2::table::new<address, vector<u8>>(arg1),
        };
        let v6 = SaleState{
            start_time   : 0,
            end_time     : 0,
            sale_types   : 0x1::vector::empty<SaleBirdType>(),
            whitelisted  : 0x2::table::new<address, bool>(arg1),
            participants : 0x2::table::new<address, vector<u8>>(arg1),
        };
        let v7 = SaleConfig{
            id          : 0x2::object::new(arg1),
            paused      : true,
            fee_balance : 0x2::balance::zero<0x2::sui::SUI>(),
            publicS     : v5,
            privateS    : v6,
            wl_manager  : 0x1::vector::empty<address>(),
            fee_manager : @0x8320647849603591d5e5684289e9a78cd42371ac7a3f89a18136b693af6ef2f4,
        };
        0x2::transfer::public_share_object<SaleConfig>(v7);
    }

    public fun removeWhitelist(arg0: &mut SaleConfig, arg1: vector<address>, arg2: &0x22d2f3e0c6657077992d1fc4f5f34bcbbba07b4f3364261decf454a8dbb8f39b::version::Version, arg3: &mut 0x2::tx_context::TxContext) {
        0x22d2f3e0c6657077992d1fc4f5f34bcbbba07b4f3364261decf454a8dbb8f39b::version::checkVersion(arg2, 1);
        let v0 = 0x2::tx_context::sender(arg3);
        assert!(0x1::vector::contains<address>(&arg0.wl_manager, &v0), 1006);
        let v1 = &mut arg0.privateS;
        let v2 = 0;
        while (v2 < 0x1::vector::length<address>(&arg1)) {
            let v3 = *0x1::vector::borrow<address>(&arg1, v2);
            if (0x2::table::contains<address, bool>(&v1.whitelisted, v3)) {
                0x2::table::remove<address, bool>(&mut v1.whitelisted, v3);
            };
            v2 = v2 + 1;
        };
        let v4 = RemoveWhiteListEvent{
            sale_config : 0x2::object::id_address<SaleConfig>(arg0),
            users       : arg1,
        };
        0x2::event::emit<RemoveWhiteListEvent>(v4);
    }

    public fun rmWlManager(arg0: &AdminCap, arg1: &mut SaleConfig, arg2: vector<address>, arg3: &0x22d2f3e0c6657077992d1fc4f5f34bcbbba07b4f3364261decf454a8dbb8f39b::version::Version) {
        0x22d2f3e0c6657077992d1fc4f5f34bcbbba07b4f3364261decf454a8dbb8f39b::version::checkVersion(arg3, 1);
        let v0 = 0;
        while (v0 < 0x1::vector::length<address>(&arg2)) {
            let v1 = 0x1::vector::borrow<address>(&arg2, v0);
            if (0x1::vector::contains<address>(&arg1.wl_manager, v1)) {
                let (_, v3) = 0x1::vector::index_of<address>(&arg1.wl_manager, v1);
                0x1::vector::remove<address>(&mut arg1.wl_manager, v3);
            };
            v0 = v0 + 1;
        };
        let v4 = RemoveWlManagerEvent{
            sale_config : 0x2::object::id_address<SaleConfig>(arg1),
            users       : arg2,
        };
        0x2::event::emit<RemoveWlManagerEvent>(v4);
    }

    fun setupNft(arg0: &0x2::package::Publisher, arg1: &mut 0x2::tx_context::TxContext) : 0x2::display::Display<BirdNFT> {
        let v0 = 0x1::vector::empty<0x1::string::String>();
        let v1 = &mut v0;
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"name"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"rare"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"link"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"image_url"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"thumbnail_url"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"description"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"project_url"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"creator"));
        let v2 = 0x1::vector::empty<0x1::string::String>();
        let v3 = &mut v2;
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"BIRD - BIRDS GameFi Asset"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"{rare}"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"https://asset.birds.dog/nft/{type}/{sub_type}.json"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"https://asset.birds.dog/img/{type}/{sub_type}.png"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"https://asset.birds.dog/img/{type}/{sub_type}-thumbnail.png"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"The leading memecoin & GameFi Telegram mini-app on the SuiNetwork"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"https://x.com/TheBirdsDogs"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"Bird Labs"));
        let v4 = 0x2::display::new_with_fields<BirdNFT>(arg0, v0, v2, arg1);
        0x2::display::update_version<BirdNFT>(&mut v4);
        v4
    }

    public fun start_pause(arg0: &AdminCap, arg1: &mut SaleConfig, arg2: bool, arg3: &0x22d2f3e0c6657077992d1fc4f5f34bcbbba07b4f3364261decf454a8dbb8f39b::version::Version) {
        0x22d2f3e0c6657077992d1fc4f5f34bcbbba07b4f3364261decf454a8dbb8f39b::version::checkVersion(arg3, 1);
        assert!(arg2 != arg1.paused, 1011);
        arg1.paused = arg2;
        let v0 = StartPauseEvent{
            sale_config : 0x2::object::id_address<SaleConfig>(arg1),
            paused      : arg2,
        };
        0x2::event::emit<StartPauseEvent>(v0);
    }

    public fun updateBirdConfig(arg0: &AdminCap, arg1: &mut BirdConfig, arg2: u8, arg3: u8, arg4: &0x22d2f3e0c6657077992d1fc4f5f34bcbbba07b4f3364261decf454a8dbb8f39b::version::Version) {
        0x22d2f3e0c6657077992d1fc4f5f34bcbbba07b4f3364261decf454a8dbb8f39b::version::checkVersion(arg4, 1);
        arg1.total_type = arg2;
        arg1.total_sub_type = arg3;
        let v0 = UpdateBirdConfigEvent{
            bird_config    : 0x2::object::id_address<BirdConfig>(arg1),
            total_type     : arg2,
            total_sub_type : arg3,
        };
        0x2::event::emit<UpdateBirdConfigEvent>(v0);
    }

    public fun updateStartEndTime(arg0: &AdminCap, arg1: bool, arg2: &mut SaleConfig, arg3: u64, arg4: u64, arg5: &0x2::clock::Clock, arg6: &0x22d2f3e0c6657077992d1fc4f5f34bcbbba07b4f3364261decf454a8dbb8f39b::version::Version) {
        0x22d2f3e0c6657077992d1fc4f5f34bcbbba07b4f3364261decf454a8dbb8f39b::version::checkVersion(arg6, 1);
        let v0 = &mut arg2.privateS;
        if (!arg1) {
            v0 = &mut arg2.publicS;
        };
        if (arg3 != v0.start_time && arg4 != v0.end_time) {
            assert!(0x2::clock::timestamp_ms(arg5) <= arg3 && arg3 < arg4, 1011);
            v0.start_time = arg3;
            v0.end_time = arg4;
        } else if (arg3 != v0.start_time) {
            assert!(0x2::clock::timestamp_ms(arg5) <= arg3 && arg3 < v0.end_time, 1011);
            v0.start_time = arg3;
        } else if (arg3 != v0.start_time) {
            assert!(0x2::clock::timestamp_ms(arg5) <= arg4 && v0.start_time < arg4, 1011);
            v0.end_time = arg4;
        };
        let v1 = UpdateStartEndTime{
            whitelist   : arg1,
            sale_config : 0x2::object::id_address<SaleConfig>(arg2),
            start_time  : arg3,
            end_time    : arg4,
        };
        0x2::event::emit<UpdateStartEndTime>(v1);
    }

    public fun updateType(arg0: &AdminCap, arg1: bool, arg2: u64, arg3: &mut SaleConfig, arg4: u64, arg5: u128, arg6: &0x22d2f3e0c6657077992d1fc4f5f34bcbbba07b4f3364261decf454a8dbb8f39b::version::Version) {
        0x22d2f3e0c6657077992d1fc4f5f34bcbbba07b4f3364261decf454a8dbb8f39b::version::checkVersion(arg6, 1);
        let v0 = &mut arg3.privateS;
        if (!arg1) {
            v0 = &mut arg3.publicS;
        };
        let v1 = 0x1::vector::borrow_mut<SaleBirdType>(&mut v0.sale_types, arg2);
        v1.fee = arg4;
        v1.total = arg5;
        v1.remaining = v1.total - v1.total - v1.remaining;
        let v2 = UpdateTypeEvent{
            whitelist   : arg1,
            sale_config : 0x2::object::id_address<SaleConfig>(arg3),
            new_fee     : arg4,
            new_total   : arg5,
        };
        0x2::event::emit<UpdateTypeEvent>(v2);
    }

    public fun withdraw_fee(arg0: &AdminCap, arg1: &mut SaleConfig, arg2: &mut 0x2::tx_context::TxContext, arg3: &0x22d2f3e0c6657077992d1fc4f5f34bcbbba07b4f3364261decf454a8dbb8f39b::version::Version) {
        0x22d2f3e0c6657077992d1fc4f5f34bcbbba07b4f3364261decf454a8dbb8f39b::version::checkVersion(arg3, 1);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::take<0x2::sui::SUI>(&mut arg1.fee_balance, 0x2::balance::value<0x2::sui::SUI>(&arg1.fee_balance), arg2), arg1.fee_manager);
    }

    // decompiled from Move bytecode v6
}

