module 0xac67d22071431162ae450d606121e3c338a272647b5f867706f8494e716ece47::poap {
    struct POAP has drop {
        dummy_field: bool,
    }

    struct PoapEvent has key {
        id: 0x2::object::UID,
        organizer: address,
        name: 0x1::string::String,
        description: 0x1::string::String,
        image_url: 0x1::string::String,
        start_ms: u64,
        end_ms: u64,
        max_supply: u64,
        minted: u64,
        amount_per_poap: u64,
        pool: 0x2::balance::Balance<0x2::sui::SUI>,
        claimed: 0x2::table::Table<address, bool>,
    }

    struct Poap has store, key {
        id: 0x2::object::UID,
        event_id: 0x2::object::ID,
        name: 0x1::string::String,
        image_url: 0x1::string::String,
        serial: u64,
        minted_at_ms: u64,
        vault: 0x2::balance::Balance<0x2::sui::SUI>,
    }

    struct EventCreated has copy, drop {
        event_id: 0x2::object::ID,
        organizer: address,
    }

    struct Minted has copy, drop {
        event_id: 0x2::object::ID,
        poap_id: 0x2::object::ID,
        to: address,
        serial: u64,
    }

    struct Redeemed has copy, drop {
        poap_id: 0x2::object::ID,
        by: address,
        amount: u64,
    }

    public fun create_event(arg0: 0x1::string::String, arg1: 0x1::string::String, arg2: 0x1::string::String, arg3: u64, arg4: u64, arg5: u64, arg6: u64, arg7: 0x2::coin::Coin<0x2::sui::SUI>, arg8: &mut 0x2::tx_context::TxContext) {
        assert!(arg4 > arg3, 7);
        assert!(0x2::coin::value<0x2::sui::SUI>(&arg7) >= arg5 * arg6, 6);
        let v0 = PoapEvent{
            id              : 0x2::object::new(arg8),
            organizer       : 0x2::tx_context::sender(arg8),
            name            : arg0,
            description     : arg1,
            image_url       : arg2,
            start_ms        : arg3,
            end_ms          : arg4,
            max_supply      : arg5,
            minted          : 0,
            amount_per_poap : arg6,
            pool            : 0x2::coin::into_balance<0x2::sui::SUI>(arg7),
            claimed         : 0x2::table::new<address, bool>(arg8),
        };
        let v1 = EventCreated{
            event_id  : 0x2::object::id<PoapEvent>(&v0),
            organizer : v0.organizer,
        };
        0x2::event::emit<EventCreated>(v1);
        0x2::transfer::share_object<PoapEvent>(v0);
    }

    fun init(arg0: POAP, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::package::claim<POAP>(arg0, arg1);
        let v1 = 0x1::vector::empty<0x1::string::String>();
        let v2 = &mut v1;
        0x1::vector::push_back<0x1::string::String>(v2, 0x1::string::utf8(b"name"));
        0x1::vector::push_back<0x1::string::String>(v2, 0x1::string::utf8(b"image_url"));
        0x1::vector::push_back<0x1::string::String>(v2, 0x1::string::utf8(b"description"));
        let v3 = 0x1::vector::empty<0x1::string::String>();
        let v4 = &mut v3;
        0x1::vector::push_back<0x1::string::String>(v4, 0x1::string::utf8(b"{name} #{serial}"));
        0x1::vector::push_back<0x1::string::String>(v4, 0x1::string::utf8(b"{image_url}"));
        0x1::vector::push_back<0x1::string::String>(v4, 0x1::string::utf8(b"Proof of attendance holding SUI"));
        let v5 = 0x2::display::new_with_fields<Poap>(&v0, v1, v3, arg1);
        0x2::display::update_version<Poap>(&mut v5);
        0x2::transfer::public_transfer<0x2::package::Publisher>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::display::Display<Poap>>(v5, 0x2::tx_context::sender(arg1));
    }

    public fun mint(arg0: &mut PoapEvent, arg1: &0x2::clock::Clock, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::clock::timestamp_ms(arg1);
        let v1 = 0x2::tx_context::sender(arg2);
        assert!(v0 >= arg0.start_ms, 2);
        assert!(v0 <= arg0.end_ms, 1);
        assert!(arg0.minted < arg0.max_supply, 3);
        assert!(!0x2::table::contains<address, bool>(&arg0.claimed, v1), 4);
        0x2::table::add<address, bool>(&mut arg0.claimed, v1, true);
        arg0.minted = arg0.minted + 1;
        let v2 = Poap{
            id           : 0x2::object::new(arg2),
            event_id     : 0x2::object::id<PoapEvent>(arg0),
            name         : arg0.name,
            image_url    : arg0.image_url,
            serial       : arg0.minted,
            minted_at_ms : v0,
            vault        : 0x2::balance::split<0x2::sui::SUI>(&mut arg0.pool, arg0.amount_per_poap),
        };
        let v3 = Minted{
            event_id : 0x2::object::id<PoapEvent>(arg0),
            poap_id  : 0x2::object::id<Poap>(&v2),
            to       : v1,
            serial   : arg0.minted,
        };
        0x2::event::emit<Minted>(v3);
        0x2::transfer::public_transfer<Poap>(v2, v1);
    }

    public fun redeem(arg0: Poap, arg1: &mut 0x2::tx_context::TxContext) {
        let Poap {
            id           : v0,
            event_id     : _,
            name         : _,
            image_url    : _,
            serial       : _,
            minted_at_ms : _,
            vault        : v6,
        } = arg0;
        let v7 = v6;
        let v8 = v0;
        let v9 = Redeemed{
            poap_id : 0x2::object::uid_to_inner(&v8),
            by      : 0x2::tx_context::sender(arg1),
            amount  : 0x2::balance::value<0x2::sui::SUI>(&v7),
        };
        0x2::event::emit<Redeemed>(v9);
        0x2::object::delete(v8);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::from_balance<0x2::sui::SUI>(v7, arg1), 0x2::tx_context::sender(arg1));
    }

    public fun withdraw_remaining(arg0: &mut PoapEvent, arg1: &0x2::clock::Clock, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg2) == arg0.organizer, 0);
        assert!(0x2::clock::timestamp_ms(arg1) > arg0.end_ms, 5);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::take<0x2::sui::SUI>(&mut arg0.pool, 0x2::balance::value<0x2::sui::SUI>(&arg0.pool), arg2), arg0.organizer);
    }

    // decompiled from Move bytecode v7
}

