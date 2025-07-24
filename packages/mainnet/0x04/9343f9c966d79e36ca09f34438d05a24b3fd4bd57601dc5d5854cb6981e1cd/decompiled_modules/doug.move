module 0x49343f9c966d79e36ca09f34438d05a24b3fd4bd57601dc5d5854cb6981e1cd::doug {
    struct DOUG has drop {
        dummy_field: bool,
    }

    fun init(arg0: DOUG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DOUG>(arg0, 6, b"DOUG", b"Dog The Pug", b"Meet Doug the Pug  the king of snorts, snacks, and social media stardom. DOUG isnt just a memecoin", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreiddvz4nlzguxxaityrce6nf2dfoo3ulcqi5ixgrajuexqhwuvufc4")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DOUG>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<DOUG>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

