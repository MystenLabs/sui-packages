module 0xc6f8f25f9fef2e9c6f278dfc0c8ee089a2b2cd963d184fdf54646a8418fad459::toto {
    struct TOTO has drop {
        dummy_field: bool,
    }

    fun init(arg0: TOTO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TOTO>(arg0, 6, b"TOTO", b"Totodile", b"It is small but rough and tough. It won't hesitate to take a bite out of anything that moves.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafybeibke6que4xhyao2ns2wa7tcnou34ekfm74qqduoeicgxjmkwuohhq")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TOTO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<TOTO>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

