module 0x86a124b76d7bc4fea8188e518d8facd063b941ef09d9e89c82df118d2bf5e898::krill {
    struct KRILL has drop {
        dummy_field: bool,
    }

    fun init(arg0: KRILL, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<KRILL>(arg0, 6, b"KRILL", b"The Krill", b"Just a crab with Wi-Fi and opinions.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafybeiatrft63n53cz573jtwsaffcd5npybmrpoxm3ahxixmwveusoyvji")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<KRILL>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<KRILL>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

