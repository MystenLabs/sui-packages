module 0xb956a9c392baf12b64671fad827e975de6e5c07a0b9dd9f2d59382d01a0ebc5::wail {
    struct WAIL has drop {
        dummy_field: bool,
    }

    fun init(arg0: WAIL, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<WAIL>(arg0, 6, b"WAIL", b"WAILORD", x"5761696c6f7264206973206f6e65206f6620746865206c61726765737420506f6bc3a96d6f6e20746f2068617665206265656e20646973636f76657265642e0a68747470733a2f2f782e636f6d2f7761696c6f72645f6d6f6e73746572", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafybeieiorpshoc5zoquaqybnhjlqf45ljf2gpq2qnajdblp35m55w7cey")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<WAIL>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<WAIL>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

