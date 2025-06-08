module 0xe5d2bc1f701055c9b8b2324d90a0fb96f0fa163594697259838fd39417305f69::jpak {
    struct JPAK has drop {
        dummy_field: bool,
    }

    fun init(arg0: JPAK, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<JPAK>(arg0, 6, b"JPAK", b"Ape Jetpack", b"Launched with no brakes. Fueled by copium and pure monkey ambition", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreidju4bhlqvae6od4th5ka24bvpvltpw5vciturpt6n6mxgl67lq3i")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<JPAK>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<JPAK>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

