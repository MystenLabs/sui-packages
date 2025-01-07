module 0xa9c76d12918712fe0964f1f361aea6f23c35292aa92ec84f0190e822ea93071d::diggy {
    struct DIGGY has drop {
        dummy_field: bool,
    }

    fun init(arg0: DIGGY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DIGGY>(arg0, 6, b"DIGGY", b"TURBO DIGGY", b"Welcome to Turbo DIGGY", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1730962261234.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<DIGGY>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DIGGY>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

