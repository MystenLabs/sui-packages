module 0x459c7a4e8dcd52a195df3df901a2687cb8f3423ece28e8da383da3ad96db468d::suigay {
    struct SUIGAY has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIGAY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIGAY>(arg0, 6, b"SUIGAY", b"THE REAL SUI GUY", b"We are real and remember the truth always comes out. Welcome to the new God of Sui Memes.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreih3jtj5l4d6inhj6ervjyqupl2n3btwy2grmfu2iqonycs3ok4pxq")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIGAY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<SUIGAY>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

