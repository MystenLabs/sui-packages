module 0xf4618e716ab7acadaf2d55b1b42137e25e35ea921d89692a6b57d9f4d44d0be1::stack {
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

