module 0x4db264047dcfebfc2cc0da1974fbc6927d9b237c6b075a023c24ec8fb56c289a::one {
    struct ONE has drop {
        dummy_field: bool,
    }

    fun init(arg0: ONE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ONE>(arg0, 6, b"ONE", b"Just Buy 1 Sui", b"Just Buy 1 SUI is not just a meme  its a full blown movement. No roadmap. No fake promises. Just pure meme energy.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafybeiavllarxwhxiwnsiad6ujxx3rjeouiwjv3hmagnjunhwbpen2ky7q")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ONE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<ONE>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

