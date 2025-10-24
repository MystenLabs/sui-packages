module 0xb5135a46dcf6aa827acf25d4133cef5bdbb760babe721e891b1e04af181497f4::the_captains {
    struct THE_CAPTAINS has drop {
        dummy_field: bool,
    }

    struct AdminCap has store, key {
        id: 0x2::object::UID,
        owner: address,
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

    struct MintConfig has store, key {
        id: 0x2::object::UID,
        paused: bool,
        default_stage_limit: u64,
        per_stage_limits: 0x2::table::Table<u64, u64>,
    }

    struct Payout has store, key {
        id: 0x2::object::UID,
        recipient: address,
    }

    struct PfpNFT has store, key {
        id: 0x2::object::UID,
        token_id: u64,
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

    public fun admin_add_lock_rule(arg0: &AdminCap, arg1: &mut 0x2::transfer_policy::TransferPolicy<PfpNFT>, arg2: &0x2::transfer_policy::TransferPolicyCap<PfpNFT>) {
    }

    public fun admin_add_royalty_rule(arg0: &AdminCap, arg1: &mut 0x2::transfer_policy::TransferPolicy<PfpNFT>, arg2: &0x2::transfer_policy::TransferPolicyCap<PfpNFT>, arg3: u16, arg4: u64) {
        0xb5135a46dcf6aa827acf25d4133cef5bdbb760babe721e891b1e04af181497f4::fixed_royalty_rule::add<PfpNFT>(arg1, arg2, arg3, arg4);
    }

    public fun admin_bump_display_version(arg0: &AdminCap, arg1: &mut 0x2::display::Display<PfpNFT>) {
        0x2::display::update_version<PfpNFT>(arg1);
    }

    public fun admin_pause_mint(arg0: &AdminCap, arg1: &mut MintConfig) {
        arg1.paused = true;
    }

    public fun admin_resume_mint(arg0: &AdminCap, arg1: &mut MintConfig) {
        arg1.paused = false;
    }

    public fun admin_set_default_stage_limit(arg0: &AdminCap, arg1: &mut MintConfig, arg2: u64) {
        arg1.default_stage_limit = arg2;
    }

    public fun admin_set_description(arg0: &AdminCap, arg1: &mut 0x2::display::Display<PfpNFT>, arg2: 0x1::string::String) {
        0x2::display::edit<PfpNFT>(arg1, 0x1::string::utf8(b"description"), arg2);
        0x2::display::update_version<PfpNFT>(arg1);
    }

    public fun admin_set_image_and_metadata_templates(arg0: &AdminCap, arg1: &mut 0x2::display::Display<PfpNFT>, arg2: 0x1::string::String, arg3: 0x1::string::String) {
        0x2::display::edit<PfpNFT>(arg1, 0x1::string::utf8(b"image_url"), arg2);
        let v0 = 0x1::string::into_bytes(arg3);
        0x2::display::edit<PfpNFT>(arg1, 0x1::string::utf8(b"metadata_url"), 0x1::string::utf8(v0));
        0x2::display::edit<PfpNFT>(arg1, 0x1::string::utf8(b"link"), 0x1::string::utf8(clone_vec_u8(&v0)));
        0x2::display::update_version<PfpNFT>(arg1);
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

    public fun admin_transfer_admincap(arg0: AdminCap, arg1: address) {
        arg0.owner = arg1;
        0x2::transfer::public_transfer<AdminCap>(arg0, arg1);
    }

    public fun admin_withdraw_policy_fees(arg0: &AdminCap, arg1: &mut 0x2::transfer_policy::TransferPolicy<PfpNFT>, arg2: &0x2::transfer_policy::TransferPolicyCap<PfpNFT>, arg3: &Payout, arg4: 0x1::option::Option<u64>, arg5: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::transfer_policy::withdraw<PfpNFT>(arg1, arg2, arg4, arg5), arg3.recipient);
    }

    fun assert_minter_text_matches_prefixed64(arg0: address, arg1: &vector<u8>) {
        assert!(0x1::vector::length<u8>(arg1) == 66, 9);
        assert!(*0x1::vector::borrow<u8>(arg1, 0) == 48, 9);
        let v0 = *0x1::vector::borrow<u8>(arg1, 1);
        assert!(v0 == 120 || v0 == 88, 9);
        let v1 = 0x1::vector::empty<u8>();
        let v2 = 2;
        while (v2 < 66) {
            0x1::vector::push_back<u8>(&mut v1, *0x1::vector::borrow<u8>(arg1, v2));
            v2 = v2 + 1;
        };
        assert!(0x2::address::from_ascii_bytes(&v1) == arg0, 9);
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

    public fun create_kiosk(arg0: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::kiosk::new(arg0);
        0x2::transfer::public_share_object<0x2::kiosk::Kiosk>(v0);
        0x2::transfer::public_transfer<0x2::kiosk::KioskOwnerCap>(v1, 0x2::tx_context::sender(arg0));
    }

    fun ensure_stage_bucket(arg0: &mut MintStats, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) {
        if (!0x2::table::contains<u64, 0x2::table::Table<address, u64>>(&arg0.per_stage, arg1)) {
            0x2::table::add<u64, 0x2::table::Table<address, u64>>(&mut arg0.per_stage, arg1, 0x2::table::new<address, u64>(arg2));
        };
    }

    fun get_stage_limit(arg0: &MintConfig, arg1: u64) : u64 {
        if (0x2::table::contains<u64, u64>(&arg0.per_stage_limits, arg1)) {
            *0x2::table::borrow<u64, u64>(&arg0.per_stage_limits, arg1)
        } else {
            arg0.default_stage_limit
        }
    }

    fun init(arg0: THE_CAPTAINS, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = AdminCap{
            id    : 0x2::object::new(arg1),
            owner : @0x552c4e45ef071c3c14e75a5247a9c5dd4e7430e3783e217b663aab1d926d8fa5,
        };
        0x2::transfer::public_transfer<AdminCap>(v0, @0x552c4e45ef071c3c14e75a5247a9c5dd4e7430e3783e217b663aab1d926d8fa5);
        let v1 = Counter{
            id      : 0x2::object::new(arg1),
            next_id : 0,
        };
        0x2::transfer::share_object<Counter>(v1);
        let v2 = MintConfig{
            id                  : 0x2::object::new(arg1),
            paused              : false,
            default_stage_limit : 1,
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
        let v6 = 0x2::package::claim<THE_CAPTAINS>(arg0, arg1);
        let v7 = 0x1::vector::empty<0x1::string::String>();
        let v8 = &mut v7;
        0x1::vector::push_back<0x1::string::String>(v8, 0x1::string::utf8(b"name"));
        0x1::vector::push_back<0x1::string::String>(v8, 0x1::string::utf8(b"image_url"));
        0x1::vector::push_back<0x1::string::String>(v8, 0x1::string::utf8(b"metadata_url"));
        0x1::vector::push_back<0x1::string::String>(v8, 0x1::string::utf8(b"link"));
        0x1::vector::push_back<0x1::string::String>(v8, 0x1::string::utf8(b"description"));
        let v9 = 0x1::vector::empty<0x1::string::String>();
        let v10 = &mut v9;
        0x1::vector::push_back<0x1::string::String>(v10, 0x1::string::utf8(b"The Captains"));
        0x1::vector::push_back<0x1::string::String>(v10, 0x1::string::utf8(b"https://dev-sui-api.talentum.id/api/the-captains/nft/image/{token_id}"));
        0x1::vector::push_back<0x1::string::String>(v10, 0x1::string::utf8(b"https://dev-sui-api.talentum.id/api/the-captains/nft/metadata/{token_id}"));
        0x1::vector::push_back<0x1::string::String>(v10, 0x1::string::utf8(b"https://dev-sui-api.talentum.id/api/the-captains/nft/metadata/{token_id}"));
        0x1::vector::push_back<0x1::string::String>(v10, 0x1::string::utf8(b"The Captains collection"));
        let v11 = 0x2::display::new_with_fields<PfpNFT>(&v6, v7, v9, arg1);
        0x2::display::update_version<PfpNFT>(&mut v11);
        let (v12, v13) = 0x2::transfer_policy::new<PfpNFT>(&v6, arg1);
        let v14 = v13;
        let v15 = v12;
        0xb5135a46dcf6aa827acf25d4133cef5bdbb760babe721e891b1e04af181497f4::fixed_royalty_rule::add<PfpNFT>(&mut v15, &v14, 100, 10000000);
        0x2::transfer::public_share_object<0x2::transfer_policy::TransferPolicy<PfpNFT>>(v15);
        0x2::transfer::public_transfer<0x2::transfer_policy::TransferPolicyCap<PfpNFT>>(v14, @0x552c4e45ef071c3c14e75a5247a9c5dd4e7430e3783e217b663aab1d926d8fa5);
        0x2::transfer::public_transfer<0x2::package::Publisher>(v6, @0x552c4e45ef071c3c14e75a5247a9c5dd4e7430e3783e217b663aab1d926d8fa5);
        0x2::transfer::public_transfer<0x2::display::Display<PfpNFT>>(v11, @0x552c4e45ef071c3c14e75a5247a9c5dd4e7430e3783e217b663aab1d926d8fa5);
    }

    public fun is_mint_paused(arg0: &MintConfig) : bool {
        arg0.paused
    }

    public fun lock_and_list(arg0: &mut 0x2::kiosk::Kiosk, arg1: &0x2::kiosk::KioskOwnerCap, arg2: &0x2::transfer_policy::TransferPolicy<PfpNFT>, arg3: PfpNFT, arg4: u64) {
        0x2::kiosk::lock<PfpNFT>(arg0, arg1, arg2, arg3);
        0x2::kiosk::list<PfpNFT>(arg0, arg1, 0x2::object::id<PfpNFT>(&arg3), arg4);
    }

    public fun mint(arg0: &PubKey, arg1: u64, arg2: u64, arg3: u64, arg4: address, arg5: vector<u8>, arg6: u8, arg7: u64, arg8: 0x1::string::String, arg9: 0x1::string::String, arg10: 0x1::string::String, arg11: &mut Counter, arg12: &MintConfig, arg13: &mut MintStats, arg14: &Payout, arg15: 0x2::coin::Coin<0x2::sui::SUI>, arg16: &0x2::transfer_policy::TransferPolicy<PfpNFT>, arg17: &mut 0x2::kiosk::Kiosk, arg18: &0x2::kiosk::KioskOwnerCap, arg19: &0x2::clock::Clock, arg20: &mut 0x2::tx_context::TxContext) {
        assert!(!arg12.paused, 7);
        assert!(arg0.pubkey_set, 1);
        let v0 = 0x2::clock::timestamp_ms(arg19);
        assert!(arg1 > v0 / 1000, 2);
        assert!(arg3 > 0, 4);
        assert!(arg11.next_id + arg3 <= 3333, 5);
        let v1 = 0x1::string::into_bytes(arg8);
        0x1::vector::append<u8>(&mut v1, 0x1::string::into_bytes(arg9));
        0x1::vector::append<u8>(&mut v1, 0x1::string::into_bytes(0x1::u64::to_string(arg1)));
        0x1::vector::append<u8>(&mut v1, 0x1::string::into_bytes(0x1::u64::to_string(arg2)));
        0x1::vector::append<u8>(&mut v1, 0x1::string::into_bytes(0x1::u64::to_string(arg3)));
        0x1::vector::append<u8>(&mut v1, 0x1::string::into_bytes(0x1::u64::to_string(arg7)));
        0x1::vector::append<u8>(&mut v1, 0x1::string::into_bytes(arg10));
        assert!(0x2::ecdsa_k1::secp256k1_verify(&arg5, &arg0.pubkey_bytes, &v1, arg6), 3);
        assert!(!0x2::table::contains<vector<u8>, bool>(&arg13.used_sigs, clone_vec_u8(&arg5)), 10);
        let v2 = take_suffix(&v1, 66);
        assert_minter_text_matches_prefixed64(arg4, &v2);
        let v3 = 0x2::tx_context::sender(arg20);
        assert!(v3 == arg4, 6);
        assert!(minted_count_in_stage(arg13, arg7, v3) + arg3 <= get_stage_limit(arg12, arg7), 11);
        if (0x2::table::contains<address, u64>(&arg13.per_address, v3)) {
            let v4 = 0x2::table::borrow_mut<address, u64>(&mut arg13.per_address, v3);
            *v4 = *v4 + arg3;
        } else {
            0x2::table::add<address, u64>(&mut arg13.per_address, v3, arg3);
        };
        ensure_stage_bucket(arg13, arg7, arg20);
        if (0x2::table::contains<address, u64>(0x2::table::borrow<u64, 0x2::table::Table<address, u64>>(&arg13.per_stage, arg7), v3)) {
            let v5 = 0x2::table::borrow_mut<address, u64>(0x2::table::borrow_mut<u64, 0x2::table::Table<address, u64>>(&mut arg13.per_stage, arg7), v3);
            *v5 = *v5 + arg3;
        } else {
            0x2::table::add<address, u64>(0x2::table::borrow_mut<u64, 0x2::table::Table<address, u64>>(&mut arg13.per_stage, arg7), v3, arg3);
        };
        assert!(0x2::coin::value<0x2::sui::SUI>(&arg15) == arg2, 4);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(arg15, arg14.recipient);
        0x2::table::add<vector<u8>, bool>(&mut arg13.used_sigs, clone_vec_u8(&arg5), true);
        let v6 = 0;
        while (v6 < arg3) {
            let v7 = arg11.next_id;
            arg11.next_id = v7 + 1;
            let v8 = PfpNFT{
                id       : 0x2::object::new(arg20),
                token_id : v7,
            };
            let v9 = MintEvent{
                minter       : v3,
                token_id     : v7,
                amount       : arg2,
                timestamp_ms : v0,
                mint_stage   : arg7,
                signature    : clone_vec_u8(&arg5),
            };
            0x2::event::emit<MintEvent>(v9);
            0x2::kiosk::lock<PfpNFT>(arg17, arg18, arg16, v8);
            v6 = v6 + 1;
        };
    }

    public fun mint_free(arg0: &PubKey, arg1: u64, arg2: u64, arg3: u64, arg4: address, arg5: vector<u8>, arg6: u8, arg7: u64, arg8: 0x1::string::String, arg9: 0x1::string::String, arg10: 0x1::string::String, arg11: &mut Counter, arg12: &MintConfig, arg13: &mut MintStats, arg14: &0x2::transfer_policy::TransferPolicy<PfpNFT>, arg15: &mut 0x2::kiosk::Kiosk, arg16: &0x2::kiosk::KioskOwnerCap, arg17: &0x2::clock::Clock, arg18: &mut 0x2::tx_context::TxContext) {
        assert!(!arg12.paused, 7);
        assert!(arg0.pubkey_set, 1);
        let v0 = 0x2::clock::timestamp_ms(arg17);
        assert!(arg1 > v0 / 1000, 2);
        assert!(arg3 > 0, 8);
        assert!(arg11.next_id + arg3 <= 3333, 5);
        assert!(arg2 == 0, 8);
        let v1 = 0x1::string::into_bytes(arg8);
        0x1::vector::append<u8>(&mut v1, 0x1::string::into_bytes(arg9));
        0x1::vector::append<u8>(&mut v1, 0x1::string::into_bytes(0x1::u64::to_string(arg1)));
        0x1::vector::append<u8>(&mut v1, 0x1::string::into_bytes(0x1::u64::to_string(arg2)));
        0x1::vector::append<u8>(&mut v1, 0x1::string::into_bytes(0x1::u64::to_string(arg3)));
        0x1::vector::append<u8>(&mut v1, 0x1::string::into_bytes(0x1::u64::to_string(arg7)));
        0x1::vector::append<u8>(&mut v1, 0x1::string::into_bytes(arg10));
        assert!(0x2::ecdsa_k1::secp256k1_verify(&arg5, &arg0.pubkey_bytes, &v1, arg6), 3);
        assert!(!0x2::table::contains<vector<u8>, bool>(&arg13.used_sigs, clone_vec_u8(&arg5)), 10);
        let v2 = take_suffix(&v1, 66);
        assert_minter_text_matches_prefixed64(arg4, &v2);
        let v3 = 0x2::tx_context::sender(arg18);
        assert!(v3 == arg4, 6);
        assert!(minted_count_in_stage(arg13, arg7, v3) + arg3 <= get_stage_limit(arg12, arg7), 11);
        if (0x2::table::contains<address, u64>(&arg13.per_address, v3)) {
            let v4 = 0x2::table::borrow_mut<address, u64>(&mut arg13.per_address, v3);
            *v4 = *v4 + arg3;
        } else {
            0x2::table::add<address, u64>(&mut arg13.per_address, v3, arg3);
        };
        ensure_stage_bucket(arg13, arg7, arg18);
        if (0x2::table::contains<address, u64>(0x2::table::borrow<u64, 0x2::table::Table<address, u64>>(&arg13.per_stage, arg7), v3)) {
            let v5 = 0x2::table::borrow_mut<address, u64>(0x2::table::borrow_mut<u64, 0x2::table::Table<address, u64>>(&mut arg13.per_stage, arg7), v3);
            *v5 = *v5 + arg3;
        } else {
            0x2::table::add<address, u64>(0x2::table::borrow_mut<u64, 0x2::table::Table<address, u64>>(&mut arg13.per_stage, arg7), v3, arg3);
        };
        0x2::table::add<vector<u8>, bool>(&mut arg13.used_sigs, clone_vec_u8(&arg5), true);
        let v6 = 0;
        while (v6 < arg3) {
            let v7 = arg11.next_id;
            arg11.next_id = v7 + 1;
            let v8 = PfpNFT{
                id       : 0x2::object::new(arg18),
                token_id : v7,
            };
            let v9 = MintEvent{
                minter       : v3,
                token_id     : v7,
                amount       : 0,
                timestamp_ms : v0,
                mint_stage   : arg7,
                signature    : clone_vec_u8(&arg5),
            };
            0x2::event::emit<MintEvent>(v9);
            0x2::kiosk::lock<PfpNFT>(arg15, arg16, arg14, v8);
            v6 = v6 + 1;
        };
    }

    public fun minted_count(arg0: &MintStats, arg1: address) : u64 {
        if (0x2::table::contains<address, u64>(&arg0.per_address, arg1)) {
            *0x2::table::borrow<address, u64>(&arg0.per_address, arg1)
        } else {
            0
        }
    }

    public fun minted_count_in_stage(arg0: &MintStats, arg1: u64, arg2: address) : u64 {
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

