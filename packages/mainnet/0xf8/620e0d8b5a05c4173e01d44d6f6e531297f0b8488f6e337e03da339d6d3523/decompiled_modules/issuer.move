module 0xf8620e0d8b5a05c4173e01d44d6f6e531297f0b8488f6e337e03da339d6d3523::issuer {
    struct EventConfig has store, key {
        id: 0x2::object::UID,
        description: 0x1::string::String,
    }

    struct Event has store, key {
        id: 0x2::object::UID,
        description: 0x1::string::String,
        expired_at: u64,
        visitors: 0x2::vec_set::VecSet<address>,
    }

    public entry fun create_event(arg0: &mut EventConfig, arg1: 0x1::string::String, arg2: 0x1::string::String, arg3: u64, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = Event{
            id          : 0x2::object::new(arg4),
            description : arg2,
            expired_at  : arg3,
            visitors    : 0x2::vec_set::empty<address>(),
        };
        0x2::dynamic_object_field::add<0x1::string::String, Event>(&mut arg0.id, arg1, v0);
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = EventConfig{
            id          : 0x2::object::new(arg0),
            description : 0x1::string::utf8(b"Sui Japn Meetup POAP"),
        };
        0x2::transfer::share_object<EventConfig>(v0);
    }

    public entry fun mint(arg0: &mut EventConfig, arg1: &0x2::clock::Clock, arg2: 0x1::string::String, arg3: 0x1::string::String, arg4: 0x1::string::String, arg5: 0x1::string::String, arg6: 0x1::string::String, arg7: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::dynamic_object_field::borrow_mut<0x1::string::String, Event>(&mut arg0.id, arg2);
        assert!(0x2::clock::timestamp_ms(arg1) < v0.expired_at, 1001);
        0x2::vec_set::insert<address>(&mut v0.visitors, 0x2::tx_context::sender(arg7));
        0x2::transfer::public_transfer<0xf8620e0d8b5a05c4173e01d44d6f6e531297f0b8488f6e337e03da339d6d3523::nft::CoCoNFT>(0xf8620e0d8b5a05c4173e01d44d6f6e531297f0b8488f6e337e03da339d6d3523::nft::new(arg3, arg4, arg5, arg1, arg7), 0x2::tx_context::sender(arg7));
    }

    // decompiled from Move bytecode v6
}

