module 0x70cf08d1a4cc499f639c23516a13c756593dd11f7b16ea4f827947baca9e932f::testloot {
    struct TESTLOOT has drop {
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

    struct BoxNFT has store, key {
        id: 0x2::object::UID,
        box_id: u64,
        name: 0x1::string::String,
        description: 0x1::string::String,
        image_url: 0x1::string::String,
        rarity: 0x1::string::String,
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

    struct MintEvent has copy, drop {
        minter: address,
        box_id: u64,
        amount: u64,
        timestamp_ms: u64,
        signature: vector<u8>,
        name: vector<u8>,
        rarity: vector<u8>,
    }

    struct KioskCreated has copy, drop {
        kiosk_id: 0x2::object::ID,
        cap_id: 0x2::object::ID,
    }

    struct BoxOpened has copy, drop {
        opener: address,
        box_id: u64,
        random_value: u64,
    }

    struct Opened has copy, drop {
        opener: address,
        box_id: u64,
        name: vector<u8>,
        random_value: u64,
    }

    public fun admin_edit_display(arg0: &AdminCap, arg1: &mut 0x2::display::Display<BoxNFT>, arg2: 0x1::string::String, arg3: 0x1::string::String) {
        0x2::display::edit<BoxNFT>(arg1, arg2, arg3);
        0x2::display::update_version<BoxNFT>(arg1);
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

    public fun admin_withdraw_policy_fees(arg0: &AdminCap, arg1: &mut 0x2::transfer_policy::TransferPolicy<BoxNFT>, arg2: &0x2::transfer_policy::TransferPolicyCap<BoxNFT>, arg3: &Payout, arg4: 0x1::option::Option<u64>, arg5: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::transfer_policy::withdraw<BoxNFT>(arg1, arg2, arg4, arg5), arg3.recipient);
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

    fun bytes_to_u64(arg0: &vector<u8>) : u64 {
        let v0 = 0;
        let v1 = 0;
        while (v1 < 8) {
            let v2 = v0 << 8;
            v0 = v2 | (*0x1::vector::borrow<u8>(arg0, v1) as u64);
            v1 = v1 + 1;
        };
        v0
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

    fun derive_random_value(arg0: &mut 0x2::tx_context::TxContext) : u64 {
        let v0 = 0x2::address::to_bytes(0x2::tx_context::fresh_object_address(arg0));
        bytes_to_u64(&v0)
    }

    fun init(arg0: TESTLOOT, arg1: &mut 0x2::tx_context::TxContext) {
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
        let v6 = 0x2::package::claim<TESTLOOT>(arg0, arg1);
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
        let v11 = 0x2::display::new_with_fields<BoxNFT>(&v6, v7, v9, arg1);
        0x2::display::update_version<BoxNFT>(&mut v11);
        let (v12, v13) = 0x2::transfer_policy::new<BoxNFT>(&v6, arg1);
        0x2::transfer::public_share_object<0x2::transfer_policy::TransferPolicy<BoxNFT>>(v12);
        0x2::transfer::public_transfer<0x2::transfer_policy::TransferPolicyCap<BoxNFT>>(v13, @0x495ce5fc99f68d2c8179618e0c4eda72df13efc4c04a6308ba5dc4b2b6ab6597);
        0x2::transfer::public_transfer<0x2::package::Publisher>(v6, @0x495ce5fc99f68d2c8179618e0c4eda72df13efc4c04a6308ba5dc4b2b6ab6597);
        0x2::transfer::public_transfer<0x2::display::Display<BoxNFT>>(v11, @0x495ce5fc99f68d2c8179618e0c4eda72df13efc4c04a6308ba5dc4b2b6ab6597);
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

    public fun mint(arg0: &PubKey, arg1: u64, arg2: u64, arg3: u64, arg4: address, arg5: vector<u8>, arg6: u8, arg7: 0x1::string::String, arg8: 0x1::string::String, arg9: 0x1::string::String, arg10: 0x1::string::String, arg11: 0x1::string::String, arg12: 0x1::string::String, arg13: 0x1::string::String, arg14: 0x1::string::String, arg15: &mut Counter, arg16: &MintConfig, arg17: &mut MintStats, arg18: &Payout, arg19: 0x2::coin::Coin<0x2::sui::SUI>, arg20: &0x2::transfer_policy::TransferPolicy<BoxNFT>, arg21: &0x2::clock::Clock, arg22: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::kiosk::new(arg22);
        let v2 = v1;
        let v3 = v0;
        let v4 = &mut v3;
        mint_core(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10, arg11, arg12, arg13, arg14, arg15, arg16, arg17, arg18, arg19, arg20, v4, &v2, arg21, arg22);
        let v5 = KioskCreated{
            kiosk_id : 0x2::object::id<0x2::kiosk::Kiosk>(&v3),
            cap_id   : 0x2::object::id<0x2::kiosk::KioskOwnerCap>(&v2),
        };
        0x2::event::emit<KioskCreated>(v5);
        0x2::transfer::public_share_object<0x2::kiosk::Kiosk>(v3);
        0x2::transfer::public_transfer<0x2::kiosk::KioskOwnerCap>(v2, 0x2::tx_context::sender(arg22));
    }

    fun mint_core(arg0: &PubKey, arg1: u64, arg2: u64, arg3: u64, arg4: address, arg5: vector<u8>, arg6: u8, arg7: 0x1::string::String, arg8: 0x1::string::String, arg9: 0x1::string::String, arg10: 0x1::string::String, arg11: 0x1::string::String, arg12: 0x1::string::String, arg13: 0x1::string::String, arg14: 0x1::string::String, arg15: &mut Counter, arg16: &MintConfig, arg17: &mut MintStats, arg18: &Payout, arg19: 0x2::coin::Coin<0x2::sui::SUI>, arg20: &0x2::transfer_policy::TransferPolicy<BoxNFT>, arg21: &mut 0x2::kiosk::Kiosk, arg22: &0x2::kiosk::KioskOwnerCap, arg23: &0x2::clock::Clock, arg24: &mut 0x2::tx_context::TxContext) {
        assert!(!arg16.paused, 8);
        assert!(arg0.pubkey_set, 1);
        let v0 = 0x2::clock::timestamp_ms(arg23);
        assert!(arg1 > v0 / 1000, 2);
        assert!(arg3 > 0, 5);
        let v1 = string_to_bytes_copy(&arg7);
        0x1::vector::append<u8>(&mut v1, string_to_bytes_copy(&arg8));
        0x1::vector::append<u8>(&mut v1, string_to_bytes_copy(&arg10));
        0x1::vector::append<u8>(&mut v1, 0x1::string::into_bytes(0x1::u64::to_string(arg1)));
        0x1::vector::append<u8>(&mut v1, 0x1::string::into_bytes(0x1::u64::to_string(arg2)));
        0x1::vector::append<u8>(&mut v1, 0x1::string::into_bytes(0x1::u64::to_string(arg3)));
        0x1::vector::append<u8>(&mut v1, 0x1::string::into_bytes(arg14));
        assert!(is_valid_hash_alg(arg6), 11);
        assert!(0x2::ecdsa_k1::secp256k1_verify(&arg5, &arg0.pubkey_bytes, &v1, arg6), 3);
        let v2 = clone_vec_u8(&arg5);
        assert!(!0x2::table::contains<vector<u8>, bool>(&arg17.used_sigs, v2), 4);
        let v3 = take_suffix(&v1, 66);
        assert_minter_text_matches_prefixed64(arg4, &v3);
        let v4 = 0x2::tx_context::sender(arg24);
        assert!(v4 == arg4, 6);
        assert!(0x2::coin::value<0x2::sui::SUI>(&arg19) == arg2, 5);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(arg19, arg18.recipient);
        0x2::table::add<vector<u8>, bool>(&mut arg17.used_sigs, v2, true);
        let v5 = 0;
        while (v5 < arg3) {
            let v6 = arg15.next_id;
            arg15.next_id = v6 + 1;
            let v7 = 0x2::vec_map::empty<0x1::string::String, 0x1::string::String>();
            0x2::vec_map::insert<0x1::string::String, 0x1::string::String>(&mut v7, 0x1::string::utf8(b"Type"), clone_string(&arg7));
            0x2::vec_map::insert<0x1::string::String, 0x1::string::String>(&mut v7, 0x1::string::utf8(b"Rarity"), clone_string(&arg10));
            0x2::vec_map::insert<0x1::string::String, 0x1::string::String>(&mut v7, 0x1::string::utf8(b"Capacity"), clone_string(&arg11));
            0x2::vec_map::insert<0x1::string::String, 0x1::string::String>(&mut v7, 0x1::string::utf8(b"Loot"), clone_string(&arg12));
            0x2::vec_map::insert<0x1::string::String, 0x1::string::String>(&mut v7, 0x1::string::utf8(b"Event"), clone_string(&arg13));
            let v8 = BoxNFT{
                id          : 0x2::object::new(arg24),
                box_id      : v6,
                name        : clone_string(&arg7),
                description : clone_string(&arg8),
                image_url   : clone_string(&arg9),
                rarity      : clone_string(&arg10),
                attributes  : v7,
            };
            let v9 = MintEvent{
                minter       : v4,
                box_id       : v6,
                amount       : arg2,
                timestamp_ms : v0,
                signature    : clone_vec_u8(&v2),
                name         : string_to_bytes_copy(&arg7),
                rarity       : string_to_bytes_copy(&arg10),
            };
            0x2::event::emit<MintEvent>(v9);
            0x2::kiosk::lock<BoxNFT>(arg21, arg22, arg20, v8);
            v5 = v5 + 1;
        };
    }

    public fun open(arg0: BoxNFT, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let BoxNFT {
            id          : v1,
            box_id      : v2,
            name        : v3,
            description : _,
            image_url   : _,
            rarity      : _,
            attributes  : _,
        } = arg0;
        let v8 = v3;
        let v9 = Opened{
            opener       : v0,
            box_id       : v2,
            name         : string_to_bytes_copy(&v8),
            random_value : derive_random_value(arg1),
        };
        0x2::event::emit<Opened>(v9);
        0x2::object::delete(v1);
    }

    public fun open_box(arg0: BoxNFT, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let BoxNFT {
            id          : v1,
            box_id      : v2,
            name        : _,
            description : _,
            image_url   : _,
            rarity      : _,
            attributes  : _,
        } = arg0;
        let v8 = BoxOpened{
            opener       : v0,
            box_id       : v2,
            random_value : derive_random_value(arg1),
        };
        0x2::event::emit<BoxOpened>(v8);
        0x2::object::delete(v1);
    }

    fun push_bytes(arg0: &mut vector<u8>, arg1: &vector<u8>) {
        let v0 = 0;
        while (v0 < 0x1::vector::length<u8>(arg1)) {
            0x1::vector::push_back<u8>(arg0, *0x1::vector::borrow<u8>(arg1, v0));
            v0 = v0 + 1;
        };
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

    // decompiled from Move bytecode v6
}

