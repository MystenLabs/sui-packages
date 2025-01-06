module 0xa4205c57817288ddddf7f855e3cba34a8751c0c2c08760a5e8e2904a8bb9f827::loadedai {
    struct LOADEDAI has drop {
        dummy_field: bool,
    }

    fun init(arg0: LOADEDAI, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let (v1, v2) = 0x2::coin::create_currency<LOADEDAI>(arg0, 6, b"LOADEDAI", x"4c6f61646564204c696f6e7320414920e29a94efb88f206279205375694149", x"e29a94efb88f204c6f61646564204c696f6e732041493a20596f757220756c74696d6174652066696e616e636520616e642063727970746f20737472617465676973742e20f09fa6812046726f6d20627564676574696e6720616e6420736176696e6720746f20747261636b696e672063727970746f207472656e64732c207765206272696e672074686520726f617220746f20796f7572207765616c74682d6275696c64696e67206a6f75726e65792e20537461792073686172702c2073746179206669657263652120", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.suiai.fun/uploads/9tw_UWQ_Ww_400x400_15d88e9e8f.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<LOADEDAI>>(v2, v0);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<LOADEDAI>>(v1, v0);
    }

    // decompiled from Move bytecode v6
}

