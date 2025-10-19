module 0x1cfd2c87d0d94ca7852a11a173deae75aeb2d044604032b3a70a37027beb3ae::hytz {
    struct HYTZ has drop {
        dummy_field: bool,
    }

    fun init(arg0: HYTZ, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<HYTZ>(arg0, 6, b"HyTZ", b"gffd", b"hjgcgdhjg", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreihftfseqviu6esdhjdyrczik4q27slw7gjqamuq4qqmfbcyrkiqha")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<HYTZ>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<HYTZ>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

