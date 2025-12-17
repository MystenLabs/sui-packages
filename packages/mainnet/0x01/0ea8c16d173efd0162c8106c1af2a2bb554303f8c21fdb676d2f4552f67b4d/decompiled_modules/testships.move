module 0xac1b63c497dbbca27717ac34116d160d2d5dd31f493157013b2f2f9d19dc0229::testships {
    struct TESTSHIPS has drop {
        dummy_field: bool,
    }

    struct AdminCap has store, key {
        id: 0x2::object::UID,
    }

    struct PubKey has store, key {
        id: 0x2::object::UID,
        pubkey_bytes: vector<u8>,
        pubkey_set: bool,
    }

    struct Counter has store, key {
        id: 0x2::object::UID,
        next_id: u64,
    }

    struct Payout has store, key {
        id: 0x2::object::UID,
        recipient: address,
    }

    struct ShipNFT has store, key {
        id: 0x2::object::UID,
        ship_id: u64,
        ship_rank: u8,
        name: 0x1::string::String,
        description: 0x1::string::String,
        image_url: 0x1::string::String,
        rarity: 0x1::string::String,
        ship_type: 0x1::string::String,
        speed: u64,
        attack: u64,
        defence: u64,
        health: u64,
        upgrades: 0x1::string::String,
        specialisation: 0x1::string::String,
        attributes: 0x2::vec_map::VecMap<0x1::string::String, 0x1::string::String>,
    }

    struct MintConfig has store, key {
        id: 0x2::object::UID,
        paused: bool,
        default_rank_limit: u64,
        total_mint_limit: u64,
        per_rank_limits: 0x2::table::Table<u64, u64>,
    }

    struct MintStats has store, key {
        id: 0x2::object::UID,
        per_address: 0x2::table::Table<address, u64>,
        used_sigs: 0x2::table::Table<vector<u8>, bool>,
        per_rank: 0x2::table::Table<u64, 0x2::table::Table<address, u64>>,
    }

    struct UpgradeRule has copy, drop, store {
        input_type: 0x1::string::String,
        input_rank: u8,
        input_count: u64,
        fee: u64,
        output_type: 0x1::string::String,
        output_rank: u8,
        output_name: 0x1::string::String,
        output_description: 0x1::string::String,
        output_image_url: 0x1::string::String,
        output_rarity: 0x1::string::String,
        output_speed: u64,
        output_attack: u64,
        output_defence: u64,
        output_health: u64,
        output_upgrades: 0x1::string::String,
        output_specialisation: 0x1::string::String,
    }

    struct UpgradeManager has store, key {
        id: 0x2::object::UID,
        rules: vector<UpgradeRule>,
    }

    struct MintEvent has copy, drop {
        minter: address,
        ship_id: u64,
        amount: u64,
        timestamp_ms: u64,
        ship_rank: u64,
        signature: vector<u8>,
        name: vector<u8>,
        rarity: vector<u8>,
        ship_type: vector<u8>,
        speed: u64,
        attack: u64,
        defence: u64,
        health: u64,
        upgrades: vector<u8>,
        specialisation: vector<u8>,
    }

    struct KioskCreated has copy, drop {
        kiosk_id: 0x2::object::ID,
        cap_id: 0x2::object::ID,
    }

    struct ShipUpgraded has copy, drop {
        upgrader: address,
        new_ship_id: u64,
        new_ship_rank: u8,
        input_count: u64,
        rule_input_type: vector<u8>,
        rule_input_rank: u8,
    }

    public fun add_upgrade_rule(arg0: &AdminCap, arg1: &mut UpgradeManager, arg2: 0x1::string::String, arg3: u8, arg4: u64, arg5: u64, arg6: 0x1::string::String, arg7: u8, arg8: 0x1::string::String, arg9: 0x1::string::String, arg10: 0x1::string::String, arg11: 0x1::string::String, arg12: u64, arg13: u64, arg14: u64, arg15: u64, arg16: 0x1::string::String, arg17: 0x1::string::String) {
        let v0 = UpgradeRule{
            input_type            : arg2,
            input_rank            : arg3,
            input_count           : arg4,
            fee                   : arg5,
            output_type           : arg6,
            output_rank           : arg7,
            output_name           : arg8,
            output_description    : arg9,
            output_image_url      : arg10,
            output_rarity         : arg11,
            output_speed          : arg12,
            output_attack         : arg13,
            output_defence        : arg14,
            output_health         : arg15,
            output_upgrades       : arg16,
            output_specialisation : arg17,
        };
        0x1::vector::push_back<UpgradeRule>(&mut arg1.rules, v0);
    }

    public fun admin_edit_attributes(arg0: &AdminCap, arg1: &mut ShipNFT, arg2: u64, arg3: u64, arg4: u64, arg5: u64, arg6: 0x1::string::String, arg7: 0x1::string::String) {
        arg1.speed = arg2;
        arg1.attack = arg3;
        arg1.defence = arg4;
        arg1.health = arg5;
        arg1.upgrades = arg6;
        arg1.specialisation = arg7;
        let v0 = 0x1::string::utf8(b"Upgrades");
        if (0x2::vec_map::contains<0x1::string::String, 0x1::string::String>(&arg1.attributes, &v0)) {
            *0x2::vec_map::get_mut<0x1::string::String, 0x1::string::String>(&mut arg1.attributes, &v0) = clone_string(&arg1.upgrades);
        } else {
            0x2::vec_map::insert<0x1::string::String, 0x1::string::String>(&mut arg1.attributes, v0, clone_string(&arg1.upgrades));
        };
        let v1 = 0x1::string::utf8(b"Specialisation");
        if (0x2::vec_map::contains<0x1::string::String, 0x1::string::String>(&arg1.attributes, &v1)) {
            *0x2::vec_map::get_mut<0x1::string::String, 0x1::string::String>(&mut arg1.attributes, &v1) = clone_string(&arg1.specialisation);
        } else {
            0x2::vec_map::insert<0x1::string::String, 0x1::string::String>(&mut arg1.attributes, v1, clone_string(&arg1.specialisation));
        };
    }

    public fun admin_edit_display(arg0: &AdminCap, arg1: &mut 0x2::display::Display<ShipNFT>, arg2: 0x1::string::String, arg3: 0x1::string::String) {
        0x2::display::edit<ShipNFT>(arg1, arg2, arg3);
        0x2::display::update_version<ShipNFT>(arg1);
    }

    public fun admin_set_default_rank_limit(arg0: &AdminCap, arg1: &mut MintConfig, arg2: u64) {
        arg1.default_rank_limit = arg2;
    }

    public fun admin_set_mint_paused(arg0: &AdminCap, arg1: &mut MintConfig, arg2: bool) {
        arg1.paused = arg2;
    }

    public fun admin_set_payout_address(arg0: &AdminCap, arg1: &mut Payout, arg2: address) {
        arg1.recipient = arg2;
    }

    public fun admin_set_pubkey(arg0: &AdminCap, arg1: &mut PubKey, arg2: vector<u8>) {
        arg1.pubkey_bytes = arg2;
        arg1.pubkey_set = true;
    }

    public fun admin_set_rank_limit(arg0: &AdminCap, arg1: &mut MintConfig, arg2: u64, arg3: u64) {
        if (0x2::table::contains<u64, u64>(&arg1.per_rank_limits, arg2)) {
            *0x2::table::borrow_mut<u64, u64>(&mut arg1.per_rank_limits, arg2) = arg3;
        } else {
            0x2::table::add<u64, u64>(&mut arg1.per_rank_limits, arg2, arg3);
        };
    }

    public fun admin_set_total_mint_limit(arg0: &AdminCap, arg1: &mut MintConfig, arg2: u64) {
        arg1.total_mint_limit = arg2;
    }

    public fun admin_transfer_admincap(arg0: AdminCap, arg1: address) {
        0x2::transfer::public_transfer<AdminCap>(arg0, arg1);
    }

    public fun admin_withdraw_policy_fees(arg0: &AdminCap, arg1: &mut 0x2::transfer_policy::TransferPolicy<ShipNFT>, arg2: &0x2::transfer_policy::TransferPolicyCap<ShipNFT>, arg3: &Payout, arg4: 0x1::option::Option<u64>, arg5: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::transfer_policy::withdraw<ShipNFT>(arg1, arg2, arg4, arg5), arg3.recipient);
    }

    fun assert_minter_text_matches_prefixed64(arg0: address, arg1: &vector<u8>) {
        assert!(0x1::vector::length<u8>(arg1) == 66, 7);
        assert!(*0x1::vector::borrow<u8>(arg1, 0) == 48, 7);
        let v0 = *0x1::vector::borrow<u8>(arg1, 1);
        assert!(v0 == 120 || v0 == 88, 7);
        let v1 = 0x1::vector::empty<u8>();
        let v2 = 2;
        while (v2 < 66) {
            0x1::vector::push_back<u8>(&mut v1, *0x1::vector::borrow<u8>(arg1, v2));
            v2 = v2 + 1;
        };
        assert!(0x2::address::from_ascii_bytes(&v1) == arg0, 7);
    }

    public fun burn(arg0: ShipNFT) {
        let ShipNFT {
            id             : v0,
            ship_id        : _,
            ship_rank      : _,
            name           : _,
            description    : _,
            image_url      : _,
            rarity         : _,
            ship_type      : _,
            speed          : _,
            attack         : _,
            defence        : _,
            health         : _,
            upgrades       : _,
            specialisation : _,
            attributes     : _,
        } = arg0;
        0x2::object::delete(v0);
    }

    fun clone_string(arg0: &0x1::string::String) : 0x1::string::String {
        0x1::string::utf8(clone_vec_u8(0x1::string::as_bytes(arg0)))
    }

    fun clone_vec_u8(arg0: &vector<u8>) : vector<u8> {
        let v0 = 0x1::vector::empty<u8>();
        let v1 = 0;
        while (v1 < 0x1::vector::length<u8>(arg0)) {
            0x1::vector::push_back<u8>(&mut v0, *0x1::vector::borrow<u8>(arg0, v1));
            v1 = v1 + 1;
        };
        v0
    }

    fun create_ship(arg0: &mut Counter, arg1: u8, arg2: 0x1::string::String, arg3: 0x1::string::String, arg4: 0x1::string::String, arg5: 0x1::string::String, arg6: 0x1::string::String, arg7: u64, arg8: u64, arg9: u64, arg10: u64, arg11: 0x1::string::String, arg12: 0x1::string::String, arg13: &mut 0x2::tx_context::TxContext) : ShipNFT {
        let v0 = arg0.next_id;
        arg0.next_id = v0 + 1;
        ShipNFT{
            id             : 0x2::object::new(arg13),
            ship_id        : v0,
            ship_rank      : arg1,
            name           : clone_string(&arg2),
            description    : clone_string(&arg3),
            image_url      : clone_string(&arg4),
            rarity         : clone_string(&arg5),
            ship_type      : clone_string(&arg6),
            speed          : arg7,
            attack         : arg8,
            defence        : arg9,
            health         : arg10,
            upgrades       : clone_string(&arg11),
            specialisation : clone_string(&arg12),
            attributes     : 0x2::vec_map::empty<0x1::string::String, 0x1::string::String>(),
        }
    }

    public fun create_upgrade_manager(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = UpgradeManager{
            id    : 0x2::object::new(arg0),
            rules : 0x1::vector::empty<UpgradeRule>(),
        };
        0x2::transfer::share_object<UpgradeManager>(v0);
    }

    fun ensure_rank_bucket(arg0: &mut MintStats, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) {
        if (!0x2::table::contains<u64, 0x2::table::Table<address, u64>>(&arg0.per_rank, arg1)) {
            0x2::table::add<u64, 0x2::table::Table<address, u64>>(&mut arg0.per_rank, arg1, 0x2::table::new<address, u64>(arg2));
        };
    }

    fun expect_ship_rank(arg0: u64) : u8 {
        (arg0 as u8)
    }

    public fun get_mint_count(arg0: &MintStats, arg1: address) : u64 {
        if (0x2::table::contains<address, u64>(&arg0.per_address, arg1)) {
            *0x2::table::borrow<address, u64>(&arg0.per_address, arg1)
        } else {
            0
        }
    }

    public fun get_rank_count(arg0: &MintStats, arg1: u64, arg2: address) : u64 {
        if (0x2::table::contains<u64, 0x2::table::Table<address, u64>>(&arg0.per_rank, arg1)) {
            let v1 = 0x2::table::borrow<u64, 0x2::table::Table<address, u64>>(&arg0.per_rank, arg1);
            if (0x2::table::contains<address, u64>(v1, arg2)) {
                *0x2::table::borrow<address, u64>(v1, arg2)
            } else {
                0
            }
        } else {
            0
        }
    }

    fun get_rank_limit(arg0: &MintConfig, arg1: u64) : u64 {
        if (0x2::table::contains<u64, u64>(&arg0.per_rank_limits, arg1)) {
            *0x2::table::borrow<u64, u64>(&arg0.per_rank_limits, arg1)
        } else {
            arg0.default_rank_limit
        }
    }

    public fun get_ship_attributes(arg0: &ShipNFT) : (u64, u8, 0x1::string::String, 0x1::string::String, 0x1::string::String, 0x1::string::String, 0x1::string::String, u64, u64, u64, u64, 0x1::string::String, 0x1::string::String) {
        (arg0.ship_id, arg0.ship_rank, arg0.name, arg0.description, arg0.image_url, arg0.rarity, arg0.ship_type, arg0.speed, arg0.attack, arg0.defence, arg0.health, arg0.upgrades, arg0.specialisation)
    }

    public fun get_ship_rank(arg0: &ShipNFT) : u8 {
        arg0.ship_rank
    }

    fun init(arg0: TESTSHIPS, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = AdminCap{id: 0x2::object::new(arg1)};
        0x2::transfer::public_transfer<AdminCap>(v0, @0x495ce5fc99f68d2c8179618e0c4eda72df13efc4c04a6308ba5dc4b2b6ab6597);
        let v1 = Counter{
            id      : 0x2::object::new(arg1),
            next_id : 1,
        };
        0x2::transfer::share_object<Counter>(v1);
        let v2 = MintConfig{
            id                 : 0x2::object::new(arg1),
            paused             : false,
            default_rank_limit : 10000,
            total_mint_limit   : 10000,
            per_rank_limits    : 0x2::table::new<u64, u64>(arg1),
        };
        0x2::transfer::share_object<MintConfig>(v2);
        let v3 = PubKey{
            id           : 0x2::object::new(arg1),
            pubkey_bytes : x"02df497ab7f7548c41e20eb81ea4bbcb0c0e2aad2635ba01b2cd8102bd408919bf",
            pubkey_set   : true,
        };
        0x2::transfer::share_object<PubKey>(v3);
        let v4 = Payout{
            id        : 0x2::object::new(arg1),
            recipient : @0x495ce5fc99f68d2c8179618e0c4eda72df13efc4c04a6308ba5dc4b2b6ab6597,
        };
        0x2::transfer::share_object<Payout>(v4);
        let v5 = MintStats{
            id          : 0x2::object::new(arg1),
            per_address : 0x2::table::new<address, u64>(arg1),
            used_sigs   : 0x2::table::new<vector<u8>, bool>(arg1),
            per_rank    : 0x2::table::new<u64, 0x2::table::Table<address, u64>>(arg1),
        };
        0x2::transfer::share_object<MintStats>(v5);
        let v6 = 0x2::package::claim<TESTSHIPS>(arg0, arg1);
        let v7 = 0x1::vector::empty<0x1::string::String>();
        let v8 = &mut v7;
        0x1::vector::push_back<0x1::string::String>(v8, 0x1::string::utf8(b"name"));
        0x1::vector::push_back<0x1::string::String>(v8, 0x1::string::utf8(b"image_url"));
        0x1::vector::push_back<0x1::string::String>(v8, 0x1::string::utf8(b"project_url"));
        0x1::vector::push_back<0x1::string::String>(v8, 0x1::string::utf8(b"creator"));
        0x1::vector::push_back<0x1::string::String>(v8, 0x1::string::utf8(b"description"));
        0x1::vector::push_back<0x1::string::String>(v8, 0x1::string::utf8(b"rarity"));
        0x1::vector::push_back<0x1::string::String>(v8, 0x1::string::utf8(b"attributes"));
        let v9 = 0x1::vector::empty<0x1::string::String>();
        let v10 = &mut v9;
        0x1::vector::push_back<0x1::string::String>(v10, 0x1::string::utf8(b"{name}"));
        0x1::vector::push_back<0x1::string::String>(v10, 0x1::string::utf8(b"{image_url}"));
        0x1::vector::push_back<0x1::string::String>(v10, 0x1::string::utf8(b"https://talentum.id"));
        0x1::vector::push_back<0x1::string::String>(v10, 0x1::string::utf8(b"Coral Reef"));
        0x1::vector::push_back<0x1::string::String>(v10, 0x1::string::utf8(b"{description}"));
        0x1::vector::push_back<0x1::string::String>(v10, 0x1::string::utf8(b"{rarity}"));
        0x1::vector::push_back<0x1::string::String>(v10, 0x1::string::utf8(b"{attributes}"));
        let v11 = 0x2::display::new_with_fields<ShipNFT>(&v6, v7, v9, arg1);
        0x2::display::update_version<ShipNFT>(&mut v11);
        let (v12, v13) = 0x2::transfer_policy::new<ShipNFT>(&v6, arg1);
        0x2::transfer::public_share_object<0x2::transfer_policy::TransferPolicy<ShipNFT>>(v12);
        0x2::transfer::public_transfer<0x2::transfer_policy::TransferPolicyCap<ShipNFT>>(v13, @0x495ce5fc99f68d2c8179618e0c4eda72df13efc4c04a6308ba5dc4b2b6ab6597);
        0x2::transfer::public_transfer<0x2::package::Publisher>(v6, @0x495ce5fc99f68d2c8179618e0c4eda72df13efc4c04a6308ba5dc4b2b6ab6597);
        0x2::transfer::public_transfer<0x2::display::Display<ShipNFT>>(v11, @0x495ce5fc99f68d2c8179618e0c4eda72df13efc4c04a6308ba5dc4b2b6ab6597);
    }

    public fun is_mint_paused(arg0: &MintConfig) : bool {
        arg0.paused
    }

    fun is_valid_hash_alg(arg0: u8) : bool {
        if (arg0 == 0) {
            true
        } else if (arg0 == 1) {
            true
        } else if (arg0 == 2) {
            true
        } else {
            arg0 == 3
        }
    }

    public fun mint(arg0: &PubKey, arg1: u64, arg2: u64, arg3: u64, arg4: address, arg5: vector<u8>, arg6: u8, arg7: u64, arg8: 0x1::string::String, arg9: 0x1::string::String, arg10: 0x1::string::String, arg11: 0x1::string::String, arg12: 0x1::string::String, arg13: 0x1::string::String, arg14: &mut Counter, arg15: &MintConfig, arg16: &mut MintStats, arg17: &Payout, arg18: 0x2::coin::Coin<0x2::sui::SUI>, arg19: &0x2::transfer_policy::TransferPolicy<ShipNFT>, arg20: &0x2::clock::Clock, arg21: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::kiosk::new(arg21);
        let v2 = v1;
        let v3 = v0;
        let v4 = &mut v3;
        mint_core(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10, arg11, arg12, arg13, arg14, arg15, arg16, arg17, arg18, arg19, v4, &v2, arg20, arg21);
        let v5 = KioskCreated{
            kiosk_id : 0x2::object::id<0x2::kiosk::Kiosk>(&v3),
            cap_id   : 0x2::object::id<0x2::kiosk::KioskOwnerCap>(&v2),
        };
        0x2::event::emit<KioskCreated>(v5);
        0x2::transfer::public_share_object<0x2::kiosk::Kiosk>(v3);
        0x2::transfer::public_transfer<0x2::kiosk::KioskOwnerCap>(v2, 0x2::tx_context::sender(arg21));
    }

    fun mint_core(arg0: &PubKey, arg1: u64, arg2: u64, arg3: u64, arg4: address, arg5: vector<u8>, arg6: u8, arg7: u64, arg8: 0x1::string::String, arg9: 0x1::string::String, arg10: 0x1::string::String, arg11: 0x1::string::String, arg12: 0x1::string::String, arg13: 0x1::string::String, arg14: &mut Counter, arg15: &MintConfig, arg16: &mut MintStats, arg17: &Payout, arg18: 0x2::coin::Coin<0x2::sui::SUI>, arg19: &0x2::transfer_policy::TransferPolicy<ShipNFT>, arg20: &mut 0x2::kiosk::Kiosk, arg21: &0x2::kiosk::KioskOwnerCap, arg22: &0x2::clock::Clock, arg23: &mut 0x2::tx_context::TxContext) {
        assert!(!arg15.paused, 8);
        assert!(arg0.pubkey_set, 1);
        let v0 = 0x2::clock::timestamp_ms(arg22);
        assert!(arg1 > v0 / 1000, 2);
        assert!(arg3 > 0, 5);
        let v1 = string_to_bytes_copy(&arg8);
        0x1::vector::append<u8>(&mut v1, string_to_bytes_copy(&arg9));
        0x1::vector::append<u8>(&mut v1, string_to_bytes_copy(&arg11));
        0x1::vector::append<u8>(&mut v1, string_to_bytes_copy(&arg12));
        0x1::vector::append<u8>(&mut v1, 0x1::string::into_bytes(0x1::u64::to_string(arg1)));
        0x1::vector::append<u8>(&mut v1, 0x1::string::into_bytes(0x1::u64::to_string(arg2)));
        0x1::vector::append<u8>(&mut v1, 0x1::string::into_bytes(0x1::u64::to_string(arg3)));
        0x1::vector::append<u8>(&mut v1, 0x1::string::into_bytes(arg13));
        assert!(is_valid_hash_alg(arg6), 11);
        assert!(0x2::ecdsa_k1::secp256k1_verify(&arg5, &arg0.pubkey_bytes, &v1, arg6), 3);
        let v2 = clone_vec_u8(&arg5);
        assert!(!0x2::table::contains<vector<u8>, bool>(&arg16.used_sigs, v2), 4);
        let v3 = take_suffix(&v1, 66);
        assert_minter_text_matches_prefixed64(arg4, &v3);
        let v4 = 0x2::tx_context::sender(arg23);
        assert!(v4 == arg4, 6);
        assert!(get_rank_count(arg16, arg7, v4) + arg3 <= get_rank_limit(arg15, arg7), 9);
        assert!(get_mint_count(arg16, v4) + arg3 <= arg15.total_mint_limit, 10);
        if (0x2::table::contains<address, u64>(&arg16.per_address, v4)) {
            let v5 = 0x2::table::borrow_mut<address, u64>(&mut arg16.per_address, v4);
            *v5 = *v5 + arg3;
        } else {
            0x2::table::add<address, u64>(&mut arg16.per_address, v4, arg3);
        };
        ensure_rank_bucket(arg16, arg7, arg23);
        if (0x2::table::contains<address, u64>(0x2::table::borrow<u64, 0x2::table::Table<address, u64>>(&arg16.per_rank, arg7), v4)) {
            let v6 = 0x2::table::borrow_mut<address, u64>(0x2::table::borrow_mut<u64, 0x2::table::Table<address, u64>>(&mut arg16.per_rank, arg7), v4);
            *v6 = *v6 + arg3;
        } else {
            0x2::table::add<address, u64>(0x2::table::borrow_mut<u64, 0x2::table::Table<address, u64>>(&mut arg16.per_rank, arg7), v4, arg3);
        };
        assert!(0x2::coin::value<0x2::sui::SUI>(&arg18) == arg2, 5);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(arg18, arg17.recipient);
        0x2::table::add<vector<u8>, bool>(&mut arg16.used_sigs, v2, true);
        let v7 = expect_ship_rank(arg7);
        let v8 = 0;
        while (v8 < arg3) {
            let v9 = create_ship(arg14, v7, arg8, arg9, arg10, arg11, arg12, 0, 0, 0, 0, 0x1::string::utf8(b""), 0x1::string::utf8(b""), arg23);
            0x2::vec_map::insert<0x1::string::String, 0x1::string::String>(&mut v9.attributes, 0x1::string::utf8(b"Type"), clone_string(&arg12));
            0x2::vec_map::insert<0x1::string::String, 0x1::string::String>(&mut v9.attributes, 0x1::string::utf8(b"Rarity"), clone_string(&arg11));
            0x2::vec_map::insert<0x1::string::String, 0x1::string::String>(&mut v9.attributes, 0x1::string::utf8(b"Rank"), u64_to_string(arg7));
            let v10 = MintEvent{
                minter         : v4,
                ship_id        : v9.ship_id,
                amount         : arg2,
                timestamp_ms   : v0,
                ship_rank      : (v7 as u64),
                signature      : clone_vec_u8(&v2),
                name           : string_to_bytes_copy(&arg8),
                rarity         : string_to_bytes_copy(&arg11),
                ship_type      : string_to_bytes_copy(&arg12),
                speed          : 0,
                attack         : 0,
                defence        : 0,
                health         : 0,
                upgrades       : 0x1::vector::empty<u8>(),
                specialisation : 0x1::vector::empty<u8>(),
            };
            0x2::event::emit<MintEvent>(v10);
            0x2::kiosk::lock<ShipNFT>(arg20, arg21, arg19, v9);
            v8 = v8 + 1;
        };
    }

    fun push_bytes(arg0: &mut vector<u8>, arg1: &vector<u8>) {
        let v0 = 0;
        while (v0 < 0x1::vector::length<u8>(arg1)) {
            0x1::vector::push_back<u8>(arg0, *0x1::vector::borrow<u8>(arg1, v0));
            v0 = v0 + 1;
        };
    }

    public fun remove_upgrade_rule(arg0: &AdminCap, arg1: &mut UpgradeManager, arg2: u64) {
        0x1::vector::remove<UpgradeRule>(&mut arg1.rules, arg2);
    }

    fun string_to_bytes_copy(arg0: &0x1::string::String) : vector<u8> {
        let v0 = 0x1::vector::empty<u8>();
        let v1 = &mut v0;
        push_bytes(v1, 0x1::string::as_bytes(arg0));
        v0
    }

    fun take_suffix(arg0: &vector<u8>, arg1: u64) : vector<u8> {
        let v0 = 0x1::vector::length<u8>(arg0);
        let v1 = 0x1::vector::empty<u8>();
        let v2 = v0 - arg1;
        while (v2 < v0) {
            0x1::vector::push_back<u8>(&mut v1, *0x1::vector::borrow<u8>(arg0, v2));
            v2 = v2 + 1;
        };
        v1
    }

    fun u64_to_string(arg0: u64) : 0x1::string::String {
        0x1::string::utf8(0x1::string::into_bytes(0x1::u64::to_string(arg0)))
    }

    public fun update_attributes(arg0: &PubKey, arg1: &mut ShipNFT, arg2: vector<u8>, arg3: u8, arg4: u64, arg5: u64, arg6: u64, arg7: u64, arg8: 0x1::string::String, arg9: 0x1::string::String, arg10: u64) {
        let v0 = 0x1::vector::empty<u8>();
        0x1::vector::append<u8>(&mut v0, b"UPDATE");
        0x1::vector::append<u8>(&mut v0, 0x1::string::into_bytes(0x1::u64::to_string(arg1.ship_id)));
        0x1::vector::append<u8>(&mut v0, 0x1::string::into_bytes(0x1::u64::to_string(arg4)));
        0x1::vector::append<u8>(&mut v0, 0x1::string::into_bytes(0x1::u64::to_string(arg5)));
        0x1::vector::append<u8>(&mut v0, 0x1::string::into_bytes(0x1::u64::to_string(arg6)));
        0x1::vector::append<u8>(&mut v0, 0x1::string::into_bytes(0x1::u64::to_string(arg7)));
        0x1::vector::append<u8>(&mut v0, string_to_bytes_copy(&arg8));
        0x1::vector::append<u8>(&mut v0, string_to_bytes_copy(&arg9));
        0x1::vector::append<u8>(&mut v0, 0x1::string::into_bytes(0x1::u64::to_string(arg10)));
        assert!(is_valid_hash_alg(arg3), 11);
        assert!(0x2::ecdsa_k1::secp256k1_verify(&arg2, &arg0.pubkey_bytes, &v0, arg3), 3);
        arg1.speed = arg4;
        arg1.attack = arg5;
        arg1.defence = arg6;
        arg1.health = arg7;
        arg1.upgrades = arg8;
        arg1.specialisation = arg9;
        let v1 = 0x1::string::utf8(b"Upgrades");
        if (0x2::vec_map::contains<0x1::string::String, 0x1::string::String>(&arg1.attributes, &v1)) {
            *0x2::vec_map::get_mut<0x1::string::String, 0x1::string::String>(&mut arg1.attributes, &v1) = clone_string(&arg1.upgrades);
        } else {
            0x2::vec_map::insert<0x1::string::String, 0x1::string::String>(&mut arg1.attributes, v1, clone_string(&arg1.upgrades));
        };
        let v2 = 0x1::string::utf8(b"Specialisation");
        if (0x2::vec_map::contains<0x1::string::String, 0x1::string::String>(&arg1.attributes, &v2)) {
            *0x2::vec_map::get_mut<0x1::string::String, 0x1::string::String>(&mut arg1.attributes, &v2) = clone_string(&arg1.specialisation);
        } else {
            0x2::vec_map::insert<0x1::string::String, 0x1::string::String>(&mut arg1.attributes, v2, clone_string(&arg1.specialisation));
        };
    }

    public fun update_attributes_in_kiosk(arg0: &PubKey, arg1: &mut 0x2::kiosk::Kiosk, arg2: &0x2::kiosk::KioskOwnerCap, arg3: 0x2::object::ID, arg4: vector<u8>, arg5: u8, arg6: u64, arg7: u64, arg8: u64, arg9: u64, arg10: 0x1::string::String, arg11: 0x1::string::String, arg12: u64) {
        let v0 = 0x2::kiosk::borrow_mut<ShipNFT>(arg1, arg2, arg3);
        update_attributes(arg0, v0, arg4, arg5, arg6, arg7, arg8, arg9, arg10, arg11, arg12);
    }

    public fun upgrade(arg0: &UpgradeManager, arg1: vector<ShipNFT>, arg2: 0x2::coin::Coin<0x2::sui::SUI>, arg3: &Payout, arg4: &0x2::transfer_policy::TransferPolicy<ShipNFT>, arg5: &mut 0x2::kiosk::Kiosk, arg6: &0x2::kiosk::KioskOwnerCap, arg7: &mut Counter, arg8: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x1::vector::length<ShipNFT>(&arg1);
        assert!(v0 > 0, 12);
        let v1 = 0x1::vector::borrow<ShipNFT>(&arg1, 0);
        let v2 = v1.ship_type;
        let v3 = v1.ship_rank;
        let v4 = 1;
        while (v4 < v0) {
            let v5 = 0x1::vector::borrow<ShipNFT>(&arg1, v4);
            assert!(v5.ship_type == v2, 12);
            assert!(v5.ship_rank == v3, 12);
            v4 = v4 + 1;
        };
        let v6 = 0;
        let v7 = false;
        let v8 = 0x1::option::none<UpgradeRule>();
        while (v6 < 0x1::vector::length<UpgradeRule>(&arg0.rules)) {
            let v9 = 0x1::vector::borrow<UpgradeRule>(&arg0.rules, v6);
            let v10 = if (v9.input_type == v2) {
                if (v9.input_rank == v3) {
                    v9.input_count == v0
                } else {
                    false
                }
            } else {
                false
            };
            if (v10) {
                v8 = 0x1::option::some<UpgradeRule>(*v9);
                v7 = true;
                break
            };
            v6 = v6 + 1;
        };
        assert!(v7, 13);
        let v11 = 0x1::option::extract<UpgradeRule>(&mut v8);
        assert!(0x2::coin::value<0x2::sui::SUI>(&arg2) == v11.fee, 14);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(arg2, arg3.recipient);
        let v12 = 0;
        while (v12 < v0) {
            let ShipNFT {
                id             : v13,
                ship_id        : _,
                ship_rank      : _,
                name           : _,
                description    : _,
                image_url      : _,
                rarity         : _,
                ship_type      : _,
                speed          : _,
                attack         : _,
                defence        : _,
                health         : _,
                upgrades       : _,
                specialisation : _,
                attributes     : _,
            } = 0x1::vector::pop_back<ShipNFT>(&mut arg1);
            0x2::object::delete(v13);
            v12 = v12 + 1;
        };
        0x1::vector::destroy_empty<ShipNFT>(arg1);
        let v28 = create_ship(arg7, v11.output_rank, v11.output_name, v11.output_description, v11.output_image_url, v11.output_rarity, v11.output_type, v11.output_speed, v11.output_attack, v11.output_defence, v11.output_health, v11.output_upgrades, v11.output_specialisation, arg8);
        0x2::kiosk::lock<ShipNFT>(arg5, arg6, arg4, v28);
        let v29 = ShipUpgraded{
            upgrader        : 0x2::tx_context::sender(arg8),
            new_ship_id     : v28.ship_id,
            new_ship_rank   : v11.output_rank,
            input_count     : v0,
            rule_input_type : string_to_bytes_copy(&v11.input_type),
            rule_input_rank : v11.input_rank,
        };
        0x2::event::emit<ShipUpgraded>(v29);
    }

    // decompiled from Move bytecode v6
}

