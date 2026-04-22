module 0x937769b1d384cb98a96f4e6c88e25c3d4d79f6314fc51698820c7906d248f184::guytexxas {
    struct GUYTEXXAS has drop {
        dummy_field: bool,
    }

    fun init(arg0: GUYTEXXAS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<GUYTEXXAS>(arg0, 6, b"GUYTEXXAS", b"GUYTEXXAS", b"Launched on Odyssey", 0x1::option::none<0x2::url::Url>(), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GUYTEXXAS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<GUYTEXXAS>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

