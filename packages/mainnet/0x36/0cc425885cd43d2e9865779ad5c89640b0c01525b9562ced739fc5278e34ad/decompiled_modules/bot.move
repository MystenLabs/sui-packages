module 0x360cc425885cd43d2e9865779ad5c89640b0c01525b9562ced739fc5278e34ad::bot {
    struct BOT has drop {
        dummy_field: bool,
    }

    fun init(arg0: BOT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BOT>(arg0, 6, b"BOT", b"BOTS ", b"In a world full of degens and market hustlers, Bots Memecoin is here to bring the spirit of bot trading to the next level. We know the game is rigged, so why not lean into it? BOT AI AGENT SOON ON TWITTER.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1730993384003.webp")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<BOT>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BOT>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

