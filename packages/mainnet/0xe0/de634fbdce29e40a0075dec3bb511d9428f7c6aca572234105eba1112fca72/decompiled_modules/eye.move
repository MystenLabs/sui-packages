module 0xe0de634fbdce29e40a0075dec3bb511d9428f7c6aca572234105eba1112fca72::eye {
    struct EYE has drop {
        dummy_field: bool,
    }

    fun init(arg0: EYE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<EYE>(arg0, 6, b"EYE", b"SUILLUMINATI", b"IYKYK. suilluminati.com", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreibe2hes7j7lu2ljfngthpidgxiyh5poyi3ebbch7j2qpnvkdmbdl4")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<EYE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<EYE>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

