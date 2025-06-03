module 0x6cc47564d1d8b0d3cc833d2ad478690d546093de9321c2bd5833bded97add732::spam {
    struct SPAM has drop {
        dummy_field: bool,
    }

    fun init(arg0: SPAM, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SPAM>(arg0, 6, b"SPAM", b"Spam sui", b"Spamnow", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreiecdh3yvazi3rxrovr2xk5ksqibuf5kmm36iawx7alo4o5jzebc2m")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SPAM>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<SPAM>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

