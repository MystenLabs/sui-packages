module 0x4b0b96db889c720110fb7ba813c291f4b12d7c3c6daab834d251dc6a7fb9c0e::soble {
    struct SOBLE has drop {
        dummy_field: bool,
    }

    fun init(arg0: SOBLE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SOBLE>(arg0, 6, b"Soble", b"Sobble Sui", b"Sobble is a Water type starter Pokemon introduced in Generation 8", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreidh3u3766uozhxpj5rjsjnzbbic53lm7x76adhtruvts2jnhgvfku")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SOBLE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<SOBLE>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

