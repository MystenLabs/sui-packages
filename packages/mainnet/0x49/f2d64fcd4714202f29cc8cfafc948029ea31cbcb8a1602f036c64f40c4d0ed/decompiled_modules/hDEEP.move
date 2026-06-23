module 0x49f2d64fcd4714202f29cc8cfafc948029ea31cbcb8a1602f036c64f40c4d0ed::hDEEP {
    struct HDEEP has drop {
        dummy_field: bool,
    }

    fun init(arg0: HDEEP, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<HDEEP>(arg0, 6, b"hDEEP", b"hDEEP Coin", b"hDEEP Coin - yield-bearing representation.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<HDEEP>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<HDEEP>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

