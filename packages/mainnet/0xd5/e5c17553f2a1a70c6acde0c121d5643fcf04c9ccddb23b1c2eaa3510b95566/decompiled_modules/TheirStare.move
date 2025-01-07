module 0xd5e5c17553f2a1a70c6acde0c121d5643fcf04c9ccddb23b1c2eaa3510b95566::TheirStare {
    struct THEIRSTARE has drop {
        dummy_field: bool,
    }

    fun init(arg0: THEIRSTARE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<THEIRSTARE>(arg0, 0, b"COS", b"Their Stare", b"See as They see... Read as They read... become anew.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://aurahma-canvas-test-bucket.s3.eu-west-3.amazonaws.com/cosmetic/Eyes_Their_Stare.png")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<THEIRSTARE>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<THEIRSTARE>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

