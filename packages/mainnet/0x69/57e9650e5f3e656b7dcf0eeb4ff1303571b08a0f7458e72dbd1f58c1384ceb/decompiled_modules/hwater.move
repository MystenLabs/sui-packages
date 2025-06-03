module 0x6957e9650e5f3e656b7dcf0eeb4ff1303571b08a0f7458e72dbd1f58c1384ceb::hwater {
    struct HWATER has drop {
        dummy_field: bool,
    }

    fun init(arg0: HWATER, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<HWATER>(arg0, 6, b"HWATER", b"Holy Water", b"2025 Will be Holy year", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafybeidphofgven4zlcr6f6enjnfn2azsnrk4idhf7lj6tr3p6mgtd3zqy")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<HWATER>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<HWATER>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

