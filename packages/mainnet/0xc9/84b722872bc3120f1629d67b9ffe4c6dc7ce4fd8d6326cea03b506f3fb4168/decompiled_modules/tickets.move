module 0xc984b722872bc3120f1629d67b9ffe4c6dc7ce4fd8d6326cea03b506f3fb4168::tickets {
    struct Tier has key {
        id: 0x2::object::UID,
        event_id: address,
        creator: address,
        name: 0x1::string::String,
        price_mist: u64,
        max_supply: u64,
        minted: u64,
        active: bool,
    }

    struct Ticket has key {
        id: 0x2::object::UID,
        event_id: address,
        tier_id: address,
        issued_at_ms: u64,
        expires_at_ms: u64,
        is_used: bool,
    }

    public fun create_tier(arg0: &0xc984b722872bc3120f1629d67b9ffe4c6dc7ce4fd8d6326cea03b506f3fb4168::events::Event, arg1: 0x1::string::String, arg2: u64, arg3: u64, arg4: bool, arg5: &mut 0x2::tx_context::TxContext) {
        let v0 = 0xc984b722872bc3120f1629d67b9ffe4c6dc7ce4fd8d6326cea03b506f3fb4168::events::creator_of(arg0);
        assert!(0x2::tx_context::sender(arg5) == v0, 1);
        let v1 = Tier{
            id         : 0x2::object::new(arg5),
            event_id   : 0xc984b722872bc3120f1629d67b9ffe4c6dc7ce4fd8d6326cea03b506f3fb4168::events::event_id(arg0),
            creator    : v0,
            name       : arg1,
            price_mist : arg2,
            max_supply : arg3,
            minted     : 0,
            active     : arg4,
        };
        0x2::transfer::share_object<Tier>(v1);
    }

    public fun mint_ticket(arg0: &mut Tier, arg1: u64, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.active, 2);
        assert!(arg0.minted < arg0.max_supply, 3);
        arg0.minted = arg0.minted + 1;
        let v0 = Ticket{
            id            : 0x2::object::new(arg3),
            event_id      : arg0.event_id,
            tier_id       : 0x2::object::uid_to_address(&arg0.id),
            issued_at_ms  : 0x2::clock::timestamp_ms(arg2),
            expires_at_ms : arg1,
            is_used       : false,
        };
        0x2::transfer::transfer<Ticket>(v0, 0x2::tx_context::sender(arg3));
    }

    public fun mint_ticket_paid(arg0: &mut Tier, arg1: 0x2::coin::Coin<0x2::sui::SUI>, arg2: u64, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.active, 2);
        assert!(arg0.minted < arg0.max_supply, 3);
        let v0 = arg0.price_mist;
        let v1 = 0x2::coin::value<0x2::sui::SUI>(&arg1);
        assert!(v1 >= v0, 6);
        if (v1 > v0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::split<0x2::sui::SUI>(&mut arg1, v1 - v0, arg4), 0x2::tx_context::sender(arg4));
        };
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(arg1, arg0.creator);
        arg0.minted = arg0.minted + 1;
        let v2 = Ticket{
            id            : 0x2::object::new(arg4),
            event_id      : arg0.event_id,
            tier_id       : 0x2::object::uid_to_address(&arg0.id),
            issued_at_ms  : 0x2::clock::timestamp_ms(arg3),
            expires_at_ms : arg2,
            is_used       : false,
        };
        0x2::transfer::transfer<Ticket>(v2, 0x2::tx_context::sender(arg4));
    }

    public fun set_tier_active(arg0: &mut Tier, arg1: bool, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg2) == arg0.creator, 1);
        arg0.active = arg1;
    }

    public fun set_tier_price(arg0: &mut Tier, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg2) == arg0.creator, 1);
        arg0.price_mist = arg1;
    }

    public fun use_ticket(arg0: &mut Ticket, arg1: &0x2::clock::Clock) {
        assert!(!arg0.is_used, 4);
        assert!(0x2::clock::timestamp_ms(arg1) <= arg0.expires_at_ms, 5);
        arg0.is_used = true;
    }

    // decompiled from Move bytecode v6
}

