module 0xdc0a777ee78eba921dcf32c2861f8feaba45995afb873c3a9d4fe9f1cbe546ef::asdfsdf {
    struct ASDFSDF has drop {
        dummy_field: bool,
    }

    fun init(arg0: ASDFSDF, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ASDFSDF>(arg0, 6, b"ASDFSDF", b"ASDFSDF", b"Launched on Odyssey", 0x1::option::none<0x2::url::Url>(), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ASDFSDF>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<ASDFSDF>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

