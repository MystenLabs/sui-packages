module 0x1ca8da846ce337c3836c68897dfe77a186505a798da64cebc15c861cb8c400ac::diamondballs {
    struct DIAMONDBALLS has drop {
        dummy_field: bool,
    }

    fun init(arg0: DIAMONDBALLS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DIAMONDBALLS>(arg0, 6, b"DIAMONDBALLS", b"DIAMOND BALLS", b"HODL ONLY.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_5751_6e4ce628c5.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DIAMONDBALLS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<DIAMONDBALLS>>(v1);
    }

    // decompiled from Move bytecode v6
}

