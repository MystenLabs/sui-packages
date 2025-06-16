module 0x79ea671b9aa98276a19cbfb7cd6831aca0fe3a85b1acebc6050a40c4f6ad1af3::neal {
    struct NEAL has drop {
        dummy_field: bool,
    }

    fun init(arg0: NEAL, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<NEAL>(arg0, 6, b"NEAL", b"NEAL FUN", b"Neal  packed with weird yet oddly captivating mini-games. No X, no Telegram  just enjoy the strange, creative, and addictive charm of games that make you laugh and think.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreidkmgf6bntmv6sijm2aixiwqegkkckuvqzi6a3p27h6ryx42plb2a")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<NEAL>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<NEAL>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

