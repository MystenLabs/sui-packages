module 0xea2ea9c875a88e6ee0efbe611f359690d0ba1b0d61c565938e8e877a4ff88ab0::stack {
    struct STACK has drop {
        dummy_field: bool,
    }

    fun init(arg0: STACK, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<STACK>(arg0, 6, b"STACK", b"overflow", b"test sui hackathon", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/QmUgnqWAswiAYiP4xXjFXcc7esQYV4aH9jGM82rN765738")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<STACK>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<STACK>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

