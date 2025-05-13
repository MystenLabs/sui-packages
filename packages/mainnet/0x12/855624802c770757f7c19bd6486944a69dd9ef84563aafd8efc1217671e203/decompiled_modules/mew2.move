module 0x12855624802c770757f7c19bd6486944a69dd9ef84563aafd8efc1217671e203::mew2 {
    struct MEW2 has drop {
        dummy_field: bool,
    }

    fun init(arg0: MEW2, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MEW2>(arg0, 6, b"Mew2", b"MewTwo", b"Mewtwo Launch on moonbags the powerful pokemon", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreie6ezx5zoz7qj7wvetnv3szbdfh42xjm2wzkwpbfaclqhotdrkexy")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MEW2>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<MEW2>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

