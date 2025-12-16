module 0x7dcd601d40cf741f112f2a872f522d6108b11df5d7c9b0041f7eb52083c78933::marketplace {
    struct Params has store, key {
        id: 0x2::object::UID,
        fee_bps: u16,
        fee_mode: u8,
        fee_treasury_addr: address,
        allowed_coin_types: 0x2::vec_set::VecSet<0x1::type_name::TypeName>,
    }

    struct Listing has store, key {
        id: 0x2::object::UID,
        seller: address,
        price: u64,
        kind: u8,
        anniv: 0x1::option::Option<0x7dcd601d40cf741f112f2a872f522d6108b11df5d7c9b0041f7eb52083c78933::anniversary_vault::Today365>,
        nost: 0x1::option::Option<0x7dcd601d40cf741f112f2a872f522d6108b11df5d7c9b0041f7eb52083c78933::nostalgia_ticket::NostalgiaTicket>,
        simple: 0x1::option::Option<0x7dcd601d40cf741f112f2a872f522d6108b11df5d7c9b0041f7eb52083c78933::simple_memory::SimpleMemory>,
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

    struct Cancelled has copy, drop, store {
        listing_id: 0x2::object::ID,
        ticket_id: 0x2::object::ID,
        seller: address,
    }

    public entry fun allow_coin<T0>(arg0: &0x7dcd601d40cf741f112f2a872f522d6108b11df5d7c9b0041f7eb52083c78933::admin::AdminCap, arg1: &mut Params) {
        let v0 = 0x1::type_name::get<T0>();
        if (!0x2::vec_set::contains<0x1::type_name::TypeName>(&arg1.allowed_coin_types, &v0)) {
            0x2::vec_set::insert<0x1::type_name::TypeName>(&mut arg1.allowed_coin_types, v0);
        };
    }

    public entry fun buy<T0>(arg0: &Params, arg1: &mut Listing, arg2: 0x2::coin::Coin<T0>, arg3: &mut 0x7dcd601d40cf741f112f2a872f522d6108b11df5d7c9b0041f7eb52083c78933::tvyn::MintVault, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg5);
        let v1 = 0x1::type_name::get<T0>();
        assert!(0x2::vec_set::contains<0x1::type_name::TypeName>(&arg0.allowed_coin_types, &v1), 99);
        assert!(arg1.status == 0, 11);
        if (arg1.expires_at_ms > 0) {
            assert!(0x2::clock::timestamp_ms(arg4) < arg1.expires_at_ms, 13);
        };
        let v2 = arg1.price;
        let v3 = 0x2::coin::value<T0>(&arg2);
        assert!(v3 >= v2, 12);
        arg1.status = 1;
        if (v3 > v2) {
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::split<T0>(&mut arg2, v3 - v2, arg5), v0);
        };
        let (v4, v5, v6) = if (arg1.kind == 0) {
            let v7 = 0x1::option::extract<0x7dcd601d40cf741f112f2a872f522d6108b11df5d7c9b0041f7eb52083c78933::anniversary_vault::Today365>(&mut arg1.anniv);
            0x2::transfer::public_transfer<0x7dcd601d40cf741f112f2a872f522d6108b11df5d7c9b0041f7eb52083c78933::anniversary_vault::Today365>(v7, v0);
            (0x7dcd601d40cf741f112f2a872f522d6108b11df5d7c9b0041f7eb52083c78933::anniversary_vault::creator(&v7), 0x7dcd601d40cf741f112f2a872f522d6108b11df5d7c9b0041f7eb52083c78933::anniversary_vault::royalty_bps(&v7), 0x7dcd601d40cf741f112f2a872f522d6108b11df5d7c9b0041f7eb52083c78933::anniversary_vault::ticket_id(&v7))
        } else if (arg1.kind == 1) {
            let v8 = 0x1::option::extract<0x7dcd601d40cf741f112f2a872f522d6108b11df5d7c9b0041f7eb52083c78933::nostalgia_ticket::NostalgiaTicket>(&mut arg1.nost);
            0x2::transfer::public_transfer<0x7dcd601d40cf741f112f2a872f522d6108b11df5d7c9b0041f7eb52083c78933::nostalgia_ticket::NostalgiaTicket>(v8, v0);
            (0x7dcd601d40cf741f112f2a872f522d6108b11df5d7c9b0041f7eb52083c78933::nostalgia_ticket::creator(&v8), 0x7dcd601d40cf741f112f2a872f522d6108b11df5d7c9b0041f7eb52083c78933::nostalgia_ticket::royalty_bps(&v8), 0x7dcd601d40cf741f112f2a872f522d6108b11df5d7c9b0041f7eb52083c78933::nostalgia_ticket::ticket_id(&v8))
        } else {
            let v9 = 0x1::option::extract<0x7dcd601d40cf741f112f2a872f522d6108b11df5d7c9b0041f7eb52083c78933::simple_memory::SimpleMemory>(&mut arg1.simple);
            0x2::transfer::public_transfer<0x7dcd601d40cf741f112f2a872f522d6108b11df5d7c9b0041f7eb52083c78933::simple_memory::SimpleMemory>(v9, v0);
            (0x7dcd601d40cf741f112f2a872f522d6108b11df5d7c9b0041f7eb52083c78933::simple_memory::creator(&v9), 0x7dcd601d40cf741f112f2a872f522d6108b11df5d7c9b0041f7eb52083c78933::simple_memory::royalty_bps(&v9), 0x7dcd601d40cf741f112f2a872f522d6108b11df5d7c9b0041f7eb52083c78933::simple_memory::id(&v9))
        };
        let v10 = 0x2::coin::value<T0>(&arg2);
        let v11 = v10 * (arg0.fee_bps as u64) / 10000;
        let v12 = v10 * (v5 as u64) / 10000;
        if (v12 > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::split<T0>(&mut arg2, v12, arg5), v4);
        };
        assert!(0x2::coin::value<T0>(&arg2) == v10 - v11 - v12, 0);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(arg2, arg1.seller);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::split<T0>(&mut arg2, v11, arg5), arg0.fee_treasury_addr);
        let v13 = OwnershipTransferred{
            listing_id     : 0x2::object::id<Listing>(arg1),
            ticket_id      : v6,
            buyer          : v0,
            seller         : arg1.seller,
            price          : v2,
            fee_amount     : v11,
            royalty_amount : v12,
            coin_type      : 0x1::string::from_ascii(0x1::type_name::into_string(v1)),
        };
        0x2::event::emit<OwnershipTransferred>(v13);
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
            let v2 = 0x1::option::extract<0x7dcd601d40cf741f112f2a872f522d6108b11df5d7c9b0041f7eb52083c78933::anniversary_vault::Today365>(&mut arg0.anniv);
            0x2::transfer::public_transfer<0x7dcd601d40cf741f112f2a872f522d6108b11df5d7c9b0041f7eb52083c78933::anniversary_vault::Today365>(v2, v0);
            0x2::object::id<0x7dcd601d40cf741f112f2a872f522d6108b11df5d7c9b0041f7eb52083c78933::anniversary_vault::Today365>(&v2)
        } else if (arg0.kind == 1) {
            let v3 = 0x1::option::extract<0x7dcd601d40cf741f112f2a872f522d6108b11df5d7c9b0041f7eb52083c78933::nostalgia_ticket::NostalgiaTicket>(&mut arg0.nost);
            0x2::transfer::public_transfer<0x7dcd601d40cf741f112f2a872f522d6108b11df5d7c9b0041f7eb52083c78933::nostalgia_ticket::NostalgiaTicket>(v3, v0);
            0x2::object::id<0x7dcd601d40cf741f112f2a872f522d6108b11df5d7c9b0041f7eb52083c78933::nostalgia_ticket::NostalgiaTicket>(&v3)
        } else {
            let v4 = 0x1::option::extract<0x7dcd601d40cf741f112f2a872f522d6108b11df5d7c9b0041f7eb52083c78933::simple_memory::SimpleMemory>(&mut arg0.simple);
            0x2::transfer::public_transfer<0x7dcd601d40cf741f112f2a872f522d6108b11df5d7c9b0041f7eb52083c78933::simple_memory::SimpleMemory>(v4, v0);
            0x2::object::id<0x7dcd601d40cf741f112f2a872f522d6108b11df5d7c9b0041f7eb52083c78933::simple_memory::SimpleMemory>(&v4)
        };
        let v5 = Cancelled{
            listing_id : 0x2::object::id<Listing>(arg0),
            ticket_id  : v1,
            seller     : v0,
        };
        0x2::event::emit<Cancelled>(v5);
    }

    public entry fun create_and_share_params(arg0: &0x7dcd601d40cf741f112f2a872f522d6108b11df5d7c9b0041f7eb52083c78933::admin::AdminCap, arg1: u16, arg2: u8, arg3: address, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(arg2 == 0 || arg2 == 1, 14);
        let v0 = Params{
            id                 : 0x2::object::new(arg4),
            fee_bps            : arg1,
            fee_mode           : arg2,
            fee_treasury_addr  : arg3,
            allowed_coin_types : 0x2::vec_set::empty<0x1::type_name::TypeName>(),
        };
        0x2::vec_set::insert<0x1::type_name::TypeName>(&mut v0.allowed_coin_types, 0x1::type_name::get<0x7dcd601d40cf741f112f2a872f522d6108b11df5d7c9b0041f7eb52083c78933::tvyn::TVYN>());
        0x2::transfer::share_object<Params>(v0);
    }

    public entry fun list_anniversary(arg0: &Params, arg1: 0x7dcd601d40cf741f112f2a872f522d6108b11df5d7c9b0041f7eb52083c78933::anniversary_vault::Today365, arg2: u64, arg3: u64, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg5);
        let v1 = Listing{
            id            : 0x2::object::new(arg5),
            seller        : v0,
            price         : arg2,
            kind          : 0,
            anniv         : 0x1::option::some<0x7dcd601d40cf741f112f2a872f522d6108b11df5d7c9b0041f7eb52083c78933::anniversary_vault::Today365>(arg1),
            nost          : 0x1::option::none<0x7dcd601d40cf741f112f2a872f522d6108b11df5d7c9b0041f7eb52083c78933::nostalgia_ticket::NostalgiaTicket>(),
            simple        : 0x1::option::none<0x7dcd601d40cf741f112f2a872f522d6108b11df5d7c9b0041f7eb52083c78933::simple_memory::SimpleMemory>(),
            created_at_ms : 0x2::clock::timestamp_ms(arg4),
            expires_at_ms : arg3,
            status        : 0,
        };
        let v2 = OwnershipOffered{
            listing_id    : 0x2::object::id<Listing>(&v1),
            ticket_id     : 0x2::object::id<0x7dcd601d40cf741f112f2a872f522d6108b11df5d7c9b0041f7eb52083c78933::anniversary_vault::Today365>(&arg1),
            seller        : v0,
            kind          : 0,
            price         : arg2,
            expires_at_ms : arg3,
        };
        0x2::event::emit<OwnershipOffered>(v2);
        0x2::transfer::share_object<Listing>(v1);
    }

    public entry fun list_nostalgia(arg0: &Params, arg1: 0x7dcd601d40cf741f112f2a872f522d6108b11df5d7c9b0041f7eb52083c78933::nostalgia_ticket::NostalgiaTicket, arg2: u64, arg3: u64, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg5);
        let v1 = Listing{
            id            : 0x2::object::new(arg5),
            seller        : v0,
            price         : arg2,
            kind          : 1,
            anniv         : 0x1::option::none<0x7dcd601d40cf741f112f2a872f522d6108b11df5d7c9b0041f7eb52083c78933::anniversary_vault::Today365>(),
            nost          : 0x1::option::some<0x7dcd601d40cf741f112f2a872f522d6108b11df5d7c9b0041f7eb52083c78933::nostalgia_ticket::NostalgiaTicket>(arg1),
            simple        : 0x1::option::none<0x7dcd601d40cf741f112f2a872f522d6108b11df5d7c9b0041f7eb52083c78933::simple_memory::SimpleMemory>(),
            created_at_ms : 0x2::clock::timestamp_ms(arg4),
            expires_at_ms : arg3,
            status        : 0,
        };
        let v2 = OwnershipOffered{
            listing_id    : 0x2::object::id<Listing>(&v1),
            ticket_id     : 0x2::object::id<0x7dcd601d40cf741f112f2a872f522d6108b11df5d7c9b0041f7eb52083c78933::nostalgia_ticket::NostalgiaTicket>(&arg1),
            seller        : v0,
            kind          : 1,
            price         : arg2,
            expires_at_ms : arg3,
        };
        0x2::event::emit<OwnershipOffered>(v2);
        0x2::transfer::share_object<Listing>(v1);
    }

    public entry fun list_simple(arg0: &Params, arg1: 0x7dcd601d40cf741f112f2a872f522d6108b11df5d7c9b0041f7eb52083c78933::simple_memory::SimpleMemory, arg2: u64, arg3: u64, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg5);
        let v1 = Listing{
            id            : 0x2::object::new(arg5),
            seller        : v0,
            price         : arg2,
            kind          : 2,
            anniv         : 0x1::option::none<0x7dcd601d40cf741f112f2a872f522d6108b11df5d7c9b0041f7eb52083c78933::anniversary_vault::Today365>(),
            nost          : 0x1::option::none<0x7dcd601d40cf741f112f2a872f522d6108b11df5d7c9b0041f7eb52083c78933::nostalgia_ticket::NostalgiaTicket>(),
            simple        : 0x1::option::some<0x7dcd601d40cf741f112f2a872f522d6108b11df5d7c9b0041f7eb52083c78933::simple_memory::SimpleMemory>(arg1),
            created_at_ms : 0x2::clock::timestamp_ms(arg4),
            expires_at_ms : arg3,
            status        : 0,
        };
        let v2 = OwnershipOffered{
            listing_id    : 0x2::object::id<Listing>(&v1),
            ticket_id     : 0x2::object::id<0x7dcd601d40cf741f112f2a872f522d6108b11df5d7c9b0041f7eb52083c78933::simple_memory::SimpleMemory>(&arg1),
            seller        : v0,
            kind          : 2,
            price         : arg2,
            expires_at_ms : arg3,
        };
        0x2::event::emit<OwnershipOffered>(v2);
        0x2::transfer::share_object<Listing>(v1);
    }

    public entry fun set_fee_bps(arg0: &0x7dcd601d40cf741f112f2a872f522d6108b11df5d7c9b0041f7eb52083c78933::admin::AdminCap, arg1: &mut Params, arg2: u16) {
        assert!((arg2 as u64) < 10000, 0);
        arg1.fee_bps = arg2;
    }

    public entry fun set_fee_mode(arg0: &0x7dcd601d40cf741f112f2a872f522d6108b11df5d7c9b0041f7eb52083c78933::admin::AdminCap, arg1: &mut Params, arg2: u8, arg3: address) {
        assert!(arg2 == 0 || arg2 == 1, 14);
        arg1.fee_mode = arg2;
        arg1.fee_treasury_addr = arg3;
    }

    // decompiled from Move bytecode v6
}

