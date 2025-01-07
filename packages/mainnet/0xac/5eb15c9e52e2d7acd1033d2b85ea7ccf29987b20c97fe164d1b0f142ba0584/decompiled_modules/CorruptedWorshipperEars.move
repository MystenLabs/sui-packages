module 0xac5eb15c9e52e2d7acd1033d2b85ea7ccf29987b20c97fe164d1b0f142ba0584::CorruptedWorshipperEars {
    struct CORRUPTEDWORSHIPPEREARS has drop {
        dummy_field: bool,
    }

    fun init(arg0: CORRUPTEDWORSHIPPEREARS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CORRUPTEDWORSHIPPEREARS>(arg0, 0, b"COS", b"Corrupted Worshipper Ears", b"Don't listen... Don't hear them... their exaltant wailing...", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://aurahma-canvas-test-bucket.s3.eu-west-3.amazonaws.com/cosmetic/Ears_Corrupted_Worshipper_Ears.png")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<CORRUPTEDWORSHIPPEREARS>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CORRUPTEDWORSHIPPEREARS>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

