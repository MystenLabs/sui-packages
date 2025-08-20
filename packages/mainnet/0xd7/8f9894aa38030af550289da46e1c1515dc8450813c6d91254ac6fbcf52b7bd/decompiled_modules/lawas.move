module 0xd78f9894aa38030af550289da46e1c1515dc8450813c6d91254ac6fbcf52b7bd::lawas {
    struct LAWAS has drop {
        dummy_field: bool,
    }

    fun init(arg0: LAWAS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<LAWAS>(arg0, 6, b"LAWAS", b"LAWAS", b"", 0x1::option::none<0x2::url::Url>(), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<LAWAS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<LAWAS>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

