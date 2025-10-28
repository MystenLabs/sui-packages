module 0x5daa386d9c9aeeae196071a16f066cd76512044794841afdd83739e2aefafbd1::the_captains {
    struct THE_CAPTAINS has drop {
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

    struct PfpNFT has store, key {
        id: 0x2::object::UID,
        token_id: u64,
        is_revealed: bool,
        attributes: 0x2::vec_map::VecMap<0x1::string::String, 0x1::string::String>,
        number: 0x1::string::String,
        url: 0x1::string::String,
    }

    struct CaptainAttributes has copy, drop, store {
        horizon: 0x1::string::String,
        sex: 0x1::string::String,
        physique: 0x1::string::String,
        companion: 0x1::string::String,
        garb: 0x1::string::String,
        whiskers: 0x1::string::String,
        headgear: 0x1::string::String,
        gaze: 0x1::string::String,
        trinkets: 0x1::string::String,
        armament: 0x1::string::String,
    }

    struct CaptainRevealed has copy, drop {
        captain_id: 0x2::object::ID,
        token_id: u64,
        revealed_by: address,
    }

    struct TraitsRegistry has key {
        id: 0x2::object::UID,
        traits: 0x2::table::Table<u64, CaptainAttributes>,
    }

    struct RevealedImagesRegistry has key {
        id: 0x2::object::UID,
        urls: 0x2::table::Table<u64, 0x1::string::String>,
    }

    struct TraitsLoaded has copy, drop {
        token_id: u64,
    }

    struct ImageUrlLoaded has copy, drop {
        token_id: u64,
    }

    struct MintConfig has store, key {
        id: 0x2::object::UID,
        paused: bool,
        default_stage_limit: u64,
        total_mint_limit: u64,
        per_stage_limits: 0x2::table::Table<u64, u64>,
    }

    struct MintStats has store, key {
        id: 0x2::object::UID,
        per_address: 0x2::table::Table<address, u64>,
        used_sigs: 0x2::table::Table<vector<u8>, bool>,
        per_stage: 0x2::table::Table<u64, 0x2::table::Table<address, u64>>,
    }

    struct MintEvent has copy, drop {
        minter: address,
        token_id: u64,
        amount: u64,
        timestamp_ms: u64,
        mint_stage: u64,
        signature: vector<u8>,
    }

    struct KioskCreated has copy, drop {
        kiosk_id: 0x2::object::ID,
        cap_id: 0x2::object::ID,
    }

    public fun admin_edit_display(arg0: &AdminCap, arg1: &mut 0x2::display::Display<PfpNFT>, arg2: 0x1::string::String, arg3: 0x1::string::String) {
        0x2::display::edit<PfpNFT>(arg1, arg2, arg3);
        0x2::display::update_version<PfpNFT>(arg1);
    }

    public fun admin_load_traits_and_url(arg0: &AdminCap, arg1: &mut TraitsRegistry, arg2: &mut RevealedImagesRegistry, arg3: u64, arg4: 0x1::string::String, arg5: 0x1::string::String, arg6: 0x1::string::String, arg7: 0x1::string::String, arg8: 0x1::string::String, arg9: 0x1::string::String, arg10: 0x1::string::String, arg11: 0x1::string::String, arg12: 0x1::string::String, arg13: 0x1::string::String, arg14: 0x1::string::String) {
        let v0 = CaptainAttributes{
            horizon   : arg4,
            sex       : arg5,
            physique  : arg6,
            companion : arg7,
            garb      : arg8,
            whiskers  : arg9,
            headgear  : arg10,
            gaze      : arg11,
            trinkets  : arg12,
            armament  : arg13,
        };
        0x2::table::add<u64, CaptainAttributes>(&mut arg1.traits, arg3, v0);
        0x2::table::add<u64, 0x1::string::String>(&mut arg2.urls, arg3, arg14);
        let v1 = TraitsLoaded{token_id: arg3};
        0x2::event::emit<TraitsLoaded>(v1);
        let v2 = ImageUrlLoaded{token_id: arg3};
        0x2::event::emit<ImageUrlLoaded>(v2);
    }

    public fun admin_load_traits_and_url_batch(arg0: &AdminCap, arg1: &mut TraitsRegistry, arg2: &mut RevealedImagesRegistry, arg3: vector<u64>, arg4: vector<0x1::string::String>, arg5: vector<0x1::string::String>, arg6: vector<0x1::string::String>, arg7: vector<0x1::string::String>, arg8: vector<0x1::string::String>, arg9: vector<0x1::string::String>, arg10: vector<0x1::string::String>, arg11: vector<0x1::string::String>, arg12: vector<0x1::string::String>, arg13: vector<0x1::string::String>, arg14: vector<0x1::string::String>) {
        let v0 = 0x1::vector::length<u64>(&arg3);
        assert!(v0 == 0x1::vector::length<0x1::string::String>(&arg4), 5);
        assert!(v0 == 0x1::vector::length<0x1::string::String>(&arg5), 5);
        assert!(v0 == 0x1::vector::length<0x1::string::String>(&arg6), 5);
        assert!(v0 == 0x1::vector::length<0x1::string::String>(&arg7), 5);
        assert!(v0 == 0x1::vector::length<0x1::string::String>(&arg8), 5);
        assert!(v0 == 0x1::vector::length<0x1::string::String>(&arg9), 5);
        assert!(v0 == 0x1::vector::length<0x1::string::String>(&arg10), 5);
        assert!(v0 == 0x1::vector::length<0x1::string::String>(&arg11), 5);
        assert!(v0 == 0x1::vector::length<0x1::string::String>(&arg12), 5);
        assert!(v0 == 0x1::vector::length<0x1::string::String>(&arg13), 5);
        assert!(v0 == 0x1::vector::length<0x1::string::String>(&arg14), 5);
        let v1 = 0;
        while (v1 < v0) {
            let v2 = *0x1::vector::borrow<u64>(&arg3, v1);
            let v3 = CaptainAttributes{
                horizon   : *0x1::vector::borrow<0x1::string::String>(&arg4, v1),
                sex       : *0x1::vector::borrow<0x1::string::String>(&arg5, v1),
                physique  : *0x1::vector::borrow<0x1::string::String>(&arg6, v1),
                companion : *0x1::vector::borrow<0x1::string::String>(&arg7, v1),
                garb      : *0x1::vector::borrow<0x1::string::String>(&arg8, v1),
                whiskers  : *0x1::vector::borrow<0x1::string::String>(&arg9, v1),
                headgear  : *0x1::vector::borrow<0x1::string::String>(&arg10, v1),
                gaze      : *0x1::vector::borrow<0x1::string::String>(&arg11, v1),
                trinkets  : *0x1::vector::borrow<0x1::string::String>(&arg12, v1),
                armament  : *0x1::vector::borrow<0x1::string::String>(&arg13, v1),
            };
            0x2::table::add<u64, CaptainAttributes>(&mut arg1.traits, v2, v3);
            0x2::table::add<u64, 0x1::string::String>(&mut arg2.urls, v2, *0x1::vector::borrow<0x1::string::String>(&arg14, v1));
            let v4 = TraitsLoaded{token_id: v2};
            0x2::event::emit<TraitsLoaded>(v4);
            let v5 = ImageUrlLoaded{token_id: v2};
            0x2::event::emit<ImageUrlLoaded>(v5);
            v1 = v1 + 1;
        };
    }

    public fun admin_set_default_stage_limit(arg0: &AdminCap, arg1: &mut MintConfig, arg2: u64) {
        arg1.default_stage_limit = arg2;
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

    public fun admin_set_stage_limit(arg0: &AdminCap, arg1: &mut MintConfig, arg2: u64, arg3: u64) {
        if (0x2::table::contains<u64, u64>(&arg1.per_stage_limits, arg2)) {
            *0x2::table::borrow_mut<u64, u64>(&mut arg1.per_stage_limits, arg2) = arg3;
        } else {
            0x2::table::add<u64, u64>(&mut arg1.per_stage_limits, arg2, arg3);
        };
    }

    public fun admin_set_total_mint_limit(arg0: &AdminCap, arg1: &mut MintConfig, arg2: u64) {
        arg1.total_mint_limit = arg2;
    }

    public fun admin_transfer_admincap(arg0: AdminCap, arg1: address) {
        0x2::transfer::public_transfer<AdminCap>(arg0, arg1);
    }

    public fun admin_withdraw_policy_fees(arg0: &AdminCap, arg1: &mut 0x2::transfer_policy::TransferPolicy<PfpNFT>, arg2: &0x2::transfer_policy::TransferPolicyCap<PfpNFT>, arg3: &Payout, arg4: 0x1::option::Option<u64>, arg5: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::transfer_policy::withdraw<PfpNFT>(arg1, arg2, arg4, arg5), arg3.recipient);
    }

    public fun are_traits_loaded(arg0: &TraitsRegistry, arg1: u64) : bool {
        0x2::table::contains<u64, CaptainAttributes>(&arg0.traits, arg1)
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

    public fun can_reveal(arg0: &TraitsRegistry, arg1: &PfpNFT) : bool {
        !arg1.is_revealed && 0x2::table::contains<u64, CaptainAttributes>(&arg0.traits, arg1.token_id)
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

    fun ensure_stage_bucket(arg0: &mut MintStats, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) {
        if (!0x2::table::contains<u64, 0x2::table::Table<address, u64>>(&arg0.per_stage, arg1)) {
            0x2::table::add<u64, 0x2::table::Table<address, u64>>(&mut arg0.per_stage, arg1, 0x2::table::new<address, u64>(arg2));
        };
    }

    public fun get_mint_count(arg0: &MintStats, arg1: address) : u64 {
        if (0x2::table::contains<address, u64>(&arg0.per_address, arg1)) {
            *0x2::table::borrow<address, u64>(&arg0.per_address, arg1)
        } else {
            0
        }
    }

    public fun get_stage_count(arg0: &MintStats, arg1: u64, arg2: address) : u64 {
        if (0x2::table::contains<u64, 0x2::table::Table<address, u64>>(&arg0.per_stage, arg1)) {
            let v1 = 0x2::table::borrow<u64, 0x2::table::Table<address, u64>>(&arg0.per_stage, arg1);
            if (0x2::table::contains<address, u64>(v1, arg2)) {
                *0x2::table::borrow<address, u64>(v1, arg2)
            } else {
                0
            }
        } else {
            0
        }
    }

    fun get_stage_limit(arg0: &MintConfig, arg1: u64) : u64 {
        if (0x2::table::contains<u64, u64>(&arg0.per_stage_limits, arg1)) {
            *0x2::table::borrow<u64, u64>(&arg0.per_stage_limits, arg1)
        } else {
            arg0.default_stage_limit
        }
    }

    fun init(arg0: THE_CAPTAINS, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = AdminCap{id: 0x2::object::new(arg1)};
        0x2::transfer::public_transfer<AdminCap>(v0, @0x552c4e45ef071c3c14e75a5247a9c5dd4e7430e3783e217b663aab1d926d8fa5);
        let v1 = Counter{
            id      : 0x2::object::new(arg1),
            next_id : 1,
        };
        0x2::transfer::share_object<Counter>(v1);
        let v2 = MintConfig{
            id                  : 0x2::object::new(arg1),
            paused              : false,
            default_stage_limit : 1,
            total_mint_limit    : 1,
            per_stage_limits    : 0x2::table::new<u64, u64>(arg1),
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
            recipient : @0x552c4e45ef071c3c14e75a5247a9c5dd4e7430e3783e217b663aab1d926d8fa5,
        };
        0x2::transfer::share_object<Payout>(v4);
        let v5 = MintStats{
            id          : 0x2::object::new(arg1),
            per_address : 0x2::table::new<address, u64>(arg1),
            used_sigs   : 0x2::table::new<vector<u8>, bool>(arg1),
            per_stage   : 0x2::table::new<u64, 0x2::table::Table<address, u64>>(arg1),
        };
        0x2::transfer::share_object<MintStats>(v5);
        let v6 = TraitsRegistry{
            id     : 0x2::object::new(arg1),
            traits : 0x2::table::new<u64, CaptainAttributes>(arg1),
        };
        0x2::transfer::share_object<TraitsRegistry>(v6);
        let v7 = RevealedImagesRegistry{
            id   : 0x2::object::new(arg1),
            urls : 0x2::table::new<u64, 0x1::string::String>(arg1),
        };
        0x2::transfer::share_object<RevealedImagesRegistry>(v7);
        let v8 = 0x2::package::claim<THE_CAPTAINS>(arg0, arg1);
        let v9 = 0x1::vector::empty<0x1::string::String>();
        let v10 = &mut v9;
        0x1::vector::push_back<0x1::string::String>(v10, 0x1::string::utf8(b"name"));
        0x1::vector::push_back<0x1::string::String>(v10, 0x1::string::utf8(b"image_url"));
        0x1::vector::push_back<0x1::string::String>(v10, 0x1::string::utf8(b"project_url"));
        0x1::vector::push_back<0x1::string::String>(v10, 0x1::string::utf8(b"creator"));
        0x1::vector::push_back<0x1::string::String>(v10, 0x1::string::utf8(b"description"));
        0x1::vector::push_back<0x1::string::String>(v10, 0x1::string::utf8(b"attributes"));
        let v11 = 0x1::vector::empty<0x1::string::String>();
        let v12 = &mut v11;
        0x1::vector::push_back<0x1::string::String>(v12, 0x1::string::utf8(b"The Captains #{token_id}"));
        0x1::vector::push_back<0x1::string::String>(v12, 0x1::string::utf8(b"{url}"));
        0x1::vector::push_back<0x1::string::String>(v12, 0x1::string::utf8(b"https://talentum.id"));
        0x1::vector::push_back<0x1::string::String>(v12, 0x1::string::utf8(b"Coral Reef"));
        0x1::vector::push_back<0x1::string::String>(v12, 0x1::string::utf8(b"3,333 captains are ready to assemble their crews, board their ships, and set sail to explore the Coral Reef."));
        0x1::vector::push_back<0x1::string::String>(v12, 0x1::string::utf8(b"{attributes}"));
        let v13 = 0x2::display::new_with_fields<PfpNFT>(&v8, v9, v11, arg1);
        0x2::display::update_version<PfpNFT>(&mut v13);
        let (v14, v15) = 0x2::transfer_policy::new<PfpNFT>(&v8, arg1);
        0x2::transfer::public_share_object<0x2::transfer_policy::TransferPolicy<PfpNFT>>(v14);
        0x2::transfer::public_transfer<0x2::transfer_policy::TransferPolicyCap<PfpNFT>>(v15, @0x552c4e45ef071c3c14e75a5247a9c5dd4e7430e3783e217b663aab1d926d8fa5);
        0x2::transfer::public_transfer<0x2::package::Publisher>(v8, @0x552c4e45ef071c3c14e75a5247a9c5dd4e7430e3783e217b663aab1d926d8fa5);
        0x2::transfer::public_transfer<0x2::display::Display<PfpNFT>>(v13, @0x552c4e45ef071c3c14e75a5247a9c5dd4e7430e3783e217b663aab1d926d8fa5);
    }

    public fun is_image_url_loaded(arg0: &RevealedImagesRegistry, arg1: u64) : bool {
        0x2::table::contains<u64, 0x1::string::String>(&arg0.urls, arg1)
    }

    public fun is_mint_paused(arg0: &MintConfig) : bool {
        arg0.paused
    }

    public fun is_revealed(arg0: &PfpNFT) : bool {
        arg0.is_revealed
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

    public fun mint(arg0: &PubKey, arg1: u64, arg2: u64, arg3: u64, arg4: address, arg5: vector<u8>, arg6: u8, arg7: u64, arg8: 0x1::string::String, arg9: 0x1::string::String, arg10: 0x1::string::String, arg11: &mut Counter, arg12: &MintConfig, arg13: &mut MintStats, arg14: &Payout, arg15: 0x2::coin::Coin<0x2::sui::SUI>, arg16: &0x2::transfer_policy::TransferPolicy<PfpNFT>, arg17: &0x2::clock::Clock, arg18: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::kiosk::new(arg18);
        let v2 = v1;
        let v3 = v0;
        let v4 = &mut v3;
        mint_core(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10, arg11, arg12, arg13, arg14, arg15, arg16, v4, &v2, arg17, arg18);
        let v5 = KioskCreated{
            kiosk_id : 0x2::object::id<0x2::kiosk::Kiosk>(&v3),
            cap_id   : 0x2::object::id<0x2::kiosk::KioskOwnerCap>(&v2),
        };
        0x2::event::emit<KioskCreated>(v5);
        0x2::transfer::public_share_object<0x2::kiosk::Kiosk>(v3);
        0x2::transfer::public_transfer<0x2::kiosk::KioskOwnerCap>(v2, 0x2::tx_context::sender(arg18));
    }

    fun mint_core(arg0: &PubKey, arg1: u64, arg2: u64, arg3: u64, arg4: address, arg5: vector<u8>, arg6: u8, arg7: u64, arg8: 0x1::string::String, arg9: 0x1::string::String, arg10: 0x1::string::String, arg11: &mut Counter, arg12: &MintConfig, arg13: &mut MintStats, arg14: &Payout, arg15: 0x2::coin::Coin<0x2::sui::SUI>, arg16: &0x2::transfer_policy::TransferPolicy<PfpNFT>, arg17: &mut 0x2::kiosk::Kiosk, arg18: &0x2::kiosk::KioskOwnerCap, arg19: &0x2::clock::Clock, arg20: &mut 0x2::tx_context::TxContext) {
        assert!(!arg12.paused, 8);
        assert!(arg0.pubkey_set, 1);
        let v0 = 0x2::clock::timestamp_ms(arg19);
        assert!(arg1 > v0 / 1000, 2);
        assert!(arg3 > 0, 5);
        assert!(arg11.next_id + arg3 <= 3333, 9);
        let v1 = 0x1::string::into_bytes(arg8);
        0x1::vector::append<u8>(&mut v1, 0x1::string::into_bytes(arg9));
        0x1::vector::append<u8>(&mut v1, 0x1::string::into_bytes(0x1::u64::to_string(arg1)));
        0x1::vector::append<u8>(&mut v1, 0x1::string::into_bytes(0x1::u64::to_string(arg2)));
        0x1::vector::append<u8>(&mut v1, 0x1::string::into_bytes(0x1::u64::to_string(arg3)));
        0x1::vector::append<u8>(&mut v1, 0x1::string::into_bytes(0x1::u64::to_string(arg7)));
        0x1::vector::append<u8>(&mut v1, 0x1::string::into_bytes(arg10));
        assert!(is_valid_hash_alg(arg6), 15);
        assert!(0x2::ecdsa_k1::secp256k1_verify(&arg5, &arg0.pubkey_bytes, &v1, arg6), 3);
        let v2 = clone_vec_u8(&arg5);
        assert!(!0x2::table::contains<vector<u8>, bool>(&arg13.used_sigs, v2), 4);
        let v3 = take_suffix(&v1, 66);
        assert_minter_text_matches_prefixed64(arg4, &v3);
        let v4 = 0x2::tx_context::sender(arg20);
        assert!(v4 == arg4, 6);
        assert!(get_stage_count(arg13, arg7, v4) + arg3 <= get_stage_limit(arg12, arg7), 10);
        assert!(get_mint_count(arg13, v4) + arg3 <= arg12.total_mint_limit, 11);
        if (0x2::table::contains<address, u64>(&arg13.per_address, v4)) {
            let v5 = 0x2::table::borrow_mut<address, u64>(&mut arg13.per_address, v4);
            *v5 = *v5 + arg3;
        } else {
            0x2::table::add<address, u64>(&mut arg13.per_address, v4, arg3);
        };
        ensure_stage_bucket(arg13, arg7, arg20);
        if (0x2::table::contains<address, u64>(0x2::table::borrow<u64, 0x2::table::Table<address, u64>>(&arg13.per_stage, arg7), v4)) {
            let v6 = 0x2::table::borrow_mut<address, u64>(0x2::table::borrow_mut<u64, 0x2::table::Table<address, u64>>(&mut arg13.per_stage, arg7), v4);
            *v6 = *v6 + arg3;
        } else {
            0x2::table::add<address, u64>(0x2::table::borrow_mut<u64, 0x2::table::Table<address, u64>>(&mut arg13.per_stage, arg7), v4, arg3);
        };
        assert!(0x2::coin::value<0x2::sui::SUI>(&arg15) == arg2, 5);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(arg15, arg14.recipient);
        0x2::table::add<vector<u8>, bool>(&mut arg13.used_sigs, v2, true);
        let v7 = 0;
        while (v7 < arg3) {
            let v8 = arg11.next_id;
            arg11.next_id = v8 + 1;
            let v9 = PfpNFT{
                id          : 0x2::object::new(arg20),
                token_id    : v8,
                is_revealed : false,
                attributes  : 0x2::vec_map::empty<0x1::string::String, 0x1::string::String>(),
                number      : 0x1::string::utf8(b""),
                url         : 0x1::string::utf8(b""),
            };
            v9.number = 0x1::u64::to_string(v8);
            let v10 = 0x1::string::utf8(b"https://dev-sui-api.talentum.id/api/the-captains/nft/image/");
            0x1::string::append(&mut v10, 0x1::u64::to_string(v8));
            v9.url = v10;
            let v11 = MintEvent{
                minter       : v4,
                token_id     : v8,
                amount       : arg2,
                timestamp_ms : v0,
                mint_stage   : arg7,
                signature    : clone_vec_u8(&v2),
            };
            0x2::event::emit<MintEvent>(v11);
            0x2::kiosk::lock<PfpNFT>(arg17, arg18, arg16, v9);
            v7 = v7 + 1;
        };
    }

    public fun reveal(arg0: &mut 0x2::kiosk::Kiosk, arg1: &0x2::kiosk::KioskOwnerCap, arg2: &mut TraitsRegistry, arg3: &mut RevealedImagesRegistry, arg4: 0x2::object::ID, arg5: &0x2::tx_context::TxContext) {
        let v0 = 0x2::kiosk::borrow_mut<PfpNFT>(arg0, arg1, arg4);
        assert!(!v0.is_revealed, 14);
        assert!(0x2::table::contains<u64, CaptainAttributes>(&arg2.traits, v0.token_id), 12);
        assert!(0x2::table::contains<u64, 0x1::string::String>(&arg3.urls, v0.token_id), 13);
        let v1 = 0x2::table::remove<u64, CaptainAttributes>(&mut arg2.traits, v0.token_id);
        0x2::vec_map::insert<0x1::string::String, 0x1::string::String>(&mut v0.attributes, 0x1::string::utf8(b"Horizon"), v1.horizon);
        0x2::vec_map::insert<0x1::string::String, 0x1::string::String>(&mut v0.attributes, 0x1::string::utf8(b"Sex"), v1.sex);
        0x2::vec_map::insert<0x1::string::String, 0x1::string::String>(&mut v0.attributes, 0x1::string::utf8(b"Physique"), v1.physique);
        0x2::vec_map::insert<0x1::string::String, 0x1::string::String>(&mut v0.attributes, 0x1::string::utf8(b"Companion"), v1.companion);
        0x2::vec_map::insert<0x1::string::String, 0x1::string::String>(&mut v0.attributes, 0x1::string::utf8(b"Garb"), v1.garb);
        0x2::vec_map::insert<0x1::string::String, 0x1::string::String>(&mut v0.attributes, 0x1::string::utf8(b"Whiskers"), v1.whiskers);
        0x2::vec_map::insert<0x1::string::String, 0x1::string::String>(&mut v0.attributes, 0x1::string::utf8(b"Headgear"), v1.headgear);
        0x2::vec_map::insert<0x1::string::String, 0x1::string::String>(&mut v0.attributes, 0x1::string::utf8(b"Gaze"), v1.gaze);
        0x2::vec_map::insert<0x1::string::String, 0x1::string::String>(&mut v0.attributes, 0x1::string::utf8(b"Trinkets"), v1.trinkets);
        0x2::vec_map::insert<0x1::string::String, 0x1::string::String>(&mut v0.attributes, 0x1::string::utf8(b"Armament"), v1.armament);
        v0.url = 0x2::table::remove<u64, 0x1::string::String>(&mut arg3.urls, v0.token_id);
        v0.is_revealed = true;
        let v2 = CaptainRevealed{
            captain_id  : 0x2::object::uid_to_inner(&v0.id),
            token_id    : v0.token_id,
            revealed_by : 0x2::tx_context::sender(arg5),
        };
        0x2::event::emit<CaptainRevealed>(v2);
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

