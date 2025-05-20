module 0x13c2cf39639733cf8b7acc4ece64bb85cdad1a9d9e86c6dfe46be781b51ce16e::tsuka {
    struct TSUKA has drop {
        dummy_field: bool,
    }

    fun init(arg0: TSUKA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TSUKA>(arg0, 6, b"Tsuka", b"Tsuka Dragon", b"Dragon born from ocean wave", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreics4ugnczaatmtphpcxuide2omb7z3u7bu235zx2qskmj3u7upjbm")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TSUKA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<TSUKA>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

