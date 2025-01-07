module 0xbac4dce73baa5cdf00895c32724224a0eef9b06d51c1fc1de4481feba298a6a0::nilly {
    struct NILLY has drop {
        dummy_field: bool,
    }

    fun init(arg0: NILLY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<NILLY>(arg0, 6, b"NILLY", b"Sui nilly", x"776f6f6620776f6f66210a58203a2068747470733a2f2f782e636f6d2f6e696c6c79646f670a54656c656772616d203a2068747470733a2f2f742e6d652f4e696c6c79506f7274616c0a576562203a2068747470733a2f2f776f6f662e636f6d2f", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_20241212_175914_600_e02ff24f3e.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<NILLY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<NILLY>>(v1);
    }

    // decompiled from Move bytecode v6
}

