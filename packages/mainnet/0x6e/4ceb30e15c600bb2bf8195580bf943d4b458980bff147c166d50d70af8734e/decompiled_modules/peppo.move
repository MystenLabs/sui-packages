module 0x6e4ceb30e15c600bb2bf8195580bf943d4b458980bff147c166d50d70af8734e::peppo {
    struct PEPPO has drop {
        dummy_field: bool,
    }

    fun init(arg0: PEPPO, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let (v1, v2) = 0x2::coin::create_currency<PEPPO>(arg0, 6, b"PEPPO", b"peppo by SuiAI", b"IS JUST A PEPPO", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.suiai.fun/uploads/peppo_coin_5340801d2a.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<PEPPO>>(v2, v0);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PEPPO>>(v1, v0);
    }

    // decompiled from Move bytecode v6
}

