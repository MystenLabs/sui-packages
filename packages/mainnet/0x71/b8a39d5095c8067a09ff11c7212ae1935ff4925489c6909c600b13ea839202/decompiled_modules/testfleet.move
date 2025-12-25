module 0x71b8a39d5095c8067a09ff11c7212ae1935ff4925489c6909c600b13ea839202::testfleet {
    struct TESTFLEET has drop {
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
    }

    struct MintStats has store, key {
        id: 0x2::object::UID,
        used_sigs: 0x2::table::Table<vector<u8>, bool>,
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
        burned_ship_ids: vector<u64>,
    }

    struct BatchAirdropEvent has copy, drop {
        admin: address,
        recipients_count: u64,
        ship_rank: u8,
        ship_type: vector<u8>,
        first_ship_id: u64,
        last_ship_id: u64,
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

    public fun admin_batch_airdrop(arg0: &AdminCap, arg1: &mut Counter, arg2: &0x2::transfer_policy::TransferPolicy<ShipNFT>, arg3: vector<address>, arg4: u8, arg5: 0x1::string::String, arg6: 0x1::string::String, arg7: 0x1::string::String, arg8: 0x1::string::String, arg9: 0x1::string::String, arg10: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x1::vector::length<address>(&arg3);
        assert!(v0 > 0, 5);
        let v1 = arg1.next_id;
        let v2 = 0;
        while (v2 < v0) {
            let (v3, v4) = 0x2::kiosk::new(arg10);
            let v5 = v4;
            let v6 = v3;
            let v7 = create_ship(arg1, arg4, arg5, arg6, arg7, arg8, arg9, 0, 0, 0, 0, 0x1::string::utf8(b""), 0x1::string::utf8(b""), arg10);
            0x2::vec_map::insert<0x1::string::String, 0x1::string::String>(&mut v7.attributes, 0x1::string::utf8(b"Type"), clone_string(&arg9));
            0x2::vec_map::insert<0x1::string::String, 0x1::string::String>(&mut v7.attributes, 0x1::string::utf8(b"Rarity"), clone_string(&arg8));
            0x2::vec_map::insert<0x1::string::String, 0x1::string::String>(&mut v7.attributes, 0x1::string::utf8(b"Rank"), u64_to_string((arg4 as u64)));
            0x2::kiosk::lock<ShipNFT>(&mut v6, &v5, arg2, v7);
            0x2::transfer::public_share_object<0x2::kiosk::Kiosk>(v6);
            0x2::transfer::public_transfer<0x2::kiosk::KioskOwnerCap>(v5, *0x1::vector::borrow<address>(&arg3, v2));
            v2 = v2 + 1;
        };
        let v8 = BatchAirdropEvent{
            admin            : 0x2::tx_context::sender(arg10),
            recipients_count : v0,
            ship_rank        : arg4,
            ship_type        : string_to_bytes_copy(&arg9),
            first_ship_id    : v1,
            last_ship_id     : arg1.next_id - 1,
        };
        0x2::event::emit<BatchAirdropEvent>(v8);
    }

    public fun admin_edit_display(arg0: &AdminCap, arg1: &mut 0x2::display::Display<ShipNFT>, arg2: 0x1::string::String, arg3: 0x1::string::String) {
        0x2::display::edit<ShipNFT>(arg1, arg2, arg3);
        0x2::display::update_version<ShipNFT>(arg1);
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

    fun expect_ship_rank(arg0: u64) : u8 {
        (arg0 as u8)
    }

    public fun get_ship_attributes(arg0: &0x2::kiosk::Kiosk, arg1: &0x2::kiosk::KioskOwnerCap, arg2: 0x2::object::ID) : (u64, u8, 0x1::string::String, 0x1::string::String, 0x1::string::String, 0x1::string::String, 0x1::string::String, u64, u64, u64, u64, 0x1::string::String, 0x1::string::String) {
        let v0 = 0x2::kiosk::borrow<ShipNFT>(arg0, arg1, arg2);
        (v0.ship_id, v0.ship_rank, v0.name, v0.description, v0.image_url, v0.rarity, v0.ship_type, v0.speed, v0.attack, v0.defence, v0.health, v0.upgrades, v0.specialisation)
    }

    fun init(arg0: TESTFLEET, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = AdminCap{id: 0x2::object::new(arg1)};
        0x2::transfer::public_transfer<AdminCap>(v0, @0x495ce5fc99f68d2c8179618e0c4eda72df13efc4c04a6308ba5dc4b2b6ab6597);
        let v1 = Counter{
            id      : 0x2::object::new(arg1),
            next_id : 1,
        };
        0x2::transfer::share_object<Counter>(v1);
        let v2 = MintConfig{
            id     : 0x2::object::new(arg1),
            paused : false,
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
            id        : 0x2::object::new(arg1),
            used_sigs : 0x2::table::new<vector<u8>, bool>(arg1),
        };
        0x2::transfer::share_object<MintStats>(v5);
        let v6 = 0x2::package::claim<TESTFLEET>(arg0, arg1);
        let v7 = 0x1::vector::empty<0x1::string::String>();
        let v8 = &mut v7;
        0x1::vector::push_back<0x1::string::String>(v8, 0x1::string::utf8(b"name"));
        0x1::vector::push_back<0x1::string::String>(v8, 0x1::string::utf8(b"image_url"));
        0x1::vector::push_back<0x1::string::String>(v8, 0x1::string::utf8(b"project_url"));
        0x1::vector::push_back<0x1::string::String>(v8, 0x1::string::utf8(b"creator"));
        0x1::vector::push_back<0x1::string::String>(v8, 0x1::string::utf8(b"description"));
        0x1::vector::push_back<0x1::string::String>(v8, 0x1::string::utf8(b"attributes"));
        let v9 = 0x1::vector::empty<0x1::string::String>();
        let v10 = &mut v9;
        0x1::vector::push_back<0x1::string::String>(v10, 0x1::string::utf8(b"{name}"));
        0x1::vector::push_back<0x1::string::String>(v10, 0x1::string::utf8(b"{image_url}"));
        0x1::vector::push_back<0x1::string::String>(v10, 0x1::string::utf8(b"https://talentum.id"));
        0x1::vector::push_back<0x1::string::String>(v10, 0x1::string::utf8(b"Coral Reef"));
        0x1::vector::push_back<0x1::string::String>(v10, 0x1::string::utf8(b"{description}"));
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
        assert!(0x2::coin::value<0x2::sui::SUI>(&arg18) == arg2, 5);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(arg18, arg17.recipient);
        0x2::table::add<vector<u8>, bool>(&mut arg16.used_sigs, v2, true);
        let v5 = expect_ship_rank(arg7);
        let v6 = 0;
        while (v6 < arg3) {
            let v7 = create_ship(arg14, v5, arg8, arg9, arg10, arg11, arg12, 0, 0, 0, 0, 0x1::string::utf8(b""), 0x1::string::utf8(b""), arg23);
            0x2::vec_map::insert<0x1::string::String, 0x1::string::String>(&mut v7.attributes, 0x1::string::utf8(b"Type"), clone_string(&arg12));
            0x2::vec_map::insert<0x1::string::String, 0x1::string::String>(&mut v7.attributes, 0x1::string::utf8(b"Rarity"), clone_string(&arg11));
            0x2::vec_map::insert<0x1::string::String, 0x1::string::String>(&mut v7.attributes, 0x1::string::utf8(b"Rank"), u64_to_string(arg7));
            let v8 = MintEvent{
                minter         : v4,
                ship_id        : v7.ship_id,
                amount         : arg2,
                timestamp_ms   : v0,
                ship_rank      : (v5 as u64),
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
            0x2::event::emit<MintEvent>(v8);
            0x2::kiosk::lock<ShipNFT>(arg20, arg21, arg19, v7);
            v6 = v6 + 1;
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

    public fun update_attributes(arg0: &PubKey, arg1: &mut MintStats, arg2: &mut 0x2::kiosk::Kiosk, arg3: &0x2::kiosk::KioskOwnerCap, arg4: 0x2::object::ID, arg5: vector<u8>, arg6: u8, arg7: u8, arg8: 0x1::string::String, arg9: 0x1::string::String, arg10: 0x1::string::String, arg11: 0x1::string::String, arg12: 0x1::string::String, arg13: u64, arg14: u64, arg15: u64, arg16: u64, arg17: 0x1::string::String, arg18: 0x1::string::String, arg19: u64) {
        let v0 = clone_vec_u8(&arg5);
        assert!(!0x2::table::contains<vector<u8>, bool>(&arg1.used_sigs, v0), 4);
        let v1 = 0x2::kiosk::borrow_mut<ShipNFT>(arg2, arg3, arg4);
        let v2 = 0x1::vector::empty<u8>();
        0x1::vector::append<u8>(&mut v2, b"UPDATE");
        0x1::vector::append<u8>(&mut v2, 0x1::string::into_bytes(0x1::u64::to_string(v1.ship_id)));
        0x1::vector::append<u8>(&mut v2, 0x1::string::into_bytes(0x1::u64::to_string((arg7 as u64))));
        0x1::vector::append<u8>(&mut v2, string_to_bytes_copy(&arg8));
        0x1::vector::append<u8>(&mut v2, string_to_bytes_copy(&arg9));
        0x1::vector::append<u8>(&mut v2, string_to_bytes_copy(&arg10));
        0x1::vector::append<u8>(&mut v2, string_to_bytes_copy(&arg11));
        0x1::vector::append<u8>(&mut v2, string_to_bytes_copy(&arg12));
        0x1::vector::append<u8>(&mut v2, 0x1::string::into_bytes(0x1::u64::to_string(arg13)));
        0x1::vector::append<u8>(&mut v2, 0x1::string::into_bytes(0x1::u64::to_string(arg14)));
        0x1::vector::append<u8>(&mut v2, 0x1::string::into_bytes(0x1::u64::to_string(arg15)));
        0x1::vector::append<u8>(&mut v2, 0x1::string::into_bytes(0x1::u64::to_string(arg16)));
        0x1::vector::append<u8>(&mut v2, string_to_bytes_copy(&arg17));
        0x1::vector::append<u8>(&mut v2, string_to_bytes_copy(&arg18));
        0x1::vector::append<u8>(&mut v2, 0x1::string::into_bytes(0x1::u64::to_string(arg19)));
        assert!(is_valid_hash_alg(arg6), 11);
        assert!(0x2::ecdsa_k1::secp256k1_verify(&arg5, &arg0.pubkey_bytes, &v2, arg6), 3);
        0x2::table::add<vector<u8>, bool>(&mut arg1.used_sigs, v0, true);
        v1.ship_rank = arg7;
        v1.name = arg8;
        v1.description = arg9;
        v1.image_url = arg10;
        v1.rarity = arg11;
        v1.ship_type = arg12;
        v1.speed = arg13;
        v1.attack = arg14;
        v1.defence = arg15;
        v1.health = arg16;
        v1.upgrades = arg17;
        v1.specialisation = arg18;
        let v3 = 0x1::string::utf8(b"Rank");
        if (0x2::vec_map::contains<0x1::string::String, 0x1::string::String>(&v1.attributes, &v3)) {
            *0x2::vec_map::get_mut<0x1::string::String, 0x1::string::String>(&mut v1.attributes, &v3) = u64_to_string((arg7 as u64));
        } else {
            0x2::vec_map::insert<0x1::string::String, 0x1::string::String>(&mut v1.attributes, v3, u64_to_string((arg7 as u64)));
        };
        let v4 = 0x1::string::utf8(b"Type");
        if (0x2::vec_map::contains<0x1::string::String, 0x1::string::String>(&v1.attributes, &v4)) {
            *0x2::vec_map::get_mut<0x1::string::String, 0x1::string::String>(&mut v1.attributes, &v4) = clone_string(&v1.ship_type);
        } else {
            0x2::vec_map::insert<0x1::string::String, 0x1::string::String>(&mut v1.attributes, v4, clone_string(&v1.ship_type));
        };
        let v5 = 0x1::string::utf8(b"Rarity");
        if (0x2::vec_map::contains<0x1::string::String, 0x1::string::String>(&v1.attributes, &v5)) {
            *0x2::vec_map::get_mut<0x1::string::String, 0x1::string::String>(&mut v1.attributes, &v5) = clone_string(&v1.rarity);
        } else {
            0x2::vec_map::insert<0x1::string::String, 0x1::string::String>(&mut v1.attributes, v5, clone_string(&v1.rarity));
        };
        let v6 = 0x1::string::utf8(b"Speed");
        if (arg13 != 0) {
            if (0x2::vec_map::contains<0x1::string::String, 0x1::string::String>(&v1.attributes, &v6)) {
                *0x2::vec_map::get_mut<0x1::string::String, 0x1::string::String>(&mut v1.attributes, &v6) = u64_to_string(arg13);
            } else {
                0x2::vec_map::insert<0x1::string::String, 0x1::string::String>(&mut v1.attributes, v6, u64_to_string(arg13));
            };
        } else if (0x2::vec_map::contains<0x1::string::String, 0x1::string::String>(&v1.attributes, &v6)) {
            let (_, _) = 0x2::vec_map::remove<0x1::string::String, 0x1::string::String>(&mut v1.attributes, &v6);
        };
        let v9 = 0x1::string::utf8(b"Attack");
        if (arg14 != 0) {
            if (0x2::vec_map::contains<0x1::string::String, 0x1::string::String>(&v1.attributes, &v9)) {
                *0x2::vec_map::get_mut<0x1::string::String, 0x1::string::String>(&mut v1.attributes, &v9) = u64_to_string(arg14);
            } else {
                0x2::vec_map::insert<0x1::string::String, 0x1::string::String>(&mut v1.attributes, v9, u64_to_string(arg14));
            };
        } else if (0x2::vec_map::contains<0x1::string::String, 0x1::string::String>(&v1.attributes, &v9)) {
            let (_, _) = 0x2::vec_map::remove<0x1::string::String, 0x1::string::String>(&mut v1.attributes, &v9);
        };
        let v12 = 0x1::string::utf8(b"Defence");
        if (arg15 != 0) {
            if (0x2::vec_map::contains<0x1::string::String, 0x1::string::String>(&v1.attributes, &v12)) {
                *0x2::vec_map::get_mut<0x1::string::String, 0x1::string::String>(&mut v1.attributes, &v12) = u64_to_string(arg15);
            } else {
                0x2::vec_map::insert<0x1::string::String, 0x1::string::String>(&mut v1.attributes, v12, u64_to_string(arg15));
            };
        } else if (0x2::vec_map::contains<0x1::string::String, 0x1::string::String>(&v1.attributes, &v12)) {
            let (_, _) = 0x2::vec_map::remove<0x1::string::String, 0x1::string::String>(&mut v1.attributes, &v12);
        };
        let v15 = 0x1::string::utf8(b"Health");
        if (arg16 != 0) {
            if (0x2::vec_map::contains<0x1::string::String, 0x1::string::String>(&v1.attributes, &v15)) {
                *0x2::vec_map::get_mut<0x1::string::String, 0x1::string::String>(&mut v1.attributes, &v15) = u64_to_string(arg16);
            } else {
                0x2::vec_map::insert<0x1::string::String, 0x1::string::String>(&mut v1.attributes, v15, u64_to_string(arg16));
            };
        } else if (0x2::vec_map::contains<0x1::string::String, 0x1::string::String>(&v1.attributes, &v15)) {
            let (_, _) = 0x2::vec_map::remove<0x1::string::String, 0x1::string::String>(&mut v1.attributes, &v15);
        };
        let v18 = 0x1::string::utf8(b"Upgrades");
        if (0x1::string::length(&v1.upgrades) != 0) {
            if (0x2::vec_map::contains<0x1::string::String, 0x1::string::String>(&v1.attributes, &v18)) {
                *0x2::vec_map::get_mut<0x1::string::String, 0x1::string::String>(&mut v1.attributes, &v18) = clone_string(&v1.upgrades);
            } else {
                0x2::vec_map::insert<0x1::string::String, 0x1::string::String>(&mut v1.attributes, v18, clone_string(&v1.upgrades));
            };
        } else if (0x2::vec_map::contains<0x1::string::String, 0x1::string::String>(&v1.attributes, &v18)) {
            let (_, _) = 0x2::vec_map::remove<0x1::string::String, 0x1::string::String>(&mut v1.attributes, &v18);
        };
        let v21 = 0x1::string::utf8(b"Specialisation");
        if (0x1::string::length(&v1.specialisation) != 0) {
            if (0x2::vec_map::contains<0x1::string::String, 0x1::string::String>(&v1.attributes, &v21)) {
                *0x2::vec_map::get_mut<0x1::string::String, 0x1::string::String>(&mut v1.attributes, &v21) = clone_string(&v1.specialisation);
            } else {
                0x2::vec_map::insert<0x1::string::String, 0x1::string::String>(&mut v1.attributes, v21, clone_string(&v1.specialisation));
            };
        } else if (0x2::vec_map::contains<0x1::string::String, 0x1::string::String>(&v1.attributes, &v21)) {
            let (_, _) = 0x2::vec_map::remove<0x1::string::String, 0x1::string::String>(&mut v1.attributes, &v21);
        };
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
        let v12 = 0x1::vector::empty<u64>();
        let v13 = 0;
        while (v13 < v0) {
            let v14 = 0x1::vector::pop_back<ShipNFT>(&mut arg1);
            0x1::vector::push_back<u64>(&mut v12, v14.ship_id);
            let ShipNFT {
                id             : v15,
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
            } = v14;
            0x2::object::delete(v15);
            v13 = v13 + 1;
        };
        0x1::vector::destroy_empty<ShipNFT>(arg1);
        let v30 = create_ship(arg7, v11.output_rank, v11.output_name, v11.output_description, v11.output_image_url, v11.output_rarity, v11.output_type, v11.output_speed, v11.output_attack, v11.output_defence, v11.output_health, v11.output_upgrades, v11.output_specialisation, arg8);
        let v31 = v30.speed;
        let v32 = v30.attack;
        let v33 = v30.defence;
        let v34 = v30.health;
        let v35 = clone_string(&v30.upgrades);
        let v36 = clone_string(&v30.specialisation);
        0x2::vec_map::insert<0x1::string::String, 0x1::string::String>(&mut v30.attributes, 0x1::string::utf8(b"Type"), clone_string(&v30.ship_type));
        0x2::vec_map::insert<0x1::string::String, 0x1::string::String>(&mut v30.attributes, 0x1::string::utf8(b"Rarity"), clone_string(&v30.rarity));
        0x2::vec_map::insert<0x1::string::String, 0x1::string::String>(&mut v30.attributes, 0x1::string::utf8(b"Rank"), u64_to_string((v30.ship_rank as u64)));
        if (v31 != 0) {
            0x2::vec_map::insert<0x1::string::String, 0x1::string::String>(&mut v30.attributes, 0x1::string::utf8(b"Speed"), u64_to_string(v31));
        };
        if (v32 != 0) {
            0x2::vec_map::insert<0x1::string::String, 0x1::string::String>(&mut v30.attributes, 0x1::string::utf8(b"Attack"), u64_to_string(v32));
        };
        if (v33 != 0) {
            0x2::vec_map::insert<0x1::string::String, 0x1::string::String>(&mut v30.attributes, 0x1::string::utf8(b"Defence"), u64_to_string(v33));
        };
        if (v34 != 0) {
            0x2::vec_map::insert<0x1::string::String, 0x1::string::String>(&mut v30.attributes, 0x1::string::utf8(b"Health"), u64_to_string(v34));
        };
        if (0x1::string::length(&v35) != 0) {
            0x2::vec_map::insert<0x1::string::String, 0x1::string::String>(&mut v30.attributes, 0x1::string::utf8(b"Upgrades"), v35);
        };
        if (0x1::string::length(&v36) != 0) {
            0x2::vec_map::insert<0x1::string::String, 0x1::string::String>(&mut v30.attributes, 0x1::string::utf8(b"Specialisation"), v36);
        };
        0x2::kiosk::lock<ShipNFT>(arg5, arg6, arg4, v30);
        let v37 = ShipUpgraded{
            upgrader        : 0x2::tx_context::sender(arg8),
            new_ship_id     : v30.ship_id,
            new_ship_rank   : v11.output_rank,
            input_count     : v0,
            rule_input_type : string_to_bytes_copy(&v11.input_type),
            rule_input_rank : v11.input_rank,
            burned_ship_ids : v12,
        };
        0x2::event::emit<ShipUpgraded>(v37);
    }

    // decompiled from Move bytecode v6
}

