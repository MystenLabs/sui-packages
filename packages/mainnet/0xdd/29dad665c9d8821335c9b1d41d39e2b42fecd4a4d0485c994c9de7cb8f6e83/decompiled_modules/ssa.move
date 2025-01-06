module 0xdd29dad665c9d8821335c9b1d41d39e2b42fecd4a4d0485c994c9de7cb8f6e83::ssa {
    struct SSA has drop {
        dummy_field: bool,
    }

    fun init(arg0: SSA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SSA>(arg0, 9, b"SSA", b"SALIVA", b"SALIVANNNGYG", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/0f1c9f6a-dfb9-420f-adff-6b5ad0422d2b.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SSA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SSA>>(v1);
    }

    // decompiled from Move bytecode v6
}

