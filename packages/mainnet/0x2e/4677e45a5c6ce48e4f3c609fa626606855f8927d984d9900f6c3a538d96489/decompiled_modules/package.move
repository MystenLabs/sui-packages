module 0x2e4677e45a5c6ce48e4f3c609fa626606855f8927d984d9900f6c3a538d96489::package {
    struct PACKAGE has drop {
        dummy_field: bool,
    }

    struct Object has store, key {
        id: 0x2::object::UID,
        name: 0x1::string::String,
    }

    struct Event has copy, drop {
        timestamp: u64,
        name: 0x1::string::String,
    }

    struct ObjectDeleted has copy, drop {
        id: 0x2::object::ID,
        timestamp: u64,
        name: 0x1::string::String,
    }

    public fun destroy(arg0: Object, arg1: &0x2::clock::Clock) {
        let Object {
            id   : v0,
            name : v1,
        } = arg0;
        let v2 = v0;
        let v3 = ObjectDeleted{
            id        : 0x2::object::uid_to_inner(&v2),
            timestamp : 0x2::clock::timestamp_ms(arg1),
            name      : v1,
        };
        0x2::event::emit<ObjectDeleted>(v3);
        0x2::object::delete(v2);
    }

    public fun emit_event(arg0: &Object, arg1: &0x2::clock::Clock) {
        let v0 = Event{
            timestamp : 0x2::clock::timestamp_ms(arg1),
            name      : arg0.name,
        };
        0x2::event::emit<Event>(v0);
    }

    fun init(arg0: PACKAGE, arg1: &mut 0x2::tx_context::TxContext) {
        0x2::package::claim_and_keep<PACKAGE>(arg0, arg1);
        let v0 = Object{
            id   : 0x2::object::new(arg1),
            name : 0x1::string::utf8(b"Object Object"),
        };
        0x2::transfer::public_transfer<Object>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

