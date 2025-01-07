module 0xf321c4d9245ebbd581fc15b0eba41482e1edfc87359b14d03f5bc7b6c16266d::xmp {
    struct XMP has drop {
        dummy_field: bool,
    }

    fun init(arg0: XMP, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<XMP>(arg0, 9, b"XMP", b"Xtoken", b"Always bullish", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/e4b6331c-4b6f-4901-b783-b77a50fb850f.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<XMP>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<XMP>>(v1);
    }

    // decompiled from Move bytecode v6
}

