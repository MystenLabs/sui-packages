module 0x168eaaa0d3e3c2c390f9dd1c0ab1e8a2577c5cfbac6f14aea1b44acfe7f231cb::com {
    struct COM has drop {
        dummy_field: bool,
    }

    fun init(arg0: COM, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<COM>(arg0, 6, b"COM", b"Circus of memes", b"\"Welcome to the chaos of memes! Here, only laughter matters. Come in and have a good laugh with the best (or worst) memes on the internet. Have fun, share and let the humor flow!\"", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1733282030000.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<COM>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<COM>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

