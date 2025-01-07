module 0xeb09c72b7e7afe04bcf631009895581e1f2585376d9043ddc3289a06e6698840::fake_coin {
    struct FAKE_COIN has drop {
        dummy_field: bool,
    }

    fun init(arg0: FAKE_COIN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FAKE_COIN>(arg0, 6, b"Fake_coin", b"fake coin", b"this is a fake coin,dont buy", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1732623917919.41")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<FAKE_COIN>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FAKE_COIN>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

