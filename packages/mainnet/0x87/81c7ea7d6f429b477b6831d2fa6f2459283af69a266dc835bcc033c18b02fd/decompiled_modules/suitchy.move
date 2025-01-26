module 0x8781c7ea7d6f429b477b6831d2fa6f2459283af69a266dc835bcc033c18b02fd::suitchy {
    struct SUITCHY has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUITCHY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUITCHY>(arg0, 6, b"SUITCHY", b"Suitchy", b"Suitchy is a memecoin designed to redefine how people perceive the crypto world. More than just a meme, Suitchy combines a strong community with real utility, offering sustainable investment opportunities. With a focus on innovation, transparency, and mass adoption, Suitchy is committed to becoming a symbol of change in the digital ecosystem. Its iconic mascot represents a progressive spirit and the courage to stand out in a competitive market. Suitchy is not just a token but a movement for a better crypto future.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000047648_c8a75117a4.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUITCHY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUITCHY>>(v1);
    }

    // decompiled from Move bytecode v6
}

