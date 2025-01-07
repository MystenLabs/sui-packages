module 0x5a1cc1d0bcf0d1cec3487c5430db8bdfc829e9022decb0149750f2d673c2e7a5::suinder {
    struct SUINDER has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUINDER, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUINDER>(arg0, 6, b"SUINDER", b"Suinder", b"Suinder is the playful fusion of Sui blockchain and the excitement of swiping through endless possibilities! Just like a dating app for crypto, Suinder matches you with the hottest new tokens, memecoins, and opportunities in the decentralized world. Every swipe could lead to your next big findwhether it's love, luck, or a lucky trade! Get ready to match with fortune in the fun, fast-paced world of Suinder!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Sem_t_A_tulo_6f82a7aaa7.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUINDER>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUINDER>>(v1);
    }

    // decompiled from Move bytecode v6
}

