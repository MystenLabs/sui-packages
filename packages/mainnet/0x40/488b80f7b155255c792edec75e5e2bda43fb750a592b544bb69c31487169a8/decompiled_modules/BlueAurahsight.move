module 0x40488b80f7b155255c792edec75e5e2bda43fb750a592b544bb69c31487169a8::BlueAurahsight {
    struct BLUEAURAHSIGHT has drop {
        dummy_field: bool,
    }

    fun init(arg0: BLUEAURAHSIGHT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BLUEAURAHSIGHT>(arg0, 0, b"COS", b"Blue Aurahsight", b"Little one, do you see?", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://aurahma-canvas-test-bucket.s3.eu-west-3.amazonaws.com/cosmetic/Eyes_Blue_Aurahsight.png")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<BLUEAURAHSIGHT>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BLUEAURAHSIGHT>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

