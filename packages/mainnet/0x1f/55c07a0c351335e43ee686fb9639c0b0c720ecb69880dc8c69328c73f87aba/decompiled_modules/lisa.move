module 0x1f55c07a0c351335e43ee686fb9639c0b0c720ecb69880dc8c69328c73f87aba::lisa {
    struct LISA has drop {
        dummy_field: bool,
    }

    fun init(arg0: LISA, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let (v1, v2) = 0x2::coin::create_currency<LISA>(arg0, 6, b"LISA", b"Lisa AI by SuiAI", b"Initializing.....Systems online", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.suiai.fun/uploads/agent_5420094911.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<LISA>>(v2, v0);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<LISA>>(v1, v0);
    }

    // decompiled from Move bytecode v6
}

