module 0xe0b0fc147d61c6af69b3a8ca786fdfcfd119c0503ee13b70afd26fc99a479448::aqua {
    struct AQUA has drop {
        dummy_field: bool,
    }

    fun init(arg0: AQUA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<AQUA>(arg0, 6, b"AQUA", b"AQUAonSUI", b"Always wet. Always upset.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreicd6z457t4dkmmizmldth6knnegpbvuwkcgn6ynbcxhfz33mnzkbi")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<AQUA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<AQUA>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

