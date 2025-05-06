module 0x5d62e418eb1085656397dc7c7a75bfa21804005c95bbf7d398ee2cff0d6b0269::gork {
    struct GORK has drop {
        dummy_field: bool,
    }

    fun init(arg0: GORK, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<GORK>(arg0, 6, b"GORK", b"New XAI gork", b"just gorkin it", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreie7zx7oljtbvfymn3s7gss4tag7cspl6z46gqk3sj2gxfptqlblz4")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GORK>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<GORK>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

