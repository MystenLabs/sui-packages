module 0x263c3f9f3f2bdefa0f14223899caa0e091d6a3898fe9526f2eeb1141be23e3cb::x {
    struct X has drop {
        dummy_field: bool,
    }

    fun init(arg0: X, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<X>(arg0, 9, b"X", b"Xsui", b"XSUI", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/190f5d6a-c801-4527-b870-8f24d07aeacc.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<X>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<X>>(v1);
    }

    // decompiled from Move bytecode v6
}

