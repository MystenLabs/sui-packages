module 0x51349fc98dcf7749e9e33684a12c1f4e47710fee472440f5d9d5528d2fb08259::asd {
    struct ASD has drop {
        dummy_field: bool,
    }

    fun init(arg0: ASD, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let (v1, v2) = 0x2::coin::create_currency<ASD>(arg0, 6, b"ASD", b"asd", x"e38082", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.suiai.fun/uploads/Screenshot_20250720_173706_com_android_chrome_bfc6d64d1d.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<ASD>>(v2, v0);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ASD>>(v1, v0);
    }

    // decompiled from Move bytecode v6
}

