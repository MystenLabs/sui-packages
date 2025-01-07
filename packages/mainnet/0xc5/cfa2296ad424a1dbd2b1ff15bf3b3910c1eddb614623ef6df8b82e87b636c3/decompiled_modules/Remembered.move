module 0xc5cfa2296ad424a1dbd2b1ff15bf3b3910c1eddb614623ef6df8b82e87b636c3::Remembered {
    struct REMEMBERED has drop {
        dummy_field: bool,
    }

    fun init(arg0: REMEMBERED, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<REMEMBERED>(arg0, 0, b"PACK", b"Remembered", b"", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://aurahma-canvas-test-bucket.s3.eu-west-3.amazonaws.com/packs/Starter_Pack_1.png")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<REMEMBERED>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<REMEMBERED>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

