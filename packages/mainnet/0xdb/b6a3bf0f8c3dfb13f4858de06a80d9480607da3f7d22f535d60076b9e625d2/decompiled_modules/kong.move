module 0xdbb6a3bf0f8c3dfb13f4858de06a80d9480607da3f7d22f535d60076b9e625d2::kong {
    struct KONG has drop {
        dummy_field: bool,
    }

    fun init(arg0: KONG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<KONG>(arg0, 6, b"KONG", b"KONG ON SUI", b"KONG live now", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreidnrgw3xuj6kt4z2okso4szovqxrdjjbtw6z442oxg3rb57pdinaa")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<KONG>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<KONG>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

