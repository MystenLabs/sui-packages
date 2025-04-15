module 0x4afb78c6ba78cabd4280e8bfc33a896c1a049d0a5830d86f203a51fe44739f93::mobarak {
    struct MOBARAK has drop {
        dummy_field: bool,
    }

    fun init(arg0: MOBARAK, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MOBARAK>(arg0, 6, b"MOBARAK", b"Moonbarak CTO", x"5468652052696368657374204b696e67206f6e205355492c20726561647920746f206d6f6f6e2066726f6d20447562616920746f207468652073746172732120f09f9a80f09f8c99f09f8c95", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://beige-abstract-pig-256.mypinata.cloud/ipfs/bafkreiek7fdtqbjwfsafsfe7kh44qfleqksxhatkd3fjbp3a6v4cldb6ku")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MOBARAK>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<MOBARAK>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

