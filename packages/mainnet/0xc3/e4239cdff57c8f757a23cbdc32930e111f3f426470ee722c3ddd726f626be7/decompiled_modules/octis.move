module 0xc3e4239cdff57c8f757a23cbdc32930e111f3f426470ee722c3ddd726f626be7::octis {
    struct OCTIS has drop {
        dummy_field: bool,
    }

    fun init(arg0: OCTIS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<OCTIS>(arg0, 6, b"Octis", b"Octis On Sui", b"Feel free to share memes, ideas and participate in group activities! Let's make $OCTIS fly high!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreiftlx7odkjtmm7oq757gzl2d6qfuwzdjdcp7afx5ixuvmwh3i3jzi")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<OCTIS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<OCTIS>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

