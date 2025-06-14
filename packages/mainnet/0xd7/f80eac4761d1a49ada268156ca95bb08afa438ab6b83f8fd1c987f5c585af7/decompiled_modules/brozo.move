module 0xd7f80eac4761d1a49ada268156ca95bb08afa438ab6b83f8fd1c987f5c585af7::brozo {
    struct BROZO has drop {
        dummy_field: bool,
    }

    fun init(arg0: BROZO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BROZO>(arg0, 6, b"BROZO", b"Brozo Kat", b"handsome blue cat, will be the king of the ocean", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreiargrt7n6drdqo2lzfmumlw7u5kabzqbdert42icp2mioo57if5tq")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BROZO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<BROZO>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

