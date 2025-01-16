module 0xa69e907cf28c1c9f036dcc5401727ce7ff8e33f0129b7f1ccac75b7b067f36d1::wai {
    struct WAI has drop {
        dummy_field: bool,
    }

    fun init(arg0: WAI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<WAI>(arg0, 9, b"WAI", b"Wallet AI", b"Introducing Wallet AI, a platform providing AI analysis for any Solana wallet with real-time insights and performance tracking.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/QmSLBXZaeTzMhjxcZZ56prGhoGLq1xRegRvvwK3WXaJLn5")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<WAI>(&mut v2, 1000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<WAI>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<WAI>>(v2, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

