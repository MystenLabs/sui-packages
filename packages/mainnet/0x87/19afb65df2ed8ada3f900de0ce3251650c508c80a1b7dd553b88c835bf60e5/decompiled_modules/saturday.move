module 0x8719afb65df2ed8ada3f900de0ce3251650c508c80a1b7dd553b88c835bf60e5::saturday {
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

