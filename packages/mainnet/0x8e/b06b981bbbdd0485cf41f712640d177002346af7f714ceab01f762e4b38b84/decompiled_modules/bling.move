module 0x8eb06b981bbbdd0485cf41f712640d177002346af7f714ceab01f762e4b38b84::bling {
    struct BLING has drop {
        dummy_field: bool,
    }

    fun init(arg0: BLING, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BLING>(arg0, 6, b"Bling", x"f09f9fa5f09f9faaf09f9fa6f09f9fa9f09f9fa8f09f9fa7", x"f09f9fa5f09f9faaf09f9fa6f09f9fa9f09f9fa8f09f9fa7f09f9fa5f09f9faaf09f9fa6f09f9fa9f09f9fa8f09f9fa7f09f9fa5f09f9faaf09f9fa6f09f9fa9f09f9fa8f09f9fa7f09f9fa5f09f9faaf09f9fa6f09f9fa9f09f9fa8f09f9fa7f09f9fa5f09f9faaf09f9fa6f09f9fa9f09f9fa8f09f9fa7f09f9fa5f09f9faaf09f9fa6f09f9fa9f09f9fa8f09f9fa7f09f9fa5f09f9faaf09f9fa6f09f9fa9f09f9fa8f09f9fa7f09f9fa5f09f9faaf09f9fa6f09f9fa9f09f9fa8f09f9fa7f09f9fa5f09f9faaf09f9fa6f09f9fa9f09f9fa8f09f9fa7f09f9fa5f09f9faaf09f9fa6f09f9fa9f09f9fa8f09f9fa7f09f9fa5f09f9faaf09f9fa6f09f9fa9f09f9fa8f09f9fa7f09f9fa5f09f9faaf09f9fa6f09f9fa9f09f9fa8f09f9fa7f09f9fa5f09f9faaf09f9fa6f09f9fa9f09f9fa8f09f9fa7f09f9fa5f09f9faaf09f9fa6f09f9fa9f09f9fa8f09f9fa7f09f9fa5f09f9faaf09f9fa6f09f9fa9f09f9fa8f09f9fa7f09f9fa5f09f9faaf09f9fa6f09f9fa9f09f9fa8f09f9fa7f09f9fa5f09f9faaf09f9fa6f09f9fa9f09f9fa8f09f9fa7f09f9fa5f09f9faaf09f9fa6f09f9fa9f09f9fa8f09f9fa7f09f9fa5f09f9faaf09f9fa6f09f9fa9f09f9fa8f09f9fa7f09f9fa5f09f9faaf09f9fa6f09f9fa9f09f9fa8f09f9fa7f09f9fa5f09f9faaf09f9fa6f09f9fa9f09f9fa8", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1732001030881.gif")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<BLING>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BLING>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

