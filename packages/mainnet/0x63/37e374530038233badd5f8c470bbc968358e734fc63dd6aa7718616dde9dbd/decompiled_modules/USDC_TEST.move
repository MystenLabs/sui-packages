module 0x6337e374530038233badd5f8c470bbc968358e734fc63dd6aa7718616dde9dbd::USDC_TEST {
    struct USDC_TEST has drop {
        dummy_field: bool,
    }

    fun init(arg0: USDC_TEST, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<USDC_TEST>(arg0, 6, b"USDC", b"USDC", b"USDC", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<USDC_TEST>(&mut v2, 100000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<USDC_TEST>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<USDC_TEST>>(v2, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

