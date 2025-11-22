module 0xc7398b058c493a53d2dd44f0297af0a5458ca652b7136f815ba1d67bb0bfc92c::saturday {
    struct Weekday has key {
        id: 0x2::object::UID,
        name: 0x1::string::String,
        age: u8,
    }

    public fun name(arg0: 0x1::string::String, arg1: u8, arg2: &mut 0x2::tx_context::TxContext) : Weekday {
        Weekday{
            id   : 0x2::object::new(arg2),
            name : arg0,
            age  : arg1,
        }
    }

    // decompiled from Move bytecode v6
}

