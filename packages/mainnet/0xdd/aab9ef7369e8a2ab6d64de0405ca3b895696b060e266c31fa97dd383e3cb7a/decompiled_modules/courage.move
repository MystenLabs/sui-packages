module 0xddaab9ef7369e8a2ab6d64de0405ca3b895696b060e266c31fa97dd383e3cb7a::courage {
    struct COURAGE has drop {
        dummy_field: bool,
    }

    fun init(arg0: COURAGE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<COURAGE>(arg0, 6, b"COURAGE", b"COURAGESUI", x"0a436f75726167652074686520706172616e6f696120646f67207475726e20626c7565207768696c652074726164696e6720535549", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/COURAGE_f7140209b0.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<COURAGE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<COURAGE>>(v1);
    }

    // decompiled from Move bytecode v6
}

