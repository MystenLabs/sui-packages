module 0xe74e64d86abee01ef02281b8c4b6454e7b35adf258fd788ceb6af8f5fb8b15f3::spx {
    struct SPX has drop {
        dummy_field: bool,
    }

    fun init(arg0: SPX, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SPX>(arg0, 6, b"SPX", b"SPX6900", b"SPX6900 (SPX) is a cryptocurrency token operating on multiple blockchains, including Ethereum, Base, and Solana. It is primarily designed as a meme token with a satirical twist on traditional financial systems, particularly inspired by the S&P 500 s.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1735159900826.png")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SPX>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SPX>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

