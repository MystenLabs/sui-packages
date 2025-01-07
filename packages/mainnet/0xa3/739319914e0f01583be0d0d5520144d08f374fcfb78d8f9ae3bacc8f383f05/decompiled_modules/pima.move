module 0xa3739319914e0f01583be0d0d5520144d08f374fcfb78d8f9ae3bacc8f383f05::pima {
    struct PIMA has drop {
        dummy_field: bool,
    }

    fun init(arg0: PIMA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PIMA>(arg0, 6, b"PIMA", b"Pixel Mario", b"Pixel Mario is here to save the day, blending the charm of classic Mario with the humor of today's meme culture. In this pixel-perfect world, our beloved plumber embarks on a quest to restore order to the Mushroom Kingdom, now overrun by viral memes and internet chaos.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/logo_m_39247613c2.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PIMA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<PIMA>>(v1);
    }

    // decompiled from Move bytecode v6
}

