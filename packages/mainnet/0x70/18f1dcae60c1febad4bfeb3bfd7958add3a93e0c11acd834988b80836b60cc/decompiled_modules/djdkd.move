module 0x7018f1dcae60c1febad4bfeb3bfd7958add3a93e0c11acd834988b80836b60cc::djdkd {
    struct DJDKD has drop {
        dummy_field: bool,
    }

    fun init(arg0: DJDKD, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DJDKD>(arg0, 9, b"DJDKD", b"Auwjwnw", b"Djdkdmgl", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/9110de5e-eb6b-4fa2-a674-753bb45be9ba.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DJDKD>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<DJDKD>>(v1);
    }

    // decompiled from Move bytecode v6
}

