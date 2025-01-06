module 0xf947893950c2264829f89725ab6d0d5bb97fadd5dbd91a3b4c0672bb972b7b74::secai {
    struct SECAI has drop {
        dummy_field: bool,
    }

    fun init(arg0: SECAI, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let (v1, v2) = 0x2::coin::create_currency<SECAI>(arg0, 6, b"SECAI", b"Security Intelligent Ai by SuiAI", b" Intelligent security in crypto space ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.suiai.fun/uploads/Screenshot_2025_01_07_01_00_39_35_40deb401b9ffe8e1df2f1cc5ba480b12_8eaff128b9.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<SECAI>>(v2, v0);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SECAI>>(v1, v0);
    }

    // decompiled from Move bytecode v6
}

