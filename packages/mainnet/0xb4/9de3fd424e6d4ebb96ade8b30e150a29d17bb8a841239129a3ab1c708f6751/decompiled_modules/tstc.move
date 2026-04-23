module 0xb49de3fd424e6d4ebb96ade8b30e150a29d17bb8a841239129a3ab1c708f6751::tstc {
    struct TSTC has drop {
        dummy_field: bool,
    }

    fun init(arg0: TSTC, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TSTC>(arg0, 6, b"TSTC", b"TSTC", b"Launched on Odyssey", 0x1::option::none<0x2::url::Url>(), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TSTC>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<TSTC>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

