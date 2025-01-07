module 0xaf3dda6bae854945a5e448593f28abcfd574f558b66de25628af115f48fcc88e::morud {
    struct MORUD has drop {
        dummy_field: bool,
    }

    fun init(arg0: MORUD, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MORUD>(arg0, 6, b"MORUD", b"MORUD on Sui", b"\"Believe in something and hold to death\", by $MORUD.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1731502618324.png")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<MORUD>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MORUD>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

