module 0xa6d375fc3ad7ab87253495686e7110ee2896390c99b8f24fb951b587c10fcb6b::eao {
    struct EAO has drop {
        dummy_field: bool,
    }

    fun init(arg0: EAO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<EAO>(arg0, 6, b"EAO", b"EEEAAAOOOO", x"4c7972696373203a0a4261627920626c7565206275696c64696e6773206661722061626f766520746865206372797374616c2067726f76650a4d6167656e746120706c61746564207465727261636520776974682061207461626c6520616e6420612073746f76650a4775617264656420676f6c64656e207261696c696e67206a75737420746f206672616d6520746865207072657474792073746172730a4669782074686174206f6c64207069616e6f20616e64207468652062697264732077696c6c2066616c6c206170617274", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1748900155043.png")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<EAO>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<EAO>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

