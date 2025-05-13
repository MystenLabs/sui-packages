module 0x9155abd2988a37e43e4822cb5fd9b544c7a5c7edcf0600d91c588780e565861e::mewtwo {
    struct MEWTWO has drop {
        dummy_field: bool,
    }

    fun init(arg0: MEWTWO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MEWTWO>(arg0, 6, b"Mewtwo", b"MewTwo SUI", b"powerful pokemon", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreie6ezx5zoz7qj7wvetnv3szbdfh42xjm2wzkwpbfaclqhotdrkexy")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MEWTWO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<MEWTWO>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

