module 0xb91254614f140ce93c7c0e16607364a39c6d2bcdb84534333c7960b960fe4019::lawas {
    struct LAWAS has drop {
        dummy_field: bool,
    }

    fun init(arg0: LAWAS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<LAWAS>(arg0, 9, b"LAWAS", b"LAWAS", b"", 0x1::option::none<0x2::url::Url>(), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<LAWAS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<LAWAS>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

