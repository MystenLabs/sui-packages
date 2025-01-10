module 0xa819a94d9d5adf16f53d2f3e7d86863d128e146d7de9536435072675c3fd90f::ama {
    struct AMA has drop {
        dummy_field: bool,
    }

    fun init(arg0: AMA, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let (v1, v2) = 0x2::coin::create_currency<AMA>(arg0, 6, b"AMA", b"AiMegaAgent by SuiAI", b"Super agent, buy me", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.suiai.fun/uploads/Designer_4_885a3453e2.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<AMA>>(v2, v0);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<AMA>>(v1, v0);
    }

    // decompiled from Move bytecode v6
}

