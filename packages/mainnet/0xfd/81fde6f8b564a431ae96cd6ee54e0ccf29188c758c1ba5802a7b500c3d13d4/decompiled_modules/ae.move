module 0xfd81fde6f8b564a431ae96cd6ee54e0ccf29188c758c1ba5802a7b500c3d13d4::ae {
    struct AE has drop {
        dummy_field: bool,
    }

    fun init(arg0: AE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<AE>(arg0, 6, b"AE", b"Albert Einstein", b"physics genius", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreieztnj42izn73uifiipnajw4pyprcgeaqkqut44oh2pgn4evsvlq4")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<AE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<AE>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

