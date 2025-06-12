module 0xc1ee8e4a220c5c5fb8a2c69f76afc509db3da62e115c1cb66b15c27446bc3445::bubo {
    struct BUBO has drop {
        dummy_field: bool,
    }

    fun init(arg0: BUBO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BUBO>(arg0, 6, b"BUBO", b"Bubbo", b"Visualize your crypto moves", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreiey3tvahv2zdei34b4li3m3injq64ouh44e753guiibruqnswljzi")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BUBO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<BUBO>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

