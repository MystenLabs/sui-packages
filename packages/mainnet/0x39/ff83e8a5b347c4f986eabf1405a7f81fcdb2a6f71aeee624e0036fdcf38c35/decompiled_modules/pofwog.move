module 0x39ff83e8a5b347c4f986eabf1405a7f81fcdb2a6f71aeee624e0036fdcf38c35::pofwog {
    struct POFWOG has drop {
        dummy_field: bool,
    }

    fun init(arg0: POFWOG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<POFWOG>(arg0, 6, b"POFWOG", b"Pump O Fwog", x"4d696c6561676520696e206375746520616e640a706c617966756c2066776f672d7468656d65640a746f6b656e73", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000004297_f3ef855cdb.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<POFWOG>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<POFWOG>>(v1);
    }

    // decompiled from Move bytecode v6
}

