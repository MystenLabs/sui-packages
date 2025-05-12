module 0x803cfca535c1eca4d7143616f8dbd09e177a2448ec70ec34d0f16ad41edabbd4::goatmeme {
    struct GOATMEME has drop {
        dummy_field: bool,
    }

    fun init(arg0: GOATMEME, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<GOATMEME>(arg0, 6, b"GOATMEME", b"A Meme of a Goat", b"We just share memes of Goats. If you love Goats, you'll love Goat memes.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafybeig7dd4qcj2gxxvwuuxb2bnlytmfy3hu256kekeg5jlzbkinoikow4")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GOATMEME>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<GOATMEME>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

