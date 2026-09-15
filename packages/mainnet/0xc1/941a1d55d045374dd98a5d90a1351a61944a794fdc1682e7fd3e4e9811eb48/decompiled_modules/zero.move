module 0xc1941a1d55d045374dd98a5d90a1351a61944a794fdc1682e7fd3e4e9811eb48::zero {
    struct ZERO has drop {
        dummy_field: bool,
    }

    fun init(arg0: ZERO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin_registry::new_currency_with_otw<ZERO>(arg0, 6, 0x1::string::utf8(b"ZERO"), 0x1::string::utf8(b"Zero"), 0x1::string::utf8(b"DEV is holding zero."), 0x1::string::utf8(b"https://popularsui.xyz/media/62af62b8f29bbb463376d61726e592a7f965887387fb86f39e6eb06c5cb436ce.webp"), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ZERO>>(v1, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin_registry::MetadataCap<ZERO>>(0x2::coin_registry::finalize<ZERO>(v0, arg1), 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v7
}

