module 0xce5d5732454da66a04b69eb0907415998f89d82a59f22f1a6d6e9f652e586def::hfog {
    struct HFOG has drop {
        dummy_field: bool,
    }

    fun init(arg0: HFOG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<HFOG>(arg0, 6, b"Hfog", b"HopFrog", x"46697273742046726f6720200a4a6f696e20636f6d6d756e6974792068747470733a2f2f742e6d652f486f7046726f67537569", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000035921_34644c757a.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<HFOG>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<HFOG>>(v1);
    }

    // decompiled from Move bytecode v6
}

