module 0xb87d92befd9d75b5c89c4f8ae203e56b9c1f6e5640be7dd15917022ab6edd7d9::legend {
    struct LEGEND has drop {
        dummy_field: bool,
    }

    fun init(arg0: LEGEND, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<LEGEND>(arg0, 6, b"LEGEND", b"Trump Legend", x"5472756d70200a0a49732077726974696e672061206c6567656e6420666f722074686520776f726c64", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1730948274175.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<LEGEND>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<LEGEND>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

