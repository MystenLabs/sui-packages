module 0x44d80074e5adc3a84aa5e7bfe1e9be8a08b6c0248ca0f40320d7cd1166bea7b6::itsui {
    struct ITSUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: ITSUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ITSUI>(arg0, 6, b"ITSUI", b"ITSUI ME A MARIO", b"ITSUIII MEEE AAA MARIOOOO!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_0810_58c726a074.gif")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ITSUI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<ITSUI>>(v1);
    }

    // decompiled from Move bytecode v6
}

