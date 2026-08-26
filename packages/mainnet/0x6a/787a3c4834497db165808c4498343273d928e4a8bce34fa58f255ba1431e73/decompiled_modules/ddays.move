module 0x6a787a3c4834497db165808c4498343273d928e4a8bce34fa58f255ba1431e73::ddays {
    struct DDAYS has drop {
        dummy_field: bool,
    }

    fun init(arg0: DDAYS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DDAYS>(arg0, 6, b"DDAYS", b"DOOMS DAYS", x"4120636f696e2064657374696e656420746f206578706c6f6465e28094616e2061706f63616c7970746963207375726765e280947768657468657220736f6f6e6572206f72206c617465722c20746f6d6f72726f77206f7220746865206461792061667465723b20736f206d616b65207375726520796f7520646f6e277420676574206c65667420626568696e64207768656e2074686174206578706c6f73696f6e20686974732e", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1787772150093.jpeg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<DDAYS>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DDAYS>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

