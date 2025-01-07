module 0xf754e1391ca512e714d7ad4b7d26d73299dc1d9defcb91a1c952d75fed5bfd63::suirub {
    struct SUIRUB has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIRUB, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIRUB>(arg0, 6, b"SUIRUB", b"Suirub The Hedgehog", b"Suirub is a community-managed project on #SUI, Elon's pet hedgehog and mascot of Tesla", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1731516093158.png")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SUIRUB>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIRUB>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

