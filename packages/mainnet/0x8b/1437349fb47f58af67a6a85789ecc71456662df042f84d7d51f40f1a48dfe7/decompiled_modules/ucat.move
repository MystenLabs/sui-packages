module 0x8b1437349fb47f58af67a6a85789ecc71456662df042f84d7d51f40f1a48dfe7::ucat {
    struct UCAT has drop {
        dummy_field: bool,
    }

    fun init(arg0: UCAT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<UCAT>(arg0, 6, b"UCAT", b"ULTRACAT", b"Ultracat is an intergalactic meme hero born from the fusion of Ultraman's power and a cat's chaotic charm.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafybeigxjf4vx3o7ejpy6rf5utgi7jrunmuuf2v6ws4hx2v7mdpov373oe")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<UCAT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<UCAT>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

