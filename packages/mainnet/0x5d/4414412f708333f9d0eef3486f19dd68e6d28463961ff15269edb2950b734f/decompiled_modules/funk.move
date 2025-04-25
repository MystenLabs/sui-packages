module 0x5d4414412f708333f9d0eef3486f19dd68e6d28463961ff15269edb2950b734f::funk {
    struct FUNK has drop {
        dummy_field: bool,
    }

    fun init(arg0: FUNK, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FUNK>(arg0, 6, b"FUNK", b"FUNKOFY", b"Transform your favorite characters into Funko Pop! collectibles", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreif66rmx5flpzqknnt7eexguhbhwin43u4hbzt6swyeq3sdkwnassu")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FUNK>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<FUNK>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

