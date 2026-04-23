module 0x479215b54e3f11f7c493a41feac3dc1b0b2e52aa7d20f71c46423c4b2d098620::sadfd {
    struct SADFD has drop {
        dummy_field: bool,
    }

    fun init(arg0: SADFD, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SADFD>(arg0, 6, b"SADFD", b"SADFD", b"Launched on Odyssey", 0x1::option::none<0x2::url::Url>(), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SADFD>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<SADFD>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

