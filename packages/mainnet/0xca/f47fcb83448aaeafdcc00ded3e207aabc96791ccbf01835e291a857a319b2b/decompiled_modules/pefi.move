module 0xcaf47fcb83448aaeafdcc00ded3e207aabc96791ccbf01835e291a857a319b2b::pefi {
    struct PEFI has drop {
        dummy_field: bool,
    }

    fun init(arg0: PEFI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PEFI>(arg0, 6, b"PEFI", b"Peefi", x"57656c636f6d6520537569427579426f7420746f205065652046696e616e636521203a290a496620546f696c6574206d61646520697420626967202077652063616e20646f20697420746f6f2c20746f676574686572206173206120636f6d6d756e6974792120200a486f70206f6e2074686520747261696e212020200a41207765627369746520697320636f6d696e6720736f6f6e20746f6f2120", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/ps1_a2ecfc7565.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PEFI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<PEFI>>(v1);
    }

    // decompiled from Move bytecode v6
}

