module 0xe0fa7b75a3dc8137b38bceb0c0c21c10e0f57c408fe9068694f58fd21e071925::pawtato_heroes {
    struct PausedKey has copy, drop, store {
        dummy_field: bool,
    }

    struct VersionKey has copy, drop, store {
        dummy_field: bool,
    }

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
        abort 0
    }

    fun check_version(arg0: &HeroCollection) {
        let v0 = VersionKey{dummy_field: false};
        assert!(0x2::dynamic_field::exists_<VersionKey>(&arg0.id, v0), 13);
        assert!(*0x2::dynamic_field::borrow<VersionKey, u64>(&arg0.id, v0) == 1, 13);
    }

    public entry fun clear_preset_attributes(arg0: &HeroAdminCap, arg1: &mut HeroCollection, arg2: u64, arg3: u64, arg4: &mut 0x2::tx_context::TxContext) {
        abort 0
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
        abort 0
    }

    public fun get_attributes(arg0: &HERO) : &0x2::vec_map::VecMap<0x1::string::String, 0x1::string::String> {
        &arg0.attributes
    }

    public fun get_token_id(arg0: &HERO) : u64 {
        arg0.token_id
    }

    public fun get_wallet_allocations(arg0: &HeroCollection, arg1: address) : (bool, u64, bool, u64, bool, u64) {
        abort 0
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

    public fun is_collection_paused(arg0: &HeroCollection) : bool {
        let v0 = PausedKey{dummy_field: false};
        0x2::dynamic_field::exists_<PausedKey>(&arg0.id, v0) && *0x2::dynamic_field::borrow<PausedKey, bool>(&arg0.id, v0)
    }

    public entry fun mint_all(arg0: &mut HeroCollection, arg1: 0x2::coin::Coin<0x2::sui::SUI>, arg2: &0x2::transfer_policy::TransferPolicy<HERO>, arg3: &0x2::clock::Clock, arg4: &0x2::random::Random, arg5: &mut 0x2::kiosk::Kiosk, arg6: &0x2::kiosk::KioskOwnerCap, arg7: &mut 0x2::tx_context::TxContext) {
        abort 0
    }

    public entry fun mint_phase(arg0: &mut HeroCollection, arg1: u8, arg2: 0x2::coin::Coin<0x2::sui::SUI>, arg3: &0x2::transfer_policy::TransferPolicy<HERO>, arg4: &0x2::clock::Clock, arg5: &0x2::random::Random, arg6: &mut 0x2::kiosk::Kiosk, arg7: &0x2::kiosk::KioskOwnerCap, arg8: u64, arg9: &mut 0x2::tx_context::TxContext) {
        abort 0
    }

    public entry fun mint_public(arg0: &mut HeroCollection, arg1: 0x2::coin::Coin<0x2::sui::SUI>, arg2: &0x2::transfer_policy::TransferPolicy<HERO>, arg3: &0x2::clock::Clock, arg4: &0x2::random::Random, arg5: &mut 0x2::kiosk::Kiosk, arg6: &0x2::kiosk::KioskOwnerCap, arg7: u64, arg8: &mut 0x2::tx_context::TxContext) {
        abort 0
    }

    public entry fun pause_minting(arg0: &HeroAdminCap, arg1: &mut HeroCollection, arg2: &mut 0x2::tx_context::TxContext) {
        abort 0
    }

    public entry fun resume_minting(arg0: &HeroAdminCap, arg1: &mut HeroCollection, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        abort 0
    }

    public fun set_attributes(arg0: &0xc3dc70c7ca20eaf2e1c52826cf5b9fb2712e34a1d6f3de5f4dfb727c32d62c36::pawtato_admin::NFTUpgradeCap, arg1: &HeroCollection, arg2: &mut HERO, arg3: 0x2::vec_map::VecMap<0x1::string::String, 0x1::string::String>) {
        assert!(!is_collection_paused(arg1), 12);
        check_version(arg1);
        let v0 = 0x2::vec_map::keys<0x1::string::String, 0x1::string::String>(&arg3);
        let v1 = 0;
        while (v1 < 0x1::vector::length<0x1::string::String>(&v0)) {
            let v2 = *0x1::vector::borrow<0x1::string::String>(&v0, v1);
            if (0x2::vec_map::contains<0x1::string::String, 0x1::string::String>(&arg2.attributes, &v2)) {
                *0x2::vec_map::get_mut<0x1::string::String, 0x1::string::String>(&mut arg2.attributes, &v2) = *0x2::vec_map::get<0x1::string::String, 0x1::string::String>(&arg3, &v2);
            } else {
                0x2::vec_map::insert<0x1::string::String, 0x1::string::String>(&mut arg2.attributes, v2, *0x2::vec_map::get<0x1::string::String, 0x1::string::String>(&arg3, &v2));
            };
            v1 = v1 + 1;
        };
    }

    public entry fun set_bulk_hero_attributes(arg0: &HeroAdminCap, arg1: &mut HeroCollection, arg2: vector<u64>, arg3: vector<vector<0x1::string::String>>, arg4: vector<vector<0x1::string::String>>, arg5: &mut 0x2::tx_context::TxContext) {
        abort 0
    }

    public entry fun set_collection_paused(arg0: &HeroAdminCap, arg1: &mut HeroCollection, arg2: bool) {
        let v0 = PausedKey{dummy_field: false};
        if (0x2::dynamic_field::exists_<PausedKey>(&arg1.id, v0)) {
            *0x2::dynamic_field::borrow_mut<PausedKey, bool>(&mut arg1.id, v0) = arg2;
        } else {
            0x2::dynamic_field::add<PausedKey, bool>(&mut arg1.id, v0, arg2);
        };
    }

    public entry fun set_phase_end(arg0: &HeroAdminCap, arg1: &mut HeroCollection, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        abort 0
    }

    public entry fun start_minting(arg0: &HeroAdminCap, arg1: &mut HeroCollection, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        abort 0
    }

    public entry fun team_mint_batch(arg0: &HeroAdminCap, arg1: &mut HeroCollection, arg2: &0x2::transfer_policy::TransferPolicy<HERO>, arg3: &mut 0x2::kiosk::Kiosk, arg4: &0x2::kiosk::KioskOwnerCap, arg5: u64, arg6: u64, arg7: &mut 0x2::tx_context::TxContext) {
        abort 0
    }

    public entry fun update_admin_address(arg0: &HeroAdminCap, arg1: &mut HeroCollection, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        arg1.admin_address = arg2;
        let v0 = AdminUpdated{new_admin: arg2};
        0x2::event::emit<AdminUpdated>(v0);
    }

    public entry fun update_price(arg0: &HeroAdminCap, arg1: &mut HeroCollection, arg2: u8, arg3: u64, arg4: &mut 0x2::tx_context::TxContext) {
        abort 0
    }

    public entry fun upgrade_version(arg0: &HeroAdminCap, arg1: &mut HeroCollection) {
        let v0 = VersionKey{dummy_field: false};
        if (0x2::dynamic_field::exists_<VersionKey>(&arg1.id, v0)) {
            assert!(1 > *0x2::dynamic_field::borrow<VersionKey, u64>(&arg1.id, v0), 14);
            *0x2::dynamic_field::borrow_mut<VersionKey, u64>(&mut arg1.id, v0) = 1;
        } else {
            0x2::dynamic_field::add<VersionKey, u64>(&mut arg1.id, v0, 1);
        };
    }

    // decompiled from Move bytecode v6
}

