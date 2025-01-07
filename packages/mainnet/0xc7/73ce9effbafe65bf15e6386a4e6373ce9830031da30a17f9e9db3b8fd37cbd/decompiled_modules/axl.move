module 0xc773ce9effbafe65bf15e6386a4e6373ce9830031da30a17f9e9db3b8fd37cbd::axl {
    struct AXL has drop {
        dummy_field: bool,
    }

    fun init(arg0: AXL, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<AXL>(arg0, 9, b"AXL", b"Axolotl", b"Axolotl in minecraft", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/5e194cc6-dc0c-4b26-acbb-b9a5f507cbfb.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<AXL>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<AXL>>(v1);
    }

    // decompiled from Move bytecode v6
}

