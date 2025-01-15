module 0x6ad1160396a65a34ab2d11d11a1faddeb1475057b1f1c690335e1b30dd20a33f::suif {
    struct SUIF has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIF, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let (v1, v2) = 0x2::coin::create_currency<SUIF>(arg0, 6, b"SUIF", b"SuiFutures by SuiAI", b"An agent that allows users to bet on the future of SUI", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.suiai.fun/uploads/images_11_0bdfc6b662.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<SUIF>>(v2, v0);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIF>>(v1, v0);
    }

    // decompiled from Move bytecode v6
}

