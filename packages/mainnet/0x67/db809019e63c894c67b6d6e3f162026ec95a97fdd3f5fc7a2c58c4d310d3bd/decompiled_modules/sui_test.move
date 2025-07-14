module 0x67db809019e63c894c67b6d6e3f162026ec95a97fdd3f5fc7a2c58c4d310d3bd::sui_test {
    struct SUI_TEST has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUI_TEST, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUI_TEST>(arg0, 9, b"SUI_TEST", b"SUI Token Test", b"xxx", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"xxx")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<SUI_TEST>(&mut v2, 1000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SUI_TEST>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUI_TEST>>(v2, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

