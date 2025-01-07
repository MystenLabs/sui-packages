module 0x82663e742a51d337d06be20c983cbef43c4bbd48dc1a26d8dc3514e10130bb96::piran {
    struct PIRAN has drop {
        dummy_field: bool,
    }

    fun init(arg0: PIRAN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PIRAN>(arg0, 6, b"PIRAN", b"Piran Hypeee", x"4120467265616b696e67204e61756768747920506972616e686120696e2074686520537569204f6365616e20f09f8c8a0a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1732379264475.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<PIRAN>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PIRAN>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

