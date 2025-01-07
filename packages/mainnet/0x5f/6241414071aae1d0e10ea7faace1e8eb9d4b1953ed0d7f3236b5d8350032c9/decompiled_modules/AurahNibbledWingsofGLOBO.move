module 0x5f6241414071aae1d0e10ea7faace1e8eb9d4b1953ed0d7f3236b5d8350032c9::AurahNibbledWingsofGLOBO {
    struct AURAHNIBBLEDWINGSOFGLOBO has drop {
        dummy_field: bool,
    }

    fun init(arg0: AURAHNIBBLEDWINGSOFGLOBO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<AURAHNIBBLEDWINGSOFGLOBO>(arg0, 0, b"COS", b"Aurah-Nibbled Wings of GLOBO", b"Crystalline: the mist-glimpsed glass that shapes our souls.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://aurahma-canvas-test-bucket.s3.eu-west-3.amazonaws.com/cosmetic/Wings_Aurah-Nibbled_Wings_of_GLOBO.png")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<AURAHNIBBLEDWINGSOFGLOBO>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<AURAHNIBBLEDWINGSOFGLOBO>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

