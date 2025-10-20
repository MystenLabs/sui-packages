module 0xce565fac62b1f1c26ff06058f04f11564ad559a2cf314585d66d8a4658e5622b::weekday {
    struct Weekday has key {
        id: 0x2::object::UID,
        name: 0x1::string::String,
        day: u8,
    }

    public fun create_weekday(arg0: 0x1::string::String, arg1: u8, arg2: &mut 0x2::tx_context::TxContext) : Weekday {
        Weekday{
            id   : 0x2::object::new(arg2),
            name : arg0,
            day  : arg1,
        }
    }

    // decompiled from Move bytecode v6
}

