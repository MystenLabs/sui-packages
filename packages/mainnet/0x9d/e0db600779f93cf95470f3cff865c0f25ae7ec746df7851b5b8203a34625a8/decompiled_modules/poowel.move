module 0x9de0db600779f93cf95470f3cff865c0f25ae7ec746df7851b5b8203a34625a8::poowel {
    struct POOWEL has drop {
        dummy_field: bool,
    }

    fun init(arg0: POOWEL, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<POOWEL>(arg0, 6, b"POOWEL", b"SUIPOOWEL", x"537475647920436f6e76696374696f6e2e2054686520506f6f77656c20436861647320476f2042727272207c2024504f4f57454c20200a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_0741_53ad7aaad1.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<POOWEL>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<POOWEL>>(v1);
    }

    // decompiled from Move bytecode v6
}

