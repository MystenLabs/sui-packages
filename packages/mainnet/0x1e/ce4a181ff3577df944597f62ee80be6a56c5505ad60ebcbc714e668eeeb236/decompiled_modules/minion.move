module 0x1ece4a181ff3577df944597f62ee80be6a56c5505ad60ebcbc714e668eeeb236::minion {
    struct MINION has drop {
        dummy_field: bool,
    }

    fun init(arg0: MINION, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MINION>(arg0, 6, b"Minion", b"SUIMINION", b"Meme of Hope", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreiatqjl6znicwvfhpjhd3z4shb3ioe5zj5d7z5ze5ryyqgrfhgde4y")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MINION>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<MINION>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

