module 0xf75f70c333292e9258ba1c6fc44e6bccfa2bd03bbed6d8e6e343f06f3b22a7f4::suimilios {
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

    struct SUIMILIOS has drop {
        dummy_field: bool,
    }

    struct AdminCap has store, key {
        id: 0x2::object::UID,
    }

    struct NFTCollection has key {
        id: 0x2::object::UID,
        minted: u64,
        premint_minted: u64,
        phase1_minted: u64,
        phase2_minted: u64,
        phase3_minted: u64,
        public_minted: u64,
        available_ids: vector<u64>,
        phase1_whitelist: 0x2::table::Table<address, u64>,
        phase2_whitelist: 0x2::table::Table<address, u64>,
        phase3_whitelist: 0x2::table::Table<address, u64>,
        preset_attributes: 0x2::table::Table<u64, 0x2::vec_map::VecMap<0x1::string::String, 0x1::string::String>>,
        preset_urls: 0x2::table::Table<u64, 0x2::url::Url>,
        mint_start: u64,
        phase_end: u64,
        admin_address: address,
        treasury_address: address,
        phase1_price: u64,
        phase2_price: u64,
        phase3_price: u64,
        public_price: u64,
    }

    struct SUIMILIOS_NFT has store, key {
        id: 0x2::object::UID,
        name: 0x1::string::String,
        description: 0x1::string::String,
        image_url: 0x2::url::Url,
        attributes: 0x2::vec_map::VecMap<0x1::string::String, 0x1::string::String>,
        token_id: u64,
    }

    public entry fun add_to_phase1(arg0: &AdminCap, arg1: &mut NFTCollection, arg2: vector<address>, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0;
        while (v0 < 0x1::vector::length<address>(&arg2)) {
            let v1 = *0x1::vector::borrow<address>(&arg2, v0);
            if (0x2::table::contains<address, u64>(&arg1.phase1_whitelist, v1)) {
                0x2::table::remove<address, u64>(&mut arg1.phase1_whitelist, v1);
            };
            0x2::table::add<address, u64>(&mut arg1.phase1_whitelist, v1, 5);
            let v2 = WhitelistAdded{
                phase      : 1,
                address    : v1,
                mint_limit : 5,
            };
            0x2::event::emit<WhitelistAdded>(v2);
            v0 = v0 + 1;
        };
    }

    public entry fun add_to_phase2(arg0: &AdminCap, arg1: &mut NFTCollection, arg2: vector<address>, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0;
        while (v0 < 0x1::vector::length<address>(&arg2)) {
            let v1 = *0x1::vector::borrow<address>(&arg2, v0);
            if (0x2::table::contains<address, u64>(&arg1.phase2_whitelist, v1)) {
                0x2::table::remove<address, u64>(&mut arg1.phase2_whitelist, v1);
            };
            0x2::table::add<address, u64>(&mut arg1.phase2_whitelist, v1, 25);
            let v2 = WhitelistAdded{
                phase      : 2,
                address    : v1,
                mint_limit : 25,
            };
            0x2::event::emit<WhitelistAdded>(v2);
            v0 = v0 + 1;
        };
    }

    public entry fun add_to_phase3(arg0: &AdminCap, arg1: &mut NFTCollection, arg2: vector<address>, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0;
        while (v0 < 0x1::vector::length<address>(&arg2)) {
            let v1 = *0x1::vector::borrow<address>(&arg2, v0);
            if (0x2::table::contains<address, u64>(&arg1.phase3_whitelist, v1)) {
                0x2::table::remove<address, u64>(&mut arg1.phase3_whitelist, v1);
            };
            0x2::table::add<address, u64>(&mut arg1.phase3_whitelist, v1, 1);
            let v2 = WhitelistAdded{
                phase      : 3,
                address    : v1,
                mint_limit : 1,
            };
            0x2::event::emit<WhitelistAdded>(v2);
            v0 = v0 + 1;
        };
    }

    public fun are_phases_active(arg0: &NFTCollection, arg1: &0x2::clock::Clock) : bool {
        let v0 = 0x2::clock::timestamp_ms(arg1);
        v0 >= arg0.mint_start && v0 <= arg0.phase_end
    }

    public entry fun burn_nft(arg0: SUIMILIOS_NFT, arg1: &mut NFTCollection) {
        let SUIMILIOS_NFT {
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

    fun create_nft(arg0: &NFTCollection, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) : SUIMILIOS_NFT {
        let v0 = 0x1::string::utf8(b"Suimilios #");
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
            0x1::string::append(&mut v3, 0x1::string::utf8(b".png"));
            0x2::url::new_unsafe_from_bytes(*0x1::string::as_bytes(&v3))
        };
        SUIMILIOS_NFT{
            id          : 0x2::object::new(arg2),
            name        : v0,
            description : 0x1::string::utf8(b"3,333 nostalgic schizos living on the sui chain."),
            image_url   : v2,
            attributes  : v1,
            token_id    : arg1,
        }
    }

    public entry fun end_phases(arg0: &AdminCap, arg1: &mut NFTCollection, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        arg1.phase_end = 0x2::clock::timestamp_ms(arg2);
        let v0 = PhaseEnded{timestamp: arg1.phase_end};
        0x2::event::emit<PhaseEnded>(v0);
    }

    public fun get_admin_address(arg0: &NFTCollection) : address {
        arg0.admin_address
    }

    public fun get_collection_stats(arg0: &NFTCollection) : (u64, u64, u64, u64, u64, u64, u64) {
        (arg0.minted, arg0.premint_minted, arg0.phase1_minted, arg0.phase2_minted, arg0.phase3_minted, arg0.public_minted, 0x1::vector::length<u64>(&arg0.available_ids))
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

    public fun get_phase3_allocations(arg0: &NFTCollection, arg1: address) : (bool, u64) {
        let v0 = 0x2::table::contains<address, u64>(&arg0.phase3_whitelist, arg1);
        let v1 = if (v0) {
            *0x2::table::borrow<address, u64>(&arg0.phase3_whitelist, arg1)
        } else {
            0
        };
        (v0, v1)
    }

    public fun get_phase3_minted(arg0: &NFTCollection) : u64 {
        arg0.phase3_minted
    }

    public fun get_premint_minted(arg0: &NFTCollection) : u64 {
        arg0.premint_minted
    }

    public fun get_public_minted(arg0: &NFTCollection) : u64 {
        arg0.public_minted
    }

    public fun get_remaining_mints(arg0: &NFTCollection, arg1: address, arg2: u8) : u64 {
        if (arg2 == 1 && 0x2::table::contains<address, u64>(&arg0.phase1_whitelist, arg1)) {
            *0x2::table::borrow<address, u64>(&arg0.phase1_whitelist, arg1)
        } else if (arg2 == 2 && 0x2::table::contains<address, u64>(&arg0.phase2_whitelist, arg1)) {
            *0x2::table::borrow<address, u64>(&arg0.phase2_whitelist, arg1)
        } else if (arg2 == 3 && 0x2::table::contains<address, u64>(&arg0.phase3_whitelist, arg1)) {
            *0x2::table::borrow<address, u64>(&arg0.phase3_whitelist, arg1)
        } else {
            0
        }
    }

    public fun get_remaining_nfts(arg0: &NFTCollection) : u64 {
        0x1::vector::length<u64>(&arg0.available_ids)
    }

    public fun get_token_id(arg0: &SUIMILIOS_NFT) : u64 {
        arg0.token_id
    }

    public fun get_total_available_mints(arg0: &NFTCollection, arg1: address) : u64 {
        let (_, v1, _, v3) = get_wallet_allocations(arg0, arg1);
        let (_, v5) = get_phase3_allocations(arg0, arg1);
        v1 + v3 + v5
    }

    public fun get_total_mint_price(arg0: &NFTCollection, arg1: address) : u64 {
        let (_, v1, _, v3) = get_wallet_allocations(arg0, arg1);
        let (_, v5) = get_phase3_allocations(arg0, arg1);
        v1 * arg0.phase1_price + v3 * arg0.phase2_price + v5 * arg0.phase3_price
    }

    public fun get_total_supply() : u64 {
        3333
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

    fun init(arg0: SUIMILIOS, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::package::claim<SUIMILIOS>(arg0, arg1);
        let v1 = NFTCollection{
            id                : 0x2::object::new(arg1),
            minted            : 0,
            premint_minted    : 0,
            phase1_minted     : 0,
            phase2_minted     : 0,
            phase3_minted     : 0,
            public_minted     : 0,
            available_ids     : 0x1::vector::empty<u64>(),
            phase1_whitelist  : 0x2::table::new<address, u64>(arg1),
            phase2_whitelist  : 0x2::table::new<address, u64>(arg1),
            phase3_whitelist  : 0x2::table::new<address, u64>(arg1),
            preset_attributes : 0x2::table::new<u64, 0x2::vec_map::VecMap<0x1::string::String, 0x1::string::String>>(arg1),
            preset_urls       : 0x2::table::new<u64, 0x2::url::Url>(arg1),
            mint_start        : 1758920400000,
            phase_end         : 1758920400000 + 3600000,
            admin_address     : @0xa3585953487cf72b94233df0895ae7f6bb05c873772f6ad956dac9cafb946d5d,
            treasury_address  : @0xa3585953487cf72b94233df0895ae7f6bb05c873772f6ad956dac9cafb946d5d,
            phase1_price      : 4000000000,
            phase2_price      : 5000000000,
            phase3_price      : 0,
            public_price      : 6000000000,
        };
        let v2 = 1;
        while (v2 <= 3333) {
            0x1::vector::push_back<u64>(&mut v1.available_ids, v2);
            v2 = v2 + 1;
        };
        let v3 = AdminCap{id: 0x2::object::new(arg1)};
        let v4 = 0x2::display::new<SUIMILIOS_NFT>(&v0, arg1);
        0x2::display::add<SUIMILIOS_NFT>(&mut v4, 0x1::string::utf8(b"name"), 0x1::string::utf8(b"{name}"));
        0x2::display::add<SUIMILIOS_NFT>(&mut v4, 0x1::string::utf8(b"description"), 0x1::string::utf8(b"{description}"));
        0x2::display::add<SUIMILIOS_NFT>(&mut v4, 0x1::string::utf8(b"image_url"), 0x1::string::utf8(b"https://walrus.doonies.net/suimilios/{token_id}.png"));
        0x2::display::add<SUIMILIOS_NFT>(&mut v4, 0x1::string::utf8(b"attributes"), 0x1::string::utf8(b"{attributes}"));
        0x2::display::update_version<SUIMILIOS_NFT>(&mut v4);
        let (v5, v6) = 0x2::transfer_policy::new<SUIMILIOS_NFT>(&v0, arg1);
        0x2::transfer::transfer<AdminCap>(v3, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::package::Publisher>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::display::Display<SUIMILIOS_NFT>>(v4, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::transfer_policy::TransferPolicyCap<SUIMILIOS_NFT>>(v6, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::transfer_policy::TransferPolicy<SUIMILIOS_NFT>>(v5);
        0x2::transfer::share_object<NFTCollection>(v1);
    }

    public fun is_public_mint_active(arg0: &NFTCollection, arg1: &0x2::clock::Clock) : bool {
        0x2::clock::timestamp_ms(arg1) > arg0.phase_end
    }

    public fun is_token_minted(arg0: &NFTCollection, arg1: u64) : bool {
        !0x1::vector::contains<u64>(&arg0.available_ids, &arg1)
    }

    public fun is_whitelisted_for_phase(arg0: &NFTCollection, arg1: address, arg2: u8) : bool {
        arg2 == 1 && 0x2::table::contains<address, u64>(&arg0.phase1_whitelist, arg1) || arg2 == 2 && 0x2::table::contains<address, u64>(&arg0.phase2_whitelist, arg1) || arg2 == 3 && 0x2::table::contains<address, u64>(&arg0.phase3_whitelist, arg1)
    }

    public entry fun mint_all(arg0: &mut NFTCollection, arg1: 0x2::coin::Coin<0x2::sui::SUI>, arg2: &0x2::transfer_policy::TransferPolicy<SUIMILIOS_NFT>, arg3: &0x2::clock::Clock, arg4: &0x2::random::Random, arg5: &mut 0x2::kiosk::Kiosk, arg6: &0x2::kiosk::KioskOwnerCap, arg7: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg7);
        let v1 = 0x2::clock::timestamp_ms(arg3);
        assert!(v1 >= arg0.mint_start, 2);
        assert!(v1 <= arg0.phase_end, 3);
        let (v2, v3, v4, v5) = get_wallet_allocations(arg0, v0);
        let (v6, v7) = get_phase3_allocations(arg0, v0);
        let v8 = if (v2) {
            true
        } else if (v4) {
            true
        } else {
            v6
        };
        assert!(v8, 4);
        let v9 = if (v2) {
            if (arg0.phase1_minted >= 333) {
                0
            } else {
                333 - arg0.phase1_minted
            }
        } else {
            0
        };
        let v10 = if (v4) {
            if (arg0.phase2_minted >= 1111) {
                0
            } else {
                1111 - arg0.phase2_minted
            }
        } else {
            0
        };
        let v11 = if (v6) {
            if (arg0.phase3_minted >= 0) {
                0
            } else {
                0 - arg0.phase3_minted
            }
        } else {
            0
        };
        let v12 = if (v3 > v9) {
            v9
        } else {
            v3
        };
        let v13 = v12;
        if (v12 > 10) {
            v13 = 10;
        };
        let v14 = if (v5 > v10) {
            v10
        } else {
            v5
        };
        let v15 = v14;
        if (v14 > 10) {
            v15 = 10;
        };
        let v16 = if (v7 > v11) {
            v11
        } else {
            v7
        };
        let v17 = v16;
        if (v16 > 10) {
            v17 = 10;
        };
        let v18 = v13 + v15 + v17;
        let v19 = v13 * arg0.phase1_price + v15 * arg0.phase2_price + v17 * arg0.phase3_price;
        assert!(v18 > 0, 5);
        assert!(arg0.minted + v18 <= 3333, 1);
        assert!(0x2::coin::value<0x2::sui::SUI>(&arg1) >= v19, 6);
        let v20 = 0;
        if (v2 && v13 > 0) {
            while (v20 < v13) {
                let v21 = select_random_id(arg0, arg4, arg7);
                let v22 = create_nft(arg0, v21, arg7);
                arg0.minted = arg0.minted + 1;
                arg0.phase1_minted = arg0.phase1_minted + 1;
                0x2::kiosk::lock<SUIMILIOS_NFT>(arg5, arg6, arg2, v22);
                let v23 = NFTMinted{
                    nft_id   : 0x2::object::id<SUIMILIOS_NFT>(&v22),
                    token_id : v21,
                    minter   : v0,
                    phase    : 1,
                };
                0x2::event::emit<NFTMinted>(v23);
                v20 = v20 + 1;
            };
            let v24 = v3 - v13;
            if (v24 > 0) {
                if (0x2::table::contains<address, u64>(&arg0.phase1_whitelist, v0)) {
                    *0x2::table::borrow_mut<address, u64>(&mut arg0.phase1_whitelist, v0) = v24;
                } else {
                    0x2::table::add<address, u64>(&mut arg0.phase1_whitelist, v0, v24);
                };
            } else if (0x2::table::contains<address, u64>(&arg0.phase1_whitelist, v0)) {
                0x2::table::remove<address, u64>(&mut arg0.phase1_whitelist, v0);
            };
        };
        if (v4 && v15 > 0) {
            let v25 = 0;
            while (v25 < v15) {
                let v26 = select_random_id(arg0, arg4, arg7);
                let v27 = create_nft(arg0, v26, arg7);
                arg0.minted = arg0.minted + 1;
                arg0.phase2_minted = arg0.phase2_minted + 1;
                0x2::kiosk::lock<SUIMILIOS_NFT>(arg5, arg6, arg2, v27);
                let v28 = NFTMinted{
                    nft_id   : 0x2::object::id<SUIMILIOS_NFT>(&v27),
                    token_id : v26,
                    minter   : v0,
                    phase    : 2,
                };
                0x2::event::emit<NFTMinted>(v28);
                v25 = v25 + 1;
                v20 = v20 + 1;
            };
            let v29 = v5 - v15;
            if (v29 > 0) {
                if (0x2::table::contains<address, u64>(&arg0.phase2_whitelist, v0)) {
                    *0x2::table::borrow_mut<address, u64>(&mut arg0.phase2_whitelist, v0) = v29;
                } else {
                    0x2::table::add<address, u64>(&mut arg0.phase2_whitelist, v0, v29);
                };
            } else if (0x2::table::contains<address, u64>(&arg0.phase2_whitelist, v0)) {
                0x2::table::remove<address, u64>(&mut arg0.phase2_whitelist, v0);
            };
        };
        if (v6 && v17 > 0) {
            let v30 = 0;
            while (v30 < v17) {
                let v31 = select_random_id(arg0, arg4, arg7);
                let v32 = create_nft(arg0, v31, arg7);
                arg0.minted = arg0.minted + 1;
                arg0.phase3_minted = arg0.phase3_minted + 1;
                0x2::kiosk::lock<SUIMILIOS_NFT>(arg5, arg6, arg2, v32);
                let v33 = NFTMinted{
                    nft_id   : 0x2::object::id<SUIMILIOS_NFT>(&v32),
                    token_id : v31,
                    minter   : v0,
                    phase    : 3,
                };
                0x2::event::emit<NFTMinted>(v33);
                v30 = v30 + 1;
                v20 = v20 + 1;
            };
            let v34 = v7 - v17;
            if (v34 > 0) {
                if (0x2::table::contains<address, u64>(&arg0.phase3_whitelist, v0)) {
                    *0x2::table::borrow_mut<address, u64>(&mut arg0.phase3_whitelist, v0) = v34;
                } else {
                    0x2::table::add<address, u64>(&mut arg0.phase3_whitelist, v0, v34);
                };
            } else if (0x2::table::contains<address, u64>(&arg0.phase3_whitelist, v0)) {
                0x2::table::remove<address, u64>(&mut arg0.phase3_whitelist, v0);
            };
        };
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::split<0x2::sui::SUI>(&mut arg1, v19, arg7), arg0.treasury_address);
        if (0x2::coin::value<0x2::sui::SUI>(&arg1) > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(arg1, v0);
        } else {
            0x2::coin::destroy_zero<0x2::sui::SUI>(arg1);
        };
    }

    public entry fun mint_phase1(arg0: &mut NFTCollection, arg1: 0x2::coin::Coin<0x2::sui::SUI>, arg2: &0x2::transfer_policy::TransferPolicy<SUIMILIOS_NFT>, arg3: &0x2::clock::Clock, arg4: &0x2::random::Random, arg5: &mut 0x2::kiosk::Kiosk, arg6: &0x2::kiosk::KioskOwnerCap, arg7: u64, arg8: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg8);
        let v1 = 0x2::clock::timestamp_ms(arg3);
        assert!(v1 >= arg0.mint_start, 2);
        assert!(v1 <= arg0.phase_end, 3);
        assert!(0x2::table::contains<address, u64>(&arg0.phase1_whitelist, v0), 4);
        assert!(arg7 > 0 && arg7 <= 10, 7);
        let v2 = *0x2::table::borrow<address, u64>(&arg0.phase1_whitelist, v0);
        assert!(v2 > 0 && arg7 <= v2, 5);
        assert!(arg0.phase1_minted + arg7 <= 333, 9);
        assert!(arg0.minted + arg7 <= 3333, 1);
        let v3 = arg0.phase1_price * arg7;
        assert!(0x2::coin::value<0x2::sui::SUI>(&arg1) >= v3, 6);
        let v4 = 0;
        while (v4 < arg7) {
            let v5 = select_random_id(arg0, arg4, arg8);
            let v6 = create_nft(arg0, v5, arg8);
            arg0.minted = arg0.minted + 1;
            arg0.phase1_minted = arg0.phase1_minted + 1;
            0x2::kiosk::lock<SUIMILIOS_NFT>(arg5, arg6, arg2, v6);
            let v7 = NFTMinted{
                nft_id   : 0x2::object::id<SUIMILIOS_NFT>(&v6),
                token_id : v5,
                minter   : v0,
                phase    : 1,
            };
            0x2::event::emit<NFTMinted>(v7);
            v4 = v4 + 1;
        };
        if (v2 > 0) {
            let v8 = v2 - arg7;
            if (v8 > 0) {
                if (0x2::table::contains<address, u64>(&arg0.phase1_whitelist, v0)) {
                    *0x2::table::borrow_mut<address, u64>(&mut arg0.phase1_whitelist, v0) = v8;
                } else {
                    0x2::table::add<address, u64>(&mut arg0.phase1_whitelist, v0, v8);
                };
            } else if (0x2::table::contains<address, u64>(&arg0.phase1_whitelist, v0)) {
                0x2::table::remove<address, u64>(&mut arg0.phase1_whitelist, v0);
            };
        };
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::split<0x2::sui::SUI>(&mut arg1, v3, arg8), arg0.treasury_address);
        if (0x2::coin::value<0x2::sui::SUI>(&arg1) > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(arg1, v0);
        } else {
            0x2::coin::destroy_zero<0x2::sui::SUI>(arg1);
        };
    }

    public entry fun mint_phase2(arg0: &mut NFTCollection, arg1: 0x2::coin::Coin<0x2::sui::SUI>, arg2: &0x2::transfer_policy::TransferPolicy<SUIMILIOS_NFT>, arg3: &0x2::clock::Clock, arg4: &0x2::random::Random, arg5: &mut 0x2::kiosk::Kiosk, arg6: &0x2::kiosk::KioskOwnerCap, arg7: u64, arg8: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg8);
        let v1 = 0x2::clock::timestamp_ms(arg3);
        assert!(v1 >= arg0.mint_start, 2);
        assert!(v1 <= arg0.phase_end, 3);
        assert!(0x2::table::contains<address, u64>(&arg0.phase2_whitelist, v0), 4);
        assert!(arg7 > 0 && arg7 <= 10, 7);
        let v2 = *0x2::table::borrow<address, u64>(&arg0.phase2_whitelist, v0);
        assert!(v2 > 0 && arg7 <= v2, 5);
        assert!(arg0.phase2_minted + arg7 <= 1111, 9);
        assert!(arg0.minted + arg7 <= 3333, 1);
        let v3 = arg0.phase2_price * arg7;
        assert!(0x2::coin::value<0x2::sui::SUI>(&arg1) >= v3, 6);
        let v4 = 0;
        while (v4 < arg7) {
            let v5 = select_random_id(arg0, arg4, arg8);
            let v6 = create_nft(arg0, v5, arg8);
            arg0.minted = arg0.minted + 1;
            arg0.phase2_minted = arg0.phase2_minted + 1;
            0x2::kiosk::lock<SUIMILIOS_NFT>(arg5, arg6, arg2, v6);
            let v7 = NFTMinted{
                nft_id   : 0x2::object::id<SUIMILIOS_NFT>(&v6),
                token_id : v5,
                minter   : v0,
                phase    : 2,
            };
            0x2::event::emit<NFTMinted>(v7);
            v4 = v4 + 1;
        };
        if (v2 > 0) {
            let v8 = v2 - arg7;
            if (v8 > 0) {
                if (0x2::table::contains<address, u64>(&arg0.phase2_whitelist, v0)) {
                    *0x2::table::borrow_mut<address, u64>(&mut arg0.phase2_whitelist, v0) = v8;
                } else {
                    0x2::table::add<address, u64>(&mut arg0.phase2_whitelist, v0, v8);
                };
            } else if (0x2::table::contains<address, u64>(&arg0.phase2_whitelist, v0)) {
                0x2::table::remove<address, u64>(&mut arg0.phase2_whitelist, v0);
            };
        };
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::split<0x2::sui::SUI>(&mut arg1, v3, arg8), arg0.treasury_address);
        if (0x2::coin::value<0x2::sui::SUI>(&arg1) > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(arg1, v0);
        } else {
            0x2::coin::destroy_zero<0x2::sui::SUI>(arg1);
        };
    }

    public entry fun mint_phase3(arg0: &mut NFTCollection, arg1: 0x2::coin::Coin<0x2::sui::SUI>, arg2: &0x2::transfer_policy::TransferPolicy<SUIMILIOS_NFT>, arg3: &0x2::clock::Clock, arg4: &0x2::random::Random, arg5: &mut 0x2::kiosk::Kiosk, arg6: &0x2::kiosk::KioskOwnerCap, arg7: u64, arg8: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg8);
        let v1 = 0x2::clock::timestamp_ms(arg3);
        assert!(v1 >= arg0.mint_start, 2);
        assert!(v1 <= arg0.phase_end, 3);
        assert!(0x2::table::contains<address, u64>(&arg0.phase3_whitelist, v0), 4);
        assert!(arg7 > 0 && arg7 <= 10, 7);
        let v2 = *0x2::table::borrow<address, u64>(&arg0.phase3_whitelist, v0);
        assert!(v2 > 0 && arg7 <= v2, 5);
        assert!(arg0.phase3_minted + arg7 <= 0, 9);
        assert!(arg0.minted + arg7 <= 3333, 1);
        let v3 = arg0.phase3_price * arg7;
        assert!(0x2::coin::value<0x2::sui::SUI>(&arg1) >= v3, 6);
        let v4 = 0;
        while (v4 < arg7) {
            let v5 = select_random_id(arg0, arg4, arg8);
            let v6 = create_nft(arg0, v5, arg8);
            arg0.minted = arg0.minted + 1;
            arg0.phase3_minted = arg0.phase3_minted + 1;
            0x2::kiosk::lock<SUIMILIOS_NFT>(arg5, arg6, arg2, v6);
            let v7 = NFTMinted{
                nft_id   : 0x2::object::id<SUIMILIOS_NFT>(&v6),
                token_id : v5,
                minter   : v0,
                phase    : 3,
            };
            0x2::event::emit<NFTMinted>(v7);
            v4 = v4 + 1;
        };
        if (v2 > 0) {
            let v8 = v2 - arg7;
            if (v8 > 0) {
                if (0x2::table::contains<address, u64>(&arg0.phase3_whitelist, v0)) {
                    *0x2::table::borrow_mut<address, u64>(&mut arg0.phase3_whitelist, v0) = v8;
                } else {
                    0x2::table::add<address, u64>(&mut arg0.phase3_whitelist, v0, v8);
                };
            } else if (0x2::table::contains<address, u64>(&arg0.phase3_whitelist, v0)) {
                0x2::table::remove<address, u64>(&mut arg0.phase3_whitelist, v0);
            };
        };
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::split<0x2::sui::SUI>(&mut arg1, v3, arg8), arg0.treasury_address);
        if (0x2::coin::value<0x2::sui::SUI>(&arg1) > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(arg1, v0);
        } else {
            0x2::coin::destroy_zero<0x2::sui::SUI>(arg1);
        };
    }

    public entry fun mint_public(arg0: &mut NFTCollection, arg1: 0x2::coin::Coin<0x2::sui::SUI>, arg2: &0x2::transfer_policy::TransferPolicy<SUIMILIOS_NFT>, arg3: &0x2::clock::Clock, arg4: &0x2::random::Random, arg5: &mut 0x2::kiosk::Kiosk, arg6: &0x2::kiosk::KioskOwnerCap, arg7: u64, arg8: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg8);
        let v1 = 0x2::clock::timestamp_ms(arg3);
        assert!(v1 >= arg0.mint_start, 2);
        assert!(v1 > arg0.phase_end, 2);
        assert!(arg7 > 0 && arg7 <= 10, 7);
        assert!(arg0.minted + arg7 <= 3333, 1);
        let v2 = arg0.public_price * arg7;
        assert!(0x2::coin::value<0x2::sui::SUI>(&arg1) >= v2, 6);
        let v3 = 0;
        while (v3 < arg7) {
            let v4 = select_random_id(arg0, arg4, arg8);
            let v5 = create_nft(arg0, v4, arg8);
            arg0.minted = arg0.minted + 1;
            arg0.public_minted = arg0.public_minted + 1;
            0x2::kiosk::lock<SUIMILIOS_NFT>(arg5, arg6, arg2, v5);
            let v6 = NFTMinted{
                nft_id   : 0x2::object::id<SUIMILIOS_NFT>(&v5),
                token_id : v4,
                minter   : v0,
                phase    : 100,
            };
            0x2::event::emit<NFTMinted>(v6);
            v3 = v3 + 1;
        };
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::split<0x2::sui::SUI>(&mut arg1, v2, arg8), arg0.treasury_address);
        if (0x2::coin::value<0x2::sui::SUI>(&arg1) > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(arg1, v0);
        } else {
            0x2::coin::destroy_zero<0x2::sui::SUI>(arg1);
        };
    }

    public entry fun pause_minting(arg0: &AdminCap, arg1: &mut NFTCollection, arg2: &mut 0x2::tx_context::TxContext) {
        arg1.mint_start = 18446744073709551615;
    }

    fun remove_specific_id(arg0: &mut NFTCollection, arg1: u64) : u64 {
        let (v0, v1) = 0x1::vector::index_of<u64>(&arg0.available_ids, &arg1);
        assert!(v0, 8);
        0x1::vector::remove<u64>(&mut arg0.available_ids, v1)
    }

    public entry fun resume_minting(arg0: &AdminCap, arg1: &mut NFTCollection, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        arg1.mint_start = arg2;
    }

    fun select_random_id(arg0: &mut NFTCollection, arg1: &0x2::random::Random, arg2: &mut 0x2::tx_context::TxContext) : u64 {
        assert!(!0x1::vector::is_empty<u64>(&arg0.available_ids), 1);
        let v0 = 0x2::random::new_generator(arg1, arg2);
        0x1::vector::swap_remove<u64>(&mut arg0.available_ids, (0x2::random::generate_u64_in_range(&mut v0, 0, (0x1::vector::length<u64>(&arg0.available_ids) as u64)) as u64))
    }

    public entry fun set_bulk_nft_attributes(arg0: &AdminCap, arg1: &mut NFTCollection, arg2: vector<u64>, arg3: vector<vector<0x1::string::String>>, arg4: vector<vector<0x1::string::String>>, arg5: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x1::vector::length<u64>(&arg2);
        assert!(v0 == 0x1::vector::length<vector<0x1::string::String>>(&arg3) && v0 == 0x1::vector::length<vector<0x1::string::String>>(&arg4), 7);
        let v1 = 0;
        while (v1 < v0) {
            set_nft_attributes(arg0, arg1, *0x1::vector::borrow<u64>(&arg2, v1), *0x1::vector::borrow<vector<0x1::string::String>>(&arg3, v1), *0x1::vector::borrow<vector<0x1::string::String>>(&arg4, v1), arg5);
            v1 = v1 + 1;
        };
    }

    public entry fun set_bulk_nft_urls(arg0: &AdminCap, arg1: &mut NFTCollection, arg2: vector<u64>, arg3: vector<vector<u8>>, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(0x1::vector::length<u64>(&arg2) == 0x1::vector::length<vector<u8>>(&arg3), 7);
        let v0 = 0;
        while (v0 < 0x1::vector::length<u64>(&arg2)) {
            set_nft_url(arg0, arg1, *0x1::vector::borrow<u64>(&arg2, v0), *0x1::vector::borrow<vector<u8>>(&arg3, v0), arg4);
            v0 = v0 + 1;
        };
    }

    public entry fun set_nft_attributes(arg0: &AdminCap, arg1: &mut NFTCollection, arg2: u64, arg3: vector<0x1::string::String>, arg4: vector<0x1::string::String>, arg5: &mut 0x2::tx_context::TxContext) {
        assert!(arg2 > 0 && arg2 <= 3333, 8);
        assert!(0x1::vector::length<0x1::string::String>(&arg3) == 0x1::vector::length<0x1::string::String>(&arg4), 7);
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
        assert!(arg2 > 0 && arg2 <= 3333, 8);
        if (0x2::table::contains<u64, 0x2::url::Url>(&arg1.preset_urls, arg2)) {
            *0x2::table::borrow_mut<u64, 0x2::url::Url>(&mut arg1.preset_urls, arg2) = 0x2::url::new_unsafe_from_bytes(arg3);
        } else {
            0x2::table::add<u64, 0x2::url::Url>(&mut arg1.preset_urls, arg2, 0x2::url::new_unsafe_from_bytes(arg3));
        };
    }

    public entry fun set_phase_end(arg0: &AdminCap, arg1: &mut NFTCollection, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        arg1.phase_end = arg2;
        let v0 = PhaseEnded{timestamp: arg2};
        0x2::event::emit<PhaseEnded>(v0);
    }

    public entry fun start_minting(arg0: &AdminCap, arg1: &mut NFTCollection, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        arg1.mint_start = arg2;
        arg1.phase_end = arg2 + 3600000;
        let v0 = PhaseStarted{timestamp: arg2};
        0x2::event::emit<PhaseStarted>(v0);
    }

    public entry fun team_mint_batch(arg0: &AdminCap, arg1: &mut NFTCollection, arg2: &0x2::transfer_policy::TransferPolicy<SUIMILIOS_NFT>, arg3: &mut 0x2::kiosk::Kiosk, arg4: &0x2::kiosk::KioskOwnerCap, arg5: u64, arg6: u64, arg7: &mut 0x2::tx_context::TxContext) {
        while (arg5 <= arg6) {
            let v0 = remove_specific_id(arg1, arg5);
            let v1 = create_nft(arg1, v0, arg7);
            arg1.minted = arg1.minted + 1;
            if (v0 >= 1 && v0 <= 100) {
                arg1.premint_minted = arg1.premint_minted + 1;
            };
            0x2::kiosk::lock<SUIMILIOS_NFT>(arg3, arg4, arg2, v1);
            let v2 = NFTMinted{
                nft_id   : 0x2::object::id<SUIMILIOS_NFT>(&v1),
                token_id : v0,
                minter   : 0x2::tx_context::sender(arg7),
                phase    : 0,
            };
            0x2::event::emit<NFTMinted>(v2);
            arg5 = arg5 + 1;
        };
    }

    public entry fun transfer_admin_cap(arg0: AdminCap, arg1: address, arg2: &mut 0x2::tx_context::TxContext) {
        let AdminCap { id: v0 } = arg0;
        0x2::object::delete(v0);
        let v1 = AdminCap{id: 0x2::object::new(arg2)};
        0x2::transfer::transfer<AdminCap>(v1, arg1);
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
        arg1.admin_address = arg2;
        let v0 = AdminUpdated{new_admin: arg2};
        0x2::event::emit<AdminUpdated>(v0);
    }

    public entry fun update_phase1_price(arg0: &AdminCap, arg1: &mut NFTCollection, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        arg1.phase1_price = arg2;
        let v0 = PriceUpdated{
            phase     : 1,
            new_price : arg2,
        };
        0x2::event::emit<PriceUpdated>(v0);
    }

    public entry fun update_phase2_price(arg0: &AdminCap, arg1: &mut NFTCollection, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        arg1.phase2_price = arg2;
        let v0 = PriceUpdated{
            phase     : 2,
            new_price : arg2,
        };
        0x2::event::emit<PriceUpdated>(v0);
    }

    public entry fun update_phase3_price(arg0: &AdminCap, arg1: &mut NFTCollection, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        arg1.phase3_price = arg2;
        let v0 = PriceUpdated{
            phase     : 3,
            new_price : arg2,
        };
        0x2::event::emit<PriceUpdated>(v0);
    }

    public entry fun update_public_price(arg0: &AdminCap, arg1: &mut NFTCollection, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        arg1.public_price = arg2;
        let v0 = PriceUpdated{
            phase     : 100,
            new_price : arg2,
        };
        0x2::event::emit<PriceUpdated>(v0);
    }

    // decompiled from Move bytecode v6
}

