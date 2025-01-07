module 0x7ab8291d63487d57c7112a0995f0f7670c837fecd7f6b327192b22ffbe99512::spr {
    struct SPR has drop {
        dummy_field: bool,
    }

    fun init(arg0: SPR, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SPR>(arg0, 9, b"SPR", b"Sparrow ", b"This coin is cleared created for injured birds to protect environment ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/27b04d4f-fdcc-457c-8839-0b963018f9c3.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SPR>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SPR>>(v1);
    }

    // decompiled from Move bytecode v6
}

