module 0x7dbb7186af906a865f574c364f14dbc72e6c6e703a7eced118443215000c7871::airos {
    struct AIROS has drop {
        dummy_field: bool,
    }

    fun init(arg0: AIROS, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let (v1, v2) = 0x2::coin::create_currency<AIROS>(arg0, 6, b"AIROS", b"AIROS AI by SuiAI", b"Decentralized AI robot harnessing Sui Network's cutting-edge blockchain technology..", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.suiai.fun/uploads/Pv6qew9_400x400_d96719b36a.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<AIROS>>(v2, v0);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<AIROS>>(v1, v0);
    }

    // decompiled from Move bytecode v6
}

