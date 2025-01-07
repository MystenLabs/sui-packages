module 0xa3d9421c98444343c1864d2098a72fc7e8acd008bf27e18eaaef46a8a418e7d8::dozo {
    struct DOZO has drop {
        dummy_field: bool,
    }

    fun init(arg0: DOZO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DOZO>(arg0, 6, b"DOZO", b"Sui Dozo", b"I am Dozo, you are Dozo, we are $DOZO", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000016999_b2a1523587.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DOZO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<DOZO>>(v1);
    }

    // decompiled from Move bytecode v6
}

