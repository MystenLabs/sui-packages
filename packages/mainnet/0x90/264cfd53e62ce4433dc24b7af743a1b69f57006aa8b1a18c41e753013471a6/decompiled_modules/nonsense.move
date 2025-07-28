module 0x90264cfd53e62ce4433dc24b7af743a1b69f57006aa8b1a18c41e753013471a6::nonsense {
    struct NONSENSE has drop {
        dummy_field: bool,
    }

    fun init(arg0: NONSENSE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<NONSENSE>(arg0, 6, b"NONSENSE", b"Nonsense Sui", b"Play to Earn", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafybeigem2lhwzclfqntytximn4dn7gsp2x5bkghu5a74dwrrrgvvyosfy")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<NONSENSE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<NONSENSE>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

