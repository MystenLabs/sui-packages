module 0xad73e34279ba08787ce778b2e41c2c76191f1727d537e25a92dbea581c0cf7a::wiw {
    struct WIW has drop {
        dummy_field: bool,
    }

    fun init(arg0: WIW, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<WIW>(arg0, 9, b"WIW", b"Wiwi", b"Wiwi is a meme token on sui", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/c9af35ab-76bd-4686-9085-6b518a417784.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<WIW>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<WIW>>(v1);
    }

    // decompiled from Move bytecode v6
}

