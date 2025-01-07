module 0x346bb1c9441e91c0a9ed67f1f92791495a76ba4b5030e5bdea4e1c978ff42492::fp {
    struct FP has drop {
        dummy_field: bool,
    }

    fun init(arg0: FP, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FP>(arg0, 6, b"FP", b"FREE PALESTINE", b"FREE PALESTINE FOR EVER", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1730990034502.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<FP>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FP>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

