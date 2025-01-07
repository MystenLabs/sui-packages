module 0x62a43a4012a3a353dea89622ef263260314ae168041f98b61120fe37cdaeb7eb::ghost {
    struct GHOST has drop {
        dummy_field: bool,
    }

    fun init(arg0: GHOST, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<GHOST>(arg0, 6, b"GHOST", b"GHOST by Matt Furie", b"Ghost, by Matt Furie, is a meme coin powered by the bullish energy of the crypto market.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/01_1_09555ba751_489c0b5f58.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GHOST>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<GHOST>>(v1);
    }

    // decompiled from Move bytecode v6
}

