module 0xdc66ab3a25633f0f34be8752279e3f82ff8effc231c560379b0d5c253b45afdf::lasu2 {
    struct Workshop has store, key {
        id: 0x2::object::UID,
        name: 0x1::string::String,
        attendees: u8,
    }

    public fun create_workshop(arg0: 0x1::string::String, arg1: u8, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = Workshop{
            id        : 0x2::object::new(arg2),
            name      : arg0,
            attendees : arg1,
        };
        0x2::transfer::public_transfer<Workshop>(v0, 0x2::tx_context::sender(arg2));
    }

    // decompiled from Move bytecode v6
}

