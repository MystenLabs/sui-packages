module 0x1fab45803040b002872a25ae283ed88a902943d9f2298b2b906d8d0a07a52989::odkn {
    struct ODKN has drop {
        dummy_field: bool,
    }

    fun init(arg0: ODKN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ODKN>(arg0, 6, b"Odkn", b"Doosn", b"Dinddn", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafybeihed53plvjurvpb6qqzxa22brpzcgyfbr3l6k5zxshrvdrepseloi")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ODKN>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<ODKN>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

