module 0xf169709f292e6640b063c65bc7f650be4264bebc095f285861b6ef1a87e359a6::emit {
    struct Event has copy, drop {
        tag: u64,
    }

    struct Admin has store, key {
        id: 0x2::object::UID,
    }

    public fun emit_events<T0>(arg0: &Admin, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = 1;
        while (v0 <= arg1) {
            let v1 = Event{tag: arg1};
            0x2::event::emit<Event>(v1);
            v0 = v0 + 1;
        };
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = Admin{id: 0x2::object::new(arg0)};
        0x2::transfer::transfer<Admin>(v0, 0x2::tx_context::sender(arg0));
    }

    // decompiled from Move bytecode v6
}

