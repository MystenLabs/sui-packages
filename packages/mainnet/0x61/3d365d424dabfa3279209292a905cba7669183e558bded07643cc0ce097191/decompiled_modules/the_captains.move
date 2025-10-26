module 0x613d365d424dabfa3279209292a905cba7669183e558bded07643cc0ce097191::the_captains {
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
        rarity: 0x1::string::String,
        is_revealed: bool,
        class: 0x1::string::String,
        weapon: 0x1::string::String,
        outfit: 0x1::string::String,
        background: 0x1::string::String,
        special: 0x1::string::String,
    }

    struct CaptainAttributes has copy, drop, store {
        class: 0x1::string::String,
        weapon: 0x1::string::String,
        outfit: 0x1::string::String,
        background: 0x1::string::String,
        special: 0x1::string::String,
    }

    struct CaptainRevealed has copy, drop {
        captain_id: 0x2::object::ID,
        token_id: u64,
        rarity: 0x1::string::String,
        revealed_by: address,
    }

    struct TraitsRegistry has key {
        id: 0x2::object::UID,
        traits: 0x2::table::Table<u64, CaptainAttributes>,
        rarities: 0x2::table::Table<u64, 0x1::string::String>,
    }

    struct TraitsLoaded has copy, drop {
        token_id: u64,
        rarity: 0x1::string::String,
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

    public fun admin_create_display(arg0: &AdminCap, arg1: &0x2::package::Publisher, arg2: &mut 0x2::tx_context::TxContext) : 0x2::display::Display<PfpNFT> {
        let v0 = 0x1::vector::empty<0x1::string::String>();
        let v1 = &mut v0;
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"name"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"image_url"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"link"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"description"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"rarity"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"class"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"weapon"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"outfit"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"background"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"special"));
        let v2 = 0x1::vector::empty<0x1::string::String>();
        let v3 = &mut v2;
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"The Captains"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"https://dev-sui-api.talentum.id/api/the-captains/nft/image/{token_id}"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"https://talentum.id"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"The Captains collection"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"{rarity}"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"{class}"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"{weapon}"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"{outfit}"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"{background}"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"{special}"));
        let v4 = 0x2::display::new_with_fields<PfpNFT>(arg1, v0, v2, arg2);
        0x2::display::update_version<PfpNFT>(&mut v4);
        v4
    }

    public fun admin_edit_display(arg0: &AdminCap, arg1: &mut 0x2::display::Display<PfpNFT>, arg2: 0x1::string::String, arg3: 0x1::string::String) {
        0x2::display::edit<PfpNFT>(arg1, arg2, arg3);
        0x2::display::update_version<PfpNFT>(arg1);
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

    public entry fun batch_load_traits(arg0: &AdminCap, arg1: &mut TraitsRegistry, arg2: vector<u64>, arg3: vector<0x1::string::String>, arg4: vector<0x1::string::String>, arg5: vector<0x1::string::String>, arg6: vector<0x1::string::String>, arg7: vector<0x1::string::String>, arg8: vector<0x1::string::String>) {
        let v0 = 0x1::vector::length<u64>(&arg2);
        assert!(v0 == 0x1::vector::length<0x1::string::String>(&arg3), 4);
        assert!(v0 == 0x1::vector::length<0x1::string::String>(&arg4), 4);
        assert!(v0 == 0x1::vector::length<0x1::string::String>(&arg5), 4);
        assert!(v0 == 0x1::vector::length<0x1::string::String>(&arg6), 4);
        assert!(v0 == 0x1::vector::length<0x1::string::String>(&arg7), 4);
        assert!(v0 == 0x1::vector::length<0x1::string::String>(&arg8), 4);
        let v1 = 0;
        while (v1 < v0) {
            let v2 = *0x1::vector::borrow<u64>(&arg2, v1);
            let v3 = CaptainAttributes{
                class      : *0x1::vector::borrow<0x1::string::String>(&arg3, v1),
                weapon     : *0x1::vector::borrow<0x1::string::String>(&arg4, v1),
                outfit     : *0x1::vector::borrow<0x1::string::String>(&arg5, v1),
                background : *0x1::vector::borrow<0x1::string::String>(&arg6, v1),
                special    : *0x1::vector::borrow<0x1::string::String>(&arg7, v1),
            };
            0x2::table::add<u64, CaptainAttributes>(&mut arg1.traits, v2, v3);
            let v4 = *0x1::vector::borrow<0x1::string::String>(&arg8, v1);
            0x2::table::add<u64, 0x1::string::String>(&mut arg1.rarities, v2, v4);
            let v5 = TraitsLoaded{
                token_id : v2,
                rarity   : v4,
            };
            0x2::event::emit<TraitsLoaded>(v5);
            v1 = v1 + 1;
        };
    }

    public entry fun claim_and_reveal_from_kiosk(arg0: &mut 0x2::kiosk::Kiosk, arg1: &0x2::kiosk::KioskOwnerCap, arg2: &mut TraitsRegistry, arg3: 0x2::object::ID, arg4: &0x2::tx_context::TxContext) {
        let v0 = 0x2::kiosk::borrow_mut<PfpNFT>(arg0, arg1, arg3);
        assert!(!v0.is_revealed, 12);
        assert!(0x2::table::contains<u64, CaptainAttributes>(&arg2.traits, v0.token_id), 13);
        let v1 = 0x2::table::remove<u64, CaptainAttributes>(&mut arg2.traits, v0.token_id);
        v0.class = v1.class;
        v0.weapon = v1.weapon;
        v0.outfit = v1.outfit;
        v0.background = v1.background;
        v0.special = v1.special;
        v0.rarity = 0x2::table::remove<u64, 0x1::string::String>(&mut arg2.rarities, v0.token_id);
        v0.is_revealed = true;
        let v2 = CaptainRevealed{
            captain_id  : 0x2::object::uid_to_inner(&v0.id),
            token_id    : v0.token_id,
            rarity      : v0.rarity,
            revealed_by : 0x2::tx_context::sender(arg4),
        };
        0x2::event::emit<CaptainRevealed>(v2);
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

    public fun get_attributes(arg0: &PfpNFT) : CaptainAttributes {
        CaptainAttributes{
            class      : arg0.class,
            weapon     : arg0.weapon,
            outfit     : arg0.outfit,
            background : arg0.background,
            special    : arg0.special,
        }
    }

    public fun get_rarity(arg0: &PfpNFT) : 0x1::string::String {
        arg0.rarity
    }

    fun get_stage_limit(arg0: &MintConfig, arg1: u64) : u64 {
        if (0x2::table::contains<u64, u64>(&arg0.per_stage_limits, arg1)) {
            *0x2::table::borrow<u64, u64>(&arg0.per_stage_limits, arg1)
        } else {
            arg0.default_stage_limit
        }
    }

    public fun get_token_id(arg0: &PfpNFT) : u64 {
        arg0.token_id
    }

    fun init(arg0: THE_CAPTAINS, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = AdminCap{id: 0x2::object::new(arg1)};
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
        let v6 = TraitsRegistry{
            id       : 0x2::object::new(arg1),
            traits   : 0x2::table::new<u64, CaptainAttributes>(arg1),
            rarities : 0x2::table::new<u64, 0x1::string::String>(arg1),
        };
        0x2::transfer::share_object<TraitsRegistry>(v6);
        let v7 = 0x2::package::claim<THE_CAPTAINS>(arg0, arg1);
        let v8 = 0x1::vector::empty<0x1::string::String>();
        let v9 = &mut v8;
        0x1::vector::push_back<0x1::string::String>(v9, 0x1::string::utf8(b"name"));
        0x1::vector::push_back<0x1::string::String>(v9, 0x1::string::utf8(b"image_url"));
        0x1::vector::push_back<0x1::string::String>(v9, 0x1::string::utf8(b"link"));
        0x1::vector::push_back<0x1::string::String>(v9, 0x1::string::utf8(b"description"));
        0x1::vector::push_back<0x1::string::String>(v9, 0x1::string::utf8(b"rarity"));
        0x1::vector::push_back<0x1::string::String>(v9, 0x1::string::utf8(b"class"));
        0x1::vector::push_back<0x1::string::String>(v9, 0x1::string::utf8(b"weapon"));
        0x1::vector::push_back<0x1::string::String>(v9, 0x1::string::utf8(b"outfit"));
        0x1::vector::push_back<0x1::string::String>(v9, 0x1::string::utf8(b"background"));
        0x1::vector::push_back<0x1::string::String>(v9, 0x1::string::utf8(b"special"));
        let v10 = 0x1::vector::empty<0x1::string::String>();
        let v11 = &mut v10;
        0x1::vector::push_back<0x1::string::String>(v11, 0x1::string::utf8(b"The Captains"));
        0x1::vector::push_back<0x1::string::String>(v11, 0x1::string::utf8(b"https://dev-sui-api.talentum.id/api/the-captains/nft/image/{token_id}"));
        0x1::vector::push_back<0x1::string::String>(v11, 0x1::string::utf8(b"https://talentum.id"));
        0x1::vector::push_back<0x1::string::String>(v11, 0x1::string::utf8(b"The Captains collection"));
        0x1::vector::push_back<0x1::string::String>(v11, 0x1::string::utf8(b"{rarity}"));
        0x1::vector::push_back<0x1::string::String>(v11, 0x1::string::utf8(b"{class}"));
        0x1::vector::push_back<0x1::string::String>(v11, 0x1::string::utf8(b"{weapon}"));
        0x1::vector::push_back<0x1::string::String>(v11, 0x1::string::utf8(b"{outfit}"));
        0x1::vector::push_back<0x1::string::String>(v11, 0x1::string::utf8(b"{background}"));
        0x1::vector::push_back<0x1::string::String>(v11, 0x1::string::utf8(b"{special}"));
        let v12 = 0x2::display::new_with_fields<PfpNFT>(&v7, v8, v10, arg1);
        0x2::display::update_version<PfpNFT>(&mut v12);
        let (v13, v14) = 0x2::transfer_policy::new<PfpNFT>(&v7, arg1);
        0x2::transfer::public_share_object<0x2::transfer_policy::TransferPolicy<PfpNFT>>(v13);
        0x2::transfer::public_transfer<0x2::transfer_policy::TransferPolicyCap<PfpNFT>>(v14, @0x552c4e45ef071c3c14e75a5247a9c5dd4e7430e3783e217b663aab1d926d8fa5);
        0x2::transfer::public_transfer<0x2::package::Publisher>(v7, @0x552c4e45ef071c3c14e75a5247a9c5dd4e7430e3783e217b663aab1d926d8fa5);
        0x2::transfer::public_transfer<0x2::display::Display<PfpNFT>>(v12, @0x552c4e45ef071c3c14e75a5247a9c5dd4e7430e3783e217b663aab1d926d8fa5);
    }

    public fun is_mint_paused(arg0: &MintConfig) : bool {
        arg0.paused
    }

    public fun is_revealed(arg0: &PfpNFT) : bool {
        arg0.is_revealed
    }

    public entry fun load_traits(arg0: &AdminCap, arg1: &mut TraitsRegistry, arg2: u64, arg3: 0x1::string::String, arg4: 0x1::string::String, arg5: 0x1::string::String, arg6: 0x1::string::String, arg7: 0x1::string::String, arg8: 0x1::string::String) {
        let v0 = CaptainAttributes{
            class      : arg3,
            weapon     : arg4,
            outfit     : arg5,
            background : arg6,
            special    : arg7,
        };
        0x2::table::add<u64, CaptainAttributes>(&mut arg1.traits, arg2, v0);
        0x2::table::add<u64, 0x1::string::String>(&mut arg1.rarities, arg2, arg8);
        let v1 = TraitsLoaded{
            token_id : arg2,
            rarity   : arg8,
        };
        0x2::event::emit<TraitsLoaded>(v1);
    }

    public fun lock_and_list(arg0: &mut 0x2::kiosk::Kiosk, arg1: &0x2::kiosk::KioskOwnerCap, arg2: &0x2::transfer_policy::TransferPolicy<PfpNFT>, arg3: PfpNFT, arg4: u64) {
        0x2::kiosk::lock<PfpNFT>(arg0, arg1, arg2, arg3);
        0x2::kiosk::list<PfpNFT>(arg0, arg1, 0x2::object::id<PfpNFT>(&arg3), arg4);
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
        let v2 = clone_vec_u8(&arg5);
        assert!(!0x2::table::contains<vector<u8>, bool>(&arg13.used_sigs, v2), 10);
        let v3 = take_suffix(&v1, 66);
        assert_minter_text_matches_prefixed64(arg4, &v3);
        let v4 = 0x2::tx_context::sender(arg20);
        assert!(v4 == arg4, 6);
        assert!(minted_count_in_stage(arg13, arg7, v4) + arg3 <= get_stage_limit(arg12, arg7), 11);
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
        assert!(0x2::coin::value<0x2::sui::SUI>(&arg15) == arg2, 4);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(arg15, arg14.recipient);
        0x2::table::add<vector<u8>, bool>(&mut arg13.used_sigs, v2, true);
        let v7 = 0;
        while (v7 < arg3) {
            let v8 = arg11.next_id;
            arg11.next_id = v8 + 1;
            let v9 = PfpNFT{
                id          : 0x2::object::new(arg20),
                token_id    : v8,
                rarity      : 0x1::string::utf8(b"Unrevealed"),
                is_revealed : false,
                class       : 0x1::string::utf8(b""),
                weapon      : 0x1::string::utf8(b""),
                outfit      : 0x1::string::utf8(b""),
                background  : 0x1::string::utf8(b""),
                special     : 0x1::string::utf8(b""),
            };
            let v10 = MintEvent{
                minter       : v4,
                token_id     : v8,
                amount       : arg2,
                timestamp_ms : v0,
                mint_stage   : arg7,
                signature    : clone_vec_u8(&v2),
            };
            0x2::event::emit<MintEvent>(v10);
            0x2::kiosk::lock<PfpNFT>(arg17, arg18, arg16, v9);
            v7 = v7 + 1;
        };
    }

    public fun mint_free(arg0: &PubKey, arg1: u64, arg2: u64, arg3: u64, arg4: address, arg5: vector<u8>, arg6: u8, arg7: u64, arg8: 0x1::string::String, arg9: 0x1::string::String, arg10: 0x1::string::String, arg11: &mut Counter, arg12: &MintConfig, arg13: &mut MintStats, arg14: &0x2::transfer_policy::TransferPolicy<PfpNFT>, arg15: &0x2::clock::Clock, arg16: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::kiosk::new(arg16);
        let v2 = v1;
        let v3 = v0;
        let v4 = &mut v3;
        mint_free_core(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10, arg11, arg12, arg13, arg14, v4, &v2, arg15, arg16);
        let v5 = KioskCreated{
            kiosk_id : 0x2::object::id<0x2::kiosk::Kiosk>(&v3),
            cap_id   : 0x2::object::id<0x2::kiosk::KioskOwnerCap>(&v2),
        };
        0x2::event::emit<KioskCreated>(v5);
        0x2::transfer::public_share_object<0x2::kiosk::Kiosk>(v3);
        0x2::transfer::public_transfer<0x2::kiosk::KioskOwnerCap>(v2, 0x2::tx_context::sender(arg16));
    }

    fun mint_free_core(arg0: &PubKey, arg1: u64, arg2: u64, arg3: u64, arg4: address, arg5: vector<u8>, arg6: u8, arg7: u64, arg8: 0x1::string::String, arg9: 0x1::string::String, arg10: 0x1::string::String, arg11: &mut Counter, arg12: &MintConfig, arg13: &mut MintStats, arg14: &0x2::transfer_policy::TransferPolicy<PfpNFT>, arg15: &mut 0x2::kiosk::Kiosk, arg16: &0x2::kiosk::KioskOwnerCap, arg17: &0x2::clock::Clock, arg18: &mut 0x2::tx_context::TxContext) {
        assert!(!arg12.paused, 7);
        let v0 = 0x2::clock::timestamp_ms(arg17);
        assert!(arg1 > v0 / 1000, 2);
        assert!(arg3 > 0, 8);
        assert!(arg11.next_id + arg3 <= 3333, 5);
        assert!(arg2 == 0, 8);
        let v1 = clone_vec_u8(&arg5);
        let v2 = 0x2::tx_context::sender(arg18);
        assert!(minted_count_in_stage(arg13, arg7, v2) + arg3 <= get_stage_limit(arg12, arg7), 11);
        if (0x2::table::contains<address, u64>(&arg13.per_address, v2)) {
            let v3 = 0x2::table::borrow_mut<address, u64>(&mut arg13.per_address, v2);
            *v3 = *v3 + arg3;
        } else {
            0x2::table::add<address, u64>(&mut arg13.per_address, v2, arg3);
        };
        ensure_stage_bucket(arg13, arg7, arg18);
        if (0x2::table::contains<address, u64>(0x2::table::borrow<u64, 0x2::table::Table<address, u64>>(&arg13.per_stage, arg7), v2)) {
            let v4 = 0x2::table::borrow_mut<address, u64>(0x2::table::borrow_mut<u64, 0x2::table::Table<address, u64>>(&mut arg13.per_stage, arg7), v2);
            *v4 = *v4 + arg3;
        } else {
            0x2::table::add<address, u64>(0x2::table::borrow_mut<u64, 0x2::table::Table<address, u64>>(&mut arg13.per_stage, arg7), v2, arg3);
        };
        let v5 = 0;
        while (v5 < arg3) {
            let v6 = arg11.next_id;
            arg11.next_id = v6 + 1;
            let v7 = PfpNFT{
                id          : 0x2::object::new(arg18),
                token_id    : v6,
                rarity      : 0x1::string::utf8(b"Unrevealed"),
                is_revealed : false,
                class       : 0x1::string::utf8(b""),
                weapon      : 0x1::string::utf8(b""),
                outfit      : 0x1::string::utf8(b""),
                background  : 0x1::string::utf8(b""),
                special     : 0x1::string::utf8(b""),
            };
            let v8 = MintEvent{
                minter       : v2,
                token_id     : v6,
                amount       : 0,
                timestamp_ms : v0,
                mint_stage   : arg7,
                signature    : clone_vec_u8(&v1),
            };
            0x2::event::emit<MintEvent>(v8);
            0x2::kiosk::lock<PfpNFT>(arg15, arg16, arg14, v7);
            v5 = v5 + 1;
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

    public fun preview_traits(arg0: &TraitsRegistry, arg1: u64) : (CaptainAttributes, 0x1::string::String) {
        (*0x2::table::borrow<u64, CaptainAttributes>(&arg0.traits, arg1), *0x2::table::borrow<u64, 0x1::string::String>(&arg0.rarities, arg1))
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

