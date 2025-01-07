module 0xfc2096c41554d6f2e3a96349a5500c1ede92b0e13ad56f04bacc9e0d1e0287dd::xsh {
    struct XSH has drop {
        dummy_field: bool,
    }

    fun init(arg0: XSH, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<XSH>(arg0, 9, b"XSH", b"Xshib", b"To the moon token", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/6244d883-1285-480c-ae25-7ee1404aa4e0.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<XSH>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<XSH>>(v1);
    }

    // decompiled from Move bytecode v6
}

