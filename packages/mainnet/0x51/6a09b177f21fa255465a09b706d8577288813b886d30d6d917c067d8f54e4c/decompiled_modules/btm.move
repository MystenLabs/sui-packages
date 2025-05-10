module 0x516a09b177f21fa255465a09b706d8577288813b886d30d6d917c067d8f54e4c::btm {
    struct BTM has drop {
        dummy_field: bool,
    }

    fun init(arg0: BTM, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BTM>(arg0, 6, b"BTM", b"Bitmoon", b"Bitmoon is king  of meme coin belive it .", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafybeibx6x4wenjynvaatydktzido5knkpcpnsculle2cj6qg3fuxkq4um")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BTM>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<BTM>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

