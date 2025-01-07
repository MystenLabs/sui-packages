module 0x3bedc376d9f6c7d1116b495117ec3575409bb2013788aea6c5c5d3836b908361::larry {
    struct LARRY has drop {
        dummy_field: bool,
    }

    fun init(arg0: LARRY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<LARRY>(arg0, 6, b"LARRY", b"Larry the Lobster", b"Welcome to the Sui Lagoon. Here you can find many ocean dwellers, but none are as much of a MUSCULAR HODL'ing CHAD as $LARRY. $LARRY has a 1 Billion supply, LP is burnt and 0% buy and sell tax. #LiveLikeLARRY", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/LARRY_LOGO_WIF_SAND_42a415672e_b9582e646b.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<LARRY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<LARRY>>(v1);
    }

    // decompiled from Move bytecode v6
}

