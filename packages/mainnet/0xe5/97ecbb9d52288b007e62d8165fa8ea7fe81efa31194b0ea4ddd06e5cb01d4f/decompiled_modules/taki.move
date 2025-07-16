module 0xe597ecbb9d52288b007e62d8165fa8ea7fe81efa31194b0ea4ddd06e5cb01d4f::taki {
    struct TAKI has drop {
        dummy_field: bool,
    }

    fun init(arg0: TAKI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TAKI>(arg0, 6, b"TAKI", b"TAKI GROK COMPANION", b"Taki grok male companion", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreic5b3no6gqfwz6us4jyllvrvfpvgxihzsq5dcrlyrth7ewu2imvvq")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TAKI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<TAKI>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

