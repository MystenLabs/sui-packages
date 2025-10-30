module 0x7d2b57ca5ecdd25609430807476ca561e443008dacbb4b445b777864f8f91305::ict {
    struct Powerbank has key {
        id: 0x2::object::UID,
        colour: 0x1::string::String,
        name: 0x1::string::String,
    }

    public fun new_powerbank(arg0: 0x1::string::String, arg1: 0x1::string::String, arg2: &mut 0x2::tx_context::TxContext) : Powerbank {
        Powerbank{
            id     : 0x2::object::new(arg2),
            colour : arg0,
            name   : arg1,
        }
    }

    // decompiled from Move bytecode v6
}

