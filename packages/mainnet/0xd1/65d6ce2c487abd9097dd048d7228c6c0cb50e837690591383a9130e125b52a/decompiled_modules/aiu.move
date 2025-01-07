module 0xd165d6ce2c487abd9097dd048d7228c6c0cb50e837690591383a9130e125b52a::aiu {
    struct AIU has drop {
        dummy_field: bool,
    }

    fun init(arg0: AIU, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let (v1, v2) = 0x2::coin::create_currency<AIU>(arg0, 6, b"AIU", b"AiUp", b"Maya ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.suiai.fun/uploads/unnamed_55bef50a42.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<AIU>>(v2, v0);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<AIU>>(v1, v0);
    }

    // decompiled from Move bytecode v6
}

