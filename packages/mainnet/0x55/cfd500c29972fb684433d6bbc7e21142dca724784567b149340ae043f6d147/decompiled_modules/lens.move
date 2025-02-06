module 0x55cfd500c29972fb684433d6bbc7e21142dca724784567b149340ae043f6d147::lens {
    struct LENS has drop {
        dummy_field: bool,
    }

    fun init(arg0: LENS, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let (v1, v2) = 0x2::coin::create_currency<LENS>(arg0, 6, b"LENS", b"LensAi by SuiAI", b"The first and pioneering platform on SUIAI to track tokens, monitor dev wallets, and uncover hidden gems", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.suiai.fun/uploads/logo_14371af543.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<LENS>>(v2, v0);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<LENS>>(v1, v0);
    }

    // decompiled from Move bytecode v6
}

