module 0x143bd9071ea4f375d4321f2eb424d083b74a34388710e2cc7fbc31a9c45f1793::marketplace {
    struct Params has store, key {
        id: 0x2::object::UID,
        fee_bps: u16,
        fee_mode: u8,
        fee_treasury_addr: address,
        allowed_coin_types: 0x2::vec_set::VecSet<0x1::type_name::TypeName>,
    }

    struct FeeConfigV3 has store, key {
        id: 0x2::object::UID,
        fee_bps_sui: u16,
        sui_fee_dev_bps: u16,
        sui_fee_pol_bps: u16,
        sui_fee_buyback_bps: u16,
    }

    struct Listing has store, key {
        id: 0x2::object::UID,
        seller: address,
        price: u64,
        kind: u8,
        anniv: 0x1::option::Option<0x143bd9071ea4f375d4321f2eb424d083b74a34388710e2cc7fbc31a9c45f1793::anniversary_vault::Today365>,
        nost: 0x1::option::Option<0x143bd9071ea4f375d4321f2eb424d083b74a34388710e2cc7fbc31a9c45f1793::nostalgia_ticket::NostalgiaTicket>,
        simple: 0x1::option::Option<0x143bd9071ea4f375d4321f2eb424d083b74a34388710e2cc7fbc31a9c45f1793::ghost_memory::GhostMemory>,
        created_at_ms: u64,
        expires_at_ms: u64,
        status: u8,
    }

    struct OwnershipOffered has copy, drop, store {
        listing_id: 0x2::object::ID,
        ticket_id: 0x2::object::ID,
        seller: address,
        kind: u8,
        price: u64,
        expires_at_ms: u64,
    }

    struct OwnershipTransferred has copy, drop, store {
        listing_id: 0x2::object::ID,
        ticket_id: 0x2::object::ID,
        buyer: address,
        seller: address,
        price: u64,
        fee_amount: u64,
        royalty_amount: u64,
        coin_type: 0x1::string::String,
    }

    struct MarketplaceSuiFeesRouted has copy, drop {
        listing_id: 0x2::object::ID,
        fee_dev: u64,
        fee_pol: u64,
        fee_buyback: u64,
    }

    struct FeeConfigV3Created has copy, drop {
        config_id: 0x2::object::ID,
        fee_bps_sui: u16,
        sui_fee_dev_bps: u16,
        sui_fee_pol_bps: u16,
        sui_fee_buyback_bps: u16,
    }

    struct Cancelled has copy, drop, store {
        listing_id: 0x2::object::ID,
        ticket_id: 0x2::object::ID,
        seller: address,
    }

    public entry fun allow_coin<T0>(arg0: &0x143bd9071ea4f375d4321f2eb424d083b74a34388710e2cc7fbc31a9c45f1793::admin::AdminCap, arg1: &mut Params) {
        let v0 = 0x1::type_name::get<T0>();
        if (!0x2::vec_set::contains<0x1::type_name::TypeName>(&arg1.allowed_coin_types, &v0)) {
            0x2::vec_set::insert<0x1::type_name::TypeName>(&mut arg1.allowed_coin_types, v0);
        };
    }

    fun assert_listing_buyable(arg0: &Listing, arg1: &0x2::clock::Clock) {
        assert!(arg0.status == 0, 11);
        if (arg0.expires_at_ms > 0) {
            assert!(0x2::clock::timestamp_ms(arg1) < arg0.expires_at_ms, 13);
        };
    }

    fun assert_sui_fee_split(arg0: u16, arg1: u16, arg2: u16, arg3: u16) {
        assert!((arg0 as u64) + (arg1 as u64) + (arg2 as u64) == (arg3 as u64), 105);
    }

    public entry fun buy<T0>(arg0: &Params, arg1: &mut Listing, arg2: 0x2::coin::Coin<T0>, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg4);
        let v1 = 0x1::type_name::get<T0>();
        assert!(0x2::vec_set::contains<0x1::type_name::TypeName>(&arg0.allowed_coin_types, &v1), 99);
        assert!(v1 != 0x1::type_name::get<0x2::sui::SUI>(), 106);
        assert_listing_buyable(arg1, arg3);
        let v2 = arg1.price;
        let v3 = 0x2::coin::value<T0>(&arg2);
        assert!(v3 >= v2, 12);
        arg1.status = 1;
        if (v3 > v2) {
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::split<T0>(&mut arg2, v3 - v2, arg4), v0);
        };
        let (v4, v5, v6) = transfer_nft_from_listing(arg1, v0);
        let v7 = 0x2::coin::value<T0>(&arg2);
        let v8 = v7 * (arg0.fee_bps as u64) / 10000;
        let v9 = v7 * (v6 as u64) / 10000;
        assert!(v8 + v9 <= v7, 102);
        if (v9 > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::split<T0>(&mut arg2, v9, arg4), v5);
        };
        assert!(0x2::coin::value<T0>(&arg2) == v7 - v8 - v9, 0);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(arg2, arg1.seller);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::split<T0>(&mut arg2, v8, arg4), arg0.fee_treasury_addr);
        let v10 = OwnershipTransferred{
            listing_id     : 0x2::object::id<Listing>(arg1),
            ticket_id      : v4,
            buyer          : v0,
            seller         : arg1.seller,
            price          : v2,
            fee_amount     : v8,
            royalty_amount : v9,
            coin_type      : 0x1::string::from_ascii(0x1::type_name::into_string(v1)),
        };
        0x2::event::emit<OwnershipTransferred>(v10);
    }

    public entry fun buy_sui(arg0: &Params, arg1: &FeeConfigV3, arg2: &0x143bd9071ea4f375d4321f2eb424d083b74a34388710e2cc7fbc31a9c45f1793::config_registry::Config, arg3: &mut 0x143bd9071ea4f375d4321f2eb424d083b74a34388710e2cc7fbc31a9c45f1793::pol_treasury::Treasury, arg4: &mut Listing, arg5: 0x2::coin::Coin<0x2::sui::SUI>, arg6: &0x2::clock::Clock, arg7: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::object::id<0x143bd9071ea4f375d4321f2eb424d083b74a34388710e2cc7fbc31a9c45f1793::pol_treasury::Treasury>(arg3) == 0x143bd9071ea4f375d4321f2eb424d083b74a34388710e2cc7fbc31a9c45f1793::config_registry::treasury_id(arg2), 107);
        let v0 = 0x2::tx_context::sender(arg7);
        let v1 = 0x1::type_name::get<0x2::sui::SUI>();
        assert!(0x2::vec_set::contains<0x1::type_name::TypeName>(&arg0.allowed_coin_types, &v1), 99);
        assert_listing_buyable(arg4, arg6);
        let v2 = arg4.price;
        let v3 = 0x2::coin::value<0x2::sui::SUI>(&arg5);
        assert!(v3 >= v2, 12);
        arg4.status = 1;
        if (v3 > v2) {
            0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::split<0x2::sui::SUI>(&mut arg5, v3 - v2, arg7), v0);
        };
        let (v4, v5, v6) = transfer_nft_from_listing(arg4, v0);
        let v7 = 0x2::coin::value<0x2::sui::SUI>(&arg5);
        let v8 = v7 * (arg1.sui_fee_dev_bps as u64) / 10000;
        let v9 = v7 * (arg1.sui_fee_pol_bps as u64) / 10000;
        let v10 = v7 * (arg1.sui_fee_buyback_bps as u64) / 10000;
        let v11 = v8 + v9 + v10;
        let v12 = v7 * (v6 as u64) / 10000;
        assert!(v11 + v12 <= v7, 102);
        if (v12 > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::split<0x2::sui::SUI>(&mut arg5, v12, arg7), v5);
        };
        if (v8 > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::split<0x2::sui::SUI>(&mut arg5, v8, arg7), 0x143bd9071ea4f375d4321f2eb424d083b74a34388710e2cc7fbc31a9c45f1793::config_registry::dev_addr(arg2));
        };
        if (v9 > 0) {
            0x143bd9071ea4f375d4321f2eb424d083b74a34388710e2cc7fbc31a9c45f1793::pol_treasury::deposit(arg3, 0x2::coin::split<0x2::sui::SUI>(&mut arg5, v9, arg7));
        };
        if (v10 > 0) {
            0x143bd9071ea4f375d4321f2eb424d083b74a34388710e2cc7fbc31a9c45f1793::pol_treasury::deposit_buyback(arg3, 0x2::coin::split<0x2::sui::SUI>(&mut arg5, v10, arg7));
        };
        assert!(0x2::coin::value<0x2::sui::SUI>(&arg5) == v7 - v11 - v12, 0);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(arg5, arg4.seller);
        let v13 = 0x2::object::id<Listing>(arg4);
        let v14 = OwnershipTransferred{
            listing_id     : v13,
            ticket_id      : v4,
            buyer          : v0,
            seller         : arg4.seller,
            price          : v2,
            fee_amount     : v11,
            royalty_amount : v12,
            coin_type      : 0x1::string::from_ascii(0x1::type_name::into_string(v1)),
        };
        0x2::event::emit<OwnershipTransferred>(v14);
        let v15 = MarketplaceSuiFeesRouted{
            listing_id  : v13,
            fee_dev     : v8,
            fee_pol     : v9,
            fee_buyback : v10,
        };
        0x2::event::emit<MarketplaceSuiFeesRouted>(v15);
    }

    public entry fun cancel(arg0: &mut Listing, arg1: &0x2::clock::Clock, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg2);
        assert!(arg0.seller == v0, 10);
        assert!(arg0.status == 0, 11);
        if (arg0.expires_at_ms > 0 && 0x2::clock::timestamp_ms(arg1) >= arg0.expires_at_ms) {
            arg0.status = 3;
        };
        arg0.status = 2;
        let v1 = if (arg0.kind == 0) {
            let v2 = 0x1::option::extract<0x143bd9071ea4f375d4321f2eb424d083b74a34388710e2cc7fbc31a9c45f1793::anniversary_vault::Today365>(&mut arg0.anniv);
            0x2::transfer::public_transfer<0x143bd9071ea4f375d4321f2eb424d083b74a34388710e2cc7fbc31a9c45f1793::anniversary_vault::Today365>(v2, v0);
            0x2::object::id<0x143bd9071ea4f375d4321f2eb424d083b74a34388710e2cc7fbc31a9c45f1793::anniversary_vault::Today365>(&v2)
        } else if (arg0.kind == 1) {
            let v3 = 0x1::option::extract<0x143bd9071ea4f375d4321f2eb424d083b74a34388710e2cc7fbc31a9c45f1793::nostalgia_ticket::NostalgiaTicket>(&mut arg0.nost);
            0x2::transfer::public_transfer<0x143bd9071ea4f375d4321f2eb424d083b74a34388710e2cc7fbc31a9c45f1793::nostalgia_ticket::NostalgiaTicket>(v3, v0);
            0x2::object::id<0x143bd9071ea4f375d4321f2eb424d083b74a34388710e2cc7fbc31a9c45f1793::nostalgia_ticket::NostalgiaTicket>(&v3)
        } else {
            let v4 = 0x1::option::extract<0x143bd9071ea4f375d4321f2eb424d083b74a34388710e2cc7fbc31a9c45f1793::ghost_memory::GhostMemory>(&mut arg0.simple);
            0x2::transfer::public_transfer<0x143bd9071ea4f375d4321f2eb424d083b74a34388710e2cc7fbc31a9c45f1793::ghost_memory::GhostMemory>(v4, v0);
            0x2::object::id<0x143bd9071ea4f375d4321f2eb424d083b74a34388710e2cc7fbc31a9c45f1793::ghost_memory::GhostMemory>(&v4)
        };
        let v5 = Cancelled{
            listing_id : 0x2::object::id<Listing>(arg0),
            ticket_id  : v1,
            seller     : v0,
        };
        0x2::event::emit<Cancelled>(v5);
    }

    public entry fun create_and_share_fee_config_v3(arg0: &0x143bd9071ea4f375d4321f2eb424d083b74a34388710e2cc7fbc31a9c45f1793::admin::AdminCap, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = FeeConfigV3{
            id                  : 0x2::object::new(arg1),
            fee_bps_sui         : 700,
            sui_fee_dev_bps     : 400,
            sui_fee_pol_bps     : 100,
            sui_fee_buyback_bps : 200,
        };
        let v1 = FeeConfigV3Created{
            config_id           : 0x2::object::id<FeeConfigV3>(&v0),
            fee_bps_sui         : 700,
            sui_fee_dev_bps     : 400,
            sui_fee_pol_bps     : 100,
            sui_fee_buyback_bps : 200,
        };
        0x2::event::emit<FeeConfigV3Created>(v1);
        0x2::transfer::share_object<FeeConfigV3>(v0);
    }

    public entry fun create_and_share_params(arg0: &0x143bd9071ea4f375d4321f2eb424d083b74a34388710e2cc7fbc31a9c45f1793::admin::AdminCap, arg1: u16, arg2: u8, arg3: address, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(arg2 == 1, 14);
        assert!((arg1 as u64) < 10000, 102);
        let v0 = Params{
            id                 : 0x2::object::new(arg4),
            fee_bps            : arg1,
            fee_mode           : arg2,
            fee_treasury_addr  : arg3,
            allowed_coin_types : 0x2::vec_set::empty<0x1::type_name::TypeName>(),
        };
        0x2::vec_set::insert<0x1::type_name::TypeName>(&mut v0.allowed_coin_types, 0x1::type_name::get<0x143bd9071ea4f375d4321f2eb424d083b74a34388710e2cc7fbc31a9c45f1793::tvyn::TVYN>());
        0x2::transfer::share_object<Params>(v0);
    }

    public entry fun list_anniversary(arg0: &Params, arg1: 0x143bd9071ea4f375d4321f2eb424d083b74a34388710e2cc7fbc31a9c45f1793::anniversary_vault::Today365, arg2: u64, arg3: u64, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg5);
        let v1 = 0x2::clock::timestamp_ms(arg4);
        assert!(arg2 > 0, 100);
        assert!(arg3 == 0 || arg3 > v1, 101);
        let v2 = Listing{
            id            : 0x2::object::new(arg5),
            seller        : v0,
            price         : arg2,
            kind          : 0,
            anniv         : 0x1::option::some<0x143bd9071ea4f375d4321f2eb424d083b74a34388710e2cc7fbc31a9c45f1793::anniversary_vault::Today365>(arg1),
            nost          : 0x1::option::none<0x143bd9071ea4f375d4321f2eb424d083b74a34388710e2cc7fbc31a9c45f1793::nostalgia_ticket::NostalgiaTicket>(),
            simple        : 0x1::option::none<0x143bd9071ea4f375d4321f2eb424d083b74a34388710e2cc7fbc31a9c45f1793::ghost_memory::GhostMemory>(),
            created_at_ms : v1,
            expires_at_ms : arg3,
            status        : 0,
        };
        let v3 = OwnershipOffered{
            listing_id    : 0x2::object::id<Listing>(&v2),
            ticket_id     : 0x2::object::id<0x143bd9071ea4f375d4321f2eb424d083b74a34388710e2cc7fbc31a9c45f1793::anniversary_vault::Today365>(&arg1),
            seller        : v0,
            kind          : 0,
            price         : arg2,
            expires_at_ms : arg3,
        };
        0x2::event::emit<OwnershipOffered>(v3);
        0x2::transfer::share_object<Listing>(v2);
    }

    public entry fun list_nostalgia(arg0: &Params, arg1: 0x143bd9071ea4f375d4321f2eb424d083b74a34388710e2cc7fbc31a9c45f1793::nostalgia_ticket::NostalgiaTicket, arg2: u64, arg3: u64, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg5);
        let v1 = 0x2::clock::timestamp_ms(arg4);
        assert!(arg2 > 0, 100);
        assert!(arg3 == 0 || arg3 > v1, 101);
        let v2 = Listing{
            id            : 0x2::object::new(arg5),
            seller        : v0,
            price         : arg2,
            kind          : 1,
            anniv         : 0x1::option::none<0x143bd9071ea4f375d4321f2eb424d083b74a34388710e2cc7fbc31a9c45f1793::anniversary_vault::Today365>(),
            nost          : 0x1::option::some<0x143bd9071ea4f375d4321f2eb424d083b74a34388710e2cc7fbc31a9c45f1793::nostalgia_ticket::NostalgiaTicket>(arg1),
            simple        : 0x1::option::none<0x143bd9071ea4f375d4321f2eb424d083b74a34388710e2cc7fbc31a9c45f1793::ghost_memory::GhostMemory>(),
            created_at_ms : v1,
            expires_at_ms : arg3,
            status        : 0,
        };
        let v3 = OwnershipOffered{
            listing_id    : 0x2::object::id<Listing>(&v2),
            ticket_id     : 0x2::object::id<0x143bd9071ea4f375d4321f2eb424d083b74a34388710e2cc7fbc31a9c45f1793::nostalgia_ticket::NostalgiaTicket>(&arg1),
            seller        : v0,
            kind          : 1,
            price         : arg2,
            expires_at_ms : arg3,
        };
        0x2::event::emit<OwnershipOffered>(v3);
        0x2::transfer::share_object<Listing>(v2);
    }

    public entry fun list_simple(arg0: &Params, arg1: 0x143bd9071ea4f375d4321f2eb424d083b74a34388710e2cc7fbc31a9c45f1793::ghost_memory::GhostMemory, arg2: u64, arg3: u64, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg5);
        let v1 = 0x2::clock::timestamp_ms(arg4);
        assert!(arg2 > 0, 100);
        assert!(arg3 == 0 || arg3 > v1, 101);
        let v2 = Listing{
            id            : 0x2::object::new(arg5),
            seller        : v0,
            price         : arg2,
            kind          : 2,
            anniv         : 0x1::option::none<0x143bd9071ea4f375d4321f2eb424d083b74a34388710e2cc7fbc31a9c45f1793::anniversary_vault::Today365>(),
            nost          : 0x1::option::none<0x143bd9071ea4f375d4321f2eb424d083b74a34388710e2cc7fbc31a9c45f1793::nostalgia_ticket::NostalgiaTicket>(),
            simple        : 0x1::option::some<0x143bd9071ea4f375d4321f2eb424d083b74a34388710e2cc7fbc31a9c45f1793::ghost_memory::GhostMemory>(arg1),
            created_at_ms : v1,
            expires_at_ms : arg3,
            status        : 0,
        };
        let v3 = OwnershipOffered{
            listing_id    : 0x2::object::id<Listing>(&v2),
            ticket_id     : 0x2::object::id<0x143bd9071ea4f375d4321f2eb424d083b74a34388710e2cc7fbc31a9c45f1793::ghost_memory::GhostMemory>(&arg1),
            seller        : v0,
            kind          : 2,
            price         : arg2,
            expires_at_ms : arg3,
        };
        0x2::event::emit<OwnershipOffered>(v3);
        0x2::transfer::share_object<Listing>(v2);
    }

    public entry fun set_fee_bps(arg0: &0x143bd9071ea4f375d4321f2eb424d083b74a34388710e2cc7fbc31a9c45f1793::admin::AdminCap, arg1: &mut Params, arg2: u16) {
        assert!((arg2 as u64) < 10000, 0);
        arg1.fee_bps = arg2;
    }

    public entry fun set_fee_bps_sui(arg0: &0x143bd9071ea4f375d4321f2eb424d083b74a34388710e2cc7fbc31a9c45f1793::admin::AdminCap, arg1: &mut FeeConfigV3, arg2: u16) {
        assert!((arg2 as u64) < 10000, 0);
        arg1.fee_bps_sui = arg2;
    }

    public entry fun set_fee_mode(arg0: &0x143bd9071ea4f375d4321f2eb424d083b74a34388710e2cc7fbc31a9c45f1793::admin::AdminCap, arg1: &mut Params, arg2: u8, arg3: address) {
        assert!(arg2 == 1, 14);
        arg1.fee_mode = arg2;
        arg1.fee_treasury_addr = arg3;
    }

    public entry fun set_sui_fee_split(arg0: &0x143bd9071ea4f375d4321f2eb424d083b74a34388710e2cc7fbc31a9c45f1793::admin::AdminCap, arg1: &mut FeeConfigV3, arg2: u16, arg3: u16, arg4: u16) {
        assert_sui_fee_split(arg2, arg3, arg4, arg1.fee_bps_sui);
        arg1.sui_fee_dev_bps = arg2;
        arg1.sui_fee_pol_bps = arg3;
        arg1.sui_fee_buyback_bps = arg4;
    }

    fun transfer_nft_from_listing(arg0: &mut Listing, arg1: address) : (0x2::object::ID, address, u16) {
        let (v0, v1, v2) = if (arg0.kind == 0) {
            let v3 = 0x1::option::extract<0x143bd9071ea4f375d4321f2eb424d083b74a34388710e2cc7fbc31a9c45f1793::anniversary_vault::Today365>(&mut arg0.anniv);
            0x2::transfer::public_transfer<0x143bd9071ea4f375d4321f2eb424d083b74a34388710e2cc7fbc31a9c45f1793::anniversary_vault::Today365>(v3, arg1);
            (0x143bd9071ea4f375d4321f2eb424d083b74a34388710e2cc7fbc31a9c45f1793::anniversary_vault::creator(&v3), 0x143bd9071ea4f375d4321f2eb424d083b74a34388710e2cc7fbc31a9c45f1793::anniversary_vault::royalty_bps(&v3), 0x143bd9071ea4f375d4321f2eb424d083b74a34388710e2cc7fbc31a9c45f1793::anniversary_vault::ticket_id(&v3))
        } else if (arg0.kind == 1) {
            let v4 = 0x1::option::extract<0x143bd9071ea4f375d4321f2eb424d083b74a34388710e2cc7fbc31a9c45f1793::nostalgia_ticket::NostalgiaTicket>(&mut arg0.nost);
            0x2::transfer::public_transfer<0x143bd9071ea4f375d4321f2eb424d083b74a34388710e2cc7fbc31a9c45f1793::nostalgia_ticket::NostalgiaTicket>(v4, arg1);
            (0x143bd9071ea4f375d4321f2eb424d083b74a34388710e2cc7fbc31a9c45f1793::nostalgia_ticket::creator(&v4), 0x143bd9071ea4f375d4321f2eb424d083b74a34388710e2cc7fbc31a9c45f1793::nostalgia_ticket::royalty_bps(&v4), 0x143bd9071ea4f375d4321f2eb424d083b74a34388710e2cc7fbc31a9c45f1793::nostalgia_ticket::ticket_id(&v4))
        } else {
            let v5 = 0x1::option::extract<0x143bd9071ea4f375d4321f2eb424d083b74a34388710e2cc7fbc31a9c45f1793::ghost_memory::GhostMemory>(&mut arg0.simple);
            0x2::transfer::public_transfer<0x143bd9071ea4f375d4321f2eb424d083b74a34388710e2cc7fbc31a9c45f1793::ghost_memory::GhostMemory>(v5, arg1);
            (0x143bd9071ea4f375d4321f2eb424d083b74a34388710e2cc7fbc31a9c45f1793::ghost_memory::creator(&v5), 0x143bd9071ea4f375d4321f2eb424d083b74a34388710e2cc7fbc31a9c45f1793::ghost_memory::royalty_bps(&v5), 0x143bd9071ea4f375d4321f2eb424d083b74a34388710e2cc7fbc31a9c45f1793::ghost_memory::id(&v5))
        };
        (v2, v0, v1)
    }

    // decompiled from Move bytecode v7
}

