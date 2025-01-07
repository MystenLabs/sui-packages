module 0xc1b3fb5e893d14acabba5c19ebb7150f3197a39de78e3d904e73889ba850fd42::waz {
    struct WAZ has drop {
        dummy_field: bool,
    }

    fun init(arg0: WAZ, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<WAZ>(arg0, 6, b"WAZ", b"WAZZA", b"Wazzaa Wazzaa!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1730953324272.52")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<WAZ>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<WAZ>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

