module 0x8aeddc665e62fbb6f1d868cd257cb354e8542c85590cf1c2e2f1ca60323156c9::WRLS {
    struct WRLS has drop {
        dummy_field: bool,
    }

    fun init(arg0: WRLS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<WRLS>(arg0, 6, b"Tusky Token", b"WRLS", b"Dive into the depths of meme wealth with Tusky Token, the official cryptocurrency of walrus enthusiasts everywhere! Hold WRLS and join the blubbery brigade of investors who are making waves in the crypto ocean.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"ICoN_URL_STRING_PLACEHOLDER")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<WRLS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<WRLS>>(v1);
    }

    // decompiled from Move bytecode v6
}

