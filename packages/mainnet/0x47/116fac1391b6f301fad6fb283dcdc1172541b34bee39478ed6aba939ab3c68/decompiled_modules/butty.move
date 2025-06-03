module 0x47116fac1391b6f301fad6fb283dcdc1172541b34bee39478ed6aba939ab3c68::butty {
    struct BUTTY has drop {
        dummy_field: bool,
    }

    fun init(arg0: BUTTY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BUTTY>(arg0, 6, b"BUTTY", b"Butty Boop", b"Butty Boop is a hot animated cartoon from 1930.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafybeidfpjza7rdh5hx6j6esbvqdkbd6yvxtwjpzxg7lxlmni24gvxp6he")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BUTTY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<BUTTY>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

