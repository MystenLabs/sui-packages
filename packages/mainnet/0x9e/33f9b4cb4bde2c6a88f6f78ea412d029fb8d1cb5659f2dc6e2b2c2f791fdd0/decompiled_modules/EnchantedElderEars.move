module 0x9e33f9b4cb4bde2c6a88f6f78ea412d029fb8d1cb5659f2dc6e2b2c2f791fdd0::EnchantedElderEars {
    struct ENCHANTEDELDEREARS has drop {
        dummy_field: bool,
    }

    fun init(arg0: ENCHANTEDELDEREARS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ENCHANTEDELDEREARS>(arg0, 0, b"COS", b"Enchanted ElderEars", b"A sound... a whisper... could it be? Must keep listening...", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://aurahma-canvas-test-bucket.s3.eu-west-3.amazonaws.com/cosmetic/Ears_Enchanted_ElderEars.png")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<ENCHANTEDELDEREARS>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ENCHANTEDELDEREARS>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

