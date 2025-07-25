module 0xe5a18e4bcff825aca53e4d4d6a3ec415f543baa2895c8660b94fe5f68843e7e5::quntz {
    struct NFTMinted has copy, drop {
        nft_id: 0x2::object::ID,
        token_id: u64,
        minter: address,
        phase: u8,
    }

    struct PhaseStarted has copy, drop {
        timestamp: u64,
    }

    struct PhaseEnded has copy, drop {
        timestamp: u64,
    }

    struct WhitelistAdded has copy, drop {
        phase: u8,
        address: address,
        mint_limit: u64,
    }

    struct PriceUpdated has copy, drop {
        phase: u8,
        new_price: u64,
    }

    struct AdminUpdated has copy, drop {
        new_admin: address,
    }

    struct IDsRemoved has copy, drop {
        token_ids: vector<u64>,
    }

    struct QUNTZ has drop {
        dummy_field: bool,
    }

    struct AdminCap has key {
        id: 0x2::object::UID,
    }

    struct NFTCollection has key {
        id: 0x2::object::UID,
        minted: u64,
        phase1_minted: u64,
        phase2_minted: u64,
        public_minted: u64,
        available_ids: vector<u64>,
        phase1_whitelist: 0x2::table::Table<address, u64>,
        phase2_whitelist: 0x2::table::Table<address, u64>,
        preset_attributes: 0x2::table::Table<u64, 0x2::vec_map::VecMap<0x1::string::String, 0x1::string::String>>,
        preset_urls: 0x2::table::Table<u64, 0x2::url::Url>,
        mint_start: u64,
        phase_end: u64,
        admin_address: address,
        treasury_address: address,
    }

    struct NFT has store, key {
        id: 0x2::object::UID,
        name: 0x1::string::String,
        description: 0x1::string::String,
        image_url: 0x2::url::Url,
        attributes: 0x2::vec_map::VecMap<0x1::string::String, 0x1::string::String>,
        token_id: u64,
    }

    public entry fun add_to_phase1(arg0: &AdminCap, arg1: &mut NFTCollection, arg2: vector<address>, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg3) == arg1.admin_address, 4);
        let v0 = 0;
        while (v0 < 0x1::vector::length<address>(&arg2)) {
            let v1 = *0x1::vector::borrow<address>(&arg2, v0);
            if (0x2::table::contains<address, u64>(&arg1.phase1_whitelist, v1)) {
                0x2::table::remove<address, u64>(&mut arg1.phase1_whitelist, v1);
            };
            0x2::table::add<address, u64>(&mut arg1.phase1_whitelist, v1, 3);
            let v2 = WhitelistAdded{
                phase      : 1,
                address    : v1,
                mint_limit : 3,
            };
            0x2::event::emit<WhitelistAdded>(v2);
            v0 = v0 + 1;
        };
    }

    public entry fun add_to_phase2(arg0: &AdminCap, arg1: &mut NFTCollection, arg2: vector<address>, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg3) == arg1.admin_address, 4);
        let v0 = 0;
        while (v0 < 0x1::vector::length<address>(&arg2)) {
            let v1 = *0x1::vector::borrow<address>(&arg2, v0);
            if (0x2::table::contains<address, u64>(&arg1.phase2_whitelist, v1)) {
                0x2::table::remove<address, u64>(&mut arg1.phase2_whitelist, v1);
            };
            0x2::table::add<address, u64>(&mut arg1.phase2_whitelist, v1, 5);
            let v2 = WhitelistAdded{
                phase      : 2,
                address    : v1,
                mint_limit : 5,
            };
            0x2::event::emit<WhitelistAdded>(v2);
            v0 = v0 + 1;
        };
    }

    public entry fun adjust_minted_count(arg0: &AdminCap, arg1: &mut NFTCollection, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg3) == arg1.admin_address, 4);
        arg1.minted = arg1.minted + arg2;
        let v0 = 0;
        let v1 = 0x1::vector::empty<u64>();
        let v2 = 0x1::vector::length<u64>(&arg1.available_ids);
        while (v0 < arg2 && v2 > 0) {
            let v3 = v2 - 1;
            v2 = v3;
            let v4 = *0x1::vector::borrow<u64>(&arg1.available_ids, v3);
            if (v4 >= 100) {
                0x1::vector::remove<u64>(&mut arg1.available_ids, v3);
                0x1::vector::push_back<u64>(&mut v1, v4);
                v0 = v0 + 1;
            };
        };
        assert!(v0 == arg2, 1);
        let v5 = IDsRemoved{token_ids: v1};
        0x2::event::emit<IDsRemoved>(v5);
    }

    public fun are_phases_active(arg0: &NFTCollection, arg1: &0x2::clock::Clock) : bool {
        let v0 = 0x2::clock::timestamp_ms(arg1);
        v0 >= arg0.mint_start && v0 <= arg0.phase_end
    }

    public entry fun burn_nft(arg0: NFT, arg1: &mut NFTCollection) {
        let NFT {
            id          : v0,
            name        : _,
            description : _,
            image_url   : _,
            attributes  : _,
            token_id    : v5,
        } = arg0;
        0x2::object::delete(v0);
        0x1::vector::push_back<u64>(&mut arg1.available_ids, v5);
        arg1.minted = arg1.minted - 1;
    }

    fun create_nft(arg0: &NFTCollection, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) : NFT {
        let v0 = 0x1::string::utf8(b"The Quntz #");
        0x1::string::append(&mut v0, u64_to_string(arg1));
        let v1 = if (0x2::table::contains<u64, 0x2::vec_map::VecMap<0x1::string::String, 0x1::string::String>>(&arg0.preset_attributes, arg1)) {
            *0x2::table::borrow<u64, 0x2::vec_map::VecMap<0x1::string::String, 0x1::string::String>>(&arg0.preset_attributes, arg1)
        } else {
            0x2::vec_map::empty<0x1::string::String, 0x1::string::String>()
        };
        let v2 = if (0x2::table::contains<u64, 0x2::url::Url>(&arg0.preset_urls, arg1)) {
            *0x2::table::borrow<u64, 0x2::url::Url>(&arg0.preset_urls, arg1)
        } else {
            let v3 = 0x1::string::utf8(b"");
            0x1::string::append(&mut v3, u64_to_string(arg1));
            0x2::url::new_unsafe_from_bytes(*0x1::string::as_bytes(&v3))
        };
        NFT{
            id          : 0x2::object::new(arg2),
            name        : v0,
            description : 0x1::string::utf8(b"When degens come together, they become Quntz"),
            image_url   : v2,
            attributes  : v1,
            token_id    : arg1,
        }
    }

    public entry fun end_phases(arg0: &AdminCap, arg1: &mut NFTCollection, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg3) == arg1.admin_address, 4);
        arg1.phase_end = 0x2::clock::timestamp_ms(arg2);
        let v0 = PhaseEnded{timestamp: arg1.phase_end};
        0x2::event::emit<PhaseEnded>(v0);
    }

    public fun get_admin_address(arg0: &NFTCollection) : address {
        arg0.admin_address
    }

    public fun get_collection_stats(arg0: &NFTCollection) : (u64, u64, u64, u64, u64) {
        (arg0.minted, arg0.phase1_minted, arg0.phase2_minted, arg0.public_minted, 0x1::vector::length<u64>(&arg0.available_ids))
    }

    public fun get_minted(arg0: &NFTCollection) : u64 {
        arg0.minted
    }

    public fun get_phase1_minted(arg0: &NFTCollection) : u64 {
        arg0.phase1_minted
    }

    public fun get_phase2_minted(arg0: &NFTCollection) : u64 {
        arg0.phase2_minted
    }

    public fun get_public_minted(arg0: &NFTCollection) : u64 {
        arg0.public_minted
    }

    public fun get_remaining_mints(arg0: &NFTCollection, arg1: address, arg2: u8) : u64 {
        if (arg2 == 1 && 0x2::table::contains<address, u64>(&arg0.phase1_whitelist, arg1)) {
            *0x2::table::borrow<address, u64>(&arg0.phase1_whitelist, arg1)
        } else if (arg2 == 2 && 0x2::table::contains<address, u64>(&arg0.phase2_whitelist, arg1)) {
            *0x2::table::borrow<address, u64>(&arg0.phase2_whitelist, arg1)
        } else {
            0
        }
    }

    public fun get_remaining_nfts(arg0: &NFTCollection) : u64 {
        0x1::vector::length<u64>(&arg0.available_ids)
    }

    public fun get_token_id(arg0: &NFT) : u64 {
        arg0.token_id
    }

    public fun get_total_available_mints(arg0: &NFTCollection, arg1: address) : u64 {
        let (_, v1, _, v3) = get_wallet_allocations(arg0, arg1);
        v1 + v3
    }

    public fun get_total_mint_price(arg0: &NFTCollection, arg1: address) : u64 {
        let (_, v1, _, v3) = get_wallet_allocations(arg0, arg1);
        v1 * 3000000000 + v3 * 12000000000
    }

    public fun get_total_supply() : u64 {
        2700
    }

    public fun get_wallet_allocations(arg0: &NFTCollection, arg1: address) : (bool, u64, bool, u64) {
        let v0 = 0x2::table::contains<address, u64>(&arg0.phase1_whitelist, arg1);
        let v1 = if (v0) {
            *0x2::table::borrow<address, u64>(&arg0.phase1_whitelist, arg1)
        } else {
            0
        };
        let v2 = 0x2::table::contains<address, u64>(&arg0.phase2_whitelist, arg1);
        let v3 = if (v2) {
            *0x2::table::borrow<address, u64>(&arg0.phase2_whitelist, arg1)
        } else {
            0
        };
        (v0, v1, v2, v3)
    }

    fun init(arg0: QUNTZ, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::package::claim<QUNTZ>(arg0, arg1);
        let v1 = NFTCollection{
            id                : 0x2::object::new(arg1),
            minted            : 0,
            phase1_minted     : 0,
            phase2_minted     : 0,
            public_minted     : 0,
            available_ids     : 0x1::vector::empty<u64>(),
            phase1_whitelist  : 0x2::table::new<address, u64>(arg1),
            phase2_whitelist  : 0x2::table::new<address, u64>(arg1),
            preset_attributes : 0x2::table::new<u64, 0x2::vec_map::VecMap<0x1::string::String, 0x1::string::String>>(arg1),
            preset_urls       : 0x2::table::new<u64, 0x2::url::Url>(arg1),
            mint_start        : 1744992000000,
            phase_end         : 1744927200000 + 1800000,
            admin_address     : @0x9728ec13d7321c7ee46669454e6d49857cc29fed09ba13696af7692c55e61a24,
            treasury_address  : @0x65217b4db25dead16d27ed1922841760044a5c73e470d1e52f6c817893c18088,
        };
        let v2 = 1;
        while (v2 <= 2700) {
            0x1::vector::push_back<u64>(&mut v1.available_ids, v2);
            v2 = v2 + 1;
        };
        let v3 = AdminCap{id: 0x2::object::new(arg1)};
        let v4 = 0x2::display::new<NFT>(&v0, arg1);
        0x2::display::add<NFT>(&mut v4, 0x1::string::utf8(b"name"), 0x1::string::utf8(b"{name}"));
        0x2::display::add<NFT>(&mut v4, 0x1::string::utf8(b"description"), 0x1::string::utf8(b"{description}"));
        0x2::display::add<NFT>(&mut v4, 0x1::string::utf8(b"image_url"), 0x1::string::utf8(b"https://walrus.tusky.io/{image_url}"));
        0x2::display::add<NFT>(&mut v4, 0x1::string::utf8(b"attributes"), 0x1::string::utf8(b"{attributes}"));
        0x2::display::update_version<NFT>(&mut v4);
        let (v5, v6) = 0x2::transfer_policy::new<NFT>(&v0, arg1);
        0x2::transfer::transfer<AdminCap>(v3, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::package::Publisher>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::display::Display<NFT>>(v4, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::transfer_policy::TransferPolicyCap<NFT>>(v6, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::transfer_policy::TransferPolicy<NFT>>(v5);
        0x2::transfer::share_object<NFTCollection>(v1);
    }

    public fun is_public_mint_active(arg0: &NFTCollection, arg1: &0x2::clock::Clock) : bool {
        0x2::clock::timestamp_ms(arg1) >= arg0.mint_start
    }

    public fun is_token_minted(arg0: &NFTCollection, arg1: u64) : bool {
        !0x1::vector::contains<u64>(&arg0.available_ids, &arg1)
    }

    public fun is_whitelisted_for_phase(arg0: &NFTCollection, arg1: address, arg2: u8) : bool {
        arg2 == 1 && 0x2::table::contains<address, u64>(&arg0.phase1_whitelist, arg1) || arg2 == 2 && 0x2::table::contains<address, u64>(&arg0.phase2_whitelist, arg1)
    }

    public entry fun mint_all(arg0: &mut NFTCollection, arg1: 0x2::coin::Coin<0x2::sui::SUI>, arg2: &0x2::transfer_policy::TransferPolicy<NFT>, arg3: &0x2::clock::Clock, arg4: &0x2::random::Random, arg5: &mut 0x2::kiosk::Kiosk, arg6: &0x2::kiosk::KioskOwnerCap, arg7: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg7);
        let v1 = 0x2::clock::timestamp_ms(arg3);
        assert!(v1 >= arg0.mint_start, 2);
        assert!(v1 <= arg0.phase_end, 3);
        let (v2, v3, v4, v5) = get_wallet_allocations(arg0, v0);
        assert!(v2 || v4, 6);
        let v6 = if (v2) {
            if (arg0.phase1_minted >= 500) {
                0
            } else {
                500 - arg0.phase1_minted
            }
        } else {
            0
        };
        let v7 = if (v4) {
            if (arg0.phase2_minted >= 2100) {
                0
            } else {
                2100 - arg0.phase2_minted
            }
        } else {
            0
        };
        let v8 = if (v3 > v6) {
            v6
        } else {
            v3
        };
        let v9 = if (v5 > v7) {
            v7
        } else {
            v5
        };
        let v10 = v8 + v9;
        let v11 = if (v8 > 0) {
            if (3 - v3 == 0) {
                if (v8 == 1) {
                    3000000000
                } else {
                    3000000000 + 10000000000 * (v8 - 1)
                }
            } else {
                10000000000 * v8
            }
        } else {
            0
        };
        let v12 = v11 + 12000000000 * v9;
        assert!(v10 > 0, 7);
        assert!(arg0.minted + v10 <= 2700, 1);
        assert!(0x2::coin::value<0x2::sui::SUI>(&arg1) >= v12, 8);
        let v13 = 0;
        if (v2 && v8 > 0) {
            while (v13 < v8) {
                let v14 = select_random_id(arg0, arg4, arg7);
                let v15 = create_nft(arg0, v14, arg7);
                arg0.minted = arg0.minted + 1;
                arg0.phase1_minted = arg0.phase1_minted + 1;
                0x2::kiosk::lock<NFT>(arg5, arg6, arg2, v15);
                let v16 = NFTMinted{
                    nft_id   : 0x2::object::id<NFT>(&v15),
                    token_id : v14,
                    minter   : v0,
                    phase    : 1,
                };
                0x2::event::emit<NFTMinted>(v16);
                v13 = v13 + 1;
            };
            if (0x2::table::contains<address, u64>(&arg0.phase1_whitelist, v0)) {
                0x2::table::remove<address, u64>(&mut arg0.phase1_whitelist, v0);
            };
            0x2::table::add<address, u64>(&mut arg0.phase1_whitelist, v0, v3 - v8);
        };
        if (v4 && v9 > 0) {
            let v17 = 0;
            while (v17 < v9) {
                let v18 = select_random_id(arg0, arg4, arg7);
                let v19 = create_nft(arg0, v18, arg7);
                arg0.minted = arg0.minted + 1;
                arg0.phase2_minted = arg0.phase2_minted + 1;
                0x2::kiosk::lock<NFT>(arg5, arg6, arg2, v19);
                let v20 = NFTMinted{
                    nft_id   : 0x2::object::id<NFT>(&v19),
                    token_id : v18,
                    minter   : v0,
                    phase    : 2,
                };
                0x2::event::emit<NFTMinted>(v20);
                v17 = v17 + 1;
                v13 = v13 + 1;
            };
            if (0x2::table::contains<address, u64>(&arg0.phase2_whitelist, v0)) {
                0x2::table::remove<address, u64>(&mut arg0.phase2_whitelist, v0);
            };
            0x2::table::add<address, u64>(&mut arg0.phase2_whitelist, v0, v5 - v9);
        };
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::split<0x2::sui::SUI>(&mut arg1, v12, arg7), arg0.treasury_address);
        if (0x2::coin::value<0x2::sui::SUI>(&arg1) > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(arg1, v0);
        } else {
            0x2::coin::destroy_zero<0x2::sui::SUI>(arg1);
        };
    }

    public entry fun mint_phase1(arg0: &mut NFTCollection, arg1: 0x2::coin::Coin<0x2::sui::SUI>, arg2: &0x2::transfer_policy::TransferPolicy<NFT>, arg3: &0x2::clock::Clock, arg4: &0x2::random::Random, arg5: &mut 0x2::kiosk::Kiosk, arg6: &0x2::kiosk::KioskOwnerCap, arg7: u64, arg8: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg8);
        let v1 = 0x2::clock::timestamp_ms(arg3);
        assert!(v1 >= arg0.mint_start, 2);
        assert!(v1 <= arg0.phase_end, 3);
        assert!(0x2::table::contains<address, u64>(&arg0.phase1_whitelist, v0), 6);
        assert!(arg7 > 0, 9);
        let v2 = *0x2::table::borrow<address, u64>(&arg0.phase1_whitelist, v0);
        assert!(v2 > 0 && arg7 <= v2, 7);
        assert!(arg0.phase1_minted + arg7 <= 500, 15);
        assert!(arg0.minted + arg7 <= 2700, 1);
        let v3 = if (3 - v2 == 0) {
            if (arg7 == 1) {
                3000000000
            } else {
                3000000000 + 10000000000 * (arg7 - 1)
            }
        } else {
            10000000000 * arg7
        };
        assert!(0x2::coin::value<0x2::sui::SUI>(&arg1) >= v3, 8);
        let v4 = 0;
        while (v4 < arg7) {
            let v5 = select_random_id(arg0, arg4, arg8);
            let v6 = create_nft(arg0, v5, arg8);
            arg0.minted = arg0.minted + 1;
            arg0.phase1_minted = arg0.phase1_minted + 1;
            0x2::kiosk::lock<NFT>(arg5, arg6, arg2, v6);
            let v7 = NFTMinted{
                nft_id   : 0x2::object::id<NFT>(&v6),
                token_id : v5,
                minter   : v0,
                phase    : 1,
            };
            0x2::event::emit<NFTMinted>(v7);
            v4 = v4 + 1;
        };
        if (0x2::table::contains<address, u64>(&arg0.phase1_whitelist, v0)) {
            0x2::table::remove<address, u64>(&mut arg0.phase1_whitelist, v0);
        };
        0x2::table::add<address, u64>(&mut arg0.phase1_whitelist, v0, v2 - arg7);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::split<0x2::sui::SUI>(&mut arg1, v3, arg8), arg0.treasury_address);
        if (0x2::coin::value<0x2::sui::SUI>(&arg1) > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(arg1, v0);
        } else {
            0x2::coin::destroy_zero<0x2::sui::SUI>(arg1);
        };
    }

    public entry fun mint_phase2(arg0: &mut NFTCollection, arg1: 0x2::coin::Coin<0x2::sui::SUI>, arg2: &0x2::transfer_policy::TransferPolicy<NFT>, arg3: &0x2::clock::Clock, arg4: &0x2::random::Random, arg5: &mut 0x2::kiosk::Kiosk, arg6: &0x2::kiosk::KioskOwnerCap, arg7: u64, arg8: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg8);
        let v1 = 0x2::clock::timestamp_ms(arg3);
        assert!(v1 >= arg0.mint_start, 2);
        assert!(v1 <= arg0.phase_end, 3);
        assert!(0x2::table::contains<address, u64>(&arg0.phase2_whitelist, v0), 6);
        assert!(arg7 > 0, 9);
        let v2 = *0x2::table::borrow<address, u64>(&arg0.phase2_whitelist, v0);
        assert!(v2 > 0 && arg7 <= v2, 7);
        assert!(arg0.phase2_minted + arg7 <= 2100, 15);
        assert!(arg0.minted + arg7 <= 2700, 1);
        let v3 = 12000000000 * arg7;
        assert!(0x2::coin::value<0x2::sui::SUI>(&arg1) >= v3, 8);
        let v4 = 0;
        while (v4 < arg7) {
            let v5 = select_random_id(arg0, arg4, arg8);
            let v6 = create_nft(arg0, v5, arg8);
            arg0.minted = arg0.minted + 1;
            arg0.phase2_minted = arg0.phase2_minted + 1;
            0x2::kiosk::lock<NFT>(arg5, arg6, arg2, v6);
            let v7 = NFTMinted{
                nft_id   : 0x2::object::id<NFT>(&v6),
                token_id : v5,
                minter   : v0,
                phase    : 2,
            };
            0x2::event::emit<NFTMinted>(v7);
            v4 = v4 + 1;
        };
        if (v2 > 0) {
            if (0x2::table::contains<address, u64>(&arg0.phase2_whitelist, v0)) {
                0x2::table::remove<address, u64>(&mut arg0.phase2_whitelist, v0);
            };
            0x2::table::add<address, u64>(&mut arg0.phase2_whitelist, v0, v2 - arg7);
        };
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::split<0x2::sui::SUI>(&mut arg1, v3, arg8), arg0.treasury_address);
        if (0x2::coin::value<0x2::sui::SUI>(&arg1) > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(arg1, v0);
        } else {
            0x2::coin::destroy_zero<0x2::sui::SUI>(arg1);
        };
    }

    public entry fun mint_public(arg0: &mut NFTCollection, arg1: 0x2::coin::Coin<0x2::sui::SUI>, arg2: &0x2::transfer_policy::TransferPolicy<NFT>, arg3: &0x2::clock::Clock, arg4: &0x2::random::Random, arg5: &mut 0x2::kiosk::Kiosk, arg6: &0x2::kiosk::KioskOwnerCap, arg7: u64, arg8: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg8);
        assert!(0x2::clock::timestamp_ms(arg3) >= arg0.mint_start, 2);
        assert!(arg7 > 0 && arg7 <= 8, 9);
        assert!(arg0.minted + arg7 <= 2700, 1);
        let v1 = 12000000000 * arg7;
        assert!(0x2::coin::value<0x2::sui::SUI>(&arg1) >= v1, 8);
        let v2 = 0;
        while (v2 < arg7) {
            let v3 = select_random_id(arg0, arg4, arg8);
            let v4 = create_nft(arg0, v3, arg8);
            arg0.minted = arg0.minted + 1;
            arg0.public_minted = arg0.public_minted + 1;
            0x2::kiosk::lock<NFT>(arg5, arg6, arg2, v4);
            let v5 = NFTMinted{
                nft_id   : 0x2::object::id<NFT>(&v4),
                token_id : v3,
                minter   : v0,
                phase    : 100,
            };
            0x2::event::emit<NFTMinted>(v5);
            v2 = v2 + 1;
        };
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::split<0x2::sui::SUI>(&mut arg1, v1, arg8), arg0.treasury_address);
        if (0x2::coin::value<0x2::sui::SUI>(&arg1) > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(arg1, v0);
        } else {
            0x2::coin::destroy_zero<0x2::sui::SUI>(arg1);
        };
    }

    public entry fun pause_minting(arg0: &AdminCap, arg1: &mut NFTCollection, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg2) == arg1.admin_address, 4);
        arg1.mint_start = 18446744073709551615;
    }

    fun remove_specific_id(arg0: &mut NFTCollection, arg1: u64) : u64 {
        let (v0, v1) = 0x1::vector::index_of<u64>(&arg0.available_ids, &arg1);
        assert!(v0, 13);
        0x1::vector::remove<u64>(&mut arg0.available_ids, v1)
    }

    public entry fun resume_minting(arg0: &AdminCap, arg1: &mut NFTCollection, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg3) == arg1.admin_address, 4);
        arg1.mint_start = arg2;
    }

    fun select_random_id(arg0: &mut NFTCollection, arg1: &0x2::random::Random, arg2: &mut 0x2::tx_context::TxContext) : u64 {
        assert!(!0x1::vector::is_empty<u64>(&arg0.available_ids), 1);
        let v0 = 0x2::random::new_generator(arg1, arg2);
        0x1::vector::swap_remove<u64>(&mut arg0.available_ids, (0x2::random::generate_u64_in_range(&mut v0, 0, (0x1::vector::length<u64>(&arg0.available_ids) as u64)) as u64))
    }

    public entry fun set_bulk_nft_attributes(arg0: &AdminCap, arg1: &mut NFTCollection, arg2: vector<u64>, arg3: vector<vector<0x1::string::String>>, arg4: vector<vector<0x1::string::String>>, arg5: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg5) == arg1.admin_address, 4);
        let v0 = 0x1::vector::length<u64>(&arg2);
        assert!(v0 == 0x1::vector::length<vector<0x1::string::String>>(&arg3) && v0 == 0x1::vector::length<vector<0x1::string::String>>(&arg4), 9);
        let v1 = 0;
        while (v1 < v0) {
            set_nft_attributes(arg0, arg1, *0x1::vector::borrow<u64>(&arg2, v1), *0x1::vector::borrow<vector<0x1::string::String>>(&arg3, v1), *0x1::vector::borrow<vector<0x1::string::String>>(&arg4, v1), arg5);
            v1 = v1 + 1;
        };
    }

    public entry fun set_bulk_nft_urls(arg0: &AdminCap, arg1: &mut NFTCollection, arg2: vector<u64>, arg3: vector<vector<u8>>, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg4) == arg1.admin_address, 4);
        assert!(0x1::vector::length<u64>(&arg2) == 0x1::vector::length<vector<u8>>(&arg3), 9);
        let v0 = 0;
        while (v0 < 0x1::vector::length<u64>(&arg2)) {
            set_nft_url(arg0, arg1, *0x1::vector::borrow<u64>(&arg2, v0), *0x1::vector::borrow<vector<u8>>(&arg3, v0), arg4);
            v0 = v0 + 1;
        };
    }

    public entry fun set_nft_attributes(arg0: &AdminCap, arg1: &mut NFTCollection, arg2: u64, arg3: vector<0x1::string::String>, arg4: vector<0x1::string::String>, arg5: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg5) == arg1.admin_address, 4);
        assert!(arg2 > 0 && arg2 <= 2700, 13);
        assert!(0x1::vector::length<0x1::string::String>(&arg3) == 0x1::vector::length<0x1::string::String>(&arg4), 9);
        let v0 = 0x2::vec_map::empty<0x1::string::String, 0x1::string::String>();
        let v1 = 0;
        while (v1 < 0x1::vector::length<0x1::string::String>(&arg3)) {
            0x2::vec_map::insert<0x1::string::String, 0x1::string::String>(&mut v0, *0x1::vector::borrow<0x1::string::String>(&arg3, v1), *0x1::vector::borrow<0x1::string::String>(&arg4, v1));
            v1 = v1 + 1;
        };
        if (0x2::table::contains<u64, 0x2::vec_map::VecMap<0x1::string::String, 0x1::string::String>>(&arg1.preset_attributes, arg2)) {
            *0x2::table::borrow_mut<u64, 0x2::vec_map::VecMap<0x1::string::String, 0x1::string::String>>(&mut arg1.preset_attributes, arg2) = v0;
        } else {
            0x2::table::add<u64, 0x2::vec_map::VecMap<0x1::string::String, 0x1::string::String>>(&mut arg1.preset_attributes, arg2, v0);
        };
    }

    public entry fun set_nft_url(arg0: &AdminCap, arg1: &mut NFTCollection, arg2: u64, arg3: vector<u8>, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg4) == arg1.admin_address, 4);
        assert!(arg2 > 0 && arg2 <= 2700, 13);
        if (0x2::table::contains<u64, 0x2::url::Url>(&arg1.preset_urls, arg2)) {
            *0x2::table::borrow_mut<u64, 0x2::url::Url>(&mut arg1.preset_urls, arg2) = 0x2::url::new_unsafe_from_bytes(arg3);
        } else {
            0x2::table::add<u64, 0x2::url::Url>(&mut arg1.preset_urls, arg2, 0x2::url::new_unsafe_from_bytes(arg3));
        };
    }

    public entry fun set_phase_end(arg0: &AdminCap, arg1: &mut NFTCollection, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg3) == arg1.admin_address, 4);
        arg1.phase_end = arg2;
        let v0 = PhaseEnded{timestamp: arg2};
        0x2::event::emit<PhaseEnded>(v0);
    }

    public entry fun start_minting(arg0: &AdminCap, arg1: &mut NFTCollection, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg3) == arg1.admin_address, 4);
        arg1.mint_start = arg2;
        arg1.phase_end = arg2 + 1800000;
        let v0 = PhaseStarted{timestamp: arg2};
        0x2::event::emit<PhaseStarted>(v0);
    }

    public entry fun team_mint(arg0: &AdminCap, arg1: &mut NFTCollection, arg2: &0x2::transfer_policy::TransferPolicy<NFT>, arg3: &mut 0x2::kiosk::Kiosk, arg4: &0x2::kiosk::KioskOwnerCap, arg5: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg5) == arg1.admin_address, 4);
        let v0 = 1;
        while (v0 <= 100) {
            let v1 = remove_specific_id(arg1, v0);
            let v2 = create_nft(arg1, v1, arg5);
            arg1.minted = arg1.minted + 1;
            0x2::kiosk::lock<NFT>(arg3, arg4, arg2, v2);
            let v3 = NFTMinted{
                nft_id   : 0x2::object::id<NFT>(&v2),
                token_id : v1,
                minter   : 0x2::tx_context::sender(arg5),
                phase    : 0,
            };
            0x2::event::emit<NFTMinted>(v3);
            v0 = v0 + 1;
        };
    }

    public entry fun team_mint_batch(arg0: &AdminCap, arg1: &mut NFTCollection, arg2: &0x2::transfer_policy::TransferPolicy<NFT>, arg3: &mut 0x2::kiosk::Kiosk, arg4: &0x2::kiosk::KioskOwnerCap, arg5: u64, arg6: u64, arg7: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg7) == arg1.admin_address, 4);
        while (arg5 <= arg6) {
            let v0 = remove_specific_id(arg1, arg5);
            let v1 = create_nft(arg1, v0, arg7);
            arg1.minted = arg1.minted + 1;
            0x2::kiosk::lock<NFT>(arg3, arg4, arg2, v1);
            let v2 = NFTMinted{
                nft_id   : 0x2::object::id<NFT>(&v1),
                token_id : v0,
                minter   : 0x2::tx_context::sender(arg7),
                phase    : 0,
            };
            0x2::event::emit<NFTMinted>(v2);
            arg5 = arg5 + 1;
        };
    }

    fun u64_to_string(arg0: u64) : 0x1::string::String {
        if (arg0 == 0) {
            return 0x1::string::utf8(b"0")
        };
        let v0 = 0x1::vector::empty<u8>();
        while (arg0 != 0) {
            0x1::vector::push_back<u8>(&mut v0, ((arg0 % 10 + 48) as u8));
            arg0 = arg0 / 10;
        };
        0x1::vector::reverse<u8>(&mut v0);
        0x1::string::utf8(v0)
    }

    public entry fun update_admin_address(arg0: &AdminCap, arg1: &mut NFTCollection, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg3) == arg1.admin_address, 4);
        arg1.admin_address = arg2;
        let v0 = AdminUpdated{new_admin: arg2};
        0x2::event::emit<AdminUpdated>(v0);
    }

    // decompiled from Move bytecode v6
}

