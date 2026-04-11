module 0xeca70f89a0850b7753d5f002042ddf6e9f70451bc116b5c0cb4a5622305ccf3b::spartan {
    struct SPARTAN has drop {
        dummy_field: bool,
    }

    fun init(arg0: SPARTAN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SPARTAN>(arg0, 6, b"SPARTAN", b"SPARTAN", b"Launched on Odyssey", 0x1::option::none<0x2::url::Url>(), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SPARTAN>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<SPARTAN>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

