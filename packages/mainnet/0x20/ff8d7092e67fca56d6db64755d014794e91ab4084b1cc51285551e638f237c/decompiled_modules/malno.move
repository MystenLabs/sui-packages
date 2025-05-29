module 0x20ff8d7092e67fca56d6db64755d014794e91ab4084b1cc51285551e638f237c::malno {
    struct MALNO has drop {
        dummy_field: bool,
    }

    fun init(arg0: MALNO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MALNO>(arg0, 6, b"MALNO", b"MALNO the DOG", b"MALNO is the internet's latest doggo obsession and a certified bop in the digital sticker game! Straight outta the mind of Julia Farkas, this quirky, lowkey iconic canine has gone absolutely viral across Europe, it's living rent free in everyone's heads, no cap.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafybeigesuphouswnikgi65ag2p5htt34oumrqzkqlwnzsjzp67bod7ngi")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MALNO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<MALNO>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

