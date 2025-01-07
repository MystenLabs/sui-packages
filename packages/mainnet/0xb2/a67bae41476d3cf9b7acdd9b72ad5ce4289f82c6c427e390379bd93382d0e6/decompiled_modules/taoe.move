module 0xb2a67bae41476d3cf9b7acdd9b72ad5ce4289f82c6c427e390379bd93382d0e6::taoe {
    struct TAOE has drop {
        dummy_field: bool,
    }

    fun init(arg0: TAOE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TAOE>(arg0, 6, b"TAOE", b"the Age of Exploration", x"576527726520676f696e6720696e207468652073616d6520646972656374696f6e0a576527726520676f696e6720746f207374617274206120766f796167650a487572727920757020616e6420676574206f6e20626f6172640a57652077696c6c2067726f7720746f676574686572", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/i_e_i_i_94079303b6.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TAOE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<TAOE>>(v1);
    }

    // decompiled from Move bytecode v6
}

