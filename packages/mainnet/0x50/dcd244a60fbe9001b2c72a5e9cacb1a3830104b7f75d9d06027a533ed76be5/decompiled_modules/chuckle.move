module 0x50dcd244a60fbe9001b2c72a5e9cacb1a3830104b7f75d9d06027a533ed76be5::chuckle {
    struct CHUCKLE has drop {
        dummy_field: bool,
    }

    fun init(arg0: CHUCKLE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CHUCKLE>(arg0, 6, b"CHUCKLE", b"Sui Chuckle", b"$CHUCKLE is a humorous meme coin aimed at enriching the crypto community with fun and laughter. Inspired by the funniest internet memes, $CHUCKLE not only promotes the joy of investing but al", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1730956145342.5929871350")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<CHUCKLE>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CHUCKLE>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

