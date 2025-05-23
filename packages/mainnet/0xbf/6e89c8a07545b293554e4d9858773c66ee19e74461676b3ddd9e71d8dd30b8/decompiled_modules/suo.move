module 0xbf6e89c8a07545b293554e4d9858773c66ee19e74461676b3ddd9e71d8dd30b8::suo {
    struct SUO has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUO>(arg0, 6, b"SUO", b"SUI STRONG WORLD", b"SUI Community lending a hand to Cetus starting with $SUO.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafybeidwdnq3h2fjk3k7oij3ns5rxxb5baurxnlh5jci3tqycdnpjluudq")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<SUO>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

