module 0x3a668a2cc33e7bf79e11afe15b588a791bc2564e40a3119f1230b5b0894736d5::bross {
    struct BROSS has drop {
        dummy_field: bool,
    }

    fun init(arg0: BROSS, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let (v1, v2) = 0x2::coin::create_currency<BROSS>(arg0, 6, b"BROSS", b"BabyRoss", b"Baby Bob Ross likes to talk about the happy little things he paints. ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.suiai.fun/uploads/openart_image_C_Xnl5w_Q8_1728097226104_raw_d8446b7951.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<BROSS>>(v2, v0);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BROSS>>(v1, v0);
    }

    // decompiled from Move bytecode v6
}

