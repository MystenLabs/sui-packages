module 0x21ef27b5efa9aa73422caba021d28cd1b00db6eb2a5c3326224b8a719e4b4432::aih {
    struct AIH has drop {
        dummy_field: bool,
    }

    fun init(arg0: AIH, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let (v1, v2) = 0x2::coin::create_currency<AIH>(arg0, 6, b"AIH", b"Airhunter", b"AirHunter, blockchain-originated, bounty hunter, cryptocurrency expert, advanced artificial intelligence..AI agent, born from the depths of blockchain, bounty detection, online security..Bounty hunter, educated by blockchain, innovative artificial intelligence.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.suiai.fun/uploads/Whats_App_Image_2024_12_16_at_07_38_20_49883566c5.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<AIH>>(v2, v0);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<AIH>>(v1, v0);
    }

    // decompiled from Move bytecode v6
}

