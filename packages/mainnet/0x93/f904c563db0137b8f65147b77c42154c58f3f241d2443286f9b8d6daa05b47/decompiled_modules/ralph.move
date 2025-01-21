module 0x93f904c563db0137b8f65147b77c42154c58f3f241d2443286f9b8d6daa05b47::ralph {
    struct RALPH has drop {
        dummy_field: bool,
    }

    fun init(arg0: RALPH, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<RALPH>(arg0, 6, b"RALPH", b"OFFICIAL TRUMP DOG", b" $RALPH - The only official Trump dog coin meme.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_20250122_002813_872_dcfb52a335.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<RALPH>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<RALPH>>(v1);
    }

    // decompiled from Move bytecode v6
}

