module 0x53651f933d684ae5dc27820b7cd52c5cc3fd8f00fd7b314d0d3ecaa46efa0247::usdc_test {
    struct USDC_TEST has drop {
        dummy_field: bool,
    }

    fun init(arg0: USDC_TEST, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<USDC_TEST>(arg0, 6, b"USDC-TEST", b"USDC Test", b"USD Coin Test", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe(0x1::ascii::string(b"https://sandbox.fullsail.finance/static_files/USDC-TEST.png"))), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<USDC_TEST>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<USDC_TEST>>(v1);
    }

    // decompiled from Move bytecode v6
}

