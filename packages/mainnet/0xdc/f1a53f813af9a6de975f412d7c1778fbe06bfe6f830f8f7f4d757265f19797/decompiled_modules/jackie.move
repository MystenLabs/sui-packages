module 0xdcf1a53f813af9a6de975f412d7c1778fbe06bfe6f830f8f7f4d757265f19797::jackie {
    struct JACKIE has drop {
        dummy_field: bool,
    }

    fun init(arg0: JACKIE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<JACKIE>(arg0, 6, b"JACKIE", b"CAPTAIN JACKIE", x"446f6e27742073656c6cf09f93882e476f20746f204b696e67206f6620726163696e67f09f9191", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1735126600126.png")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<JACKIE>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<JACKIE>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

