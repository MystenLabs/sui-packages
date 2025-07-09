module 0x4d56a0338bfcd02de6061f415b5d4d862035897c9b4ab65e78fe802435605427::usdc_test {
    struct USDC_TEST has drop {
        dummy_field: bool,
    }

    fun init(arg0: USDC_TEST, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<USDC_TEST>(arg0, 6, b"USDC_TEST", b"USDC Token Test", b"xxx", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"xxx")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<USDC_TEST>(&mut v2, 1000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<USDC_TEST>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<USDC_TEST>>(v2, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

