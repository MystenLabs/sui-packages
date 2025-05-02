module 0x36ac1f318aab86f27078a1723700daf71e20b73fcd1a13c96866618e0ae525bf::poor {
    struct POOR has drop {
        dummy_field: bool,
    }

    fun init(arg0: POOR, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<POOR>(arg0, 6, b"Poor", b"Poorlax", b"Still holding  still hoping still poor", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreihymparkvpaithuqol35l4kykidyakm5g76cpqv7lobb7phsg2tlu")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<POOR>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<POOR>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

