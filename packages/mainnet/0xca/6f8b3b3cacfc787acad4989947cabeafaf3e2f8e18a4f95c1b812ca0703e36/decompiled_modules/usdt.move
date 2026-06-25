module 0xca6f8b3b3cacfc787acad4989947cabeafaf3e2f8e18a4f95c1b812ca0703e36::usdt {
    struct USDT has drop {
        dummy_field: bool,
    }

    fun init(arg0: USDT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1, v2) = 0x2::coin::create_regulated_currency_v2<USDT>(arg0, 6, b"USDT", b"Tether USD", x"5465746865722055534420e2809420666961742d6261636b656420737461626c65636f696e2e", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://tether.to/")), true, arg1);
        let v3 = 0x2::tx_context::sender(arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<USDT>>(v0, v3);
        0x2::transfer::public_transfer<0x2::coin::DenyCapV2<USDT>>(v1, v3);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<USDT>>(v2);
    }

    // decompiled from Move bytecode v7
}

