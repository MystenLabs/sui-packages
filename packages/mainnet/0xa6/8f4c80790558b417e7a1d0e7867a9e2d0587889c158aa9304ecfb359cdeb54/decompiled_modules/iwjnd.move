module 0xa68f4c80790558b417e7a1d0e7867a9e2d0587889c158aa9304ecfb359cdeb54::iwjnd {
    struct IWJND has drop {
        dummy_field: bool,
    }

    fun init(arg0: IWJND, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<IWJND>(arg0, 9, b"IWJND", b"bsjsj", b"bdbd", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/d5c29070-d4ae-4ebc-830b-29d4a1d85f69.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<IWJND>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<IWJND>>(v1);
    }

    // decompiled from Move bytecode v6
}

