module 0x14e9fe23c1a658f0ce8d5e20e1e7e283f83819a24302df2e7bdb47d7c3ef504c::pt {
    struct PT has drop {
        dummy_field: bool,
    }

    fun init(arg0: PT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PT>(arg0, 9, b"Nemo-sSUI-Pt-1746589260000", b"Nemo sSUI PT 1746589260000", b"Nemo sSUI PT 1746589260000", 0x1::option::none<0x2::url::Url>(), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<PT>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PT>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

