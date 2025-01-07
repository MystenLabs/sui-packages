module 0x75fdff81933cf7fe95e17008e42900b62cd266566458e0afff3eca2cf38053a5::bmc {
    struct BMC has drop {
        dummy_field: bool,
    }

    fun init(arg0: BMC, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BMC>(arg0, 9, b"BMC", b"BullMemec", b"To the moon ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/3beade36-041c-48d2-941e-9867b820848b.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BMC>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<BMC>>(v1);
    }

    // decompiled from Move bytecode v6
}

