module 0xeb8c49ef53ac799dda856c7e5fa081648ac017fadbeef8f940cd84cb7cac1c2a::jaq {
    struct JAQ has drop {
        dummy_field: bool,
    }

    fun init(arg0: JAQ, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<JAQ>(arg0, 6, b"JaQ", b"JasQuant ", b"This is a Quantitative trading Fund project.Today I start a personal Quantitative trading project.I will deposit every trade 5% to this token. This token help to learn AI and Quantitative trade and encourage blockchain", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1740131823659.webp")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<JAQ>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<JAQ>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

