module 0x4e41d8b524857ba236d17b37f31af1b9dbd8bbf051824bbaef0cc75a58de5b1e::disco {
    struct DISCO has drop {
        dummy_field: bool,
    }

    fun init(arg0: DISCO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DISCO>(arg0, 6, b"DISCO", x"f09f9fa5f09f9faaf09f9fa6f09f9fa9f09f9fa8f09f9fa7f09f9fa5", x"f09f9fa5f09f9faaf09f9fa6f09f9fa9f09f9fa8f09f9fa7f09f9fa5f09f9faaf09f9fa6f09f9fa9f09f9fa8f09f9fa7f09f9fa5f09f9faaf09f9fa6f09f9fa9f09f9fa8f09f9fa7f09f9fa5f09f9faaf09f9fa6f09f9fa9f09f9fa8f09f9fa7f09f9fa5f09f9faaf09f9fa6f09f9fa9f09f9fa8f09f9fa7f09f9fa5f09f9faaf09f9fa6f09f9fa9f09f9fa8f09f9fa7f09f9fa5f09f9faaf09f9fa6f09f9fa9f09f9fa8f09f9fa7f09f9fa5f09f9faaf09f9fa6f09f9fa9f09f9fa8f09f9fa7f09f9fa5f09f9faaf09f9fa6f09f9fa9f09f9fa8f09f9fa7f09f9fa5f09f9faaf09f9fa6f09f9fa9f09f9fa8f09f9fa7f09f9fa5f09f9faaf09f9fa6f09f9fa9f09f9fa8f09f9fa7f09f9fa5f09f9faaf09f9fa6f09f9fa9f09f9fa8f09f9fa7f09f9fa5f09f9faaf09f9fa6f09f9fa9f09f9fa8f09f9fa7f09f9fa5f09f9faaf09f9fa6f09f9fa9f09f9fa8f09f9fa7f09f9fa5f09f9faaf09f9fa6f09f9fa9f09f9fa8f09f9fa7f09f9fa5f09f9faaf09f9fa6f09f9fa9f09f9fa8f09f9fa7f09f9fa5f09f9faaf09f9fa6f09f9fa9f09f9fa8f09f9fa7f09f9fa5f09f9faaf09f9fa6f09f9fa9f09f9fa8f09f9fa7f09f9fa5f09f9faaf09f9fa6f09f9fa9f09f9fa8f09f9fa7f09f9fa5f09f9faaf09f9fa6f09f9fa9f09f9fa8f09f9fa7f09f9fa5f09f9faaf09f9fa6f09f9fa9f09f9fa8", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1731860549165.webp")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<DISCO>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DISCO>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

