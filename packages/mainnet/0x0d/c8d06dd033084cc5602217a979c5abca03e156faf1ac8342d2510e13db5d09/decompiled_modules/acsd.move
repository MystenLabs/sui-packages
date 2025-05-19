module 0xdc8d06dd033084cc5602217a979c5abca03e156faf1ac8342d2510e13db5d09::acsd {
    struct ACSD has drop {
        dummy_field: bool,
    }

    fun init(arg0: ACSD, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ACSD>(arg0, 6, b"Acsd", b"test", b"sdsds", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreiausiabi6ej4ftvikttwijpjk4p5uyikm2dinhnh3dbemhgcjxuim")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ACSD>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<ACSD>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

