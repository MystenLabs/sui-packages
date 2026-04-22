module 0x3197fc9b14ae9f468805e23f5aa679e78ae68e9e71c3570677f9e7a40dd39557::texmother {
    struct TEXMOTHER has drop {
        dummy_field: bool,
    }

    fun init(arg0: TEXMOTHER, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TEXMOTHER>(arg0, 6, b"TEXMOTHER", b"TEXMOTHER", b"Launched on Odyssey", 0x1::option::none<0x2::url::Url>(), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TEXMOTHER>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<TEXMOTHER>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

