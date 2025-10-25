module 0x71fdad9ad1c4e320cad2a8a38b747cb0976a81b4fc6f95840315235f9ec9acf9::workshop {
    struct DayTwo has store, key {
        id: 0x2::object::UID,
        title: 0x1::string::String,
    }

    public fun workshop(arg0: 0x1::string::String, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = DayTwo{
            id    : 0x2::object::new(arg1),
            title : arg0,
        };
        0x2::transfer::public_transfer<DayTwo>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

