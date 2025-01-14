module 0x73f104be8e53f56bc9acbd8bf005ee1103bfeb13e630e833182bb9df7a03413::rocket {
    struct ROCKET has drop {
        dummy_field: bool,
    }

    fun init(arg0: ROCKET, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let (v1, v2) = 0x2::coin::create_currency<ROCKET>(arg0, 6, b"ROCKET", b"AI ROCKET by SuiAI", b"Alpha Terminal and On Chain VC", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.suiai.fun/uploads/oo9on_Rf_L_400x400_1_43d7b904f0.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<ROCKET>>(v2, v0);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ROCKET>>(v1, v0);
    }

    // decompiled from Move bytecode v6
}

