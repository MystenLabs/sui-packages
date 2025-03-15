module 0xb5dda0f233085af4ec9c70d8a39b3e4cd23fcc9f876a6cbb718654e043055fd7::suiguzman {
    struct SUIGUZMAN has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIGUZMAN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIGUZMAN>(arg0, 6, b"SuiGuzman", b"Sui Guzman", b"Meet Sui Guzman a 40 year major market news and journalism veteran working for Fox News.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1742070898750.jpeg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SUIGUZMAN>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIGUZMAN>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

