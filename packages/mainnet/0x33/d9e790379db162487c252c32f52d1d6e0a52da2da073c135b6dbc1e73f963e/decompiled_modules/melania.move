module 0x33d9e790379db162487c252c32f52d1d6e0a52da2da073c135b6dbc1e73f963e::melania {
    struct MELANIA has drop {
        dummy_field: bool,
    }

    fun init(arg0: MELANIA, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let (v1, v2) = 0x2::coin::create_currency<MELANIA>(arg0, 6, b"MELANIA", b"Official Melania Meme by SuiAI", b"Melania memes are digital collectibles intended to function as an expression of support for and engagement with the values embodied by the symbol MELANIA. and the associated artwork, and are not intended to be, or to be the subject of, an investment opportunity, investment contract, or security of any type. https://melaniameme.com/ is not political and has nothing to do with any political campaign or any political office or governmental agency.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.suiai.fun/uploads/images_6_ddf8763a7a.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<MELANIA>>(v2, v0);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MELANIA>>(v1, v0);
    }

    // decompiled from Move bytecode v6
}

