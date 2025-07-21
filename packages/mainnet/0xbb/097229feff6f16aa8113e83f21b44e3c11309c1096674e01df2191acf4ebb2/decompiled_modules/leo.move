module 0xbb097229feff6f16aa8113e83f21b44e3c11309c1096674e01df2191acf4ebb2::leo {
    struct LEO has drop {
        dummy_field: bool,
    }

    fun init(arg0: LEO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<LEO>(arg0, 6, b"LEO", b"SEALEO", b"A tale of courage of $LEO The Seal", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreie4j4wbdwqwnnc2m7oihn3c4yqyvuvc5ln27jloiwuoil7y5swkkq")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<LEO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<LEO>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

