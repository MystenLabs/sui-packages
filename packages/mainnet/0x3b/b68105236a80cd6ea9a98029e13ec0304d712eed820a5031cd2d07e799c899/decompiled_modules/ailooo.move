module 0x3bb68105236a80cd6ea9a98029e13ec0304d712eed820a5031cd2d07e799c899::ailooo {
    struct AILOOO has drop {
        dummy_field: bool,
    }

    fun init(arg0: AILOOO, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let (v1, v2) = 0x2::coin::create_currency<AILOOO>(arg0, 6, b"AILOOO", b"AI1000 by SuiAI", b"AI1000", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.suiai.fun/uploads/3_Xmz_Bra_400x400_f523afeec1.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<AILOOO>>(v2, v0);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<AILOOO>>(v1, v0);
    }

    // decompiled from Move bytecode v6
}

