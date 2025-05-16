module 0x27a8b3e530ed8f5413dd7eb2788ec6d4202ce617413b8568c2b474caffd775a9::suidos {
    struct SUIDOS has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIDOS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIDOS>(arg0, 6, b"SUIDOS", b"Gyarados on SUI", x"54776f206c6966656c6f6e6720506f6bc3a96d6f6e2066616e732c206675656c6564206279206368696c64686f6f64206d656d6f72696573206f662072697070696e67206f70656e20626f6f73746572207061636b7320616e642068756e74696e6720666f72207468617420706572666563742070756c6c2c2068617665207465616d656420757020746f206c61756e63682024537569646f73206f6e20537569206120636f6d6d756e6974792064726976656e206d656d6520636f696e20696e73706972656420627920746865206d6967687479204779617261646f732e204275696c74206f6e207468652053756920426c6f636b636861696e2e204a6f696e207573206f6e2074686520726f616420746f206d696c6c696f6e7321", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreicahx3x4fmxcmfmdz42q5c3bysyf7qfwunbbu7ctxpygi5xejxgbe")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIDOS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<SUIDOS>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

