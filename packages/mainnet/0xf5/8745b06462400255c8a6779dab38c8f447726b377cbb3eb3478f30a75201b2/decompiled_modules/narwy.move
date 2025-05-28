module 0xf58745b06462400255c8a6779dab38c8f447726b377cbb3eb3478f30a75201b2::narwy {
    struct NARWY has drop {
        dummy_field: bool,
    }

    fun init(arg0: NARWY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<NARWY>(arg0, 6, b"NARWY", b"Narwy on Sui", b"$NARWY - the meme-powered narwhal cruising the Sui seas.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafybeiaf362mh2ac2dz2i3k3cfva6m6n6l3t2u27ar3pfgqhh4ioauqzde")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<NARWY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<NARWY>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

