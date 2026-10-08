module 0x5a47e692ca1fa94e31cdf5582bb06bdc5e3323ecb0189c1bac38b1f6f04d9476::xslushx {
    struct XSLUSHX has drop {
        dummy_field: bool,
    }

    fun init(arg0: XSLUSHX, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<XSLUSHX>(arg0, 6, b"XSLUSHX", b"XSLUSHX", b"v1.0 XSLUSHX COIN/TOKEN FOR ALL SUI DIGITAL WALLETS INCLUDING SLUSH! COLLECT AND SHARE WITH TEXT TO PAY AND EASY DIRECT SHARING TO ANY SLUSH WALLET. WE/I ARE/AM NOT LIABLE FOR ANY LOST FUNDS OR MALICIOUS ACTIVITY. COIN/TOKEN PRICES GO UP AND DOWN. COINS/TOKENS ARE MADE IN U.S.A. WITH STRICT QUALITY CONTROL.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreieqdctjg24k473kapmmz2a5ugxnhna3aqhn4lidd7y2du3lm4wzei")), arg1);
        let v2 = v0;
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<XSLUSHX>>(v1);
        0x2::transfer::public_transfer<0x2::coin::Coin<XSLUSHX>>(0x2::coin::mint<XSLUSHX>(&mut v2, 10000000000000000, arg1), 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<XSLUSHX>>(v2, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v7
}

