module 0x2c2e29a1655944668ad19f1a1d8030b9084371b0e14b2e5dccfe3188f352088::rugg {
    struct RUGG has drop {
        dummy_field: bool,
    }

    fun init(arg0: RUGG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<RUGG>(arg0, 9, b"RUGG", b"RugLife", x"456d62726163696e67207468652075707320616e6420646f776e73206f6620746865206d656d6520636f696e20776f726c642c205275674c69666520697320616c6c2061626f75742074686520746872696c6c206f66207468652063686173652e204a6f696e2074686520525547472067616e6720616e642072656d656d62657220e280932077696e206f72206c6f73652c206974277320616c6c2070617274206f6620746865207269646521", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/78094955-6392-421a-8e4c-2dd9328e40ce.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<RUGG>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<RUGG>>(v1);
    }

    // decompiled from Move bytecode v6
}

