module 0xc984b722872bc3120f1629d67b9ffe4c6dc7ce4fd8d6326cea03b506f3fb4168::events {
    struct Event has key {
        id: 0x2::object::UID,
        creator: address,
        name: 0x1::string::String,
        description: 0x1::string::String,
        start_time_ms: u64,
        end_time_ms: u64,
        created_at_ms: u64,
        is_public: bool,
    }

    public fun create_event(arg0: 0x1::string::String, arg1: 0x1::string::String, arg2: u64, arg3: u64, arg4: bool, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) {
        assert!(arg3 >= arg2, 1);
        let v0 = Event{
            id            : 0x2::object::new(arg6),
            creator       : 0x2::tx_context::sender(arg6),
            name          : arg0,
            description   : arg1,
            start_time_ms : arg2,
            end_time_ms   : arg3,
            created_at_ms : 0x2::clock::timestamp_ms(arg5),
            is_public     : arg4,
        };
        0x2::transfer::transfer<Event>(v0, 0x2::tx_context::sender(arg6));
    }

    public fun creator_of(arg0: &Event) : address {
        arg0.creator
    }

    public fun event_id(arg0: &Event) : address {
        0x2::object::uid_to_address(&arg0.id)
    }

    // decompiled from Move bytecode v6
}

