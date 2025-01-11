module 0x44e205e66c1d2cdb68a8d2be6fe6c9ac01e2ab995ff1ed27f604a6389b6794a7::nfas {
    struct NFAS has drop {
        dummy_field: bool,
    }

    fun init(arg0: NFAS, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let (v1, v2) = 0x2::coin::create_currency<NFAS>(arg0, 6, b"NFAS", b"Not Financial Advice  by SuiAI", b"Not a financial advice", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.suiai.fun/uploads/IMG_3075_1548625ada.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<NFAS>>(v2, v0);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<NFAS>>(v1, v0);
    }

    // decompiled from Move bytecode v6
}

