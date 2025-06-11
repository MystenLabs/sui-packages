module 0xc68f720ce0b0cde7b1657aa1cfe7767cc0c004559bbc80ae313620320b83e6fc::jarvai {
    struct JARVAI has drop {
        dummy_field: bool,
    }

    fun init(arg0: JARVAI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<JARVAI>(arg0, 6, b"JARVAI", b"Jarvis AI", x"4a617276697320414920436f696e3a2054686520536d6172742043686f69636520666f722041492d456e68616e636564205472616e73616374696f6e732e0a496e74726f647563696e67204a617276697320414920436f696e2c207468652063727970746f63757272656e637920656e67696e656572656420666f7220656666696369656e637920616e6420696e74656c6c6967656e63652e", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1749662182626.jpeg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<JARVAI>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<JARVAI>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

