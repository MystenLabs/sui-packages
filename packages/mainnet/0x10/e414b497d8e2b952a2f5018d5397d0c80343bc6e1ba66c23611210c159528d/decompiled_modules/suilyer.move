module 0x10e414b497d8e2b952a2f5018d5397d0c80343bc6e1ba66c23611210c159528d::suilyer {
    struct SUILYER has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUILYER, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let (v1, v2) = 0x2::coin::create_currency<SUILYER>(arg0, 6, b"SUILYER", b"Lyer Agent by SuiAI", x"556e636f766572207468652074727574682068696464656e20626568696e6420616e206167656e742074686174206e657665722074656c6c732069742e204c6f6f6b20636c6f73656c79e28094646f65732074686520776562736974652072657665616c20677265656e3f", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.suiai.fun/uploads/ldaa_fd2e65a210.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<SUILYER>>(v2, v0);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUILYER>>(v1, v0);
    }

    // decompiled from Move bytecode v6
}

