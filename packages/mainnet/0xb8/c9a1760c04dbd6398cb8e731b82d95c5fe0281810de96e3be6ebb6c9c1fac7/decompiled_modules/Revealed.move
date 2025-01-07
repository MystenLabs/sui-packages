module 0xb8c9a1760c04dbd6398cb8e731b82d95c5fe0281810de96e3be6ebb6c9c1fac7::Revealed {
    struct REVEALED has drop {
        dummy_field: bool,
    }

    fun init(arg0: REVEALED, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<REVEALED>(arg0, 0, b"PACK", b"Revealed", b"", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://aurahma-canvas-test-bucket.s3.eu-west-3.amazonaws.com/packs/Starter_Pack_2.png")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<REVEALED>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<REVEALED>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

