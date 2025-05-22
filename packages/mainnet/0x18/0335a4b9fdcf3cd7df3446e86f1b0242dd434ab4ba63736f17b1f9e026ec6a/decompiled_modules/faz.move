module 0x180335a4b9fdcf3cd7df3446e86f1b0242dd434ab4ba63736f17b1f9e026ec6a::faz {
    struct FAZ has drop {
        dummy_field: bool,
    }

    fun init(arg0: FAZ, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FAZ>(arg0, 6, b"FAZ", b"Faz on Sui", b"A chill face in the middle of trenches while everyone is having fun, thats just Faz.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafybeicfi37ltmycbnq7lpqnzyj22ndqdgwbvvjpyvbv6xcq3upca4zs7a")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FAZ>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<FAZ>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

