module 0xd7bfbcf18eab90e370486681f0d9fb9a7db98b37edb4d9ac6ba35425df94ab51::s6900reborn {
    struct S6900REBORN has drop {
        dummy_field: bool,
    }

    fun init(arg0: S6900REBORN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<S6900REBORN>(arg0, 6, b"S6900REBORN", b"SUI6900", x"53554936393030205245424f524e0a0a0a57656c636f6d6520746f207468652057696c642057657374206f6620746865204368696e6573652053746f636b204d61726b6574212047657420596f75722053554936393030205245424f524e204e6f7721", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafybeihz667siv5mnyiokjqnqf7judjur2yhmdq7bkemil42mlmqr262ei")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<S6900REBORN>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<S6900REBORN>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

