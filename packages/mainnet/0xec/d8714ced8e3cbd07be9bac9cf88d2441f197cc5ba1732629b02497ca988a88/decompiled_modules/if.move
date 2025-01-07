module 0xecd8714ced8e3cbd07be9bac9cf88d2441f197cc5ba1732629b02497ca988a88::if {
    struct IF has drop {
        dummy_field: bool,
    }

    fun init(arg0: IF, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<IF>(arg0, 9, b"IF", b"IF ONLY I ", b"IF ONLY I HELD, I COULD HAVE BECOME A MILLIONAIRE ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/79201075-c0f4-4d36-819f-f5dfdcaf57b9.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<IF>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<IF>>(v1);
    }

    // decompiled from Move bytecode v6
}

