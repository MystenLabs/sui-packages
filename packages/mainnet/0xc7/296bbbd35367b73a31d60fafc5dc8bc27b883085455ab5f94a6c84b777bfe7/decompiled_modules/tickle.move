module 0xc7296bbbd35367b73a31d60fafc5dc8bc27b883085455ab5f94a6c84b777bfe7::tickle {
    struct TICKLE has drop {
        dummy_field: bool,
    }

    fun init(arg0: TICKLE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TICKLE>(arg0, 6, b"TICKLE", b"Tickle", b"They call me $TICKLE. Your best red friend!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/pfp_57ad8a64b4.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TICKLE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<TICKLE>>(v1);
    }

    // decompiled from Move bytecode v6
}

