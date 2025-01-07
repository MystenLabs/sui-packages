module 0x7386da908a9fa388de56328f08fd6fa3568a02e389f8bf91c09df6b193885e9e::spr {
    struct SPR has drop {
        dummy_field: bool,
    }

    fun init(arg0: SPR, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SPR>(arg0, 9, b"SPR", b"Sparrow ", b"This coin is cleared created for injured birds to protect environment ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/d9d10c2e-6c16-485b-bb97-51b6f24c2ba1.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SPR>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SPR>>(v1);
    }

    // decompiled from Move bytecode v6
}

