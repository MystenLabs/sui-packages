module 0xc31ee621a0397fb9de647c37e3d39d5bb4f3524079f3889fae19fc118df6fb17::trinity {
    struct TRINITY has drop {
        dummy_field: bool,
    }

    fun init(arg0: TRINITY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TRINITY>(arg0, 6, b"TRINITY", b"TRINITY AI", b"Unleashing Al-powered fluid simulations on Solana, shaping dynamic assets and limitless possibilities.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1732296701003.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<TRINITY>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TRINITY>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

