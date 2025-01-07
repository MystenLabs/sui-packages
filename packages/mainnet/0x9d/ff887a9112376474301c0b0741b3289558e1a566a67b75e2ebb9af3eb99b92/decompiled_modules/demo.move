module 0x9dff887a9112376474301c0b0741b3289558e1a566a67b75e2ebb9af3eb99b92::demo {
    struct PubishedMessage has store, key {
        id: 0x2::object::UID,
        message: 0x1::string::String,
    }

    public entry fun pubish_message(arg0: 0x1::string::String, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = PubishedMessage{
            id      : 0x2::object::new(arg1),
            message : arg0,
        };
        0x2::transfer::share_object<PubishedMessage>(v0);
    }

    // decompiled from Move bytecode v6
}

