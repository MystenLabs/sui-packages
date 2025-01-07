module 0xef9a88e2de1c8055a9daf94bee0f0153ff7d1c4591f9db78537027a41a900dbe::xby {
    struct XBY has drop {
        dummy_field: bool,
    }

    fun init(arg0: XBY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<XBY>(arg0, 9, b"XBY", b"Xiobay", b"It is multipurpose coin built to develop online shop and huge potential in fashion industy.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/e86ac32a-02ff-4722-868c-fd8470e7d3f2.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<XBY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<XBY>>(v1);
    }

    // decompiled from Move bytecode v6
}

