module 0x6e32a4d55d10d5767df754c01a06b0e720c109d4cafef365eabcd5b2989dbbd6::phyt {
    struct PHYT has drop {
        dummy_field: bool,
    }

    fun init(arg0: PHYT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PHYT>(arg0, 6, b"PHYT", b"The Physics Teacher", b"This project will raise money for the creation of a Social Platform Profile for sharing educational contents on Physics, created by the best science communicators around the world. Holders will benefit the possibility to partecipate to exclusive events and decision-making.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreig7zj7zp4hoit6jxu5oouopih2q6t2fmzid7iz6w3nwgtflulcq3i")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PHYT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<PHYT>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

