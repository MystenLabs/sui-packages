module 0x15fa2fa2f7fafee6af04fb732cf7f8352e830b73fa5274e333f724c4884ba030::meowth {
    struct MEOWTH has drop {
        dummy_field: bool,
    }

    fun init(arg0: MEOWTH, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MEOWTH>(arg0, 6, b"MEOWTH", b"Meowth On Sui", b"Meowth is the ultimate meme coin for broke cats and delusional dreamers. Buy now before even my respect runs out.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafybeihcsqd7ybtnbhedh4qhmblob6bwegnepiju5boyfo32yncsv3j6x4")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MEOWTH>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<MEOWTH>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

