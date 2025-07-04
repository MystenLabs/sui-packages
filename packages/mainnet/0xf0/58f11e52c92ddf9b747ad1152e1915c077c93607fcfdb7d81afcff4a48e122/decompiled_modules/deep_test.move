module 0xf058f11e52c92ddf9b747ad1152e1915c077c93607fcfdb7d81afcff4a48e122::deep_test {
    struct DEEP_TEST has drop {
        dummy_field: bool,
    }

    fun init(arg0: DEEP_TEST, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DEEP_TEST>(arg0, 6, b"DEEP-TEST", b"DeepBook Token Test", b"DeepBook Token Test", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe(0x1::ascii::string(b"https://sandbox.fullsail.finance/static_files/Deep-TEST.png"))), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DEEP_TEST>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<DEEP_TEST>>(v1);
    }

    // decompiled from Move bytecode v6
}

