module 0xcca6afe492455556aab0477fb60a3f4356d5fe0a1fce9e7c6b511894464fcc1e::marketplace {
    struct Params has store, key {
        id: 0x2::object::UID,
        fee_bps: u16,
        fee_mode: u8,
        fee_treasury_addr: address,
    }

    struct Listing has store, key {
        id: 0x2::object::UID,
        seller: address,
        price_tvyn: u64,
        kind: u8,
        anniv: 0x1::option::Option<0xcca6afe492455556aab0477fb60a3f4356d5fe0a1fce9e7c6b511894464fcc1e::anniversary_vault::AnniversaryTicket>,
        nost: 0x1::option::Option<0xcca6afe492455556aab0477fb60a3f4356d5fe0a1fce9e7c6b511894464fcc1e::nostalgia_ticket::NostalgiaTicket>,
        simple: 0x1::option::Option<0xcca6afe492455556aab0477fb60a3f4356d5fe0a1fce9e7c6b511894464fcc1e::simple_memory::SimpleMemory>,
        created_at_ms: u64,
        expires_at_ms: u64,
        status: u8,
    }

    struct Listed has copy, drop, store {
        listing_id: 0x2::object::ID,
        ticket_id: 0x2::object::ID,
        seller: address,
        kind: u8,
        price_tvyn: u64,
        expires_at_ms: u64,
    }

    struct Sold has copy, drop, store {
        listing_id: 0x2::object::ID,
        ticket_id: 0x2::object::ID,
        buyer: address,
        seller: address,
        price_tvyn: u64,
        fee_tvyn: u64,
        royalty_tvyn: u64,
    }

    struct Cancelled has copy, drop, store {
        listing_id: 0x2::object::ID,
        ticket_id: 0x2::object::ID,
        seller: address,
    }

    public entry fun buy(arg0: &Params, arg1: &mut Listing, arg2: 0x2::coin::Coin<0xcca6afe492455556aab0477fb60a3f4356d5fe0a1fce9e7c6b511894464fcc1e::tvyn::TVYN>, arg3: &mut 0xcca6afe492455556aab0477fb60a3f4356d5fe0a1fce9e7c6b511894464fcc1e::tvyn::MintVault, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg5);
        assert!(arg1.status == 0, 11);
        if (arg1.expires_at_ms > 0) {
            assert!(0x2::clock::timestamp_ms(arg4) < arg1.expires_at_ms, 13);
        };
        let v1 = arg1.price_tvyn;
        let v2 = 0x2::coin::value<0xcca6afe492455556aab0477fb60a3f4356d5fe0a1fce9e7c6b511894464fcc1e::tvyn::TVYN>(&arg2);
        assert!(v2 >= v1, 12);
        arg1.status = 1;
        if (v2 > v1) {
            0x2::transfer::public_transfer<0x2::coin::Coin<0xcca6afe492455556aab0477fb60a3f4356d5fe0a1fce9e7c6b511894464fcc1e::tvyn::TVYN>>(0x2::coin::split<0xcca6afe492455556aab0477fb60a3f4356d5fe0a1fce9e7c6b511894464fcc1e::tvyn::TVYN>(&mut arg2, v2 - v1, arg5), v0);
        };
        let (v3, v4, v5) = if (arg1.kind == 0) {
            let v6 = 0x1::option::extract<0xcca6afe492455556aab0477fb60a3f4356d5fe0a1fce9e7c6b511894464fcc1e::anniversary_vault::AnniversaryTicket>(&mut arg1.anniv);
            0x2::transfer::public_transfer<0xcca6afe492455556aab0477fb60a3f4356d5fe0a1fce9e7c6b511894464fcc1e::anniversary_vault::AnniversaryTicket>(v6, v0);
            (0xcca6afe492455556aab0477fb60a3f4356d5fe0a1fce9e7c6b511894464fcc1e::anniversary_vault::creator(&v6), 0xcca6afe492455556aab0477fb60a3f4356d5fe0a1fce9e7c6b511894464fcc1e::anniversary_vault::royalty_bps(&v6), 0xcca6afe492455556aab0477fb60a3f4356d5fe0a1fce9e7c6b511894464fcc1e::anniversary_vault::ticket_id(&v6))
        } else if (arg1.kind == 1) {
            let v7 = 0x1::option::extract<0xcca6afe492455556aab0477fb60a3f4356d5fe0a1fce9e7c6b511894464fcc1e::nostalgia_ticket::NostalgiaTicket>(&mut arg1.nost);
            0x2::transfer::public_transfer<0xcca6afe492455556aab0477fb60a3f4356d5fe0a1fce9e7c6b511894464fcc1e::nostalgia_ticket::NostalgiaTicket>(v7, v0);
            (0xcca6afe492455556aab0477fb60a3f4356d5fe0a1fce9e7c6b511894464fcc1e::nostalgia_ticket::creator(&v7), 0xcca6afe492455556aab0477fb60a3f4356d5fe0a1fce9e7c6b511894464fcc1e::nostalgia_ticket::royalty_bps(&v7), 0xcca6afe492455556aab0477fb60a3f4356d5fe0a1fce9e7c6b511894464fcc1e::nostalgia_ticket::ticket_id(&v7))
        } else {
            let v8 = 0x1::option::extract<0xcca6afe492455556aab0477fb60a3f4356d5fe0a1fce9e7c6b511894464fcc1e::simple_memory::SimpleMemory>(&mut arg1.simple);
            0x2::transfer::public_transfer<0xcca6afe492455556aab0477fb60a3f4356d5fe0a1fce9e7c6b511894464fcc1e::simple_memory::SimpleMemory>(v8, v0);
            (@0x0, 0, 0xcca6afe492455556aab0477fb60a3f4356d5fe0a1fce9e7c6b511894464fcc1e::simple_memory::id(&v8))
        };
        let v9 = 0x2::coin::value<0xcca6afe492455556aab0477fb60a3f4356d5fe0a1fce9e7c6b511894464fcc1e::tvyn::TVYN>(&arg2);
        let v10 = v9 * (arg0.fee_bps as u64) / 10000;
        let v11 = v9 * (v4 as u64) / 10000;
        if (v11 > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<0xcca6afe492455556aab0477fb60a3f4356d5fe0a1fce9e7c6b511894464fcc1e::tvyn::TVYN>>(0x2::coin::split<0xcca6afe492455556aab0477fb60a3f4356d5fe0a1fce9e7c6b511894464fcc1e::tvyn::TVYN>(&mut arg2, v11, arg5), v3);
        };
        assert!(0x2::coin::value<0xcca6afe492455556aab0477fb60a3f4356d5fe0a1fce9e7c6b511894464fcc1e::tvyn::TVYN>(&arg2) == v9 - v10 - v11, 0);
        0x2::transfer::public_transfer<0x2::coin::Coin<0xcca6afe492455556aab0477fb60a3f4356d5fe0a1fce9e7c6b511894464fcc1e::tvyn::TVYN>>(arg2, arg1.seller);
        if (arg0.fee_mode == 0) {
            0xcca6afe492455556aab0477fb60a3f4356d5fe0a1fce9e7c6b511894464fcc1e::tvyn::burn_for_protocol(arg3, 0x2::coin::split<0xcca6afe492455556aab0477fb60a3f4356d5fe0a1fce9e7c6b511894464fcc1e::tvyn::TVYN>(&mut arg2, v10, arg5));
        } else {
            0x2::transfer::public_transfer<0x2::coin::Coin<0xcca6afe492455556aab0477fb60a3f4356d5fe0a1fce9e7c6b511894464fcc1e::tvyn::TVYN>>(0x2::coin::split<0xcca6afe492455556aab0477fb60a3f4356d5fe0a1fce9e7c6b511894464fcc1e::tvyn::TVYN>(&mut arg2, v10, arg5), arg0.fee_treasury_addr);
        };
        let v12 = Sold{
            listing_id   : 0x2::object::id<Listing>(arg1),
            ticket_id    : v5,
            buyer        : v0,
            seller       : arg1.seller,
            price_tvyn   : v1,
            fee_tvyn     : v10,
            royalty_tvyn : v11,
        };
        0x2::event::emit<Sold>(v12);
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
            let v2 = 0x1::option::extract<0xcca6afe492455556aab0477fb60a3f4356d5fe0a1fce9e7c6b511894464fcc1e::anniversary_vault::AnniversaryTicket>(&mut arg0.anniv);
            0x2::transfer::public_transfer<0xcca6afe492455556aab0477fb60a3f4356d5fe0a1fce9e7c6b511894464fcc1e::anniversary_vault::AnniversaryTicket>(v2, v0);
            0x2::object::id<0xcca6afe492455556aab0477fb60a3f4356d5fe0a1fce9e7c6b511894464fcc1e::anniversary_vault::AnniversaryTicket>(&v2)
        } else if (arg0.kind == 1) {
            let v3 = 0x1::option::extract<0xcca6afe492455556aab0477fb60a3f4356d5fe0a1fce9e7c6b511894464fcc1e::nostalgia_ticket::NostalgiaTicket>(&mut arg0.nost);
            0x2::transfer::public_transfer<0xcca6afe492455556aab0477fb60a3f4356d5fe0a1fce9e7c6b511894464fcc1e::nostalgia_ticket::NostalgiaTicket>(v3, v0);
            0x2::object::id<0xcca6afe492455556aab0477fb60a3f4356d5fe0a1fce9e7c6b511894464fcc1e::nostalgia_ticket::NostalgiaTicket>(&v3)
        } else {
            let v4 = 0x1::option::extract<0xcca6afe492455556aab0477fb60a3f4356d5fe0a1fce9e7c6b511894464fcc1e::simple_memory::SimpleMemory>(&mut arg0.simple);
            0x2::transfer::public_transfer<0xcca6afe492455556aab0477fb60a3f4356d5fe0a1fce9e7c6b511894464fcc1e::simple_memory::SimpleMemory>(v4, v0);
            0x2::object::id<0xcca6afe492455556aab0477fb60a3f4356d5fe0a1fce9e7c6b511894464fcc1e::simple_memory::SimpleMemory>(&v4)
        };
        let v5 = Cancelled{
            listing_id : 0x2::object::id<Listing>(arg0),
            ticket_id  : v1,
            seller     : v0,
        };
        0x2::event::emit<Cancelled>(v5);
    }

    public entry fun create_and_share_params(arg0: &0xcca6afe492455556aab0477fb60a3f4356d5fe0a1fce9e7c6b511894464fcc1e::admin::AdminCap, arg1: u16, arg2: u8, arg3: address, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(arg2 == 0 || arg2 == 1, 14);
        let v0 = Params{
            id                : 0x2::object::new(arg4),
            fee_bps           : arg1,
            fee_mode          : arg2,
            fee_treasury_addr : arg3,
        };
        0x2::transfer::share_object<Params>(v0);
    }

    public entry fun list_anniversary(arg0: &Params, arg1: 0xcca6afe492455556aab0477fb60a3f4356d5fe0a1fce9e7c6b511894464fcc1e::anniversary_vault::AnniversaryTicket, arg2: u64, arg3: u64, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg5);
        let v1 = Listing{
            id            : 0x2::object::new(arg5),
            seller        : v0,
            price_tvyn    : arg2,
            kind          : 0,
            anniv         : 0x1::option::some<0xcca6afe492455556aab0477fb60a3f4356d5fe0a1fce9e7c6b511894464fcc1e::anniversary_vault::AnniversaryTicket>(arg1),
            nost          : 0x1::option::none<0xcca6afe492455556aab0477fb60a3f4356d5fe0a1fce9e7c6b511894464fcc1e::nostalgia_ticket::NostalgiaTicket>(),
            simple        : 0x1::option::none<0xcca6afe492455556aab0477fb60a3f4356d5fe0a1fce9e7c6b511894464fcc1e::simple_memory::SimpleMemory>(),
            created_at_ms : 0x2::clock::timestamp_ms(arg4),
            expires_at_ms : arg3,
            status        : 0,
        };
        let v2 = Listed{
            listing_id    : 0x2::object::id<Listing>(&v1),
            ticket_id     : 0x2::object::id<0xcca6afe492455556aab0477fb60a3f4356d5fe0a1fce9e7c6b511894464fcc1e::anniversary_vault::AnniversaryTicket>(&arg1),
            seller        : v0,
            kind          : 0,
            price_tvyn    : arg2,
            expires_at_ms : arg3,
        };
        0x2::event::emit<Listed>(v2);
        0x2::transfer::share_object<Listing>(v1);
    }

    public entry fun list_nostalgia(arg0: &Params, arg1: 0xcca6afe492455556aab0477fb60a3f4356d5fe0a1fce9e7c6b511894464fcc1e::nostalgia_ticket::NostalgiaTicket, arg2: u64, arg3: u64, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg5);
        let v1 = Listing{
            id            : 0x2::object::new(arg5),
            seller        : v0,
            price_tvyn    : arg2,
            kind          : 1,
            anniv         : 0x1::option::none<0xcca6afe492455556aab0477fb60a3f4356d5fe0a1fce9e7c6b511894464fcc1e::anniversary_vault::AnniversaryTicket>(),
            nost          : 0x1::option::some<0xcca6afe492455556aab0477fb60a3f4356d5fe0a1fce9e7c6b511894464fcc1e::nostalgia_ticket::NostalgiaTicket>(arg1),
            simple        : 0x1::option::none<0xcca6afe492455556aab0477fb60a3f4356d5fe0a1fce9e7c6b511894464fcc1e::simple_memory::SimpleMemory>(),
            created_at_ms : 0x2::clock::timestamp_ms(arg4),
            expires_at_ms : arg3,
            status        : 0,
        };
        let v2 = Listed{
            listing_id    : 0x2::object::id<Listing>(&v1),
            ticket_id     : 0x2::object::id<0xcca6afe492455556aab0477fb60a3f4356d5fe0a1fce9e7c6b511894464fcc1e::nostalgia_ticket::NostalgiaTicket>(&arg1),
            seller        : v0,
            kind          : 1,
            price_tvyn    : arg2,
            expires_at_ms : arg3,
        };
        0x2::event::emit<Listed>(v2);
        0x2::transfer::share_object<Listing>(v1);
    }

    public entry fun list_simple(arg0: &Params, arg1: 0xcca6afe492455556aab0477fb60a3f4356d5fe0a1fce9e7c6b511894464fcc1e::simple_memory::SimpleMemory, arg2: u64, arg3: u64, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg5);
        let v1 = Listing{
            id            : 0x2::object::new(arg5),
            seller        : v0,
            price_tvyn    : arg2,
            kind          : 2,
            anniv         : 0x1::option::none<0xcca6afe492455556aab0477fb60a3f4356d5fe0a1fce9e7c6b511894464fcc1e::anniversary_vault::AnniversaryTicket>(),
            nost          : 0x1::option::none<0xcca6afe492455556aab0477fb60a3f4356d5fe0a1fce9e7c6b511894464fcc1e::nostalgia_ticket::NostalgiaTicket>(),
            simple        : 0x1::option::some<0xcca6afe492455556aab0477fb60a3f4356d5fe0a1fce9e7c6b511894464fcc1e::simple_memory::SimpleMemory>(arg1),
            created_at_ms : 0x2::clock::timestamp_ms(arg4),
            expires_at_ms : arg3,
            status        : 0,
        };
        let v2 = Listed{
            listing_id    : 0x2::object::id<Listing>(&v1),
            ticket_id     : 0x2::object::id<0xcca6afe492455556aab0477fb60a3f4356d5fe0a1fce9e7c6b511894464fcc1e::simple_memory::SimpleMemory>(&arg1),
            seller        : v0,
            kind          : 2,
            price_tvyn    : arg2,
            expires_at_ms : arg3,
        };
        0x2::event::emit<Listed>(v2);
        0x2::transfer::share_object<Listing>(v1);
    }

    public entry fun set_fee_bps(arg0: &0xcca6afe492455556aab0477fb60a3f4356d5fe0a1fce9e7c6b511894464fcc1e::admin::AdminCap, arg1: &mut Params, arg2: u16) {
        assert!((arg2 as u64) < 10000, 0);
        arg1.fee_bps = arg2;
    }

    public entry fun set_fee_mode(arg0: &0xcca6afe492455556aab0477fb60a3f4356d5fe0a1fce9e7c6b511894464fcc1e::admin::AdminCap, arg1: &mut Params, arg2: u8, arg3: address) {
        assert!(arg2 == 0 || arg2 == 1, 14);
        arg1.fee_mode = arg2;
        arg1.fee_treasury_addr = arg3;
    }

    // decompiled from Move bytecode v6
}

