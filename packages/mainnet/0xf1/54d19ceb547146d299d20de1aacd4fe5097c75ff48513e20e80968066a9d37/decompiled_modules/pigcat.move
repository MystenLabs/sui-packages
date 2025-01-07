module 0xf154d19ceb547146d299d20de1aacd4fe5097c75ff48513e20e80968066a9d37::pigcat {
    struct PIGCAT has drop {
        dummy_field: bool,
    }

    fun init(arg0: PIGCAT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PIGCAT>(arg0, 6, b"PigCat", b"Piglet Cat", b"Just a Very Cutsy piggy cat", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_1844_30d8b1ba18.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PIGCAT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<PIGCAT>>(v1);
    }

    // decompiled from Move bytecode v6
}

