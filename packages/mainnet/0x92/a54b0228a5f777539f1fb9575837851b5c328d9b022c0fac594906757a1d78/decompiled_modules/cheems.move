module 0x92a54b0228a5f777539f1fb9575837851b5c328d9b022c0fac594906757a1d78::cheems {
    struct CHEEMS has drop {
        dummy_field: bool,
    }

    fun init(arg0: CHEEMS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CHEEMS>(arg0, 6, b"CHEEMS", b"cheems", b"Kabosu's best friend, the most interesting meme coin of all time. The high transaction fees of Ethereum are unbearable for people, and we have found a new home for Cheems. Let's experience the convenience of Sui together.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/c2fdfc039245d6882a9b7214702c7a14d01b24da_a338316837.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CHEEMS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<CHEEMS>>(v1);
    }

    // decompiled from Move bytecode v6
}

