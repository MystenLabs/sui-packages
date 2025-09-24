module 0xaa1f0a92f84fdf6738b7b34b115312d1be5c00bdf635e74dc77c0b7bfb877d8b::aster {
    struct ASTER has drop {
        dummy_field: bool,
    }

    fun init(arg0: ASTER, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ASTER>(arg0, 9, b"ASTER", b"ASTER", b"ZO Virtual Coin for Aster", 0x1::option::none<0x2::url::Url>(), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<ASTER>>(v1);
        0x2::transfer::public_freeze_object<0x2::coin::TreasuryCap<ASTER>>(v0);
    }

    // decompiled from Move bytecode v6
}

