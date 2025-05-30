module 0x85565f97c62644641e51e663f0eda853daf9737010443cc66d2aafaf7c17348d::bluemove_launchpad {
    struct LaunchpadData has store, key {
        id: 0x2::object::UID,
        minted: u64,
        current_nft: u64,
        current_place: u64,
        base_name: 0x1::string::String,
        base_url: 0x1::string::String,
        base_image_url: 0x1::string::String,
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
        url: 0x1::string::String,
        image_url: 0x1::string::String,
    }

    struct BurnEvent has copy, drop {
        id: 0x2::object::ID,
        name: 0x1::string::String,
        description: 0x1::string::String,
        url: 0x1::string::String,
        image_url: 0x1::string::String,
    }

    struct MintedByUser has store {
        user_minted: 0x2::vec_map::VecMap<u64, u64>,
    }

    struct BLUEMOVE_LAUNCHPAD has drop {
        dummy_field: bool,
    }

    struct DSL_Legacy has store, key {
        id: 0x2::object::UID,
        name: 0x1::string::String,
        description: 0x1::string::String,
        url: 0x1::string::String,
        image_url: 0x1::string::String,
        external_link: 0x1::string::String,
        contents: vector<0x1::string::String>,
        content_size: u64,
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

    public entry fun burn_nft(arg0: DSL_Legacy, arg1: &mut 0x2::tx_context::TxContext) {
        let DSL_Legacy {
            id            : v0,
            name          : v1,
            description   : v2,
            url           : v3,
            image_url     : v4,
            external_link : _,
            contents      : _,
            content_size  : _,
        } = arg0;
        let v8 = v0;
        let v9 = BurnEvent{
            id          : 0x2::object::uid_to_inner(&v8),
            name        : v1,
            description : v2,
            url         : v3,
            image_url   : v4,
        };
        0x2::event::emit<BurnEvent>(v9);
        0x2::object::delete(v8);
    }

    public entry fun distributed_nft(arg0: &mut LaunchpadData, arg1: &mut Order, arg2: &mut Storage, arg3: u64, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.current_nft + arg3 <= arg0.total_nft, 1);
        let v0 = 0;
        while (v0 < arg3) {
            let v1 = arg0.current_nft + 1;
            let v2 = 0x2::dynamic_field::remove<u64, UserOrder>(&mut arg1.id, v1);
            0x2::transfer::public_transfer<DSL_Legacy>(0x2::dynamic_object_field::remove<u64, DSL_Legacy>(&mut arg2.id, v1), v2.recipent);
            arg0.current_nft = v1;
            v0 = v0 + 1;
        };
    }

    fun init(arg0: BLUEMOVE_LAUNCHPAD, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x1::vector::empty<0x1::string::String>();
        let v1 = &mut v0;
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"name"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"url"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"image_url"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"description"));
        let v2 = 0x1::vector::empty<0x1::string::String>();
        let v3 = &mut v2;
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"{name}"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"{url}"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"{image_url}"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"description"));
        let v4 = LaunchpadData{
            id             : 0x2::object::new(arg1),
            minted         : 0,
            current_nft    : 0,
            current_place  : 0,
            base_name      : 0x1::string::utf8(b"DSL Legacy #"),
            base_url       : 0x1::string::utf8(b"https://bluemovecdn.s3.ap-northeast-1.amazonaws.com/dsl-legacy/"),
            base_image_url : 0x1::string::utf8(b"https://ipfs.io/ipfs/bafybeif6bt43yulin7at4was5h5fb6zhc33h3xkfjpja5r6x34afgkiok4/"),
            description    : 0x1::string::utf8(b"222 degens inscribed on the Sui Blockchain, forever. The first ever digital collectibles inscribed on Sui Network"),
            phases         : 0x1::vector::empty<PhaseInfo>(),
            fund_address   : @0xe537170f46cd1ecaebe3c2b49c55ed5a57082fe19a682293921efaa77f011851,
            total_nft      : 3,
            pre_mint       : 0,
            start_order    : 0,
        };
        let v5 = Storage{id: 0x2::object::new(arg1)};
        0x2::transfer::public_share_object<Storage>(v5);
        let v6 = Order{id: 0x2::object::new(arg1)};
        0x2::transfer::public_share_object<Order>(v6);
        let v7 = 0x2::package::claim<BLUEMOVE_LAUNCHPAD>(arg0, arg1);
        let v8 = 0x2::display::new_with_fields<DSL_Legacy>(&v7, v0, v2, arg1);
        0x2::display::update_version<DSL_Legacy>(&mut v8);
        0x2::transfer::public_transfer<0x2::package::Publisher>(v7, @0x2);
        0x2::transfer::public_transfer<0x2::display::Display<DSL_Legacy>>(v8, @0x2);
        0x2::transfer::public_share_object<LaunchpadData>(v4);
    }

    public fun inscriptions(arg0: &mut DSL_Legacy, arg1: 0x1::string::String, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg2) == @0x49cc391ab4d3503e03dbb24c4f9e28f3cdd2ddf8a459e0d43012c3868ffefa1, 5);
        assert!(0x1::string::length(&arg1) + 0x1::vector::length<0x1::string::String>(&arg0.contents) * 12000 <= arg0.content_size, 8);
        0x1::vector::push_back<0x1::string::String>(&mut arg0.contents, arg1);
    }

    public fun mint_inscriptions_nft(arg0: 0x1::string::String, arg1: 0x1::string::String, arg2: 0x1::string::String, arg3: 0x1::string::String, arg4: 0x1::string::String, arg5: u64, arg6: &mut 0x2::tx_context::TxContext) : DSL_Legacy {
        assert!(0x2::tx_context::sender(arg6) == @0x49cc391ab4d3503e03dbb24c4f9e28f3cdd2ddf8a459e0d43012c3868ffefa1, 5);
        let v0 = DSL_Legacy{
            id            : 0x2::object::new(arg6),
            name          : arg0,
            description   : arg1,
            url           : arg2,
            image_url     : arg3,
            external_link : arg4,
            contents      : 0x1::vector::empty<0x1::string::String>(),
            content_size  : arg5,
        };
        let v1 = MintNFTEvent{
            id          : 0x2::object::uid_to_inner(&v0.id),
            name        : arg0,
            description : arg1,
            url         : arg2,
            image_url   : arg3,
        };
        0x2::event::emit<MintNFTEvent>(v1);
        v0
    }

    public entry fun mint_with_quantity(arg0: 0x2::coin::Coin<0x2::sui::SUI>, arg1: u64, arg2: &mut LaunchpadData, arg3: &mut Order, arg4: u64, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg6);
        let v1 = 0x1::vector::borrow_mut<PhaseInfo>(&mut arg2.phases, arg1);
        let v2 = 0x2::clock::timestamp_ms(arg5);
        assert!(0x2::coin::value<0x2::sui::SUI>(&arg0) == arg4 * v1.price_per_item, 3);
        assert!(v1.start_time <= v2 && v1.expired_time >= v2, 4);
        if (!0x2::dynamic_field::exists_with_type<address, MintedByUser>(&arg2.id, v0)) {
            let v3 = MintedByUser{user_minted: 0x2::vec_map::empty<u64, u64>()};
            0x2::dynamic_field::add<address, MintedByUser>(&mut arg2.id, v0, v3);
        };
        assert!(arg2.minted + arg4 <= arg2.total_nft, 1);
        let v4 = 0x2::dynamic_field::borrow_mut<address, MintedByUser>(&mut arg2.id, v0);
        if (!0x2::vec_map::contains<u64, u64>(&v4.user_minted, &arg1)) {
            0x2::vec_map::insert<u64, u64>(&mut v4.user_minted, arg1, 0);
        };
        let (_, v6) = 0x2::vec_map::remove<u64, u64>(&mut v4.user_minted, &arg1);
        assert!(arg4 <= v1.nft_per_user - v6, 2);
        if (0x2::table::length<address, u64>(&v1.member) != 0) {
            assert!(0x2::table::contains<address, u64>(&v1.member, v0), 6);
        };
        let v7 = 0;
        while (v7 < arg4) {
            let v8 = arg2.minted + 1;
            arg2.minted = arg2.minted + 1;
            let v9 = UserOrder{
                order_id : v8,
                recipent : v0,
            };
            0x2::dynamic_field::add<u64, UserOrder>(&mut arg3.id, v8, v9);
            v7 = v7 + 1;
        };
        0x2::vec_map::insert<u64, u64>(&mut v4.user_minted, arg1, v6 + arg4);
        v1.current_nft = v1.current_nft + arg4;
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(arg0, @0xe537170f46cd1ecaebe3c2b49c55ed5a57082fe19a682293921efaa77f011851);
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

    public fun placeNftOrder(arg0: &mut LaunchpadData, arg1: &mut Storage, arg2: DSL_Legacy, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg3) == @0x49cc391ab4d3503e03dbb24c4f9e28f3cdd2ddf8a459e0d43012c3868ffefa1, 5);
        0x2::dynamic_object_field::add<u64, DSL_Legacy>(&mut arg1.id, arg0.current_place + 1, arg2);
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

    public entry fun update_base_url(arg0: &mut LaunchpadData, arg1: 0x1::string::String, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg2) == @0x49cc391ab4d3503e03dbb24c4f9e28f3cdd2ddf8a459e0d43012c3868ffefa1, 5);
        arg0.base_url = arg1;
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

