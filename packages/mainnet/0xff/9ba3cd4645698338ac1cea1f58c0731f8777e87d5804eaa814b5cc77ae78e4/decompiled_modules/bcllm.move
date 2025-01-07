module 0xff9ba3cd4645698338ac1cea1f58c0731f8777e87d5804eaa814b5cc77ae78e4::bcllm {
    struct BCLLM has drop {
        dummy_field: bool,
    }

    fun init(arg0: BCLLM, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let (v1, v2) = 0x2::coin::create_currency<BCLLM>(arg0, 6, b"BCLLM", b"BCLLM", b"blockchain in LLM", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.suiai.fun/uploads/8466329_cf00d5ef21.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<BCLLM>>(v2, v0);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BCLLM>>(v1, v0);
    }

    // decompiled from Move bytecode v6
}

