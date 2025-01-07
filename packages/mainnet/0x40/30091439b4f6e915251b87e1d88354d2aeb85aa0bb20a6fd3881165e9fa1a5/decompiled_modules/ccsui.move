module 0x4030091439b4f6e915251b87e1d88354d2aeb85aa0bb20a6fd3881165e9fa1a5::ccsui {
    struct CCSUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: CCSUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CCSUI>(arg0, 6, b"CCSui", b"Cool Cat Sui", x"546869732069732074686520636f6f6c65737420636174206f6e205375692e0a4c6f6f6b206174206865722062616720616e64206369676172657474652c2064616d6e202c2053757575757569", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1731336984605.jfif")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<CCSUI>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CCSUI>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

