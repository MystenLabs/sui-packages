module 0x8f6fd4d49861d6f8c2ccfb8deeb63227be349220fef28bae2f591a9b3da5037b::alt {
    struct ALT has drop {
        dummy_field: bool,
    }

    fun init(arg0: ALT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ALT>(arg0, 6, b"ALT", b"ALT SEASON", b"Born from memes. Backed by pure degen energy. If you're still bagholding BTC... this ain't for you. SOLANA DEGEN PLAY", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafybeibnn5gaxck52p5orz2gpqpmrrvp7sbvpt4wx75iyfpthpaoq2qs34")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ALT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<ALT>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

