module 0x7f05b17a4cec40708061460eb0b912ffefc418c6ed1e43075f6d99b0ee4345ae::akita {
    struct AKITA has drop {
        dummy_field: bool,
    }

    fun init(arg0: AKITA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<AKITA>(arg0, 6, b"AKITA", b"AKITA ON MOONBAGS", b"AKITA IS TICKER", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://beige-abstract-pig-256.mypinata.cloud/ipfs/bafkreihafiuyxbupmuezxrvc7juhgqcfneux3zdybajuyv25jm6skgkck4")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<AKITA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<AKITA>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

