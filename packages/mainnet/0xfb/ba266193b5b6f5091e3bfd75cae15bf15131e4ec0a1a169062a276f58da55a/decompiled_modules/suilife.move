module 0xfbba266193b5b6f5091e3bfd75cae15bf15131e4ec0a1a169062a276f58da55a::suilife {
    struct SUILIFE has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUILIFE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUILIFE>(arg0, 6, b"SUILIFE", b"SUILIFETOKEN", b"Decentrakized", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreibrtnfldhe57fapdkomugyrpdsvjdtyf4dlu3rxpqzbzxoaw2r6uq")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUILIFE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<SUILIFE>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

