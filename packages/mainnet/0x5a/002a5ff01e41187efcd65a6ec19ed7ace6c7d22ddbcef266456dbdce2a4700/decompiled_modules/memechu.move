module 0x5a002a5ff01e41187efcd65a6ec19ed7ace6c7d22ddbcef266456dbdce2a4700::memechu {
    struct MEMECHU has drop {
        dummy_field: bool,
    }

    fun init(arg0: MEMECHU, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MEMECHU>(arg0, 6, b"MEMECHU", b"MEME PIKACHU", b"we are here to electrify the chain. No promises, no utility, just raw meme energy buzzing through the SUI universe", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreifwk5jexrq66arwrlonem7srnvobfjh542t6xlokdpe7hbqlx7624")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MEMECHU>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<MEMECHU>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

