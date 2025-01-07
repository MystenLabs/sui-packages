module 0xf9963e9306250809c7979dab6036ba8fdf4c4e2460250f2e4f80796c19b41b48::hodl {
    struct HODL has drop {
        dummy_field: bool,
    }

    fun init(arg0: HODL, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<HODL>(arg0, 6, b"HODL", b"LEGOARDIO", x"0a69742773204c45474f415244494f20486f646c20477579206f6e205375692e", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1730975375595.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<HODL>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<HODL>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

