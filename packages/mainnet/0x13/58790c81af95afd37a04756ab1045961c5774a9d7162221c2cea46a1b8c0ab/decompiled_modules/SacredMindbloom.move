module 0x1358790c81af95afd37a04756ab1045961c5774a9d7162221c2cea46a1b8c0ab::SacredMindbloom {
    struct SACREDMINDBLOOM has drop {
        dummy_field: bool,
    }

    fun init(arg0: SACREDMINDBLOOM, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SACREDMINDBLOOM>(arg0, 0, b"COS", b"Sacred Mindbloom", b"In the quiet dark, we sing with divine Flowersight...", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://aurahma-canvas-test-bucket.s3.eu-west-3.amazonaws.com/cosmetic/Head_Sacred_Mindbloom.png")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SACREDMINDBLOOM>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SACREDMINDBLOOM>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

