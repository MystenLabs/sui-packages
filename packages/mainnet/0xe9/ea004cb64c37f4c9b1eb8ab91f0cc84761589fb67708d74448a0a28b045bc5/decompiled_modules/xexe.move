module 0xe9ea004cb64c37f4c9b1eb8ab91f0cc84761589fb67708d74448a0a28b045bc5::xexe {
    struct XEXE has drop {
        dummy_field: bool,
    }

    fun init(arg0: XEXE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<XEXE>(arg0, 6, b"XEXE", b"First Xexe on Sui", b"First Xexe on Sui.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Logo_1_8_17cbd59470.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<XEXE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<XEXE>>(v1);
    }

    // decompiled from Move bytecode v6
}

