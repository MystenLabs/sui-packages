module 0x64e1031f5296b174d9a94598bf25728398acc9eefcf1c3b3e4c75593d4217dc8::lzard {
    struct LZARD has drop {
        dummy_field: bool,
    }

    fun init(arg0: LZARD, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<LZARD>(arg0, 9, b"LZARD", b"Lizard", b"meme on sui", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/2fa83f0d-9bd3-482f-b395-8061ba101dea.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<LZARD>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<LZARD>>(v1);
    }

    // decompiled from Move bytecode v6
}

