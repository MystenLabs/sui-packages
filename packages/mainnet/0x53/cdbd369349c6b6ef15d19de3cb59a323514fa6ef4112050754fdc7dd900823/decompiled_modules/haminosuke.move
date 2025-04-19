module 0x53cdbd369349c6b6ef15d19de3cb59a323514fa6ef4112050754fdc7dd900823::haminosuke {
    struct HAMINOSUKE has drop {
        dummy_field: bool,
    }

    fun init(arg0: HAMINOSUKE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<HAMINOSUKE>(arg0, 9, b"Haminosuke", b"Hamster with Biggest Balls", b"", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/QmapGMcHJycABj2PMBLvYy6L6LDfbhdQm3X3Srxs7pSEur")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<HAMINOSUKE>(&mut v2, 1000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<HAMINOSUKE>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<HAMINOSUKE>>(v2, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

