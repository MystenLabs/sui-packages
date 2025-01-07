module 0xb3488be31f1ec8164a0f95c6212829504ca3fe3aa2bcbf06752ccbd7608a5ce::boss {
    struct BOSS has drop {
        dummy_field: bool,
    }

    fun init(arg0: BOSS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BOSS>(arg0, 6, b"Boss", b"TurBoss", b"Unofficial http://Turbos.fun Mascot", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1731430879689.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<BOSS>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BOSS>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

