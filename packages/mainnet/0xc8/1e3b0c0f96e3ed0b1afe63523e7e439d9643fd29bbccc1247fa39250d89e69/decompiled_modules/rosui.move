module 0xc81e3b0c0f96e3ed0b1afe63523e7e439d9643fd29bbccc1247fa39250d89e69::rosui {
    struct ROSUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: ROSUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ROSUI>(arg0, 6, b"ROSUI", b"RoSui", b"Your friendly, futuristic AI bot who here to tidy up your mess and keep you company while she does it", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1730962781659.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<ROSUI>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ROSUI>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

