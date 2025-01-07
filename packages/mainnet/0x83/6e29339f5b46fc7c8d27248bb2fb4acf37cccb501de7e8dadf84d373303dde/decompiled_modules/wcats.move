module 0x836e29339f5b46fc7c8d27248bb2fb4acf37cccb501de7e8dadf84d373303dde::wcats {
    struct WCATS has drop {
        dummy_field: bool,
    }

    fun init(arg0: WCATS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<WCATS>(arg0, 9, b"WCATS", b"White cats", b"White Cat is beautiful ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/4ec12002-3ad8-4463-988e-ea15c00d4373.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<WCATS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<WCATS>>(v1);
    }

    // decompiled from Move bytecode v6
}

