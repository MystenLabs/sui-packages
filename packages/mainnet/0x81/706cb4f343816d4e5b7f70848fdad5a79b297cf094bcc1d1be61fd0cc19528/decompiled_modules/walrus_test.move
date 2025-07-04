module 0x81706cb4f343816d4e5b7f70848fdad5a79b297cf094bcc1d1be61fd0cc19528::walrus_test {
    struct WALRUS_TEST has drop {
        dummy_field: bool,
    }

    fun init(arg0: WALRUS_TEST, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<WALRUS_TEST>(arg0, 6, b"WALRUS-TEST", b"Walrus Token Test", b"Walrus Token Test", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe(0x1::ascii::string(b"https://sandbox.fullsail.finance/static_files/Walrus-TEST.png"))), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<WALRUS_TEST>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<WALRUS_TEST>>(v1);
    }

    // decompiled from Move bytecode v6
}

