module 0xac71eff8ecb63f6728afebe8864e1cb892d6f67e0ef2c3af76a4e7054c7513c0::hkr {
    struct HKR has drop {
        dummy_field: bool,
    }

    fun init(arg0: HKR, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let (v1, v2) = 0x2::coin::create_currency<HKR>(arg0, 6, b"HKR", x"48696b617275f09f8d9520206279205375694149", b"Your delivery AI Agent in sui", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.suiai.fun/uploads/RK_Hl7_VP_400x400_3e265c0d13.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<HKR>>(v2, v0);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<HKR>>(v1, v0);
    }

    // decompiled from Move bytecode v6
}

