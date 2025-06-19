module 0xa78b729e8381530c243894f14960dc18dcdb152f0d87d19e0f3895ff11801080::floki {
    struct FLOKI has drop {
        dummy_field: bool,
    }

    fun init(arg0: FLOKI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FLOKI>(arg0, 6, b"FLOKI", b"Floki On Sui", b"Floki na Sui the future is now.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreickvigbamttgt7uvewhq74n26ajoh3djdtrl4jzdn66xpxykhafje")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FLOKI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<FLOKI>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

