module 0x1edeb091d7a948420f573349d94dcb07c71272a974c6b1bd52b745bde0fd4981::brb {
    struct BRB has drop {
        dummy_field: bool,
    }

    fun init(arg0: BRB, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BRB>(arg0, 6, b"BRB", b"BadRabbit", x"4c696d697465642d65646974696f6e20542d73686972747320666561747572696e67206578636c757369766520426164526162626974204e465420617274776f726b0a5072656d69756d206d6174657269616c7320616e64207374616e646f75742064657369676e73206372656174656420666f722074686520576562332067656e65726174696f6e", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreiem5n6s53yr2z5viqydre2yydhsrqijammr4wf5632h3i32ydreyi")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BRB>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<BRB>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

