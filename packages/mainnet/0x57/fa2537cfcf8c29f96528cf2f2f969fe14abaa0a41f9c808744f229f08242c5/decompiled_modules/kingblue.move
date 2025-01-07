module 0x57fa2537cfcf8c29f96528cf2f2f969fe14abaa0a41f9c808744f229f08242c5::kingblue {
    struct KINGBLUE has drop {
        dummy_field: bool,
    }

    fun init(arg0: KINGBLUE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<KINGBLUE>(arg0, 6, b"KINGBLUE", b"KING BLUE SUI", b"EVERYTHING IS BLUE = MOON, BLUE IS THE KING ON $SUI", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_3905_2160585a54.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<KINGBLUE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<KINGBLUE>>(v1);
    }

    // decompiled from Move bytecode v6
}

