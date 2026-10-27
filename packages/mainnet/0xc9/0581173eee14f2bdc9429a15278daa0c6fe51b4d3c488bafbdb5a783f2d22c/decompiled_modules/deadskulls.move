module 0xc90581173eee14f2bdc9429a15278daa0c6fe51b4d3c488bafbdb5a783f2d22c::deadskulls {
    struct DEADSKULLS has drop {
        dummy_field: bool,
    }

    struct AdminCap has store, key {
        id: 0x2::object::UID,
    }

    struct Code has copy, drop, store {
        issuer: 0x1::option::Option<address>,
        number: u64,
        used_by: 0x1::option::Option<address>,
    }

    struct Record has copy, drop, store {
        skull: 0x2::object::ID,
        minter: address,
        inviter: 0x1::option::Option<address>,
        via_code: bool,
        referral_paid: u64,
        pass: 0x1::option::Option<0x2::object::ID>,
    }

    struct Collection has key {
        id: 0x2::object::UID,
        supply: u64,
        minted: u64,
        price: u64,
        referral_bps: u64,
        treasury: address,
        codes_open: bool,
        founder_codes: u64,
        paused: bool,
        cursor: u64,
        traits: 0x2::table::Table<u64, vector<u16>>,
        traits_locked: bool,
        library: 0x1::option::Option<0x2::object::ID>,
        codes: 0x2::table::Table<vector<u8>, Code>,
        pass_type: 0x1::option::Option<0x1::type_name::TypeName>,
        passes_used: 0x2::table::Table<0x2::object::ID, u64>,
        records: 0x2::table::Table<u64, Record>,
    }

    struct NFT has store, key {
        id: 0x2::object::UID,
        number: u64,
        traits: vector<u16>,
        image_url: 0x1::string::String,
        attributes: 0x2::vec_map::VecMap<0x1::string::String, 0x1::string::String>,
    }

    struct MintParams has drop {
        price: u64,
        number: u64,
        code: 0x1::option::Option<vector<u8>>,
        inviter: 0x1::option::Option<address>,
        referrer: 0x1::option::Option<address>,
        new_codes: vector<vector<u8>>,
        kiosk: 0x2::object::ID,
        pass: 0x1::option::Option<0x2::object::ID>,
    }

    struct Minted has copy, drop {
        skull_id: 0x2::object::ID,
        number: u64,
        minter: address,
        kiosk: 0x2::object::ID,
        pass: 0x1::option::Option<0x2::object::ID>,
        code: 0x1::option::Option<vector<u8>>,
        referrer: 0x1::option::Option<address>,
        referral_paid: u64,
        treasury_paid: u64,
    }

    struct CodesIssued has copy, drop {
        owner: address,
        number: u64,
        codes: vector<vector<u8>>,
    }

    public fun add_founder_codes(arg0: &mut Collection, arg1: &AdminCap, arg2: vector<vector<u8>>) {
        assert!(0x1::vector::length<vector<u8>>(&arg2) <= 200, 13839282009590857759);
        assert!(arg0.minted < arg0.supply, 13835059889233199105);
        0x1::vector::reverse<vector<u8>>(&mut arg2);
        let v0 = 0;
        while (v0 < 0x1::vector::length<vector<u8>>(&arg2)) {
            let v1 = 0x1::vector::pop_back<vector<u8>>(&mut arg2);
            assert!(0x1::vector::length<u8>(&v1) == 32, 13835622847776817157);
            assert!(!0x2::table::contains<vector<u8>, Code>(&arg0.codes, v1), 13835904327048626183);
            let v2 = Code{
                issuer  : 0x1::option::none<address>(),
                number  : 0,
                used_by : 0x1::option::none<address>(),
            };
            0x2::table::add<vector<u8>, Code>(&mut arg0.codes, v1, v2);
            v0 = v0 + 1;
        };
        0x1::vector::destroy_empty<vector<u8>>(arg2);
        arg0.founder_codes = arg0.founder_codes + 0x1::vector::length<vector<u8>>(&arg2);
    }

    public fun add_traits(arg0: &mut Collection, arg1: &AdminCap, arg2: u64, arg3: vector<vector<u16>>) {
        assert!(!arg0.traits_locked, 13839000637693231133);
        assert!(0x1::vector::length<vector<u16>>(&arg3) <= 500, 13839282116965040159);
        0x1::vector::reverse<vector<u16>>(&mut arg3);
        let v0 = 0;
        while (v0 < 0x1::vector::length<vector<u16>>(&arg3)) {
            assert!(arg2 >= 1 && arg2 <= arg0.supply, 13840970979710992427);
            assert!(!0x2::table::contains<u64, vector<u16>>(&arg0.traits, arg2), 13838719184191225883);
            0x2::table::add<u64, vector<u16>>(&mut arg0.traits, arg2, 0x1::vector::pop_back<vector<u16>>(&mut arg3));
            arg2 = arg2 + 1;
            v0 = v0 + 1;
        };
        0x1::vector::destroy_empty<vector<u16>>(arg3);
    }

    fun assert_mintable(arg0: &Collection, arg1: &0xc90581173eee14f2bdc9429a15278daa0c6fe51b4d3c488bafbdb5a783f2d22c::art::Library) {
        assert!(arg0.minted < arg0.supply, 13835060271485288449);
        assert!(arg0.traits_locked && 0x1::option::is_some<0x2::object::ID>(&arg0.library), 13835341750757097475);
        let v0 = 0x2::object::id<0xc90581173eee14f2bdc9429a15278daa0c6fe51b4d3c488bafbdb5a783f2d22c::art::Library>(arg1);
        assert!(0x1::option::borrow<0x2::object::ID>(&arg0.library) == &v0, 13839563879704690721);
    }

    fun assert_new_codes(arg0: &Collection, arg1: &vector<u8>, arg2: &vector<u8>) {
        assert!(0x1::vector::length<u8>(arg1) == 32 && 0x1::vector::length<u8>(arg2) == 32, 13835623247208775685);
        assert!(arg1 != arg2, 13840408326110052391);
        assert!(!0x2::table::contains<vector<u8>, Code>(&arg0.codes, *arg1) && !0x2::table::contains<vector<u8>, Code>(&arg0.codes, *arg2), 13835904730775552007);
    }

    public fun clear_pass_type(arg0: &mut Collection, arg1: &AdminCap) {
        arg0.pass_type = 0x1::option::none<0x1::type_name::TypeName>();
    }

    public fun code_issuer(arg0: &Collection, arg1: vector<u8>) : 0x1::option::Option<address> {
        0x2::table::borrow<vector<u8>, Code>(&arg0.codes, arg1).issuer
    }

    public fun code_number(arg0: &Collection, arg1: vector<u8>) : u64 {
        0x2::table::borrow<vector<u8>, Code>(&arg0.codes, arg1).number
    }

    public fun code_used_by(arg0: &Collection, arg1: vector<u8>) : 0x1::option::Option<address> {
        0x2::table::borrow<vector<u8>, Code>(&arg0.codes, arg1).used_by
    }

    public fun codes_open(arg0: &Collection) : bool {
        arg0.codes_open
    }

    fun finish_mint(arg0: &mut Collection, arg1: &0xc90581173eee14f2bdc9429a15278daa0c6fe51b4d3c488bafbdb5a783f2d22c::art::Library, arg2: &mut 0x2::coin::Coin<0x2::sui::SUI>, arg3: MintParams, arg4: &mut 0x2::tx_context::TxContext) : NFT {
        let MintParams {
            price     : v0,
            number    : v1,
            code      : v2,
            inviter   : v3,
            referrer  : v4,
            new_codes : v5,
            kiosk     : v6,
            pass      : v7,
        } = arg3;
        let v8 = v5;
        let v9 = v4;
        let v10 = v2;
        let v11 = 0x2::table::remove<u64, vector<u16>>(&mut arg0.traits, v1);
        let (v12, v13, v14) = 0xc90581173eee14f2bdc9429a15278daa0c6fe51b4d3c488bafbdb5a783f2d22c::art::compose(arg1, &v11);
        let v15 = if (0x1::option::is_some<address>(&v9)) {
            (((v0 as u128) * (arg0.referral_bps as u128) / (10000 as u128)) as u64)
        } else {
            0
        };
        let v16 = v0 - v15;
        if (v15 > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::split<0x2::sui::SUI>(arg2, v15, arg4), *0x1::option::borrow<address>(&v9));
        };
        if (v16 > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::split<0x2::sui::SUI>(arg2, v16, arg4), arg0.treasury);
        };
        arg0.minted = arg0.minted + 1;
        let v17 = 0x2::tx_context::sender(arg4);
        if (!0x1::vector::is_empty<vector<u8>>(&v8) && arg0.minted < arg0.supply) {
            let v18 = &v8;
            let v19 = 0;
            while (v19 < 0x1::vector::length<vector<u8>>(v18)) {
                let v20 = Code{
                    issuer  : 0x1::option::some<address>(v17),
                    number  : v1,
                    used_by : 0x1::option::none<address>(),
                };
                0x2::table::add<vector<u8>, Code>(&mut arg0.codes, *0x1::vector::borrow<vector<u8>>(v18, v19), v20);
                v19 = v19 + 1;
            };
            let v21 = CodesIssued{
                owner  : v17,
                number : v1,
                codes  : v8,
            };
            0x2::event::emit<CodesIssued>(v21);
        };
        let v22 = NFT{
            id         : 0x2::object::new(arg4),
            number     : v1,
            traits     : v11,
            image_url  : v12,
            attributes : 0x2::vec_map::from_keys_values<0x1::string::String, 0x1::string::String>(v13, v14),
        };
        let v23 = Record{
            skull         : 0x2::object::id<NFT>(&v22),
            minter        : v17,
            inviter       : v3,
            via_code      : 0x1::option::is_some<vector<u8>>(&v10),
            referral_paid : v15,
            pass          : v7,
        };
        0x2::table::add<u64, Record>(&mut arg0.records, v1, v23);
        let v24 = Minted{
            skull_id      : 0x2::object::id<NFT>(&v22),
            number        : v1,
            minter        : v17,
            kiosk         : v6,
            pass          : v7,
            code          : v10,
            referrer      : v9,
            referral_paid : v15,
            treasury_paid : v16,
        };
        0x2::event::emit<Minted>(v24);
        v22
    }

    public fun founder_codes(arg0: &Collection) : u64 {
        arg0.founder_codes
    }

    public fun has_code(arg0: &Collection, arg1: vector<u8>) : bool {
        0x2::table::contains<vector<u8>, Code>(&arg0.codes, arg1)
    }

    public fun image_url(arg0: &NFT) : 0x1::string::String {
        arg0.image_url
    }

    fun init(arg0: DEADSKULLS, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::package::claim<DEADSKULLS>(arg0, arg1);
        let v1 = 0x1::vector::empty<0x1::string::String>();
        let v2 = &mut v1;
        0x1::vector::push_back<0x1::string::String>(v2, 0x1::string::utf8(b"name"));
        0x1::vector::push_back<0x1::string::String>(v2, 0x1::string::utf8(b"image_url"));
        0x1::vector::push_back<0x1::string::String>(v2, 0x1::string::utf8(b"description"));
        0x1::vector::push_back<0x1::string::String>(v2, 0x1::string::utf8(b"project_url"));
        let v3 = 0x1::vector::empty<0x1::string::String>();
        let v4 = &mut v3;
        0x1::vector::push_back<0x1::string::String>(v4, 0x1::string::utf8(b"Dead Skull #{number}"));
        0x1::vector::push_back<0x1::string::String>(v4, 0x1::string::utf8(b"{image_url}"));
        0x1::vector::push_back<0x1::string::String>(v4, 0x1::string::utf8(b"Rebellio Contra Mores"));
        0x1::vector::push_back<0x1::string::String>(v4, 0x1::string::utf8(b"https://dead.so"));
        let v5 = 0x2::display::new_with_fields<NFT>(&v0, v1, v3, arg1);
        0x2::display::update_version<NFT>(&mut v5);
        let (v6, v7) = 0x2::transfer_policy::new<NFT>(&v0, arg1);
        let v8 = v7;
        let v9 = v6;
        0xc90581173eee14f2bdc9429a15278daa0c6fe51b4d3c488bafbdb5a783f2d22c::market::add<NFT>(&mut v9, &v8, 500, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::transfer_policy::TransferPolicy<NFT>>(v9);
        0x2::transfer::public_transfer<0x2::transfer_policy::TransferPolicyCap<NFT>>(v8, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::package::Publisher>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::display::Display<NFT>>(v5, 0x2::tx_context::sender(arg1));
        let v10 = AdminCap{id: 0x2::object::new(arg1)};
        0x2::transfer::transfer<AdminCap>(v10, 0x2::tx_context::sender(arg1));
        let v11 = Collection{
            id            : 0x2::object::new(arg1),
            supply        : 888,
            minted        : 0,
            price         : 44000000000,
            referral_bps  : 2000,
            treasury      : 0x2::tx_context::sender(arg1),
            codes_open    : false,
            founder_codes : 0,
            paused        : false,
            cursor        : 0,
            traits        : 0x2::table::new<u64, vector<u16>>(arg1),
            traits_locked : false,
            library       : 0x1::option::none<0x2::object::ID>(),
            codes         : 0x2::table::new<vector<u8>, Code>(arg1),
            pass_type     : 0x1::option::none<0x1::type_name::TypeName>(),
            passes_used   : 0x2::table::new<0x2::object::ID, u64>(arg1),
            records       : 0x2::table::new<u64, Record>(arg1),
        };
        0x2::transfer::share_object<Collection>(v11);
    }

    public fun is_minted(arg0: &Collection, arg1: u64) : bool {
        0x2::table::contains<u64, Record>(&arg0.records, arg1)
    }

    public fun library(arg0: &Collection) : 0x1::option::Option<0x2::object::ID> {
        arg0.library
    }

    public fun lock_traits(arg0: &mut Collection, arg1: &AdminCap) {
        assert!(!arg0.traits_locked, 13839000693527805981);
        assert!(0x2::table::length<u64, vector<u16>>(&arg0.traits) == arg0.supply, 13839845122753298467);
        arg0.traits_locked = true;
    }

    public fun mint_with_code(arg0: &mut Collection, arg1: &0xc90581173eee14f2bdc9429a15278daa0c6fe51b4d3c488bafbdb5a783f2d22c::art::Library, arg2: &0x2::transfer_policy::TransferPolicy<NFT>, arg3: &mut 0x2::kiosk::Kiosk, arg4: &0x2::kiosk::KioskOwnerCap, arg5: &mut 0x2::coin::Coin<0x2::sui::SUI>, arg6: vector<u8>, arg7: vector<u8>, arg8: vector<u8>, arg9: vector<u8>, arg10: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.codes_open, 13837311040507871249);
        assert!(!arg0.paused, 13840125794571255845);
        let v0 = next_number(arg0);
        assert_mintable(arg0, arg1);
        assert_new_codes(arg0, &arg8, &arg9);
        assert!(0x2::table::contains<vector<u8>, Code>(&arg0.codes, arg6), 13836185162075340809);
        let v1 = *0x2::table::borrow<vector<u8>, Code>(&arg0.codes, arg6);
        assert!(0x1::option::is_none<address>(&v1.used_by), 13836466645642117131);
        let v2 = if (0x1::option::is_some<address>(&v1.issuer)) {
            arg0.price
        } else {
            0
        };
        assert!(0x2::coin::value<0x2::sui::SUI>(arg5) >= v2, 13837029608480702479);
        let v3 = signing_message(arg0, 0x2::tx_context::sender(arg10));
        assert!(0x2::ed25519::ed25519_verify(&arg7, &arg6, &v3), 13836748142093795341);
        0x2::table::borrow_mut<vector<u8>, Code>(&mut arg0.codes, arg6).used_by = 0x1::option::some<address>(0x2::tx_context::sender(arg10));
        arg0.cursor = v0;
        let v4 = 0x1::vector::empty<vector<u8>>();
        let v5 = &mut v4;
        0x1::vector::push_back<vector<u8>>(v5, arg8);
        0x1::vector::push_back<vector<u8>>(v5, arg9);
        let v6 = MintParams{
            price     : v2,
            number    : v0,
            code      : 0x1::option::some<vector<u8>>(arg6),
            inviter   : v1.issuer,
            referrer  : v1.issuer,
            new_codes : v4,
            kiosk     : 0x2::object::id<0x2::kiosk::Kiosk>(arg3),
            pass      : 0x1::option::none<0x2::object::ID>(),
        };
        0x2::kiosk::lock<NFT>(arg3, arg4, arg2, finish_mint(arg0, arg1, arg5, v6, arg10));
    }

    public fun mint_with_pass<T0: key>(arg0: &mut Collection, arg1: &0xc90581173eee14f2bdc9429a15278daa0c6fe51b4d3c488bafbdb5a783f2d22c::art::Library, arg2: &0x2::transfer_policy::TransferPolicy<NFT>, arg3: &mut 0x2::kiosk::Kiosk, arg4: &0x2::kiosk::KioskOwnerCap, arg5: &mut 0x2::coin::Coin<0x2::sui::SUI>, arg6: &T0, arg7: vector<u8>, arg8: vector<u8>, arg9: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.codes_open, 13837311208011595793);
        assert!(!arg0.paused, 13840125962074980389);
        assert!(arg0.pass_type == 0x1::option::some<0x1::type_name::TypeName>(0x1::type_name::with_original_ids<T0>()), 13842096291207839795);
        let v0 = 0x2::object::id<T0>(arg6);
        assert!(!0x2::table::contains<0x2::object::ID, u64>(&arg0.passes_used, v0), 13842377774774616117);
        let v1 = next_number(arg0);
        assert_mintable(arg0, arg1);
        assert_new_codes(arg0, &arg7, &arg8);
        let v2 = arg0.price;
        assert!(0x2::coin::value<0x2::sui::SUI>(arg5) >= v2, 13837029771689459727);
        0x2::table::add<0x2::object::ID, u64>(&mut arg0.passes_used, v0, v1);
        arg0.cursor = v1;
        let v3 = 0x1::vector::empty<vector<u8>>();
        let v4 = &mut v3;
        0x1::vector::push_back<vector<u8>>(v4, arg7);
        0x1::vector::push_back<vector<u8>>(v4, arg8);
        let v5 = MintParams{
            price     : v2,
            number    : v1,
            code      : 0x1::option::none<vector<u8>>(),
            inviter   : 0x1::option::none<address>(),
            referrer  : 0x1::option::none<address>(),
            new_codes : v3,
            kiosk     : 0x2::object::id<0x2::kiosk::Kiosk>(arg3),
            pass      : 0x1::option::some<0x2::object::ID>(v0),
        };
        0x2::kiosk::lock<NFT>(arg3, arg4, arg2, finish_mint(arg0, arg1, arg5, v5, arg9));
    }

    public fun minted(arg0: &Collection) : u64 {
        arg0.minted
    }

    public fun next_number(arg0: &Collection) : u64 {
        let v0 = arg0.cursor + 1;
        while (0x2::table::contains<u64, Record>(&arg0.records, v0)) {
            v0 = v0 + 1;
        };
        v0
    }

    public fun number(arg0: &NFT) : u64 {
        arg0.number
    }

    public fun open_codes(arg0: &mut Collection, arg1: &AdminCap) {
        assert!(!arg0.codes_open, 13838437494466019353);
        assert!(arg0.traits_locked && 0x1::option::is_some<0x2::object::ID>(&arg0.library), 13835341274015727619);
        arg0.codes_open = true;
    }

    public fun pass_type(arg0: &Collection) : 0x1::option::Option<0x1::type_name::TypeName> {
        arg0.pass_type
    }

    public fun pass_used(arg0: &Collection, arg1: 0x2::object::ID) : bool {
        0x2::table::contains<0x2::object::ID, u64>(&arg0.passes_used, arg1)
    }

    public fun paused(arg0: &Collection) : bool {
        arg0.paused
    }

    public fun premint(arg0: &mut Collection, arg1: &AdminCap, arg2: &0xc90581173eee14f2bdc9429a15278daa0c6fe51b4d3c488bafbdb5a783f2d22c::art::Library, arg3: &0x2::transfer_policy::TransferPolicy<NFT>, arg4: u64, arg5: &mut 0x2::tx_context::TxContext) {
        assert!(!arg0.codes_open, 13840689216971341865);
        assert!(arg4 >= 1 && arg4 <= arg0.supply, 13840970696243150891);
        assert!(!0x2::table::contains<u64, Record>(&arg0.records, arg4), 13841252175514959917);
        assert_mintable(arg0, arg2);
        let (v0, v1) = 0x2::kiosk::new(arg5);
        let v2 = v1;
        let v3 = v0;
        let v4 = 0x2::coin::zero<0x2::sui::SUI>(arg5);
        let v5 = &mut v4;
        let v6 = MintParams{
            price     : 0,
            number    : arg4,
            code      : 0x1::option::none<vector<u8>>(),
            inviter   : 0x1::option::none<address>(),
            referrer  : 0x1::option::none<address>(),
            new_codes : vector[],
            kiosk     : 0x2::object::id<0x2::kiosk::Kiosk>(&v3),
            pass      : 0x1::option::none<0x2::object::ID>(),
        };
        let v7 = finish_mint(arg0, arg2, v5, v6, arg5);
        0x2::coin::destroy_zero<0x2::sui::SUI>(v4);
        0x2::kiosk::lock<NFT>(&mut v3, &v2, arg3, v7);
        0x2::transfer::public_share_object<0x2::kiosk::Kiosk>(v3);
        0x2::transfer::public_transfer<0x2::kiosk::KioskOwnerCap>(v2, 0x2::tx_context::sender(arg5));
    }

    public fun price(arg0: &Collection) : u64 {
        arg0.price
    }

    public fun receive<T0: store + key>(arg0: &mut NFT, arg1: 0x2::transfer::Receiving<T0>) : T0 {
        0x2::transfer::public_receive<T0>(&mut arg0.id, arg1)
    }

    public fun record(arg0: &Collection, arg1: u64) : Record {
        *0x2::table::borrow<u64, Record>(&arg0.records, arg1)
    }

    public fun record_inviter(arg0: &Record) : 0x1::option::Option<address> {
        arg0.inviter
    }

    public fun record_minter(arg0: &Record) : address {
        arg0.minter
    }

    public fun record_pass(arg0: &Record) : 0x1::option::Option<0x2::object::ID> {
        arg0.pass
    }

    public fun record_referral_paid(arg0: &Record) : u64 {
        arg0.referral_paid
    }

    public fun record_skull(arg0: &Record) : 0x2::object::ID {
        arg0.skull
    }

    public fun record_via_code(arg0: &Record) : bool {
        arg0.via_code
    }

    public fun referral_bps(arg0: &Collection) : u64 {
        arg0.referral_bps
    }

    public fun revoke_founder_codes(arg0: &mut Collection, arg1: &AdminCap, arg2: vector<vector<u8>>) {
        assert!(0x1::vector::length<vector<u8>>(&arg2) <= 200, 13839282061130465311);
        0x1::vector::reverse<vector<u8>>(&mut arg2);
        let v0 = 0;
        while (v0 < 0x1::vector::length<vector<u8>>(&arg2)) {
            let v1 = 0x1::vector::pop_back<vector<u8>>(&mut arg2);
            assert!(0x2::table::contains<vector<u8>, Code>(&arg0.codes, v1), 13836185844975140873);
            let v2 = *0x2::table::borrow<vector<u8>, Code>(&arg0.codes, v1);
            assert!(0x1::option::is_none<address>(&v2.issuer), 13841815353101910065);
            assert!(0x1::option::is_none<address>(&v2.used_by), 13836467332836884491);
            0x2::table::remove<vector<u8>, Code>(&mut arg0.codes, v1);
            v0 = v0 + 1;
        };
        0x1::vector::destroy_empty<vector<u8>>(arg2);
    }

    public fun set_library(arg0: &mut Collection, arg1: &AdminCap, arg2: &0xc90581173eee14f2bdc9429a15278daa0c6fe51b4d3c488bafbdb5a783f2d22c::art::Library) {
        assert!(0x1::option::is_none<0x2::object::ID>(&arg0.library), 13838719252910702619);
        arg0.library = 0x1::option::some<0x2::object::ID>(0x2::object::id<0xc90581173eee14f2bdc9429a15278daa0c6fe51b4d3c488bafbdb5a783f2d22c::art::Library>(arg2));
    }

    public fun set_pass_type<T0: key>(arg0: &mut Collection, arg1: &AdminCap) {
        arg0.pass_type = 0x1::option::some<0x1::type_name::TypeName>(0x1::type_name::with_original_ids<T0>());
    }

    public fun set_paused(arg0: &mut Collection, arg1: &AdminCap, arg2: bool) {
        assert!(arg2 != arg0.paused, 13838437558890528793);
        arg0.paused = arg2;
    }

    public fun set_price(arg0: &mut Collection, arg1: &AdminCap, arg2: u64) {
        assert!(arg2 != arg0.price, 13838437301192491033);
        arg0.price = arg2;
    }

    public fun set_referral_bps(arg0: &mut Collection, arg1: &AdminCap, arg2: u64) {
        assert!(arg2 <= 10000, 13837874372713644053);
        assert!(arg2 != arg0.referral_bps, 13838437326962294809);
        arg0.referral_bps = arg2;
    }

    public fun set_supply(arg0: &mut Collection, arg1: &AdminCap, arg2: u64) {
        assert!(arg0.minted == 0 && !arg0.traits_locked, 13841533491578011695);
        assert!(arg2 >= 0x2::table::length<u64, vector<u16>>(&arg0.traits), 13837592846197194771);
        assert!(arg2 > 0, 13837592850492162067);
        assert!(arg2 != arg0.supply, 13838437279717654553);
        arg0.supply = arg2;
    }

    public fun set_treasury(arg0: &mut Collection, arg1: &AdminCap, arg2: address) {
        assert!(arg2 != @0x0, 13838155873460289559);
        assert!(arg2 != arg0.treasury, 13838437352732098585);
        arg0.treasury = arg2;
    }

    public fun signing_message(arg0: &Collection, arg1: address) : vector<u8> {
        let v0 = b"DEAD_SKULLS_INVITE_V1";
        0x1::vector::append<u8>(&mut v0, 0x2::object::uid_to_bytes(&arg0.id));
        0x1::vector::append<u8>(&mut v0, 0x2::bcs::to_bytes<address>(&arg1));
        v0
    }

    public fun supply(arg0: &Collection) : u64 {
        arg0.supply
    }

    public fun traits(arg0: &NFT) : vector<u16> {
        arg0.traits
    }

    public fun traits_locked(arg0: &Collection) : bool {
        arg0.traits_locked
    }

    public fun traits_of(arg0: &Collection, arg1: u64) : vector<u16> {
        *0x2::table::borrow<u64, vector<u16>>(&arg0.traits, arg1)
    }

    public fun treasury(arg0: &Collection) : address {
        arg0.treasury
    }

    // decompiled from Move bytecode v7
}

