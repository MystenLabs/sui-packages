module 0x35235e1c6921432e528ff948f43b1babd58fe0372fb702493523fed88380b26c::BitcoinDoge {
    struct BITCOINDOGE has drop {
        dummy_field: bool,
    }

    fun init(arg0: BITCOINDOGE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BITCOINDOGE>(arg0, 6, b"BitcoinDoge", b"BTCDoge", b"BitcoinDoge is a meme token that is a tribute to the original BitcoinDoge.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://gateway.pinata.cloud/ipfs/QmSJCP2WXdMGVQDqzASwSufX1vtHbrttshdVMMqnpTg4DK")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BITCOINDOGE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BITCOINDOGE>>(v1);
    }

    // decompiled from Move bytecode v6
}

