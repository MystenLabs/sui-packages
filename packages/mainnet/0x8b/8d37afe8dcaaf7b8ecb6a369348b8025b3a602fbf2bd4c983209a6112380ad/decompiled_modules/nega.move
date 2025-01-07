module 0x8b8d37afe8dcaaf7b8ecb6a369348b8025b3a602fbf2bd4c983209a6112380ad::nega {
    struct NEGA has drop {
        dummy_field: bool,
    }

    fun init(arg0: NEGA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<NEGA>(arg0, 6, b"NEGA", b"NebulaGoat ", x"2f2f204d6f6f6e426c6561743a20576865726520676f617473206d65657420746865206d6f6f6e0a7b0a2020226e616d65223a20224d6f6f6e426c656174222c0a2020226d697373696f6e223a2022426c656174206265796f6e642074686520737461727320f09f8c95f09f9090222c0a202022626c6f636b636861696e223a2022537569222c0a202022707572706f7365223a2022556e646566696e6564202f2f204a7573742076696265732e222c0a202022737461747573223a2022496e697469616c697a696e672e2e2e20f09f9a80222c0a2020227574696c697479223a20223f3f3f222c0a2020227669626573223a2022496e66696e697465220a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1731996819195.png")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<NEGA>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<NEGA>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

