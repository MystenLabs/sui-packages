module 0x3a616c24d42cd51cada8a838d0de8a489f68ec32e5ff9740194192ef8e239043::moocat {
    struct MOOCAT has drop {
        dummy_field: bool,
    }

    fun init(arg0: MOOCAT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MOOCAT>(arg0, 6, b"MOOCAT", b"MooCat on SUI", b"meow is temporary, moo is forever!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/urmh6j_Ot_400x400_40760dfb17.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MOOCAT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<MOOCAT>>(v1);
    }

    // decompiled from Move bytecode v6
}

