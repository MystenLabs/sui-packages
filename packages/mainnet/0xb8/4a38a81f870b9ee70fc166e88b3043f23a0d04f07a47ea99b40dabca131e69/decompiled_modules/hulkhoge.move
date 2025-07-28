module 0xb84a38a81f870b9ee70fc166e88b3043f23a0d04f07a47ea99b40dabca131e69::hulkhoge {
    struct HULKHOGE has drop {
        dummy_field: bool,
    }

    fun init(arg0: HULKHOGE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<HULKHOGE>(arg0, 6, b"HULKHOGE", b"HULK HOGAN COIN", b"Whatcha gonna do, brother, when SUI and the HULK run wild on you?", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafybeigg2ub4w76m2knnmhy3orlj36usibpxhfwe3xhm65cbbvmrytb6hy")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<HULKHOGE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<HULKHOGE>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

