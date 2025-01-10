module 0x4fa83d65f47a7dee863716b41b5fd78b0dd21d9ca223bb68d0c06873f5d95b01::modernai {
    struct MODERNAI has drop {
        dummy_field: bool,
    }

    fun init(arg0: MODERNAI, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let (v1, v2) = 0x2::coin::create_currency<MODERNAI>(arg0, 6, b"MODERNAI", b"MODERN AI by SuiAI", b"MODERN AI IN SUI", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.suiai.fun/uploads/images_12_52ff3607ae.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<MODERNAI>>(v2, v0);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MODERNAI>>(v1, v0);
    }

    // decompiled from Move bytecode v6
}

