module 0xcf138e7e4853a40501a8b1a7d0a078a2edc48b8cedc80b6eb2c4784ed03c2f48::suic {
    struct SUIC has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIC, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIC>(arg0, 6, b"SUIC", b"SUI Classic", x"546865204f726967696e616c204275796261636b2048797065722d4465666c6174696f6e61727920546f6b656e0a0a46726f6d2069747320696e63657074696f6e2c2024535549432068617320646f6e65207468696e677320646966666572656e746c792e205374617274696e672077697468206120737570706c79206f662031207472696c6c696f6e2c206f757220666f756e6465722c204c69717569646974792077696c6c206265206c6f636b656420696e20547572626f73207468656e20e2809c6275726e6564e2809d207468652036252065616368207472616e73616374696f6e20666f7220736166656b656570696e672e", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1732226672994.35")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SUIC>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIC>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

