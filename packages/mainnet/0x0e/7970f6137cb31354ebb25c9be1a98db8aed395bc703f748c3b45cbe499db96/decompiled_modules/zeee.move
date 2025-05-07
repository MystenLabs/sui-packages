module 0xe7970f6137cb31354ebb25c9be1a98db8aed395bc703f748c3b45cbe499db96::zeee {
    struct ZEEE has drop {
        dummy_field: bool,
    }

    fun init(arg0: ZEEE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ZEEE>(arg0, 6, b"ZEEE", b"aezaez", b"azeafz", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreihybyjfjlh74w7gxjyejdss5la5tgko74tn457msxyqekizoa5unq")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ZEEE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<ZEEE>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

