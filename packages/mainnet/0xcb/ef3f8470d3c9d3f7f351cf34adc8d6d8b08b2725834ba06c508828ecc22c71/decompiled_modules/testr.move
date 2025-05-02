module 0xcbef3f8470d3c9d3f7f351cf34adc8d6d8b08b2725834ba06c508828ecc22c71::testr {
    struct TESTR has drop {
        dummy_field: bool,
    }

    fun init(arg0: TESTR, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TESTR>(arg0, 6, b"TESTR", b"Testteres", b"testasd asd a sd asd asdasd as asd", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1746218397838.png")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<TESTR>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TESTR>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

