module 0x1c2e5755fa6c18587b255d27cf5dd7996e5dd45275ef5ca528885ced2921b2cb::notpixel {
    struct NOTPIXEL has drop {
        dummy_field: bool,
    }

    fun init(arg0: NOTPIXEL, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<NOTPIXEL>(arg0, 9, b"NOTPIXEL", b"Not pixel ", b"Not pixel token.this is a meme token", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/87f1d79f-1741-49d9-870c-162e2e6a3631.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<NOTPIXEL>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<NOTPIXEL>>(v1);
    }

    // decompiled from Move bytecode v6
}

