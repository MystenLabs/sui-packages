module 0x304c7ee2c77f19d3988e6ec6571ba6f318accdbb903446bafe6502ac6b20d342::suivoo {
    struct SUIVOO has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIVOO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIVOO>(arg0, 6, b"SUIVOO", b"Suivoo pokemon", b"Suivoo is @suiveememe 's girlfriend.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreib5yuifzu3hw4g5wqixmfrq43h6hzmp3yv2nykzami3mbkctrjihi")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIVOO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<SUIVOO>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

