module 0xf7ea336a578a6cb8258efecd6e8f6303e8c459659c90a6401945d939e6cab1b4::farthouse {
    struct FARTHOUSE has drop {
        dummy_field: bool,
    }

    fun init(arg0: FARTHOUSE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FARTHOUSE>(arg0, 6, b"FartHouse", b"FartHouse Sui", b"TURN ANY HOUSE INTO A #FARTHOUSE", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafybeieefujunzul3jugeos5katq7yp43dyastrs3mdljzirt4m3ombeiq")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FARTHOUSE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<FARTHOUSE>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

