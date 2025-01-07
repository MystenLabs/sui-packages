module 0x5d4603d242f2c64bf6457e74b7ee022db8ab0ed44d1639773290997d8cb07bc8::maya {
    struct MAYA has drop {
        dummy_field: bool,
    }

    fun init(arg0: MAYA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MAYA>(arg0, 6, b"Maya", b"Maya Points", x"4d61796120506f696e74730a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1731013870371.jpeg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<MAYA>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MAYA>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

