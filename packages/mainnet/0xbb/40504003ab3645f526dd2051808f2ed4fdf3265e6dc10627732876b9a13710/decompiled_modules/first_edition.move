module 0xbb40504003ab3645f526dd2051808f2ed4fdf3265e6dc10627732876b9a13710::first_edition {
    struct FirstEdition has key {
        id: 0x2::object::UID,
    }

    struct FIRST_EDITION has drop {
        dummy_field: bool,
    }

    fun init(arg0: FIRST_EDITION, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = FirstEdition{id: 0x2::object::new(arg1)};
        0x2::transfer::transfer<FirstEdition>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

