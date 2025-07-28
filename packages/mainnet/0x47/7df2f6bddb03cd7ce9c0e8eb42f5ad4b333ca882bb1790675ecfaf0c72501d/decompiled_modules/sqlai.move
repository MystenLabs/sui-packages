module 0x477df2f6bddb03cd7ce9c0e8eb42f5ad4b333ca882bb1790675ecfaf0c72501d::sqlai {
    struct SQLAI has drop {
        dummy_field: bool,
    }

    fun init(arg0: SQLAI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SQLAI>(arg0, 6, b"SQLAI", b"Squirrel AI", b"The future of SQL", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1753743902242.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SQLAI>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SQLAI>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

