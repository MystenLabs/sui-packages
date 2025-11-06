module 0x439f2844747688ad44d383a0f6544753f32ab247bc90e65234fe89a325787de9::lasu2 {
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

