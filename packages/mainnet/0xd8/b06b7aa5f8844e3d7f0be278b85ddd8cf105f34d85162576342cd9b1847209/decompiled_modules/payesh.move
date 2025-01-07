module 0xd8b06b7aa5f8844e3d7f0be278b85ddd8cf105f34d85162576342cd9b1847209::payesh {
    struct PAYESH has drop {
        dummy_field: bool,
    }

    fun init(arg0: PAYESH, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PAYESH>(arg0, 9, b"PAYESH", b"Mori", b"just wave", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/b346d6f5-2124-4465-895c-c23a2fe1cd16.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PAYESH>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<PAYESH>>(v1);
    }

    // decompiled from Move bytecode v6
}

