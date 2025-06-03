module 0x1e687909e4e930c568d358ec4c6511ee8e08156f3b1bc89276693111e5f6c5be::norm {
    struct NORM has drop {
        dummy_field: bool,
    }

    fun init(arg0: NORM, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<NORM>(arg0, 6, b"Norm", b"Normie", b"Hi, I'm Normie. Nothing special, just a regular character", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreihqwcvlc7rnblvbjqdi3k3iklo2tzi7qbkbr3vqnv6s4mgr2xmjyq")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<NORM>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<NORM>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

