module 0x632632489c6ab473770d41a0ca4e95beefa38b3757063141ac40559b5898cdca::sofi {
    struct SOFI has drop {
        dummy_field: bool,
    }

    fun init(arg0: SOFI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SOFI>(arg0, 6, b"Sofi", b"SoPhia on sui", b"Welcome to the Sophia community! Let's explore the world of smart robots together.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/4_8f123626b7.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SOFI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SOFI>>(v1);
    }

    // decompiled from Move bytecode v6
}

