module 0xa9cc950ff3458dc8fdc2915bcc1da59b68fe561632d77189ab13f0181e2afd41::bbr {
    struct BBR has drop {
        dummy_field: bool,
    }

    fun init(arg0: BBR, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BBR>(arg0, 6, b"BBR", x"42c3b3626572204b55525741", x"42c3b3626572204b555257412069732074686520666972737420706f6c697368206d656d6520636f696e206261736564206f6e202242c3b36272204b75727761204a612050696572646f6c652220696e7465726e6574206d656d652e0a436865636b2069743a2068747470733a2f2f7777772e796f75747562652e636f6d2f73686f7274732f5767593551356439534e51", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1731622918147.jpeg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<BBR>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BBR>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

