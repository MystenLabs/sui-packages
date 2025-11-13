module 0x9cb1bc5f66943b88ac6ec9a2942e1ce2cbba2b98b4f41c67c1096b3cf0610a74::engineering {
    struct Workshop has store, key {
        id: 0x2::object::UID,
        name: 0x1::string::String,
        title: 0x1::string::String,
        duration: u8,
    }

    public fun create_workshop(arg0: 0x1::string::String, arg1: 0x1::string::String, arg2: u8, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = Workshop{
            id       : 0x2::object::new(arg3),
            name     : arg0,
            title    : arg1,
            duration : arg2,
        };
        0x2::transfer::transfer<Workshop>(v0, 0x2::tx_context::sender(arg3));
    }

    // decompiled from Move bytecode v6
}

