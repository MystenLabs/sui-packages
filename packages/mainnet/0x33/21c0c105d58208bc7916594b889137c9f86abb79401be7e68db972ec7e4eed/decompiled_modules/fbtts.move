module 0x3321c0c105d58208bc7916594b889137c9f86abb79401be7e68db972ec7e4eed::fbtts {
    struct FBTTS has drop {
        dummy_field: bool,
    }

    fun init(arg0: FBTTS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FBTTS>(arg0, 6, b"FBTTS", b"FBTTS", b"Launched on Odyssey", 0x1::option::none<0x2::url::Url>(), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FBTTS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<FBTTS>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

