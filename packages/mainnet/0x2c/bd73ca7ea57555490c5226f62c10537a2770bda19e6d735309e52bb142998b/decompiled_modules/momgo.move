module 0x2cbd73ca7ea57555490c5226f62c10537a2770bda19e6d735309e52bb142998b::momgo {
    struct MOMGO has drop {
        dummy_field: bool,
    }

    fun init(arg0: MOMGO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MOMGO>(arg0, 6, b"MomGo", b"PokeMom Go", b"PokeMom Go hottest pokemon meme", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafybeic6wgeb6fn72in3svlz2mvds3jys7dbrxidxatuncsvohthypzx4i")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MOMGO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<MOMGO>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

