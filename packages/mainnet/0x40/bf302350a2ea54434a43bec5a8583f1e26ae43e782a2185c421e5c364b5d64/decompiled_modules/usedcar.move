module 0x40bf302350a2ea54434a43bec5a8583f1e26ae43e782a2185c421e5c364b5d64::usedcar {
    struct USEDCAR has drop {
        dummy_field: bool,
    }

    fun init(arg0: USEDCAR, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<USEDCAR>(arg0, 6, b"USEDCAR", b"A gently used 1998 Suzuki Swift", x"35207370656564206d616e75616c207472616e736d697373696f6e2c203133303043432063617262757265746564204f484320342063796c696e646572206f6e205355490a0a3131322c393030206f726967696e616c206d6c6c65732c2064726976656e206f6e207765656b656e6473206f6e6c792e20756e72656c6961626c65206a6565742d6d6f62696c650a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/ss_b5c972354a.JPG")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<USEDCAR>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<USEDCAR>>(v1);
    }

    // decompiled from Move bytecode v6
}

