module 0x299852db08c6895efcde6e45721f9d8dd73241d6fc856cb17f960e2ab13b69ae::counter {
    struct COUNTER has drop {
        dummy_field: bool,
    }

    public entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<COUNTER>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<COUNTER>>(0x2::coin::mint<COUNTER>(arg0, arg1, arg3), arg2);
    }

    fun init(arg0: COUNTER, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<COUNTER>(arg0, 9, b"CVE", b"CVE", b"Self-issued counter coin", 0x1::option::none<0x2::url::Url>(), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<COUNTER>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<COUNTER>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v7
}

