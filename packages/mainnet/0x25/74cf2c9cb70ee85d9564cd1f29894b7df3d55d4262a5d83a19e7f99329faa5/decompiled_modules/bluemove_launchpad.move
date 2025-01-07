module 0x2574cf2c9cb70ee85d9564cd1f29894b7df3d55d4262a5d83a19e7f99329faa5::bluemove_launchpad {
    struct LaunchpadData has store, key {
        id: 0x2::object::UID,
        minted: u64,
        current_nft: u64,
        current_place: u64,
        base_name: 0x1::string::String,
        base_image_url: 0x1::string::String,
        base_url: 0x1::string::String,
        description: 0x1::string::String,
        phases: vector<PhaseInfo>,
        fund_address: address,
        total_nft: u64,
        pre_mint: u64,
        start_order: u64,
    }

    struct Storage has store, key {
        id: 0x2::object::UID,
    }

    struct Order has store, key {
        id: 0x2::object::UID,
    }

    struct UserOrder has copy, drop, store {
        order_id: u64,
        recipent: address,
    }

    struct UserOrderEvent has copy, drop {
        order_id: u64,
        recipent: address,
    }

    struct PhaseInfo has store {
        name: 0x1::string::String,
        start_time: u64,
        expired_time: u64,
        nft_per_user: u64,
        current_nft: u64,
        price_per_item: u64,
        total_nfts: u64,
        member: 0x2::table::Table<address, u64>,
    }

    struct MintNFTEvent has copy, drop {
        id: 0x2::object::ID,
        name: 0x1::string::String,
        description: 0x1::string::String,
        image_url: 0x1::string::String,
    }

    struct BurnEvent has copy, drop {
        id: 0x2::object::ID,
        name: 0x1::string::String,
        description: 0x1::string::String,
        image_url: 0x1::string::String,
    }

    struct MintedByUser has store {
        user_minted: 0x2::vec_map::VecMap<u64, u64>,
    }

    struct BLUEMOVE_LAUNCHPAD has drop {
        dummy_field: bool,
    }

    struct BlueMoveXNavi has store, key {
        id: 0x2::object::UID,
        name: 0x1::string::String,
        description: 0x1::string::String,
        image_url: 0x1::string::String,
        url: 0x1::string::String,
        external_link: 0x1::string::String,
    }

    public entry fun add_new_phase(arg0: &mut LaunchpadData, arg1: 0x1::string::String, arg2: u64, arg3: u64, arg4: u64, arg5: u64, arg6: u64, arg7: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg7) == @0x49cc391ab4d3503e03dbb24c4f9e28f3cdd2ddf8a459e0d43012c3868ffefa1, 5);
        let v0 = PhaseInfo{
            name           : arg1,
            start_time     : arg2,
            expired_time   : arg3,
            nft_per_user   : arg5,
            current_nft    : 0,
            price_per_item : arg6,
            total_nfts     : arg4,
            member         : 0x2::table::new<address, u64>(arg7),
        };
        0x1::vector::push_back<PhaseInfo>(&mut arg0.phases, v0);
    }

    public fun add_wl_for_phase(arg0: &mut LaunchpadData, arg1: u64, arg2: vector<address>, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg3) == @0x49cc391ab4d3503e03dbb24c4f9e28f3cdd2ddf8a459e0d43012c3868ffefa1, 5);
        let v0 = 0x1::vector::borrow_mut<PhaseInfo>(&mut arg0.phases, arg1);
        while (!0x1::vector::is_empty<address>(&arg2)) {
            let v1 = 0x1::vector::pop_back<address>(&mut arg2);
            if (!0x2::table::contains<address, u64>(&v0.member, v1)) {
                0x2::table::add<address, u64>(&mut v0.member, v1, 0x2::table::length<address, u64>(&v0.member));
            };
        };
    }

    public fun asser_suis_inscriptions<T0>() {
        assert!(get_token_name<T0>() == get_token_name<BlueMoveXNavi>(), 9);
    }

    public entry fun burn_nft(arg0: BlueMoveXNavi, arg1: &mut 0x2::tx_context::TxContext) {
        let BlueMoveXNavi {
            id            : v0,
            name          : v1,
            description   : v2,
            image_url     : v3,
            url           : _,
            external_link : _,
        } = arg0;
        let v6 = v0;
        let v7 = BurnEvent{
            id          : 0x2::object::uid_to_inner(&v6),
            name        : v1,
            description : v2,
            image_url   : v3,
        };
        0x2::event::emit<BurnEvent>(v7);
        0x2::object::delete(v6);
    }

    public entry fun distributed_nft(arg0: &mut LaunchpadData, arg1: &mut Order, arg2: &mut Storage, arg3: u64, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.current_nft + arg3 <= arg0.total_nft, 1);
        assert!(0x2::clock::timestamp_ms(arg4) > 0x1::vector::borrow_mut<PhaseInfo>(&mut arg0.phases, 0x1::vector::length<PhaseInfo>(&arg0.phases) - 1).expired_time || arg0.minted >= arg0.total_nft, 4);
        let v0 = 0;
        while (v0 < arg3) {
            let v1 = arg0.current_nft + 1;
            let v2 = 0x2::dynamic_field::remove<u64, UserOrder>(&mut arg1.id, v1);
            0x2::transfer::public_transfer<BlueMoveXNavi>(0x2::dynamic_object_field::remove<u64, BlueMoveXNavi>(&mut arg2.id, v1), v2.recipent);
            arg0.current_nft = v1;
            v0 = v0 + 1;
        };
    }

    public fun get_token_name<T0>() : 0x1::string::String {
        0x1::string::utf8(0x1::ascii::into_bytes(0x1::type_name::into_string(0x1::type_name::get<T0>())))
    }

    fun init(arg0: BLUEMOVE_LAUNCHPAD, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x1::vector::empty<0x1::string::String>();
        let v1 = &mut v0;
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"name"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"image_url"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"description"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"url"));
        let v2 = 0x1::vector::empty<0x1::string::String>();
        let v3 = &mut v2;
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"{name}"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"{image_url}"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"{description}"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"{url}"));
        let v4 = LaunchpadData{
            id             : 0x2::object::new(arg1),
            minted         : 0,
            current_nft    : 0,
            current_place  : 0,
            base_name      : 0x1::string::utf8(b"BlueMove Dragon #"),
            base_image_url : 0x1::string::utf8(b"https://ipfs.bluemove.net/uploads/bluemove-dragon/"),
            base_url       : 0x1::string::utf8(b"https://bluemovecdn.s3.ap-northeast-1.amazonaws.com/bluemove-dragon/"),
            description    : 0x1::string::utf8(b"Unique NFT collection on Sui Blockchain's largest marketplace. Captivating digital artworks of distinctive dragons."),
            phases         : 0x1::vector::empty<PhaseInfo>(),
            fund_address   : @0x997c025aa9c4cc19d0665db2548680a31403b4bc55667fff33cbf3e5c69fc562,
            total_nft      : 30,
            pre_mint       : 0,
            start_order    : 0,
        };
        let v5 = Storage{id: 0x2::object::new(arg1)};
        0x2::transfer::public_share_object<Storage>(v5);
        let v6 = Order{id: 0x2::object::new(arg1)};
        0x2::transfer::public_share_object<Order>(v6);
        let v7 = 0x2::package::claim<BLUEMOVE_LAUNCHPAD>(arg0, arg1);
        let v8 = 0x2::display::new_with_fields<BlueMoveXNavi>(&v7, v0, v2, arg1);
        0x2::display::update_version<BlueMoveXNavi>(&mut v8);
        0x2::transfer::public_transfer<0x2::package::Publisher>(v7, @0x2);
        0x2::transfer::public_transfer<0x2::display::Display<BlueMoveXNavi>>(v8, @0x2);
        0x2::transfer::public_share_object<LaunchpadData>(v4);
    }

    fun mint_inscriptions_nft(arg0: 0x1::string::String, arg1: 0x1::string::String, arg2: 0x1::string::String, arg3: 0x1::string::String, arg4: 0x1::string::String, arg5: &mut 0x2::tx_context::TxContext) : BlueMoveXNavi {
        let v0 = BlueMoveXNavi{
            id            : 0x2::object::new(arg5),
            name          : arg0,
            description   : arg1,
            image_url     : arg2,
            url           : arg3,
            external_link : arg4,
        };
        let v1 = MintNFTEvent{
            id          : 0x2::object::uid_to_inner(&v0.id),
            name        : arg0,
            description : arg1,
            image_url   : arg2,
        };
        0x2::event::emit<MintNFTEvent>(v1);
        v0
    }

    public entry fun mint_with_quantity(arg0: 0x2::coin::Coin<0x2::sui::SUI>, arg1: u64, arg2: &mut LaunchpadData, arg3: &mut Order, arg4: &mut Storage, arg5: u64, arg6: &0x2::clock::Clock, arg7: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg7);
        let v1 = 0x1::vector::borrow_mut<PhaseInfo>(&mut arg2.phases, arg1);
        let v2 = arg5 * v1.price_per_item;
        let v3 = 0x2::clock::timestamp_ms(arg6);
        assert!(0x2::coin::value<0x2::sui::SUI>(&arg0) == v2, 3);
        assert!(v1.start_time <= v3 && v1.expired_time >= v3, 4);
        if (!0x2::dynamic_field::exists_with_type<address, MintedByUser>(&arg2.id, v0)) {
            let v4 = MintedByUser{user_minted: 0x2::vec_map::empty<u64, u64>()};
            0x2::dynamic_field::add<address, MintedByUser>(&mut arg2.id, v0, v4);
        };
        assert!(arg2.minted + arg5 <= arg2.total_nft, 1);
        let v5 = 0x2::dynamic_field::borrow_mut<address, MintedByUser>(&mut arg2.id, v0);
        if (!0x2::vec_map::contains<u64, u64>(&v5.user_minted, &arg1)) {
            0x2::vec_map::insert<u64, u64>(&mut v5.user_minted, arg1, 0);
        };
        let (_, v7) = 0x2::vec_map::remove<u64, u64>(&mut v5.user_minted, &arg1);
        assert!(arg5 <= v1.nft_per_user - v7, 2);
        if (0x2::table::length<address, u64>(&v1.member) != 0) {
            assert!(0x2::table::contains<address, u64>(&v1.member, v0), 6);
        };
        let v8 = 0;
        while (v8 < arg5) {
            let v9 = arg2.minted + 1;
            arg2.minted = arg2.minted + 1;
            let v10 = UserOrder{
                order_id : v9,
                recipent : v0,
            };
            0x2::dynamic_field::add<u64, UserOrder>(&mut arg3.id, v9, v10);
            let v11 = arg2.base_name;
            0x1::string::append(&mut v11, num_str(v9));
            let v12 = arg2.base_url;
            0x1::string::append(&mut v12, num_str(v9));
            0x1::string::append(&mut v12, 0x1::string::utf8(b".json"));
            0x1::string::append(&mut v12, num_str(v9));
            0x1::string::append(&mut v12, 0x1::string::utf8(b".webp"));
            0x2::dynamic_object_field::add<u64, BlueMoveXNavi>(&mut arg4.id, arg2.current_place + 1, mint_inscriptions_nft(v11, arg2.description, arg2.base_image_url, v12, 0x1::string::utf8(b"https://sui.bluemove.net/"), arg7));
            arg2.current_place = arg2.current_place + 1;
            v8 = v8 + 1;
            let v13 = UserOrderEvent{
                order_id : v9,
                recipent : v0,
            };
            0x2::event::emit<UserOrderEvent>(v13);
        };
        0x2::vec_map::insert<u64, u64>(&mut v5.user_minted, arg1, v7 + arg5);
        v1.current_nft = v1.current_nft + arg5;
        if (v2 > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(arg0, @0x997c025aa9c4cc19d0665db2548680a31403b4bc55667fff33cbf3e5c69fc562);
        } else {
            0x2::coin::destroy_zero<0x2::sui::SUI>(arg0);
        };
    }

    fun num_str(arg0: u64) : 0x1::string::String {
        let v0 = 0x1::vector::empty<u8>();
        while (arg0 / 10 > 0) {
            0x1::vector::push_back<u8>(&mut v0, ((arg0 % 10 + 48) as u8));
            arg0 = arg0 / 10;
        };
        0x1::vector::push_back<u8>(&mut v0, ((arg0 + 48) as u8));
        0x1::vector::reverse<u8>(&mut v0);
        0x1::string::utf8(v0)
    }

    fun placeNftOrder(arg0: &mut LaunchpadData, arg1: &mut Storage, arg2: BlueMoveXNavi, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::dynamic_object_field::add<u64, BlueMoveXNavi>(&mut arg1.id, arg0.current_place + 1, arg2);
        arg0.current_place = arg0.current_place + 1;
    }

    public entry fun remove_phase(arg0: &mut LaunchpadData, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg2) == @0x49cc391ab4d3503e03dbb24c4f9e28f3cdd2ddf8a459e0d43012c3868ffefa1, 5);
        let PhaseInfo {
            name           : _,
            start_time     : _,
            expired_time   : _,
            nft_per_user   : _,
            current_nft    : _,
            price_per_item : _,
            total_nfts     : _,
            member         : v7,
        } = 0x1::vector::remove<PhaseInfo>(&mut arg0.phases, arg1);
        0x2::table::drop<address, u64>(v7);
    }

    public entry fun update_base_image_url(arg0: &mut LaunchpadData, arg1: 0x1::string::String, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg2) == @0x49cc391ab4d3503e03dbb24c4f9e28f3cdd2ddf8a459e0d43012c3868ffefa1, 5);
        arg0.base_image_url = arg1;
    }

    public entry fun update_nft_per_user(arg0: &mut LaunchpadData, arg1: u64, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x1::vector::borrow_mut<PhaseInfo>(&mut arg0.phases, arg1);
        assert!(@0x49cc391ab4d3503e03dbb24c4f9e28f3cdd2ddf8a459e0d43012c3868ffefa1 == 0x2::tx_context::sender(arg3), 5);
        v0.nft_per_user = arg2;
    }

    public entry fun update_number_pre_mint(arg0: &mut LaunchpadData, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg2) == @0x49cc391ab4d3503e03dbb24c4f9e28f3cdd2ddf8a459e0d43012c3868ffefa1, 5);
        arg0.pre_mint = arg1;
    }

    public entry fun update_price_per_item(arg0: &mut LaunchpadData, arg1: u64, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x1::vector::borrow_mut<PhaseInfo>(&mut arg0.phases, arg1);
        assert!(@0x49cc391ab4d3503e03dbb24c4f9e28f3cdd2ddf8a459e0d43012c3868ffefa1 == 0x2::tx_context::sender(arg3), 5);
        v0.price_per_item = arg2;
    }

    public entry fun update_time_to_mint(arg0: &mut LaunchpadData, arg1: u64, arg2: u64, arg3: u64, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(@0x49cc391ab4d3503e03dbb24c4f9e28f3cdd2ddf8a459e0d43012c3868ffefa1 == 0x2::tx_context::sender(arg4), 5);
        let v0 = 0x1::vector::borrow_mut<PhaseInfo>(&mut arg0.phases, arg1);
        v0.start_time = arg2;
        v0.expired_time = arg3;
    }

    public entry fun update_total_globle(arg0: &mut LaunchpadData, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg2) == @0x49cc391ab4d3503e03dbb24c4f9e28f3cdd2ddf8a459e0d43012c3868ffefa1, 5);
        arg0.total_nft = arg1;
    }

    public entry fun update_total_nft(arg0: &mut LaunchpadData, arg1: u64, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x1::vector::borrow_mut<PhaseInfo>(&mut arg0.phases, arg1);
        assert!(@0x49cc391ab4d3503e03dbb24c4f9e28f3cdd2ddf8a459e0d43012c3868ffefa1 == 0x2::tx_context::sender(arg3), 5);
        v0.total_nfts = arg2;
    }

    // decompiled from Move bytecode v6
}

