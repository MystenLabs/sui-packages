module 0x5442bb0eb7bd5cbb2e56dccb4f119a70681f3ddcbb0af6941ce82d4b18013186::tramp {
    struct TRAMP has drop {
        dummy_field: bool,
    }

    fun init(arg0: TRAMP, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TRAMP>(arg0, 6, b"TRAMP", b"VOTE $TRAMP", b"DONALD TRAMPPP FOR PRESIDENTS $SUI", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_4068_899b07ee84.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TRAMP>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<TRAMP>>(v1);
    }

    // decompiled from Move bytecode v6
}

