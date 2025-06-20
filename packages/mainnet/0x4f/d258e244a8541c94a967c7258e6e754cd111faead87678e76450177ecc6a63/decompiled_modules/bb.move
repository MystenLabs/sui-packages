module 0x4fd258e244a8541c94a967c7258e6e754cd111faead87678e76450177ecc6a63::bb {
    struct BB has drop {
        dummy_field: bool,
    }

    fun init(arg0: BB, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BB>(arg0, 6, b"BB", b"fadsfadsf", b"fadsfadsfdas", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreictyhzshznstmsgx6freun5fl7jo7vaelzs4qwxdyqq5vsntkzyda")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BB>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<BB>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

