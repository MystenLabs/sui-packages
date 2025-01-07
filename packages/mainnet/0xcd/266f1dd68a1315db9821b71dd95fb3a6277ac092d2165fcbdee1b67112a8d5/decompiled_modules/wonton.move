module 0xcd266f1dd68a1315db9821b71dd95fb3a6277ac092d2165fcbdee1b67112a8d5::wonton {
    struct WONTON has drop {
        dummy_field: bool,
    }

    fun init(arg0: WONTON, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<WONTON>(arg0, 6, b"WONTON", b"WONTON ", b"WONTON now on SUI", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1730959163508.png")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<WONTON>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<WONTON>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

