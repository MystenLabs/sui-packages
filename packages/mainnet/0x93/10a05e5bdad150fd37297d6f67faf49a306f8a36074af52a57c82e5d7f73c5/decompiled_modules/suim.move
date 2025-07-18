module 0x9310a05e5bdad150fd37297d6f67faf49a306f8a36074af52a57c82e5d7f73c5::suim {
    struct SUIM has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIM, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let (v1, v2) = 0x2::coin::create_currency<SUIM>(arg0, 6, b"SUIM", b"Sui-meme", b" Meet Suimeme, powered by Meme Master Sui - a goofy crypto hero with a blockchain cape, battling gas fees with memes! Tip creators, stake for rewards, and vote with SUIM on the Sui network. Let's laugh to the moon! [AI Meme - By SuiAI]", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.suiai.fun/meme/65q5vp.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<SUIM>>(v2, v0);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIM>>(v1, v0);
    }

    // decompiled from Move bytecode v6
}

