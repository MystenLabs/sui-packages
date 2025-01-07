module 0xe1fe7dbc2da922e7d4eb41adf1c08d8cafc6cc05ececafdb3fbd436e1922096e::snail {
    struct SNAIL has drop {
        dummy_field: bool,
    }

    fun init(arg0: SNAIL, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SNAIL>(arg0, 6, b"Snail", b"Turbosnail", x"20547572626f736e61696c2069732054686520756c74696d617465206d656d6520746f6b656e206c61756e6368206f6e20747572626f732e66756e2021204a6f696e2074686520736c6f7720616e6420737465616479207261636520746f20746865206d6f6f6e2c20706f776572656420627920636f6d6d756e6974792e0a6d6f76656d656e7420616e6420776174636820697420696e6368206974732077617920746f2074686520746f70", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1730723361970.jpeg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SNAIL>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SNAIL>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

