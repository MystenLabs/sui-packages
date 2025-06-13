module 0xf2c831d0cb6f4d9de35294207423ccd983fc7097483bb8f2ecb81a7f068f04ff::poda {
    struct PODA has drop {
        dummy_field: bool,
    }

    fun init(arg0: PODA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PODA>(arg0, 6, b"PODA", b"PokeDailySui", x"596f75722066726f6e7420726f772068616e6468656c64206c6f6f6b206174207265616c20776f726c6420506f6bc3a96d6f6e20747261696e6572732c2065706963206361746368657320616e6420626174746c6573206c697665206163726f7373204b616e746f206f6e2053756921", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafybeidqf5vwf6nkbnxovpdrg366dkps3lfygtyuk3g4oo2ovvw2z3mngq")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PODA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<PODA>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

