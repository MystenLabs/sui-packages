module 0x7faf479b6f1d01583e92a14d92a6736e861fc48f1f32517d5cdada60f9818303::etst {
    struct ETST has drop {
        dummy_field: bool,
    }

    fun init(arg0: ETST, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let (v1, v2) = 0x2::coin::create_currency<ETST>(arg0, 6, b"ETST", b"test by SuiAI", b"e", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.suiai.fun/uploads/hippo_AI_0cfefbcc11.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<ETST>>(v2, v0);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ETST>>(v1, v0);
    }

    // decompiled from Move bytecode v6
}

