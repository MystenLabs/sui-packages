module 0x3d83b15824de4fec28204ef0e8d6995d271f1271bbc8f8fe515fffd2e8442448::insora {
    struct INSORA has drop {
        dummy_field: bool,
    }

    fun init(arg0: INSORA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<INSORA>(arg0, 6, b"INSORA", b"INSORA AI", b"Redefining crypto with Al ON SUI.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1731518345188.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<INSORA>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<INSORA>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

