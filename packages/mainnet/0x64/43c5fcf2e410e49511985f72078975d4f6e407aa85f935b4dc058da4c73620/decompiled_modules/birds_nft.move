module 0x6443c5fcf2e410e49511985f72078975d4f6e407aa85f935b4dc058da4c73620::birds_nft {
    struct BIRDS_NFT has drop {
        dummy_field: bool,
    }

    struct AdminCap has store, key {
        id: 0x2::object::UID,
    }

    struct UserArchive has store, key {
        id: 0x2::object::UID,
        owner: address,
        nonce: u128,
    }

    struct BirdNFT has store, key {
        id: 0x2::object::UID,
        xid: u64,
        type: u8,
        sub_type: u8,
    }

    struct BirdConfig has store, key {
        id: 0x2::object::UID,
        version: u64,
        fee_balance: 0x2::balance::Balance<0x2::sui::SUI>,
        fee_manager: address,
        validator: 0x1::option::Option<vector<u8>>,
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
        types: vector<SaleBirdType>,
        whitelisted: 0x2::table::Table<address, bool>,
        participants: 0x2::table::Table<address, vector<u8>>,
    }

    struct SaleConfig has store, key {
        id: 0x2::object::UID,
        paused: bool,
        total_sold: u64,
        public_round: SaleState,
        private_round: SaleState,
        wl_manager: vector<address>,
    }

    struct ConfigSaleTypeEvent has copy, drop {
        is_private: bool,
        minting_fee: u64,
        total_sale: u128,
    }

    struct UpdateStartEndTime has copy, drop {
        is_private: bool,
        start_time: u64,
        end_time: u64,
    }

    struct AddWhiteListEvent has copy, drop {
        is_private: bool,
        users: vector<address>,
    }

    struct RemoveWhiteListEvent has copy, drop {
        is_private: bool,
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

    struct BirdTypeConfigEvent has copy, drop {
        total_type: u8,
        total_sub_type: u8,
    }

    struct MintedEvent has copy, drop {
        user: address,
        id: 0x2::object::ID,
        xid: u64,
        type: u8,
        sub_type: u8,
    }

    struct BurnedEvent has copy, drop {
        owner: address,
        id: 0x2::object::ID,
        xid: u64,
        type: u8,
        sub_type: u8,
    }

    public fun add_whitelist(arg0: &mut SaleConfig, arg1: bool, arg2: vector<address>, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg3);
        assert!(0x1::vector::contains<address>(&arg0.wl_manager, &v0), 1006);
        let v1 = if (arg1) {
            &mut arg0.private_round
        } else {
            &mut arg0.public_round
        };
        let v2 = 0;
        while (v2 < 0x1::vector::length<address>(&arg2)) {
            let v3 = *0x1::vector::borrow<address>(&arg2, v2);
            if (!0x2::table::contains<address, bool>(&v1.whitelisted, v3)) {
                0x2::table::add<address, bool>(&mut v1.whitelisted, v3, true);
            };
            v2 = v2 + 1;
        };
        let v4 = AddWhiteListEvent{
            is_private : arg1,
            users      : arg2,
        };
        0x2::event::emit<AddWhiteListEvent>(v4);
    }

    public fun add_whitelist_manager(arg0: &AdminCap, arg1: &mut SaleConfig, arg2: vector<address>) {
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

    public fun burn(arg0: &BirdConfig, arg1: BirdNFT, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.version == 1, 1002);
        let BirdNFT {
            id       : v0,
            xid      : v1,
            type     : v2,
            sub_type : v3,
        } = arg1;
        0x2::object::delete(v0);
        let v4 = BurnedEvent{
            owner    : 0x2::tx_context::sender(arg2),
            id       : 0x2::object::id<BirdNFT>(&arg1),
            xid      : v1,
            type     : v2,
            sub_type : v3,
        };
        0x2::event::emit<BurnedEvent>(v4);
    }

    public fun buy(arg0: &mut BirdConfig, arg1: &mut SaleConfig, arg2: u8, arg3: u8, arg4: 0x2::coin::Coin<0x2::sui::SUI>, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) : BirdNFT {
        assert!(arg0.version == 1, 1002);
        assert!(!arg1.paused, 1004);
        assert!(arg2 < arg0.total_type, 1005);
        let v0 = 0x2::clock::timestamp_ms(arg5);
        assert!(v0 >= arg1.private_round.start_time, 1009);
        assert!(v0 <= arg1.public_round.end_time, 1013);
        let v1 = &mut arg1.private_round;
        if (v0 >= arg1.public_round.start_time && v0 <= arg1.public_round.end_time) {
            v1 = &mut arg1.public_round;
        };
        let v2 = 0x2::table::length<address, bool>(&v1.whitelisted) > 0;
        let v3 = 0x2::tx_context::sender(arg6);
        if (v2) {
            assert!(0x2::table::contains<address, bool>(&v1.whitelisted, v3), 1012);
        };
        let v4 = 0x1::vector::borrow_mut<SaleBirdType>(&mut v1.types, (arg2 as u64));
        assert!(v4.remaining > 0, 1007);
        if (0x2::table::contains<address, vector<u8>>(&v1.participants, v3)) {
            assert!(!0x1::vector::contains<u8>(0x2::table::borrow<address, vector<u8>>(&v1.participants, v3), &arg2), 1010);
        };
        assert!(0x2::coin::value<0x2::sui::SUI>(&arg4) == v4.fee, 1000);
        0x2::balance::join<0x2::sui::SUI>(&mut arg0.fee_balance, 0x2::coin::into_balance<0x2::sui::SUI>(arg4));
        v4.remaining = v4.remaining - 1;
        if (0x2::table::contains<address, vector<u8>>(&v1.participants, v3)) {
            0x1::vector::push_back<u8>(0x2::table::borrow_mut<address, vector<u8>>(&mut v1.participants, v3), arg2);
        } else {
            let v5 = 0x1::vector::empty<u8>();
            0x1::vector::push_back<u8>(&mut v5, arg2);
            0x2::table::add<address, vector<u8>>(&mut v1.participants, v3, v5);
        };
        let v6 = BirdNFT{
            id       : 0x2::object::new(arg6),
            xid      : arg1.total_sold,
            type     : arg2,
            sub_type : arg3,
        };
        arg1.total_sold = arg1.total_sold + 1;
        let v7 = MintedEvent{
            user     : v3,
            id       : 0x2::object::id<BirdNFT>(&v6),
            xid      : v6.xid,
            type     : arg2,
            sub_type : arg3,
        };
        0x2::event::emit<MintedEvent>(v7);
        v6
    }

    public fun change_fee_manager(arg0: &AdminCap, arg1: &mut BirdConfig, arg2: address) {
        assert!(arg1.version == 1, 1002);
        arg1.fee_manager = arg2;
    }

    public fun config_sale_type(arg0: &AdminCap, arg1: &mut SaleConfig, arg2: &BirdConfig, arg3: bool, arg4: u64, arg5: u64, arg6: u128) {
        assert!(arg2.version == 1, 1002);
        let v0 = if (arg3) {
            &mut arg1.private_round
        } else {
            &mut arg1.public_round
        };
        if (arg4 == 0x1::vector::length<SaleBirdType>(&v0.types)) {
            let v1 = SaleBirdType{
                fee       : arg5,
                total     : arg6,
                remaining : arg6,
            };
            0x1::vector::push_back<SaleBirdType>(&mut v0.types, v1);
        } else {
            let v2 = 0x1::vector::borrow_mut<SaleBirdType>(&mut v0.types, arg4);
            v2.fee = arg5;
            v2.total = arg6;
            v2.remaining = v2.total - v2.total - v2.remaining;
        };
        let v3 = ConfigSaleTypeEvent{
            is_private  : arg3,
            minting_fee : arg5,
            total_sale  : arg6,
        };
        0x2::event::emit<ConfigSaleTypeEvent>(v3);
    }

    public fun info(arg0: &BirdNFT) : (u64, u8, u8) {
        (arg0.xid, arg0.type, arg0.sub_type)
    }

    fun init(arg0: BIRDS_NFT, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let v1 = 0x2::package::claim<BIRDS_NFT>(arg0, arg1);
        let v2 = setup_nft_display(&v1, arg1);
        0x2::transfer::public_transfer<0x2::package::Publisher>(v1, v0);
        0x2::transfer::public_transfer<0x2::display::Display<BirdNFT>>(v2, v0);
        let v3 = AdminCap{id: 0x2::object::new(arg1)};
        0x2::transfer::public_transfer<AdminCap>(v3, v0);
        let v4 = BirdConfig{
            id             : 0x2::object::new(arg1),
            version        : 1,
            fee_balance    : 0x2::balance::zero<0x2::sui::SUI>(),
            fee_manager    : v0,
            validator      : 0x1::option::none<vector<u8>>(),
            total_type     : 5,
            total_sub_type : 3,
        };
        0x2::transfer::public_share_object<BirdConfig>(v4);
        let v5 = SaleState{
            start_time   : 0,
            end_time     : 0,
            types        : 0x1::vector::empty<SaleBirdType>(),
            whitelisted  : 0x2::table::new<address, bool>(arg1),
            participants : 0x2::table::new<address, vector<u8>>(arg1),
        };
        let v6 = SaleState{
            start_time   : 0,
            end_time     : 0,
            types        : 0x1::vector::empty<SaleBirdType>(),
            whitelisted  : 0x2::table::new<address, bool>(arg1),
            participants : 0x2::table::new<address, vector<u8>>(arg1),
        };
        let v7 = SaleConfig{
            id            : 0x2::object::new(arg1),
            paused        : true,
            total_sold    : 0,
            public_round  : v6,
            private_round : v5,
            wl_manager    : 0x1::vector::empty<address>(),
        };
        0x2::transfer::public_share_object<SaleConfig>(v7);
    }

    public fun migrate(arg0: &AdminCap, arg1: &mut BirdConfig) {
        assert!(arg1.version < 1, 1003);
        arg1.version = 1;
    }

    public fun mint(arg0: &mut BirdConfig, arg1: 0x2::coin::Coin<0x2::sui::SUI>, arg2: &mut UserArchive, arg3: vector<u8>, arg4: vector<u8>, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) : BirdNFT {
        assert!(arg0.version == 1, 1002);
        verify_signature(arg3, arg4, &arg0.validator);
        let v0 = 0x2::tx_context::sender(arg6);
        let v1 = 0x2::bcs::new(arg4);
        let v2 = 0x2::bcs::peel_u8(&mut v1);
        let v3 = 0x2::bcs::peel_u8(&mut v1);
        let v4 = 0x2::bcs::peel_u128(&mut v1);
        assert!(v0 == 0x2::bcs::peel_address(&mut v1), 1006);
        assert!(0x2::bcs::peel_u64(&mut v1) > 0x2::clock::timestamp_ms(arg5), 1008);
        assert!(arg2.nonce < v4, 1014);
        arg2.nonce = v4;
        assert!(0x2::coin::value<0x2::sui::SUI>(&arg1) == 0x2::bcs::peel_u64(&mut v1), 1000);
        0x2::balance::join<0x2::sui::SUI>(&mut arg0.fee_balance, 0x2::coin::into_balance<0x2::sui::SUI>(arg1));
        let v5 = BirdNFT{
            id       : 0x2::object::new(arg6),
            xid      : 0x2::bcs::peel_u64(&mut v1),
            type     : v2,
            sub_type : v3,
        };
        let v6 = MintedEvent{
            user     : v0,
            id       : 0x2::object::id<BirdNFT>(&v5),
            xid      : v5.xid,
            type     : v2,
            sub_type : v3,
        };
        0x2::event::emit<MintedEvent>(v6);
        v5
    }

    public fun pause(arg0: &AdminCap, arg1: &mut SaleConfig, arg2: bool) {
        assert!(arg2 != arg1.paused, 1011);
        arg1.paused = arg2;
        let v0 = StartPauseEvent{paused: arg2};
        0x2::event::emit<StartPauseEvent>(v0);
    }

    public fun remove_whitelist(arg0: &mut SaleConfig, arg1: bool, arg2: vector<address>, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg3);
        assert!(0x1::vector::contains<address>(&arg0.wl_manager, &v0), 1006);
        let v1 = if (arg1) {
            &mut arg0.private_round
        } else {
            &mut arg0.public_round
        };
        let v2 = 0;
        while (v2 < 0x1::vector::length<address>(&arg2)) {
            let v3 = *0x1::vector::borrow<address>(&arg2, v2);
            if (0x2::table::contains<address, bool>(&v1.whitelisted, v3)) {
                0x2::table::remove<address, bool>(&mut v1.whitelisted, v3);
            };
            v2 = v2 + 1;
        };
        let v4 = RemoveWhiteListEvent{
            is_private : arg1,
            users      : arg2,
        };
        0x2::event::emit<RemoveWhiteListEvent>(v4);
    }

    public fun remove_whitelist_manager(arg0: &AdminCap, arg1: &mut SaleConfig, arg2: vector<address>) {
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

    public fun set_validator(arg0: &AdminCap, arg1: &mut BirdConfig, arg2: vector<u8>) {
        assert!(arg1.version == 1, 1002);
        0x1::option::swap_or_fill<vector<u8>>(&mut arg1.validator, arg2);
    }

    fun setup_nft_display(arg0: &0x2::package::Publisher, arg1: &mut 0x2::tx_context::TxContext) : 0x2::display::Display<BirdNFT> {
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
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"https://assets.thebirds.ai/nft/{type}/{xid}.json"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"https://assets.thebirds.ai/img/{type}/{sub_type}.png"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"https://assets.thebirds.ai/img/{type}/{sub_type}-thumbnail.png"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"The leading memecoin & GameFi Telegram mini-app on the SuiNetwork"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"https://x.com/TheBirdsDogs"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"Bird Labs"));
        let v4 = 0x2::display::new_with_fields<BirdNFT>(arg0, v0, v2, arg1);
        0x2::display::update_version<BirdNFT>(&mut v4);
        v4
    }

    public fun update_bird_config(arg0: &AdminCap, arg1: &mut BirdConfig, arg2: u8, arg3: u8) {
        assert!(arg1.version == 1, 1002);
        arg1.total_type = arg2;
        arg1.total_sub_type = arg3;
        let v0 = BirdTypeConfigEvent{
            total_type     : arg2,
            total_sub_type : arg3,
        };
        0x2::event::emit<BirdTypeConfigEvent>(v0);
    }

    public fun update_start_end_time(arg0: &AdminCap, arg1: &mut SaleConfig, arg2: &BirdConfig, arg3: bool, arg4: u64, arg5: u64, arg6: &0x2::clock::Clock) {
        assert!(arg2.version == 1, 1002);
        let v0 = if (arg3) {
            &mut arg1.private_round
        } else {
            &mut arg1.public_round
        };
        if (arg4 != v0.start_time && arg5 != v0.end_time) {
            assert!(0x2::clock::timestamp_ms(arg6) <= arg4 && arg4 < arg5, 1011);
            v0.start_time = arg4;
            v0.end_time = arg5;
        } else if (arg4 != v0.start_time) {
            assert!(0x2::clock::timestamp_ms(arg6) <= arg4 && arg4 < v0.end_time, 1011);
            v0.start_time = arg4;
        } else if (arg4 != v0.start_time) {
            assert!(0x2::clock::timestamp_ms(arg6) <= arg5 && v0.start_time < arg5, 1011);
            v0.end_time = arg5;
        };
        let v1 = UpdateStartEndTime{
            is_private : arg3,
            start_time : arg4,
            end_time   : arg5,
        };
        0x2::event::emit<UpdateStartEndTime>(v1);
    }

    public fun user_register(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg0);
        let v1 = UserArchive{
            id    : 0x2::object::new(arg0),
            owner : v0,
            nonce : 0,
        };
        0x2::transfer::public_transfer<UserArchive>(v1, v0);
    }

    fun verify_signature(arg0: vector<u8>, arg1: vector<u8>, arg2: &0x1::option::Option<vector<u8>>) {
        assert!(0x1::option::is_some<vector<u8>>(arg2), 1015);
        assert!(0x2::ed25519::ed25519_verify(&arg0, 0x1::option::borrow<vector<u8>>(arg2), &arg1), 1016);
    }

    public fun withdraw_fee(arg0: &mut BirdConfig, arg1: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg1) == arg0.fee_manager, 1006);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::take<0x2::sui::SUI>(&mut arg0.fee_balance, 0x2::balance::value<0x2::sui::SUI>(&arg0.fee_balance), arg1), arg0.fee_manager);
    }

    // decompiled from Move bytecode v6
}

