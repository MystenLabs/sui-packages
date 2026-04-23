module 0xadff966781f3ac49dbf4c5297850e7f918f0f26dc387ac49183588d94f7181c7::fuckpad {
    struct FUCKPAD has drop {
        dummy_field: bool,
    }

    fun init(arg0: FUCKPAD, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FUCKPAD>(arg0, 6, b"FUCKPAD", b"FUCKPAD", b"Launched on Odyssey", 0x1::option::none<0x2::url::Url>(), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FUCKPAD>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<FUCKPAD>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

