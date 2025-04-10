module 0xd8cecb6a05ec49006f47c604ae2d97ed8fb3b82a2a67c5902567fb8cd15a6ca6::birds_nft {
    struct BIRDS_NFT has drop {
        dummy_field: bool,
    }

    struct AdminCap has store, key {
        id: 0x2::object::UID,
    }

    struct Register has store, key {
        id: 0x2::object::UID,
        nonce: 0x2::table::Table<address, u128>,
    }

    struct BirdNFT has store, key {
        id: 0x2::object::UID,
        xid: u64,
        type: u16,
        sub_type: u8,
        gen_id: u16,
        mating_left: u64,
    }

    struct BirdConfig has store, key {
        id: 0x2::object::UID,
        version: u64,
        fee_balance: 0x2::balance::Balance<0x2::sui::SUI>,
        fee_manager: address,
        validator: 0x1::option::Option<vector<u8>>,
        total_box_type: u16,
        total_type: u16,
        total_sub_type: u8,
        total_gen_id: u16,
    }

    struct SaleBoxType has store {
        fee: u64,
        total: u128,
        remaining: u128,
        rate: vector<u16>,
    }

    struct SaleState has store {
        start_time: u64,
        end_time: u64,
        box_types: 0x2::table::Table<u16, SaleBoxType>,
        whitelisted: 0x2::table::Table<address, bool>,
        participants: 0x2::table::Table<address, vector<u16>>,
    }

    struct SaleConfig has store, key {
        id: 0x2::object::UID,
        paused: bool,
        total_sold: u64,
        public_round: SaleState,
        private_round: SaleState,
        wl_manager: vector<address>,
    }

    struct ConfigSaleBoxEvent has copy, drop {
        is_private: bool,
        box_type: u16,
        fee: u64,
        total_sale: u128,
        bird_type: u16,
        rate: u16,
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
        total_type: u16,
        total_sub_type: u8,
        total_gen_id: u16,
    }

    struct MintedEvent has copy, drop {
        user: address,
        id: 0x2::object::ID,
        xid: u64,
        type: u16,
        sub_type: u8,
        gen_id: u16,
        mating_left: u64,
    }

    struct BurnedEvent has copy, drop {
        owner: address,
        id: 0x2::object::ID,
        xid: u64,
        type: u16,
        sub_type: u8,
        gen_id: u16,
        mating_left: u64,
    }

    struct UpdateNFTMatingCount has copy, drop {
        id: 0x2::object::ID,
        mating_left: u64,
        mating_count: u64,
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
            id          : v0,
            xid         : v1,
            type        : v2,
            sub_type    : v3,
            gen_id      : v4,
            mating_left : v5,
        } = arg1;
        0x2::object::delete(v0);
        let v6 = BurnedEvent{
            owner       : 0x2::tx_context::sender(arg2),
            id          : 0x2::object::id<BirdNFT>(&arg1),
            xid         : v1,
            type        : v2,
            sub_type    : v3,
            gen_id      : v4,
            mating_left : v5,
        };
        0x2::event::emit<BurnedEvent>(v6);
    }

    public fun buy(arg0: &mut BirdConfig, arg1: &mut SaleConfig, arg2: u16, arg3: 0x2::coin::Coin<0x2::sui::SUI>, arg4: &0x2::clock::Clock, arg5: &0x2::random::Random, arg6: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.version == 1, 1002);
        assert!(!arg1.paused, 1004);
        assert!(arg2 < arg0.total_box_type, 1005);
        let v0 = 0x2::clock::timestamp_ms(arg4);
        assert!(v0 >= arg1.private_round.start_time, 1009);
        assert!(v0 <= arg1.public_round.end_time, 1013);
        let v1 = if (v0 >= arg1.private_round.start_time && v0 <= arg1.private_round.end_time) {
            &mut arg1.private_round
        } else {
            assert!(v0 >= arg1.public_round.start_time && v0 <= arg1.public_round.end_time, 1003);
            &mut arg1.public_round
        };
        let v2 = 0x2::table::length<address, bool>(&v1.whitelisted) > 0;
        let v3 = 0x2::tx_context::sender(arg6);
        if (v2) {
            assert!(0x2::table::contains<address, bool>(&v1.whitelisted, v3), 1012);
        };
        let v4 = 0x2::table::borrow_mut<u16, SaleBoxType>(&mut v1.box_types, arg2);
        assert!(v4.remaining > 0, 1007);
        if (0x2::table::contains<address, vector<u16>>(&v1.participants, v3)) {
            assert!(!0x1::vector::contains<u16>(0x2::table::borrow<address, vector<u16>>(&v1.participants, v3), &arg2), 1010);
        };
        assert!(0x2::coin::value<0x2::sui::SUI>(&arg3) == v4.fee, 1000);
        0x2::balance::join<0x2::sui::SUI>(&mut arg0.fee_balance, 0x2::coin::into_balance<0x2::sui::SUI>(arg3));
        v4.remaining = v4.remaining - 1;
        if (0x2::table::contains<address, vector<u16>>(&v1.participants, v3)) {
            0x1::vector::push_back<u16>(0x2::table::borrow_mut<address, vector<u16>>(&mut v1.participants, v3), arg2);
        } else {
            let v5 = 0x1::vector::empty<u16>();
            0x1::vector::push_back<u16>(&mut v5, arg2);
            0x2::table::add<address, vector<u16>>(&mut v1.participants, v3, v5);
        };
        let v6 = 0x2::random::new_generator(arg5, arg6);
        let v7 = 0;
        let v8 = 0;
        let v9 = 0;
        while (v9 < 0x1::vector::length<u16>(&v4.rate)) {
            let v10 = v8 + *0x1::vector::borrow<u16>(&v4.rate, v9);
            v8 = v10;
            if (0x2::random::generate_u16_in_range(&mut v6, 1, 100) <= v10 / 100) {
                v7 = (v9 as u16);
            };
            v9 = v9 + 1;
        };
        let v11 = ((v0 % (arg0.total_sub_type as u64)) as u8);
        let v12 = ((v0 % (arg0.total_gen_id as u64)) as u16);
        let v13 = BirdNFT{
            id          : 0x2::object::new(arg6),
            xid         : arg1.total_sold,
            type        : v7,
            sub_type    : v11,
            gen_id      : v12,
            mating_left : 25,
        };
        arg1.total_sold = arg1.total_sold + 1;
        let v14 = MintedEvent{
            user        : v3,
            id          : 0x2::object::id<BirdNFT>(&v13),
            xid         : v13.xid,
            type        : v7,
            sub_type    : v11,
            gen_id      : v12,
            mating_left : v13.mating_left,
        };
        0x2::event::emit<MintedEvent>(v14);
        0x2::transfer::public_transfer<BirdNFT>(v13, v3);
    }

    public fun change_fee_manager(arg0: &AdminCap, arg1: &mut BirdConfig, arg2: address) {
        assert!(arg1.version == 1, 1002);
        arg1.fee_manager = arg2;
    }

    public fun config_sale_box_type(arg0: &AdminCap, arg1: &mut SaleConfig, arg2: &BirdConfig, arg3: bool, arg4: u16, arg5: &0x1::option::Option<u128>, arg6: &0x1::option::Option<u64>, arg7: &0x1::option::Option<u16>, arg8: &0x1::option::Option<u16>) {
        assert!(arg2.version == 1, 1002);
        let v0 = if (arg3) {
            &mut arg1.private_round
        } else {
            &mut arg1.public_round
        };
        if (!0x2::table::contains<u16, SaleBoxType>(&v0.box_types, arg4)) {
            let v1 = SaleBoxType{
                fee       : *0x1::option::borrow<u64>(arg6),
                total     : *0x1::option::borrow<u128>(arg5),
                remaining : *0x1::option::borrow<u128>(arg5),
                rate      : 0x1::vector::empty<u16>(),
            };
            0x2::table::add<u16, SaleBoxType>(&mut v0.box_types, arg4, v1);
        } else {
            let v2 = 0x2::table::borrow_mut<u16, SaleBoxType>(&mut v0.box_types, arg4);
            if (0x1::option::is_some<u64>(arg6)) {
                v2.fee = *0x1::option::borrow<u64>(arg6);
            };
            if (0x1::option::is_some<u128>(arg5)) {
                v2.total = *0x1::option::borrow<u128>(arg5);
                v2.remaining = v2.total - v2.total - v2.remaining;
            };
            if (0x1::option::is_some<u16>(arg7)) {
                assert!(*0x1::option::borrow<u16>(arg7) < arg2.total_type, 1018);
                assert!(0x1::option::is_some<u16>(arg8), 1011);
                *0x1::vector::borrow_mut<u16>(&mut v2.rate, (*0x1::option::borrow<u16>(arg7) as u64)) = *0x1::option::borrow<u16>(arg8);
            };
        };
        let v3 = ConfigSaleBoxEvent{
            is_private : arg3,
            box_type   : arg4,
            fee        : *0x1::option::borrow<u64>(arg6),
            total_sale : *0x1::option::borrow<u128>(arg5),
            bird_type  : *0x1::option::borrow<u16>(arg7),
            rate       : *0x1::option::borrow<u16>(arg8),
        };
        0x2::event::emit<ConfigSaleBoxEvent>(v3);
    }

    public fun info(arg0: &BirdNFT) : (u64, u16, u8, u16) {
        (arg0.xid, arg0.type, arg0.sub_type, arg0.gen_id)
    }

    fun init(arg0: BIRDS_NFT, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let v1 = 0x2::package::claim<BIRDS_NFT>(arg0, arg1);
        let v2 = setup_nft_display(&v1, arg1);
        0x2::transfer::public_transfer<0x2::package::Publisher>(v1, v0);
        0x2::transfer::public_transfer<0x2::display::Display<BirdNFT>>(v2, v0);
        let v3 = AdminCap{id: 0x2::object::new(arg1)};
        0x2::transfer::public_transfer<AdminCap>(v3, v0);
        let v4 = Register{
            id    : 0x2::object::new(arg1),
            nonce : 0x2::table::new<address, u128>(arg1),
        };
        0x2::transfer::public_share_object<Register>(v4);
        let v5 = BirdConfig{
            id             : 0x2::object::new(arg1),
            version        : 1,
            fee_balance    : 0x2::balance::zero<0x2::sui::SUI>(),
            fee_manager    : v0,
            validator      : 0x1::option::none<vector<u8>>(),
            total_box_type : 3,
            total_type     : 5,
            total_sub_type : 3,
            total_gen_id   : 10,
        };
        0x2::transfer::public_share_object<BirdConfig>(v5);
        let v6 = SaleState{
            start_time   : 0,
            end_time     : 0,
            box_types    : 0x2::table::new<u16, SaleBoxType>(arg1),
            whitelisted  : 0x2::table::new<address, bool>(arg1),
            participants : 0x2::table::new<address, vector<u16>>(arg1),
        };
        let v7 = SaleState{
            start_time   : 0,
            end_time     : 0,
            box_types    : 0x2::table::new<u16, SaleBoxType>(arg1),
            whitelisted  : 0x2::table::new<address, bool>(arg1),
            participants : 0x2::table::new<address, vector<u16>>(arg1),
        };
        let v8 = SaleConfig{
            id            : 0x2::object::new(arg1),
            paused        : true,
            total_sold    : 0,
            public_round  : v7,
            private_round : v6,
            wl_manager    : 0x1::vector::empty<address>(),
        };
        0x2::transfer::public_share_object<SaleConfig>(v8);
    }

    public fun migrate(arg0: &AdminCap, arg1: &mut BirdConfig) {
        assert!(arg1.version < 1, 1001);
        arg1.version = 1;
    }

    public fun mint(arg0: &mut BirdConfig, arg1: 0x2::coin::Coin<0x2::sui::SUI>, arg2: &mut Register, arg3: vector<u8>, arg4: vector<u8>, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) : BirdNFT {
        assert!(arg0.version == 1, 1002);
        verify_signature(arg3, arg4, &arg0.validator);
        let v0 = 0x2::tx_context::sender(arg6);
        let v1 = 0x2::bcs::new(arg4);
        let v2 = 0x2::bcs::peel_u16(&mut v1);
        let v3 = 0x2::bcs::peel_u8(&mut v1);
        let v4 = 0x2::bcs::peel_u16(&mut v1);
        let v5 = 0x2::bcs::peel_u128(&mut v1);
        assert!(v0 == 0x2::bcs::peel_address(&mut v1), 1006);
        assert!(0x2::bcs::peel_u64(&mut v1) > 0x2::clock::timestamp_ms(arg5), 1008);
        let v6 = if (0x2::table::contains<address, u128>(&arg2.nonce, v0)) {
            0x2::table::borrow_mut<address, u128>(&mut arg2.nonce, v0)
        } else {
            0x2::table::add<address, u128>(&mut arg2.nonce, v0, 0);
            0x2::table::borrow_mut<address, u128>(&mut arg2.nonce, v0)
        };
        assert!(*v6 < v5, 1014);
        *v6 = v5;
        assert!(0x2::coin::value<0x2::sui::SUI>(&arg1) == 0x2::bcs::peel_u64(&mut v1), 1000);
        0x2::balance::join<0x2::sui::SUI>(&mut arg0.fee_balance, 0x2::coin::into_balance<0x2::sui::SUI>(arg1));
        let v7 = BirdNFT{
            id          : 0x2::object::new(arg6),
            xid         : 0x2::bcs::peel_u64(&mut v1),
            type        : v2,
            sub_type    : v3,
            gen_id      : v4,
            mating_left : 25,
        };
        let v8 = MintedEvent{
            user        : v0,
            id          : 0x2::object::id<BirdNFT>(&v7),
            xid         : v7.xid,
            type        : v2,
            sub_type    : v3,
            gen_id      : v4,
            mating_left : v7.mating_left,
        };
        0x2::event::emit<MintedEvent>(v8);
        v7
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
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"https://assets.thebirds.ai/img/{type}/{sub_type}/{gen_id}.png"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"https://assets.thebirds.ai/img/{type}/{sub_type}/{gen_id}-thumbnail.png"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"The leading memecoin & GameFi Telegram mini-app on the SuiNetwork"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"https://x.com/TheBirdsDogs"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"Bird Labs"));
        let v4 = 0x2::display::new_with_fields<BirdNFT>(arg0, v0, v2, arg1);
        0x2::display::update_version<BirdNFT>(&mut v4);
        v4
    }

    public fun update_bird_config(arg0: &AdminCap, arg1: &mut BirdConfig, arg2: u16, arg3: u8, arg4: u16) {
        assert!(arg1.version == 1, 1002);
        arg1.total_type = arg2;
        arg1.total_sub_type = arg3;
        arg1.total_gen_id = arg4;
        let v0 = BirdTypeConfigEvent{
            total_type     : arg2,
            total_sub_type : arg3,
            total_gen_id   : arg4,
        };
        0x2::event::emit<BirdTypeConfigEvent>(v0);
    }

    public fun update_mating_left(arg0: &mut BirdNFT) : u64 {
        assert!(arg0.mating_left > 0, 1017);
        arg0.mating_left = arg0.mating_left - 1;
        let v0 = UpdateNFTMatingCount{
            id           : 0x2::object::id<BirdNFT>(arg0),
            mating_left  : arg0.mating_left,
            mating_count : 25 - arg0.mating_left,
        };
        0x2::event::emit<UpdateNFTMatingCount>(v0);
        arg0.mating_left
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
        } else if (arg5 != v0.end_time) {
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

