module 0xee041529157411882c5685da3564bfabd912b9559b9d28f9aad523c3a05204e6::lazy {
    struct LAZY has drop {
        dummy_field: bool,
    }

    fun init(arg0: LAZY, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let (v1, v2) = 0x2::coin::create_currency<LAZY>(arg0, 6, b"LAZY", b"Lazy by SuiAI", b"LazyLazyLazy", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.suiai.fun/uploads/Screenshot_2025_01_16_at_12_12_10_PM_2638109501.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<LAZY>>(v2, v0);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<LAZY>>(v1, v0);
    }

    // decompiled from Move bytecode v6
}

