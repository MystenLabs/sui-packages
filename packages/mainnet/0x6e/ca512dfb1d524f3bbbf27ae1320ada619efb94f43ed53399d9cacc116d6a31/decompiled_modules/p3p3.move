module 0x6eca512dfb1d524f3bbbf27ae1320ada619efb94f43ed53399d9cacc116d6a31::p3p3 {
    struct P3P3 has drop {
        dummy_field: bool,
    }

    fun init(arg0: P3P3, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<P3P3>(arg0, 6, b"P3P3", b"PEPE TOKEN", b"NOTHING!!!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreihmkn66aqfhhw4twnzvbmpg5qi7tvi7my6beho4t7wwvwnz7ab6vq")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<P3P3>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<P3P3>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

