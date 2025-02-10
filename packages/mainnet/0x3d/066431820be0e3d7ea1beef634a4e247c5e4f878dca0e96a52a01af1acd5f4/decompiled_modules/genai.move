module 0x3d066431820be0e3d7ea1beef634a4e247c5e4f878dca0e96a52a01af1acd5f4::genai {
    struct GENAI has drop {
        dummy_field: bool,
    }

    fun init(arg0: GENAI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<GENAI>(arg0, 6, b"GENAI", b"Genesis AI", x"4d756c74692d4149204167677265676174696f6e20456e67696e652e20536d61727420436f6e74726163742047656e65726174696f6e20285375692c204e4654732c2044414f73292e20496e74756974697665204e6f2d436f646520496e746572666163652e205265616c2d54696d6520436f6465204f7074696d697a6174696f6e2e2043726f73732d436861696e20436f6d7061746962696c6974792e0a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1739153255189.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<GENAI>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GENAI>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

