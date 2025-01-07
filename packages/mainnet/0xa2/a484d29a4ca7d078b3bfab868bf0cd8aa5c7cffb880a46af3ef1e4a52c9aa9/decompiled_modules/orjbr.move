module 0xa2a484d29a4ca7d078b3bfab868bf0cd8aa5c7cffb880a46af3ef1e4a52c9aa9::orjbr {
    struct ORJBR has drop {
        dummy_field: bool,
    }

    fun init(arg0: ORJBR, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ORJBR>(arg0, 9, b"ORJBR", b"hdnd", b"jdbe", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/e85c08a1-aa97-45a4-a7e3-775ac283f550.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ORJBR>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<ORJBR>>(v1);
    }

    // decompiled from Move bytecode v6
}

