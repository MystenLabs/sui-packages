module 0xa25377f1bbd904ce7ffeb192e890620d178b17d2cc83a9bb1ebac897dfa4cbec::poliwhirl {
    struct POLIWHIRL has drop {
        dummy_field: bool,
    }

    fun init(arg0: POLIWHIRL, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<POLIWHIRL>(arg0, 6, b"POLIWHIRL", b"POLIWHIRL POKEMON", b"Poliwhirl is a frog pokemon. Cute, feisty, and strong, Poliwhirl is the most meme-worthy and meme-able pokemon character.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreia2ixt2xnoixuqb6wx43iu3fdphv7dln2x52w6yw2yh6pdq3jh4qi")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<POLIWHIRL>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<POLIWHIRL>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

