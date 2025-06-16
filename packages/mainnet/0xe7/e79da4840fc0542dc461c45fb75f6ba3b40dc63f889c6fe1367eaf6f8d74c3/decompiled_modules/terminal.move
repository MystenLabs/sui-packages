module 0xe7e79da4840fc0542dc461c45fb75f6ba3b40dc63f889c6fe1367eaf6f8d74c3::terminal {
    struct TERMINAL has drop {
        dummy_field: bool,
    }

    fun init(arg0: TERMINAL, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TERMINAL>(arg0, 6, b"TERMINAL", b"TRUTH TERMINAL OF SUI", b"WELCOME TO THE ANOTHER WORLDS TRUTH TERMINAL OF SUI", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreif3gon3qiote3ncl26drh63felhhpdbzxy773vpddvzdh2jziird4")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TERMINAL>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<TERMINAL>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

