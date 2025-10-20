module 0x2a195834fb8c88b44227730eb41b7ab37a26eb15247fa817e7fa333c9a074ad8::weekday {
    struct Weekday has store, key {
        id: 0x2::object::UID,
        name: 0x1::string::String,
        day: u8,
    }

    public fun create_weekday(arg0: 0x1::string::String, arg1: u8, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = Weekday{
            id   : 0x2::object::new(arg2),
            name : arg0,
            day  : arg1,
        };
        0x2::transfer::public_transfer<Weekday>(v0, 0x2::tx_context::sender(arg2));
    }

    // decompiled from Move bytecode v6
}

