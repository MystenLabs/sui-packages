module 0xe0fa7b75a3dc8137b38bceb0c0c21c10e0f57c408fe9068694f58fd21e071925::pawtato_heroes {
    struct HeroMinted has copy, drop {
        hero_id: 0x2::object::ID,
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

    struct PriceUpdated has copy, drop {
        phase: u8,
        new_price: u64,
    }

    struct AdminUpdated has copy, drop {
        new_admin: address,
    }

    struct PAWTATO_HEROES has drop {
        dummy_field: bool,
    }

    struct HeroAdminCap has store, key {
        id: 0x2::object::UID,
    }

    struct HeroCollection has key {
        id: 0x2::object::UID,
        minted: u64,
        phase1_minted: u64,
        phase2_minted: u64,
        phase3_minted: u64,
        public_minted: u64,
        available_ids: vector<u64>,
        phase1_whitelist: 0x2::table::Table<address, u64>,
        phase2_whitelist: 0x2::table::Table<address, u64>,
        phase3_whitelist: 0x2::table::Table<address, u64>,
        preset_attributes: 0x2::table::Table<u64, 0x2::vec_map::VecMap<0x1::string::String, 0x1::string::String>>,
        mint_start: u64,
        phase_end: u64,
        admin_address: address,
        treasury_address: address,
        phase1_price: u64,
        phase2_price: u64,
        phase3_price: u64,
        public_price: u64,
    }

    struct HERO has store, key {
        id: 0x2::object::UID,
        name: 0x1::string::String,
        description: 0x1::string::String,
        image_url: 0x2::url::Url,
        attributes: 0x2::vec_map::VecMap<0x1::string::String, 0x1::string::String>,
        token_id: u64,
    }

    public entry fun add_to_whitelist(arg0: &HeroAdminCap, arg1: &mut HeroCollection, arg2: u8, arg3: vector<address>, arg4: u64, arg5: &mut 0x2::tx_context::TxContext) {
        assert!(arg2 >= 1 && arg2 <= 3, 4);
        let v0 = 0;
        while (v0 < 0x1::vector::length<address>(&arg3)) {
            let v1 = *0x1::vector::borrow<address>(&arg3, v0);
            if (arg2 == 1) {
                if (0x2::table::contains<address, u64>(&arg1.phase1_whitelist, v1)) {
                    0x2::table::remove<address, u64>(&mut arg1.phase1_whitelist, v1);
                };
                0x2::table::add<address, u64>(&mut arg1.phase1_whitelist, v1, arg4);
            } else if (arg2 == 2) {
                if (0x2::table::contains<address, u64>(&arg1.phase2_whitelist, v1)) {
                    0x2::table::remove<address, u64>(&mut arg1.phase2_whitelist, v1);
                };
                0x2::table::add<address, u64>(&mut arg1.phase2_whitelist, v1, arg4);
            } else {
                if (0x2::table::contains<address, u64>(&arg1.phase3_whitelist, v1)) {
                    0x2::table::remove<address, u64>(&mut arg1.phase3_whitelist, v1);
                };
                0x2::table::add<address, u64>(&mut arg1.phase3_whitelist, v1, arg4);
            };
            v0 = v0 + 1;
        };
    }

    public entry fun clear_preset_attributes(arg0: &HeroAdminCap, arg1: &mut HeroCollection, arg2: u64, arg3: u64, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(arg2 > 0 && arg2 <= 30000, 9);
        assert!(arg3 > 0 && arg3 <= 30000, 9);
        assert!(arg2 <= arg3, 9);
        while (arg2 <= arg3) {
            if (0x2::table::contains<u64, 0x2::vec_map::VecMap<0x1::string::String, 0x1::string::String>>(&arg1.preset_attributes, arg2)) {
                0x2::table::remove<u64, 0x2::vec_map::VecMap<0x1::string::String, 0x1::string::String>>(&mut arg1.preset_attributes, arg2);
            };
            arg2 = arg2 + 1;
        };
    }

    fun create_hero(arg0: &HeroCollection, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) : HERO {
        let v0 = 0x1::string::utf8(b"Pawtato Hero #");
        0x1::string::append(&mut v0, 0xa9d503feaf655e76df1de94b034bcdd9c4caa7cba5311269506b07100d03ee72::pawtato_helpers::u64_to_string(arg1));
        assert!(0x2::table::contains<u64, 0x2::vec_map::VecMap<0x1::string::String, 0x1::string::String>>(&arg0.preset_attributes, arg1), 11);
        let v1 = 0x1::string::utf8(b"https://img.pawtato.app/hero/");
        0x1::string::append(&mut v1, 0xa9d503feaf655e76df1de94b034bcdd9c4caa7cba5311269506b07100d03ee72::pawtato_helpers::u64_to_string(arg1));
        0x1::string::append(&mut v1, 0x1::string::utf8(b".png"));
        HERO{
            id          : 0x2::object::new(arg2),
            name        : v0,
            description : 0x1::string::utf8(b"Pawtato Heroes are the Adventurers of Pawtato Land."),
            image_url   : 0x2::url::new_unsafe_from_bytes(*0x1::string::as_bytes(&v1)),
            attributes  : *0x2::table::borrow<u64, 0x2::vec_map::VecMap<0x1::string::String, 0x1::string::String>>(&arg0.preset_attributes, arg1),
            token_id    : arg1,
        }
    }

    public entry fun end_phases(arg0: &HeroAdminCap, arg1: &mut HeroCollection, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        arg1.phase_end = 0x2::clock::timestamp_ms(arg2);
        let v0 = PhaseEnded{timestamp: arg1.phase_end};
        0x2::event::emit<PhaseEnded>(v0);
    }

    public fun get_attributes(arg0: &HERO) : &0x2::vec_map::VecMap<0x1::string::String, 0x1::string::String> {
        &arg0.attributes
    }

    public fun get_token_id(arg0: &HERO) : u64 {
        arg0.token_id
    }

    public fun get_wallet_allocations(arg0: &HeroCollection, arg1: address) : (bool, u64, bool, u64, bool, u64) {
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
        let v4 = 0x2::table::contains<address, u64>(&arg0.phase3_whitelist, arg1);
        let v5 = if (v4) {
            *0x2::table::borrow<address, u64>(&arg0.phase3_whitelist, arg1)
        } else {
            0
        };
        (v0, v1, v2, v3, v4, v5)
    }

    fun init(arg0: PAWTATO_HEROES, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::package::claim<PAWTATO_HEROES>(arg0, arg1);
        let v1 = HeroCollection{
            id                : 0x2::object::new(arg1),
            minted            : 0,
            phase1_minted     : 0,
            phase2_minted     : 0,
            phase3_minted     : 0,
            public_minted     : 0,
            available_ids     : 0x1::vector::empty<u64>(),
            phase1_whitelist  : 0x2::table::new<address, u64>(arg1),
            phase2_whitelist  : 0x2::table::new<address, u64>(arg1),
            phase3_whitelist  : 0x2::table::new<address, u64>(arg1),
            preset_attributes : 0x2::table::new<u64, 0x2::vec_map::VecMap<0x1::string::String, 0x1::string::String>>(arg1),
            mint_start        : 1762002000000,
            phase_end         : 1762002000000 + 3600000,
            admin_address     : 0x2::tx_context::sender(arg1),
            treasury_address  : @0x844dd285ddfc12628f51f1091e22495657230b188c260ae692ad6bfa20aa0b2,
            phase1_price      : 5000000000,
            phase2_price      : 6000000000,
            phase3_price      : 7000000000,
            public_price      : 8000000000,
        };
        let v2 = 1;
        while (v2 <= 30000) {
            0x1::vector::push_back<u64>(&mut v1.available_ids, v2);
            v2 = v2 + 1;
        };
        let v3 = HeroAdminCap{id: 0x2::object::new(arg1)};
        let v4 = 0x2::display::new<HERO>(&v0, arg1);
        0x2::display::add<HERO>(&mut v4, 0x1::string::utf8(b"name"), 0x1::string::utf8(b"{name}"));
        0x2::display::add<HERO>(&mut v4, 0x1::string::utf8(b"description"), 0x1::string::utf8(b"{description}"));
        0x2::display::add<HERO>(&mut v4, 0x1::string::utf8(b"image_url"), 0x1::string::utf8(b"https://img.pawtato.app/hero/{token_id}.png"));
        0x2::display::add<HERO>(&mut v4, 0x1::string::utf8(b"attributes"), 0x1::string::utf8(b"{attributes}"));
        0x2::display::update_version<HERO>(&mut v4);
        let (v5, v6) = 0x2::transfer_policy::new<HERO>(&v0, arg1);
        0x2::transfer::transfer<HeroAdminCap>(v3, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::package::Publisher>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::display::Display<HERO>>(v4, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::transfer_policy::TransferPolicyCap<HERO>>(v6, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::transfer_policy::TransferPolicy<HERO>>(v5);
        0x2::transfer::share_object<HeroCollection>(v1);
    }

    public entry fun mint_all(arg0: &mut HeroCollection, arg1: 0x2::coin::Coin<0x2::sui::SUI>, arg2: &0x2::transfer_policy::TransferPolicy<HERO>, arg3: &0x2::clock::Clock, arg4: &0x2::random::Random, arg5: &mut 0x2::kiosk::Kiosk, arg6: &0x2::kiosk::KioskOwnerCap, arg7: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg7);
        let v1 = 0x2::clock::timestamp_ms(arg3);
        assert!(v1 >= arg0.mint_start, 2);
        assert!(v1 <= arg0.phase_end, 3);
        let (v2, v3, v4, v5, v6, v7) = get_wallet_allocations(arg0, v0);
        let v8 = if (v2) {
            true
        } else if (v4) {
            true
        } else {
            v6
        };
        assert!(v8, 5);
        let v9 = if (v2) {
            if (arg0.phase1_minted >= 7500) {
                0
            } else {
                7500 - arg0.phase1_minted
            }
        } else {
            0
        };
        let v10 = if (v4) {
            if (arg0.phase2_minted >= 5000) {
                0
            } else {
                5000 - arg0.phase2_minted
            }
        } else {
            0
        };
        let v11 = if (v6) {
            if (arg0.phase3_minted >= 3000) {
                0
            } else {
                3000 - arg0.phase3_minted
            }
        } else {
            0
        };
        let v12 = if (v3 > v9) {
            v9
        } else {
            v3
        };
        let v13 = if (v5 > v10) {
            v10
        } else {
            v5
        };
        let v14 = if (v7 > v11) {
            v11
        } else {
            v7
        };
        let v15 = v12 + v13 + v14;
        let v16 = v12 * arg0.phase1_price + v13 * arg0.phase2_price + v14 * arg0.phase3_price;
        assert!(v15 > 0, 6);
        assert!(arg0.minted + v15 <= 30000, 1);
        assert!(0x2::coin::value<0x2::sui::SUI>(&arg1) >= v16, 7);
        let v17 = 0;
        if (v2 && v12 > 0) {
            while (v17 < v12) {
                let v18 = select_random_id(arg0, arg4, arg7);
                let v19 = create_hero(arg0, v18, arg7);
                arg0.minted = arg0.minted + 1;
                arg0.phase1_minted = arg0.phase1_minted + 1;
                0x2::kiosk::lock<HERO>(arg5, arg6, arg2, v19);
                let v20 = HeroMinted{
                    hero_id  : 0x2::object::id<HERO>(&v19),
                    token_id : v18,
                    minter   : v0,
                    phase    : 1,
                };
                0x2::event::emit<HeroMinted>(v20);
                v17 = v17 + 1;
            };
            if (0x2::table::contains<address, u64>(&arg0.phase1_whitelist, v0)) {
                0x2::table::remove<address, u64>(&mut arg0.phase1_whitelist, v0);
            };
            0x2::table::add<address, u64>(&mut arg0.phase1_whitelist, v0, 0);
        };
        if (v4 && v13 > 0) {
            let v21 = 0;
            while (v21 < v13) {
                let v22 = select_random_id(arg0, arg4, arg7);
                let v23 = create_hero(arg0, v22, arg7);
                arg0.minted = arg0.minted + 1;
                arg0.phase2_minted = arg0.phase2_minted + 1;
                0x2::kiosk::lock<HERO>(arg5, arg6, arg2, v23);
                let v24 = HeroMinted{
                    hero_id  : 0x2::object::id<HERO>(&v23),
                    token_id : v22,
                    minter   : v0,
                    phase    : 2,
                };
                0x2::event::emit<HeroMinted>(v24);
                v21 = v21 + 1;
                v17 = v17 + 1;
            };
            if (0x2::table::contains<address, u64>(&arg0.phase2_whitelist, v0)) {
                0x2::table::remove<address, u64>(&mut arg0.phase2_whitelist, v0);
            };
            0x2::table::add<address, u64>(&mut arg0.phase2_whitelist, v0, 0);
        };
        if (v6 && v14 > 0) {
            let v25 = 0;
            while (v25 < v14) {
                let v26 = select_random_id(arg0, arg4, arg7);
                let v27 = create_hero(arg0, v26, arg7);
                arg0.minted = arg0.minted + 1;
                arg0.phase3_minted = arg0.phase3_minted + 1;
                0x2::kiosk::lock<HERO>(arg5, arg6, arg2, v27);
                let v28 = HeroMinted{
                    hero_id  : 0x2::object::id<HERO>(&v27),
                    token_id : v26,
                    minter   : v0,
                    phase    : 3,
                };
                0x2::event::emit<HeroMinted>(v28);
                v25 = v25 + 1;
                v17 = v17 + 1;
            };
            if (0x2::table::contains<address, u64>(&arg0.phase3_whitelist, v0)) {
                0x2::table::remove<address, u64>(&mut arg0.phase3_whitelist, v0);
            };
            0x2::table::add<address, u64>(&mut arg0.phase3_whitelist, v0, 0);
        };
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::split<0x2::sui::SUI>(&mut arg1, v16, arg7), arg0.treasury_address);
        if (0x2::coin::value<0x2::sui::SUI>(&arg1) > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(arg1, v0);
        } else {
            0x2::coin::destroy_zero<0x2::sui::SUI>(arg1);
        };
    }

    public entry fun mint_phase(arg0: &mut HeroCollection, arg1: u8, arg2: 0x2::coin::Coin<0x2::sui::SUI>, arg3: &0x2::transfer_policy::TransferPolicy<HERO>, arg4: &0x2::clock::Clock, arg5: &0x2::random::Random, arg6: &mut 0x2::kiosk::Kiosk, arg7: &0x2::kiosk::KioskOwnerCap, arg8: u64, arg9: &mut 0x2::tx_context::TxContext) {
        assert!(arg1 >= 1 && arg1 <= 3, 4);
        let v0 = 0x2::tx_context::sender(arg9);
        let v1 = 0x2::clock::timestamp_ms(arg4);
        assert!(v1 >= arg0.mint_start, 2);
        assert!(v1 <= arg0.phase_end, 3);
        let (v2, v3, v4, v5) = if (arg1 == 1) {
            let v2 = &arg0.phase1_whitelist;
            (v2, arg0.phase1_minted, 7500, arg0.phase1_price)
        } else {
            let (v6, v7, v8, v9) = if (arg1 == 2) {
                (&arg0.phase2_whitelist, arg0.phase2_minted, 5000, arg0.phase2_price)
            } else {
                (&arg0.phase3_whitelist, arg0.phase3_minted, 3000, arg0.phase3_price)
            };
            let v2 = v6;
            (v2, v7, v8, v9)
        };
        assert!(0x2::table::contains<address, u64>(v2, v0), 5);
        assert!(arg8 > 0, 8);
        let v10 = *0x2::table::borrow<address, u64>(v2, v0);
        assert!(v10 > 0 && arg8 <= v10, 6);
        assert!(v3 + arg8 <= v4, 10);
        assert!(arg0.minted + arg8 <= 30000, 1);
        let v11 = v5 * arg8;
        assert!(0x2::coin::value<0x2::sui::SUI>(&arg2) >= v11, 7);
        let v12 = 0;
        while (v12 < arg8) {
            let v13 = select_random_id(arg0, arg5, arg9);
            let v14 = create_hero(arg0, v13, arg9);
            arg0.minted = arg0.minted + 1;
            if (arg1 == 1) {
                arg0.phase1_minted = arg0.phase1_minted + 1;
            } else if (arg1 == 2) {
                arg0.phase2_minted = arg0.phase2_minted + 1;
            } else {
                arg0.phase3_minted = arg0.phase3_minted + 1;
            };
            0x2::kiosk::lock<HERO>(arg6, arg7, arg3, v14);
            let v15 = HeroMinted{
                hero_id  : 0x2::object::id<HERO>(&v14),
                token_id : v13,
                minter   : v0,
                phase    : arg1,
            };
            0x2::event::emit<HeroMinted>(v15);
            v12 = v12 + 1;
        };
        if (arg1 == 1) {
            if (0x2::table::contains<address, u64>(&arg0.phase1_whitelist, v0)) {
                0x2::table::remove<address, u64>(&mut arg0.phase1_whitelist, v0);
            };
            0x2::table::add<address, u64>(&mut arg0.phase1_whitelist, v0, v10 - arg8);
        } else if (arg1 == 2) {
            if (0x2::table::contains<address, u64>(&arg0.phase2_whitelist, v0)) {
                0x2::table::remove<address, u64>(&mut arg0.phase2_whitelist, v0);
            };
            0x2::table::add<address, u64>(&mut arg0.phase2_whitelist, v0, v10 - arg8);
        } else {
            if (0x2::table::contains<address, u64>(&arg0.phase3_whitelist, v0)) {
                0x2::table::remove<address, u64>(&mut arg0.phase3_whitelist, v0);
            };
            0x2::table::add<address, u64>(&mut arg0.phase3_whitelist, v0, v10 - arg8);
        };
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::split<0x2::sui::SUI>(&mut arg2, v11, arg9), arg0.treasury_address);
        if (0x2::coin::value<0x2::sui::SUI>(&arg2) > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(arg2, v0);
        } else {
            0x2::coin::destroy_zero<0x2::sui::SUI>(arg2);
        };
    }

    public entry fun mint_public(arg0: &mut HeroCollection, arg1: 0x2::coin::Coin<0x2::sui::SUI>, arg2: &0x2::transfer_policy::TransferPolicy<HERO>, arg3: &0x2::clock::Clock, arg4: &0x2::random::Random, arg5: &mut 0x2::kiosk::Kiosk, arg6: &0x2::kiosk::KioskOwnerCap, arg7: u64, arg8: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg8);
        let v1 = 0x2::clock::timestamp_ms(arg3);
        assert!(v1 >= arg0.mint_start, 2);
        assert!(v1 > arg0.phase_end, 2);
        assert!(arg7 > 0 && arg7 <= 10, 8);
        assert!(arg0.minted + arg7 <= 30000, 1);
        let v2 = arg0.public_price * arg7;
        assert!(0x2::coin::value<0x2::sui::SUI>(&arg1) >= v2, 7);
        let v3 = 0;
        while (v3 < arg7) {
            let v4 = select_random_id(arg0, arg4, arg8);
            let v5 = create_hero(arg0, v4, arg8);
            arg0.minted = arg0.minted + 1;
            arg0.public_minted = arg0.public_minted + 1;
            0x2::kiosk::lock<HERO>(arg5, arg6, arg2, v5);
            let v6 = HeroMinted{
                hero_id  : 0x2::object::id<HERO>(&v5),
                token_id : v4,
                minter   : v0,
                phase    : 100,
            };
            0x2::event::emit<HeroMinted>(v6);
            v3 = v3 + 1;
        };
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::split<0x2::sui::SUI>(&mut arg1, v2, arg8), arg0.treasury_address);
        if (0x2::coin::value<0x2::sui::SUI>(&arg1) > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(arg1, v0);
        } else {
            0x2::coin::destroy_zero<0x2::sui::SUI>(arg1);
        };
    }

    public entry fun pause_minting(arg0: &HeroAdminCap, arg1: &mut HeroCollection, arg2: &mut 0x2::tx_context::TxContext) {
        arg1.mint_start = 18446744073709551615;
    }

    fun remove_specific_id(arg0: &mut HeroCollection, arg1: u64) : u64 {
        let (v0, v1) = 0x1::vector::index_of<u64>(&arg0.available_ids, &arg1);
        assert!(v0, 9);
        0x1::vector::remove<u64>(&mut arg0.available_ids, v1)
    }

    public entry fun resume_minting(arg0: &HeroAdminCap, arg1: &mut HeroCollection, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        arg1.mint_start = arg2;
    }

    fun select_random_id(arg0: &mut HeroCollection, arg1: &0x2::random::Random, arg2: &mut 0x2::tx_context::TxContext) : u64 {
        assert!(!0x1::vector::is_empty<u64>(&arg0.available_ids), 1);
        let v0 = 0x2::random::new_generator(arg1, arg2);
        0x1::vector::swap_remove<u64>(&mut arg0.available_ids, 0x2::random::generate_u64_in_range(&mut v0, 0, 0x1::vector::length<u64>(&arg0.available_ids) - 1))
    }

    public entry fun set_bulk_hero_attributes(arg0: &HeroAdminCap, arg1: &mut HeroCollection, arg2: vector<u64>, arg3: vector<vector<0x1::string::String>>, arg4: vector<vector<0x1::string::String>>, arg5: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x1::vector::length<u64>(&arg2);
        assert!(v0 == 0x1::vector::length<vector<0x1::string::String>>(&arg3) && v0 == 0x1::vector::length<vector<0x1::string::String>>(&arg4), 8);
        let v1 = 0;
        while (v1 < v0) {
            let v2 = *0x1::vector::borrow<u64>(&arg2, v1);
            assert!(v2 > 0 && v2 <= 30000, 9);
            let v3 = 0x1::vector::borrow<vector<0x1::string::String>>(&arg3, v1);
            let v4 = 0x1::vector::borrow<vector<0x1::string::String>>(&arg4, v1);
            let v5 = 0x1::vector::length<0x1::string::String>(v3);
            assert!(v5 == 0x1::vector::length<0x1::string::String>(v4), 8);
            let v6 = 0x2::vec_map::empty<0x1::string::String, 0x1::string::String>();
            let v7 = 0;
            while (v7 < v5) {
                0x2::vec_map::insert<0x1::string::String, 0x1::string::String>(&mut v6, *0x1::vector::borrow<0x1::string::String>(v3, v7), *0x1::vector::borrow<0x1::string::String>(v4, v7));
                v7 = v7 + 1;
            };
            if (0x2::table::contains<u64, 0x2::vec_map::VecMap<0x1::string::String, 0x1::string::String>>(&arg1.preset_attributes, v2)) {
                *0x2::table::borrow_mut<u64, 0x2::vec_map::VecMap<0x1::string::String, 0x1::string::String>>(&mut arg1.preset_attributes, v2) = v6;
            } else {
                0x2::table::add<u64, 0x2::vec_map::VecMap<0x1::string::String, 0x1::string::String>>(&mut arg1.preset_attributes, v2, v6);
            };
            v1 = v1 + 1;
        };
    }

    public entry fun set_phase_end(arg0: &HeroAdminCap, arg1: &mut HeroCollection, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        arg1.phase_end = arg2;
        let v0 = PhaseEnded{timestamp: arg2};
        0x2::event::emit<PhaseEnded>(v0);
    }

    public entry fun start_minting(arg0: &HeroAdminCap, arg1: &mut HeroCollection, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        arg1.mint_start = arg2;
        arg1.phase_end = arg2 + 3600000;
        let v0 = PhaseStarted{timestamp: arg2};
        0x2::event::emit<PhaseStarted>(v0);
    }

    public entry fun team_mint_batch(arg0: &HeroAdminCap, arg1: &mut HeroCollection, arg2: &0x2::transfer_policy::TransferPolicy<HERO>, arg3: &mut 0x2::kiosk::Kiosk, arg4: &0x2::kiosk::KioskOwnerCap, arg5: u64, arg6: u64, arg7: &mut 0x2::tx_context::TxContext) {
        while (arg5 <= arg6) {
            let v0 = remove_specific_id(arg1, arg5);
            let v1 = create_hero(arg1, v0, arg7);
            arg1.minted = arg1.minted + 1;
            0x2::kiosk::lock<HERO>(arg3, arg4, arg2, v1);
            let v2 = HeroMinted{
                hero_id  : 0x2::object::id<HERO>(&v1),
                token_id : v0,
                minter   : 0x2::tx_context::sender(arg7),
                phase    : 0,
            };
            0x2::event::emit<HeroMinted>(v2);
            arg5 = arg5 + 1;
        };
    }

    public entry fun update_admin_address(arg0: &HeroAdminCap, arg1: &mut HeroCollection, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        arg1.admin_address = arg2;
        let v0 = AdminUpdated{new_admin: arg2};
        0x2::event::emit<AdminUpdated>(v0);
    }

    public(friend) fun update_hero_attribute(arg0: &mut HERO, arg1: 0x1::string::String, arg2: 0x1::string::String) {
        if (0x2::vec_map::contains<0x1::string::String, 0x1::string::String>(&arg0.attributes, &arg1)) {
            *0x2::vec_map::get_mut<0x1::string::String, 0x1::string::String>(&mut arg0.attributes, &arg1) = arg2;
        } else {
            0x2::vec_map::insert<0x1::string::String, 0x1::string::String>(&mut arg0.attributes, arg1, arg2);
        };
    }

    public entry fun update_price(arg0: &HeroAdminCap, arg1: &mut HeroCollection, arg2: u8, arg3: u64, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(arg2 >= 1 && arg2 <= 3 || arg2 == 100, 4);
        if (arg2 == 1) {
            arg1.phase1_price = arg3;
        } else if (arg2 == 2) {
            arg1.phase2_price = arg3;
        } else if (arg2 == 3) {
            arg1.phase3_price = arg3;
        } else {
            arg1.public_price = arg3;
        };
        let v0 = PriceUpdated{
            phase     : arg2,
            new_price : arg3,
        };
        0x2::event::emit<PriceUpdated>(v0);
    }

    // decompiled from Move bytecode v6
}

