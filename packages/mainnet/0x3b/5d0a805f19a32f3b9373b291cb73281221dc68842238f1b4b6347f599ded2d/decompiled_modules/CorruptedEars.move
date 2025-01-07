module 0x3b5d0a805f19a32f3b9373b291cb73281221dc68842238f1b4b6347f599ded2d::CorruptedEars {
    struct CORRUPTEDEARS has drop {
        dummy_field: bool,
    }

    fun init(arg0: CORRUPTEDEARS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CORRUPTEDEARS>(arg0, 0, b"COS", b"Corrupted Ears", b"Pierced by war, exposed by the waste of Nindfall...", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://aurahma-canvas-test-bucket.s3.eu-west-3.amazonaws.com/cosmetic/Ears_Corrupted_Ears.png")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<CORRUPTEDEARS>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CORRUPTEDEARS>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

