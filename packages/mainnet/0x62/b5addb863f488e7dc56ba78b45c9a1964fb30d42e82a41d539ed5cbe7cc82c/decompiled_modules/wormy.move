module 0x62b5addb863f488e7dc56ba78b45c9a1964fb30d42e82a41d539ed5cbe7cc82c::wormy {
    struct WORMY has drop {
        dummy_field: bool,
    }

    fun init(arg0: WORMY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<WORMY>(arg0, 6, b"WORMY", b"Wormy Gold Sui", b"The leader's golden worm travels through the desert and is of great value", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000013406_36badfdfe0.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<WORMY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<WORMY>>(v1);
    }

    // decompiled from Move bytecode v6
}

