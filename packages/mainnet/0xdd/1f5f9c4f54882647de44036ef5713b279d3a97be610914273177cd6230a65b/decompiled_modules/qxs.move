module 0xdd1f5f9c4f54882647de44036ef5713b279d3a97be610914273177cd6230a65b::qxs {
    struct QXS has drop {
        dummy_field: bool,
    }

    fun init(arg0: QXS, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let (v1, v2) = 0x2::coin::create_currency<QXS>(arg0, 6, b"QXS", b"qiuxishu", x"e982b1e4b887e5b1b1e79a84e584bfe5ad90", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.suiai.fun/uploads/20250103140412_353c4f23fe.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<QXS>>(v2, v0);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<QXS>>(v1, v0);
    }

    // decompiled from Move bytecode v6
}

