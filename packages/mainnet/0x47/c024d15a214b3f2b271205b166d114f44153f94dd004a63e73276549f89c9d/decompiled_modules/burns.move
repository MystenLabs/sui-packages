module 0x47c024d15a214b3f2b271205b166d114f44153f94dd004a63e73276549f89c9d::burns {
    struct BURNS has drop {
        dummy_field: bool,
    }

    fun init(arg0: BURNS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BURNS>(arg0, 6, b"BURNS", b"MR BURNS", x"4d72204275726e732069732074686520696465616c2063727970746f20666f756e6465722e20436f6e76696e636573206d696c6c696f6e7320746f207465737420686973206170702e200a0a5a65726f20706c616e7320746f2070617920616e79206f66207468656d2e", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreicgedcmqyhagiqp4ta2ugalzfujoejnhhyii5vrc62vcnux4wnjea")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BURNS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<BURNS>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

