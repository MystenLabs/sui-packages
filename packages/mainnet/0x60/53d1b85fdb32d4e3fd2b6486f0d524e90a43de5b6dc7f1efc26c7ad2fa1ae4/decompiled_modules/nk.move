module 0x6053d1b85fdb32d4e3fd2b6486f0d524e90a43de5b6dc7f1efc26c7ad2fa1ae4::nk {
    struct NK has drop {
        dummy_field: bool,
    }

    fun init(arg0: NK, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<NK>(arg0, 9, b"NK", b"Nakada", b"Supper bullish meme", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/dfd91b16-e01c-4aa5-ad27-c444a427572e.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<NK>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<NK>>(v1);
    }

    // decompiled from Move bytecode v6
}

