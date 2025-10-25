module 0x63e12d1104c4f715719fa11b2b12cc1571dc518f7129b97cb01932950173079e::workshop {
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

