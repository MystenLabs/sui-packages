module 0xe5ae24993da28d7b157dace2cf158096855976c3e6c98c96d5878bc07ff54436::per {
    struct PER has drop {
        dummy_field: bool,
    }

    fun init(arg0: PER, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PER>(arg0, 6, b"PER", b"perfect", b"PEREEEER", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreidusxwrdhly64qtrw3uxj3gf2pc5lrdevgigcaa72dew2vec27cva")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PER>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<PER>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

