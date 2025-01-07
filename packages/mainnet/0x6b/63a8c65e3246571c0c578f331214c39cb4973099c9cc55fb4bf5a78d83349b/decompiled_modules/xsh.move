module 0x6b63a8c65e3246571c0c578f331214c39cb4973099c9cc55fb4bf5a78d83349b::xsh {
    struct XSH has drop {
        dummy_field: bool,
    }

    fun init(arg0: XSH, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<XSH>(arg0, 9, b"XSH", b"Xshib", b"To the moon token", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/2da8a1ab-e4fe-4876-ad8a-9640d788b35c.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<XSH>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<XSH>>(v1);
    }

    // decompiled from Move bytecode v6
}

