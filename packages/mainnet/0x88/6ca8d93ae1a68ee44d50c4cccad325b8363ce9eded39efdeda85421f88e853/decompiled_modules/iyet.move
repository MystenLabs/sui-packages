module 0x886ca8d93ae1a68ee44d50c4cccad325b8363ce9eded39efdeda85421f88e853::iyet {
    struct IYET has drop {
        dummy_field: bool,
    }

    fun init(arg0: IYET, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<IYET>(arg0, 6, b"IYET", b"Iyet sui moon", b"Iyetbsba", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreie6y7lc4o6rvjpf6szahmocqua6wvpckw2spsa7pdwtphy4x7i5iq")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<IYET>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<IYET>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

