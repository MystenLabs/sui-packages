module 0x59eb8099f87a141f8227f502a39b365d6fd891c59ed3bed1f47d5669225e899f::quack {
    struct QUACK has drop {
        dummy_field: bool,
    }

    fun init(arg0: QUACK, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let (v1, v2) = 0x2::coin::create_currency<QUACK>(arg0, 6, b"QUACK", b"Debug Duck by SuiAI", b"Born in a factory of defective toys, our rubber duck had a factory bug: it was self-aware. While other debug ducks helped programmers solve problems, $QUACK decided its purpose in life was to create problems!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.suiai.fun/uploads/hero_duck_e65b847d07.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<QUACK>>(v2, v0);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<QUACK>>(v1, v0);
    }

    // decompiled from Move bytecode v6
}

