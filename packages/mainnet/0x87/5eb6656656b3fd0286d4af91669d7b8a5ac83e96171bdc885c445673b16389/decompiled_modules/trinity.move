module 0x875eb6656656b3fd0286d4af91669d7b8a5ac83e96171bdc885c445673b16389::trinity {
    struct TRINITY has drop {
        dummy_field: bool,
    }

    fun init(arg0: TRINITY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TRINITY>(arg0, 6, b"TRINITY", b"Trinity AI", b"Unleashing Al-powered fluid simulations on Solana, shaping dynamic assets and limitless possibilities.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1732400112504.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<TRINITY>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TRINITY>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

