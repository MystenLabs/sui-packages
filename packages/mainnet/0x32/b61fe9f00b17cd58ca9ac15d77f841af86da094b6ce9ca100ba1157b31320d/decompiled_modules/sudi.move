module 0x32b61fe9f00b17cd58ca9ac15d77f841af86da094b6ce9ca100ba1157b31320d::sudi {
    struct SUDI has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUDI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUDI>(arg0, 6, b"Sudi", b"Suidi", x"536175646920636f696e20666f7220636f696e200a65616368203125", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1731496935377.jpeg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SUDI>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUDI>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

