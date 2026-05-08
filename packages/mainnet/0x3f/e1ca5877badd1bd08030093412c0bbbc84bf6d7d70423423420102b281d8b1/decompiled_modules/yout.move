module 0x3fe1ca5877badd1bd08030093412c0bbbc84bf6d7d70423423420102b281d8b1::yout {
    struct YOUT has drop {
        dummy_field: bool,
    }

    fun init(arg0: YOUT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<YOUT>(arg0, 6, b"YOUT", b"youtube", b"adeniyi youtube channel", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreicfasvdcwuz3ahuf576viauxuhhni7y5mknwj2dm5f5vb7iamf7vy")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<YOUT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<YOUT>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

