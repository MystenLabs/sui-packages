module 0x96dc23e81800874870cd6bdf3f17e01d315e583e7fe523b77c11121db9cbbb88::usdc_test {
    struct USDC_TEST has drop {
        dummy_field: bool,
    }

    fun init(arg0: USDC_TEST, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<USDC_TEST>(arg0, 6, b"USDC-TEST", b"Tether USD Test", b"Tether USD Test", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe(0x1::ascii::string(b"https://sandbox.fullsail.finance/static_files/USDC-TEST.png"))), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<USDC_TEST>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<USDC_TEST>>(v1);
    }

    // decompiled from Move bytecode v6
}

