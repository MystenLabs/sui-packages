module 0x2a824a4dcea93e98372d9c10525c2fd84ee9ab6b5545127a5a6147fae8e914b8::arborist {
    struct ARBORIST has drop {
        dummy_field: bool,
    }

    fun init(arg0: ARBORIST, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ARBORIST>(arg0, 6, b"Arborist", b"Arborist Liquidity", b"Crypto liquidity", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreigksq5kqxxk2dbpa7g4db5v5my5ezlr56qqq3msk6gcqtxnyca56q")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ARBORIST>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<ARBORIST>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

