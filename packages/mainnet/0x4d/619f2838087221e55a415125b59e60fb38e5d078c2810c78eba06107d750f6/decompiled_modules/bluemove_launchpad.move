module 0x4d619f2838087221e55a415125b59e60fb38e5d078c2810c78eba06107d750f6::bluemove_launchpad {
    struct BLUEMOVE_LAUNCHPAD has drop {
        dummy_field: bool,
    }

    struct Witness has drop {
        dummy_field: bool,
    }

    struct LaunchpadData has store, key {
        id: 0x2::object::UID,
        minted: u64,
        current_nft: u64,
        base_name: 0x1::string::String,
        base_url: 0x1::string::String,
        base_image_url: 0x1::string::String,
        description: 0x1::string::String,
        keys: 0x2::table::Table<u64, vector<0x1::ascii::String>>,
        values: 0x2::table::Table<u64, vector<0x1::ascii::String>>,
        phases: vector<PhaseInfo>,
        fund_address: address,
        balance: 0x2::balance::Balance<0x2::sui::SUI>,
        total_nft: u64,
        pre_mint: u64,
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
        can_claim: 0x2::table::Table<address, CanClaim>,
    }

    struct MintedByUser has store {
        user_minted: 0x2::vec_map::VecMap<u64, u64>,
    }

    struct CanClaim has drop, store {
        can_claim: u64,
    }

    struct MintNFTEvent has copy, drop {
        object_id: 0x2::object::ID,
        creator: address,
        name: 0x1::string::String,
    }

    struct BurnEvent has copy, drop {
        object_id: 0x2::object::ID,
        sender: address,
        nft_name: 0x1::string::String,
    }

    struct DegenBears has store, key {
        id: 0x2::object::UID,
        name: 0x1::string::String,
        description: 0x1::string::String,
        url: 0x1::string::String,
        image_url: 0x1::string::String,
    }

    public fun add_atributes(arg0: &mut LaunchpadData, arg1: vector<vector<0x1::ascii::String>>, arg2: vector<vector<0x1::ascii::String>>, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg3) == @0x49cc391ab4d3503e03dbb24c4f9e28f3cdd2ddf8a459e0d43012c3868ffefa1, 5);
        let v0 = 0x1::vector::length<vector<0x1::ascii::String>>(&arg1);
        assert!(v0 == 0x1::vector::length<vector<0x1::ascii::String>>(&arg2), 20);
        let v1 = 0;
        while (v1 < v0) {
            let v2 = 0x2::table::length<u64, vector<0x1::ascii::String>>(&arg0.keys) + 1;
            0x2::table::add<u64, vector<0x1::ascii::String>>(&mut arg0.keys, v2, *0x1::vector::borrow_mut<vector<0x1::ascii::String>>(&mut arg1, v1));
            0x2::table::add<u64, vector<0x1::ascii::String>>(&mut arg0.values, v2, *0x1::vector::borrow_mut<vector<0x1::ascii::String>>(&mut arg2, v1));
            v1 = v1 + 1;
        };
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
            can_claim      : 0x2::table::new<address, CanClaim>(arg7),
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

    public entry fun burn_nft(arg0: DegenBears, arg1: &mut 0x2::tx_context::TxContext) {
        let DegenBears {
            id          : v0,
            name        : v1,
            description : _,
            url         : _,
            image_url   : _,
        } = arg0;
        0x2::object::delete(v0);
        let v5 = BurnEvent{
            object_id : 0x2::object::id<DegenBears>(&arg0),
            sender    : 0x2::tx_context::sender(arg1),
            nft_name  : v1,
        };
        0x2::event::emit<BurnEvent>(v5);
    }

    public entry fun claim_nfts(arg0: &mut LaunchpadData, arg1: &0x2::clock::Clock, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg2);
        let v1 = 0x1::vector::length<PhaseInfo>(&arg0.phases);
        let v2 = 0;
        let v3 = 0;
        assert!(0x1::vector::borrow<PhaseInfo>(&mut arg0.phases, v1 - 1).expired_time < 0x2::clock::timestamp_ms(arg1) || arg0.minted == arg0.total_nft, 4);
        while (v3 < v1) {
            let v4 = 0x1::vector::borrow_mut<PhaseInfo>(&mut arg0.phases, v3);
            let v5 = if (!0x2::table::contains<address, CanClaim>(&mut v4.can_claim, v0)) {
                0
            } else {
                0x2::table::borrow_mut<address, CanClaim>(&mut v4.can_claim, v0).can_claim
            };
            v2 = v2 + v5;
            v3 = v3 + 1;
        };
        let v6 = 0x2::dynamic_field::borrow_mut<address, MintedByUser>(&mut arg0.id, v0);
        let v7 = 9;
        if (!0x2::vec_map::contains<u64, u64>(&v6.user_minted, &v7)) {
            0x2::vec_map::insert<u64, u64>(&mut v6.user_minted, 9, 0);
        };
        let v8 = 9;
        let (_, v10) = 0x2::vec_map::remove<u64, u64>(&mut v6.user_minted, &v8);
        assert!(v2 > v10, 5);
        let v11 = v2 - v10;
        while (v11 > 0) {
            let v12 = arg0.current_nft;
            assert!(v12 < arg0.total_nft, 1);
            let v13 = v12 + 1;
            let v14 = arg0.base_name;
            0x1::string::append(&mut v14, num_str(v13));
            let v15 = arg0.base_image_url;
            0x1::string::append(&mut v15, num_str(v13));
            0x1::string::append(&mut v15, 0x1::string::utf8(b".webp"));
            let v16 = arg0.base_url;
            0x1::string::append(&mut v16, num_str(v13));
            0x1::string::append(&mut v16, 0x1::string::utf8(b".json"));
            let v17 = DegenBears{
                id          : 0x2::object::new(arg2),
                name        : v14,
                description : arg0.description,
                url         : v16,
                image_url   : v15,
            };
            let v18 = MintNFTEvent{
                object_id : 0x2::object::id<DegenBears>(&v17),
                creator   : v0,
                name      : v14,
            };
            0x2::event::emit<MintNFTEvent>(v18);
            0x2::transfer::public_transfer<DegenBears>(v17, v0);
            arg0.current_nft = v13;
            v11 = v11 - 1;
        };
        0x2::vec_map::insert<u64, u64>(&mut v6.user_minted, 9, v10 + v2);
    }

    public entry fun claim_token_to_fund(arg0: &mut LaunchpadData, arg1: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.fund_address == 0x2::tx_context::sender(arg1), 5);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::from_balance<0x2::sui::SUI>(0x2::balance::split<0x2::sui::SUI>(&mut arg0.balance, 0x2::balance::value<0x2::sui::SUI>(&arg0.balance)), arg1), arg0.fund_address);
    }

    fun init(arg0: BLUEMOVE_LAUNCHPAD, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 5666;
        let v1 = LaunchpadData{
            id             : 0x2::object::new(arg1),
            minted         : 0,
            current_nft    : 0,
            base_name      : 0x1::string::utf8(b"Degen Bears #"),
            base_url       : 0x1::string::utf8(b"https://static.bluemove.net/degen-bears-1/"),
            base_image_url : 0x1::string::utf8(b"https://ipfs.bluemove.net/uploads2/degen-bears/images/"),
            description    : 0x1::string::utf8(b"Degen Bears is an nft project on sui blockchain that aims to transmit a positive degen vibe with cool utilities. Our task is to develop useful product on fresh ecosystem of sui blockchain and grow it's community together!"),
            keys           : 0x2::table::new<u64, vector<0x1::ascii::String>>(arg1),
            values         : 0x2::table::new<u64, vector<0x1::ascii::String>>(arg1),
            phases         : 0x1::vector::empty<PhaseInfo>(),
            fund_address   : @0x4a095a73cccd2fabac4afead73c008d91bcfa71522d0910212d6218824685256,
            balance        : 0x2::balance::zero<0x2::sui::SUI>(),
            total_nft      : v0,
            pre_mint       : 0,
        };
        let v2 = 0x2::tx_context::sender(arg1);
        let (v3, v4) = 0xbc3df36be17f27ac98e3c839b2589db8475fa07b20657b08e8891e3aaf5ee5f9::collection::create_with_mint_cap<BLUEMOVE_LAUNCHPAD, DegenBears>(&arg0, 0x1::option::some<u64>(v0), arg1);
        let v5 = v3;
        let v6 = Witness{dummy_field: false};
        let v7 = 0x16c5f17f2d55584a6e6daa442ccf83b4530d10546a8e7dedda9ba324e012fc40::witness::from_witness<DegenBears, Witness>(v6);
        0xbc3df36be17f27ac98e3c839b2589db8475fa07b20657b08e8891e3aaf5ee5f9::collection::add_domain<DegenBears, 0xbc3df36be17f27ac98e3c839b2589db8475fa07b20657b08e8891e3aaf5ee5f9::creators::Creators>(v7, &mut v5, 0xbc3df36be17f27ac98e3c839b2589db8475fa07b20657b08e8891e3aaf5ee5f9::creators::new(0x2::vec_set::singleton<address>(v2)));
        0xbc3df36be17f27ac98e3c839b2589db8475fa07b20657b08e8891e3aaf5ee5f9::collection::add_domain<DegenBears, 0xbc3df36be17f27ac98e3c839b2589db8475fa07b20657b08e8891e3aaf5ee5f9::display_info::DisplayInfo>(v7, &mut v5, 0xbc3df36be17f27ac98e3c839b2589db8475fa07b20657b08e8891e3aaf5ee5f9::display_info::new(0x1::string::utf8(b"Degen Bears"), 0x1::string::utf8(b"Degen Bears is an nft project on sui blockchain that aims to transmit a positive degen vibe with cool utilities. Our task is to develop useful product on fresh ecosystem of sui blockchain and grow it's community together!")));
        let v8 = 0x2::package::claim<BLUEMOVE_LAUNCHPAD>(arg0, arg1);
        let v9 = 0x1::vector::empty<0x1::string::String>();
        let v10 = &mut v9;
        0x1::vector::push_back<0x1::string::String>(v10, 0xbc3df36be17f27ac98e3c839b2589db8475fa07b20657b08e8891e3aaf5ee5f9::tags::art());
        0x1::vector::push_back<0x1::string::String>(v10, 0xbc3df36be17f27ac98e3c839b2589db8475fa07b20657b08e8891e3aaf5ee5f9::tags::game_asset());
        let v11 = 0x2::display::new<DegenBears>(&v8, arg1);
        0x2::display::add<DegenBears>(&mut v11, 0x1::string::utf8(b"name"), 0x1::string::utf8(b"{name}"));
        0x2::display::add<DegenBears>(&mut v11, 0x1::string::utf8(b"description"), 0x1::string::utf8(b"{description}"));
        0x2::display::add<DegenBears>(&mut v11, 0x1::string::utf8(b"image_url"), 0x1::string::utf8(b"{image_url}"));
        0x2::display::add<DegenBears>(&mut v11, 0x1::string::utf8(b"tags"), 0x859eb18bd5b5e8cc32deb6dfb1c39941008ab3c6e27f0b8ce2364be7102bb7cb::display::from_vec(v9));
        0x2::display::update_version<DegenBears>(&mut v11);
        0x2::transfer::public_transfer<0x2::display::Display<DegenBears>>(v11, 0x2::tx_context::sender(arg1));
        let (v12, v13) = 0xe2c7a6843cb13d9549a9d2dc1c266b572ead0b4b9f090e7c3c46de2714102b43::transfer_request::init_policy<DegenBears>(&v8, arg1);
        let v14 = v13;
        let v15 = v12;
        0xbc3df36be17f27ac98e3c839b2589db8475fa07b20657b08e8891e3aaf5ee5f9::royalty_strategy_bps::enforce<DegenBears>(&mut v15, &v14);
        0xbc3df36be17f27ac98e3c839b2589db8475fa07b20657b08e8891e3aaf5ee5f9::transfer_allowlist::enforce<DegenBears>(&mut v15, &v14);
        0xbc3df36be17f27ac98e3c839b2589db8475fa07b20657b08e8891e3aaf5ee5f9::royalty_strategy_bps::create_domain_and_add_strategy<DegenBears>(v7, &mut v5, 0xbc3df36be17f27ac98e3c839b2589db8475fa07b20657b08e8891e3aaf5ee5f9::royalty::from_address(@0x4a095a73cccd2fabac4afead73c008d91bcfa71522d0910212d6218824685256, arg1), 600, arg1);
        0x2::transfer::public_transfer<0xbc3df36be17f27ac98e3c839b2589db8475fa07b20657b08e8891e3aaf5ee5f9::mint_cap::MintCap<DegenBears>>(v4, v2);
        0x2::transfer::public_transfer<0x2::package::Publisher>(v8, v2);
        0x2::transfer::public_transfer<0x2::transfer_policy::TransferPolicyCap<DegenBears>>(v14, v2);
        0x2::transfer::public_share_object<0x2::transfer_policy::TransferPolicy<DegenBears>>(v15);
        0x2::transfer::public_share_object<0xbc3df36be17f27ac98e3c839b2589db8475fa07b20657b08e8891e3aaf5ee5f9::collection::Collection<DegenBears>>(v5);
        0x2::transfer::public_share_object<LaunchpadData>(v1);
    }

    public entry fun mint_with_quantity(arg0: 0x2::coin::Coin<0x2::sui::SUI>, arg1: u64, arg2: &mut LaunchpadData, arg3: u64, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg5);
        0x1::vector::length<PhaseInfo>(&arg2.phases);
        let v1 = 0x1::vector::borrow_mut<PhaseInfo>(&mut arg2.phases, arg1);
        let v2 = arg3 * v1.price_per_item;
        let v3 = 0x2::clock::timestamp_ms(arg4);
        assert!(0x2::coin::value<0x2::sui::SUI>(&arg0) == v2, 3);
        assert!(v1.start_time <= v3 && v1.expired_time >= v3, 4);
        if (!0x2::dynamic_field::exists_with_type<address, MintedByUser>(&arg2.id, v0)) {
            let v4 = MintedByUser{user_minted: 0x2::vec_map::empty<u64, u64>()};
            0x2::dynamic_field::add<address, MintedByUser>(&mut arg2.id, v0, v4);
        };
        assert!(arg2.minted + arg3 <= arg2.total_nft, 1);
        let v5 = 0x2::dynamic_field::borrow_mut<address, MintedByUser>(&mut arg2.id, v0);
        if (!0x2::vec_map::contains<u64, u64>(&v5.user_minted, &arg1)) {
            0x2::vec_map::insert<u64, u64>(&mut v5.user_minted, arg1, 0);
        };
        let (_, v7) = 0x2::vec_map::remove<u64, u64>(&mut v5.user_minted, &arg1);
        assert!(arg3 <= v1.nft_per_user - v7, 2);
        if (0x2::table::length<address, u64>(&v1.member) != 0) {
            assert!(0x2::table::contains<address, u64>(&v1.member, v0), 6);
        };
        if (!0x2::table::contains<address, CanClaim>(&v1.can_claim, v0)) {
            let v8 = CanClaim{can_claim: 0};
            0x2::table::add<address, CanClaim>(&mut v1.can_claim, v0, v8);
        };
        let v9 = 0x2::table::borrow_mut<address, CanClaim>(&mut v1.can_claim, v0);
        v9.can_claim = v9.can_claim + arg3;
        0x2::vec_map::insert<u64, u64>(&mut v5.user_minted, arg1, v7 + arg3);
        v1.current_nft = v1.current_nft + arg3;
        0x2::pay::keep<0x2::sui::SUI>(arg0, arg5);
        0x2::balance::join<0x2::sui::SUI>(&mut arg2.balance, 0x2::coin::into_balance<0x2::sui::SUI>(0x2::coin::split<0x2::sui::SUI>(&mut arg0, v2, arg5)));
        arg2.minted = arg2.minted + arg3;
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

    public entry fun pre_nfts(arg0: &mut LaunchpadData, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg3) == @0x49cc391ab4d3503e03dbb24c4f9e28f3cdd2ddf8a459e0d43012c3868ffefa1, 5);
        while (arg1 > 0) {
            let v0 = arg0.current_nft + 1;
            let v1 = arg0.base_name;
            0x1::string::append(&mut v1, num_str(v0));
            let v2 = arg0.base_image_url;
            0x1::string::append(&mut v2, num_str(v0));
            0x1::string::append(&mut v2, 0x1::string::utf8(b".webp"));
            let v3 = arg0.base_url;
            0x1::string::append(&mut v3, num_str(v0));
            0x1::string::append(&mut v3, 0x1::string::utf8(b".json"));
            let v4 = DegenBears{
                id          : 0x2::object::new(arg3),
                name        : v1,
                description : arg0.description,
                url         : v3,
                image_url   : v2,
            };
            0x2::transfer::public_transfer<DegenBears>(v4, arg2);
            arg0.current_nft = v0;
            arg0.minted = arg0.minted + 1;
            arg1 = arg1 - 1;
        };
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
            can_claim      : v8,
        } = 0x1::vector::remove<PhaseInfo>(&mut arg0.phases, arg1);
        0x2::table::drop<address, u64>(v7);
        0x2::table::drop<address, CanClaim>(v8);
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

    public entry fun update_user_can_claim(arg0: &mut LaunchpadData, arg1: address, arg2: u64, arg3: u64, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg4) == @0x49cc391ab4d3503e03dbb24c4f9e28f3cdd2ddf8a459e0d43012c3868ffefa1, 5);
        let v0 = 0x1::vector::borrow_mut<PhaseInfo>(&mut arg0.phases, arg2);
        if (!0x2::table::contains<address, CanClaim>(&v0.can_claim, arg1)) {
            let v1 = CanClaim{can_claim: 0};
            0x2::table::add<address, CanClaim>(&mut v0.can_claim, arg1, v1);
        };
        0x2::table::borrow_mut<address, CanClaim>(&mut v0.can_claim, arg1).can_claim = arg3;
    }

    // decompiled from Move bytecode v6
}

