module 0xd70d1bd5894f6aa4fb0b47ae3bd4dc3b1cdaf91ad687ce296f05b4d9d8df1a7e::SIU {
    struct SIU has drop {
        dummy_field: bool,
    }

    fun init(arg0: SIU, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SIU>(arg0, 6, b"SIUUUUUU", b"SIU", x"4265636175736520747970696e6720e2809c5349555555e2809d20696e20616c6c20636170732072656c6561736573207365726f746f6e696e2e", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"ICoN_URL_STRING_PLACEHOLDER")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SIU>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SIU>>(v1);
    }

    // decompiled from Move bytecode v6
}

