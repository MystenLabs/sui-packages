module 0xdcee0e4370c7c321b7dc9f09bfd2456f1035f31df91cce20cdf4be14bcd352f0::hcat {
    struct HCAT has drop {
        dummy_field: bool,
    }

    fun init(arg0: HCAT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<HCAT>(arg0, 6, b"HCAT", b"HopCat", b"HopCatSui", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1730953731221.png")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<HCAT>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<HCAT>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

