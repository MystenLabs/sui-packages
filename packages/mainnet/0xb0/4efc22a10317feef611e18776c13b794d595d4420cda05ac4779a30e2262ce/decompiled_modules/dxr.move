module 0xb04efc22a10317feef611e18776c13b794d595d4420cda05ac4779a30e2262ce::dxr {
    struct DXR has drop {
        dummy_field: bool,
    }

    fun init(arg0: DXR, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DXR>(arg0, 9, b"DXR", b"Dxster", b"Dxster coin is a cryptocurrency inspired by internet memes or popular culture trends.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/60e39cfe-c6bd-4059-a5e8-38c3a2fa8e7a.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DXR>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<DXR>>(v1);
    }

    // decompiled from Move bytecode v6
}

