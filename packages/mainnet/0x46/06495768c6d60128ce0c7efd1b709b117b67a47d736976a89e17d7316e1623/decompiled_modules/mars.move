module 0x4606495768c6d60128ce0c7efd1b709b117b67a47d736976a89e17d7316e1623::mars {
    struct MARS has drop {
        dummy_field: bool,
    }

    fun init(arg0: MARS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MARS>(arg0, 6, b"Mars", b"Marsupilami", b"BULLISH ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000193711_ad1c958c80.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MARS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<MARS>>(v1);
    }

    // decompiled from Move bytecode v6
}

