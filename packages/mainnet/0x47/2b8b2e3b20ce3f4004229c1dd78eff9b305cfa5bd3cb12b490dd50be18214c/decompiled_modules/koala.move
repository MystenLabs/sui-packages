module 0x472b8b2e3b20ce3f4004229c1dd78eff9b305cfa5bd3cb12b490dd50be18214c::koala {
    struct KOALA has drop {
        dummy_field: bool,
    }

    fun init(arg0: KOALA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<KOALA>(arg0, 6, b"Koala", b"Koala on sui", b"SCAM", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreibcdwkyjmqb2fwapeynaw4wd3xsdms2c5p5yop3vuyvrsbh7q2cwq")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<KOALA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<KOALA>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

