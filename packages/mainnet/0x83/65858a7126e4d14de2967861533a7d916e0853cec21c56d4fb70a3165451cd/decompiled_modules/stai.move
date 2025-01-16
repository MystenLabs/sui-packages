module 0x8365858a7126e4d14de2967861533a7d916e0853cec21c56d4fb70a3165451cd::stai {
    struct STAI has drop {
        dummy_field: bool,
    }

    fun init(arg0: STAI, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let (v1, v2) = 0x2::coin::create_currency<STAI>(arg0, 6, b"STAI", b"Stability AI by SuiAI", b"Empowering AI with Stability.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.suiai.fun/uploads/IMG_2160_8b23059021.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<STAI>>(v2, v0);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<STAI>>(v1, v0);
    }

    // decompiled from Move bytecode v6
}

