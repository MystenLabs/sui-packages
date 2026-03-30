module 0x517fa7b4b2ef37c5f9fadb23ef02bee83a3e0c65e6d352c99c72274cc0372e4d::opm {
    struct OPM has drop {
        dummy_field: bool,
    }

    fun init(arg0: OPM, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<OPM>(arg0, 6, b"OPM", b"OPM", b"Launched on Odyssey", 0x1::option::none<0x2::url::Url>(), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<OPM>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<OPM>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

