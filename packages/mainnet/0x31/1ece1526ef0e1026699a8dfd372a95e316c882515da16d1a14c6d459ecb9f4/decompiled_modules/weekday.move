module 0x311ece1526ef0e1026699a8dfd372a95e316c882515da16d1a14c6d459ecb9f4::weekday {
    struct Weekday has key {
        id: 0x2::object::UID,
        name: 0x1::string::String,
        day: u8,
    }

    public(friend) fun create_weekday(arg0: 0x1::string::String, arg1: u8, arg2: &mut 0x2::tx_context::TxContext) : Weekday {
        Weekday{
            id   : 0x2::object::new(arg2),
            name : arg0,
            day  : arg1,
        }
    }

    // decompiled from Move bytecode v6
}

