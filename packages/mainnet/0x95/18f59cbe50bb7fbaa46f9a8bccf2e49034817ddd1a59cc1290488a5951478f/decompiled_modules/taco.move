module 0x9518f59cbe50bb7fbaa46f9a8bccf2e49034817ddd1a59cc1290488a5951478f::taco {
    struct TACO has drop {
        dummy_field: bool,
    }

    fun init(arg0: TACO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TACO>(arg0, 6, b"TACO", b"Player1Taco", x"4576657279626f6479206c6f76657320245441434f0a0a4275696c64696e6720736f6d657468696e672e2e2e2e0a0a427574204761727920736179732077652063616e27742074656c6c20796f752e0a0a57652073746172746564206f6e2041504520436861696e2c20627574207765206172652063686173696e672074686520424c55452e2e2e2e", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1731055840201.png")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<TACO>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TACO>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

