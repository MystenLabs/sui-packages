module 0x16cc8515efa0f653790f6e55b97231f88ecd6d73f6706c21090965706dfe3290::suipei {
    struct SUIPEI has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIPEI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIPEI>(arg0, 6, b"SUIPEI", b"PEIPEI ON SUI", x"504549504549204841532041525249564544204f4e205355490a0a436f6d65206a6f696e206f75722074656c656772616d20636f6d6d756e6974793a0a68747470733a2f2f742e6d652f537569706569506f7274616c", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/peipei_sui_15e9dbc3b8.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIPEI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUIPEI>>(v1);
    }

    // decompiled from Move bytecode v6
}

