module 0x1973dba33be1c8aad5ad7e45cb09b2f77b2c8bf7ad5ecb190e238fedcb33bd5d::anpe {
    struct ANPE has drop {
        dummy_field: bool,
    }

    fun init(arg0: ANPE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ANPE>(arg0, 6, b"ANPE", b"Ant pepe", b"First ant with pepe head on sui", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1730953169256.jpeg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<ANPE>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ANPE>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

