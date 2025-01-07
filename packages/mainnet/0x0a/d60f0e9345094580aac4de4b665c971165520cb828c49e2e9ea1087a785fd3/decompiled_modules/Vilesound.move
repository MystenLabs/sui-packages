module 0xad60f0e9345094580aac4de4b665c971165520cb828c49e2e9ea1087a785fd3::Vilesound {
    struct VILESOUND has drop {
        dummy_field: bool,
    }

    fun init(arg0: VILESOUND, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<VILESOUND>(arg0, 0, b"COS", b"Vilesound", b"Feast on the sound, grubby yet gooey.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://aurahma-canvas-test-bucket.s3.eu-west-3.amazonaws.com/cosmetic/Ears_Vilesound.png")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<VILESOUND>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<VILESOUND>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

