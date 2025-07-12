module 0xb4d04aa4e41adc760293ab45f7fe28d2ff92138fe2d4c75228992a8a75b96f76::skebob {
    struct SKEBOB has drop {
        dummy_field: bool,
    }

    fun init(arg0: SKEBOB, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SKEBOB>(arg0, 6, b"SKEBOB", x"d0a1d09ad095d091d09ed091", b"viral russian bird", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1752300087346.png")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SKEBOB>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SKEBOB>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

