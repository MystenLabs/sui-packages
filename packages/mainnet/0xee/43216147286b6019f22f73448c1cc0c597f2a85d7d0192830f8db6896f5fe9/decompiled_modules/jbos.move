module 0xee43216147286b6019f22f73448c1cc0c597f2a85d7d0192830f8db6896f5fe9::jbos {
    struct JBOS has drop {
        dummy_field: bool,
    }

    fun init(arg0: JBOS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<JBOS>(arg0, 6, b"JBOS", b"JustBuyOneSui", x"4a75737420427579204f6e6520537569200a546f206d616b6520697420736d696c65203a290a0a54686973206973206d7920666972737420636f696e2e2054696c6c20746865206d6f6f6e20776974682073746172746572206c75636b20", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/DALLA_E_2025_01_12_08_56_27_A_cute_blue_coin_with_a_smiling_face_featuring_large_adorable_eyes_and_a_friendly_expression_surrounded_by_a_subtle_glow_to_make_it_appear_vibrant_a_05da5c6bbc.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<JBOS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<JBOS>>(v1);
    }

    // decompiled from Move bytecode v6
}

