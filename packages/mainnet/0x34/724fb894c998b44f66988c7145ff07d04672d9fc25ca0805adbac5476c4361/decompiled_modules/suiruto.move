module 0x34724fb894c998b44f66988c7145ff07d04672d9fc25ca0805adbac5476c4361::suiruto {
    struct SUIRUTO has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIRUTO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIRUTO>(arg0, 6, b"SUIRUTO", b"SUIRUTO on SUI", x"456e74657220746865205355495255544f20576f726c642e2e2e2054686520535549204e6574776f726b20737465616c746869657374206d656d6520636f696e210a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1731693473561.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SUIRUTO>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIRUTO>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

