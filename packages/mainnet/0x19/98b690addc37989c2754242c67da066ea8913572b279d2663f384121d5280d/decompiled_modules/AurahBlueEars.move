module 0x1998b690addc37989c2754242c67da066ea8913572b279d2663f384121d5280d::AurahBlueEars {
    struct AURAHBLUEEARS has drop {
        dummy_field: bool,
    }

    fun init(arg0: AURAHBLUEEARS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<AURAHBLUEEARS>(arg0, 0, b"COS", b"AurahBlue Ears", b"Little one, are you listening?", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://aurahma-canvas-test-bucket.s3.eu-west-3.amazonaws.com/cosmetic/Ears_AurahBlue_Ears.png")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<AURAHBLUEEARS>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<AURAHBLUEEARS>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

