module 0x56186036c9a795a93c56990745219be186b83d1fe13622498f7d04cebf78a9c2::core {
    struct CORE has drop {
        dummy_field: bool,
    }

    fun init(arg0: CORE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CORE>(arg0, 6, b"CORE", b"CORE AI", x"436f726520416920e2809320596f757220416c6c2d696e2d4f6e652041492d506f77657265642043727970746f20426f7420537569746521f09faa99", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1731673751235.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<CORE>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CORE>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

