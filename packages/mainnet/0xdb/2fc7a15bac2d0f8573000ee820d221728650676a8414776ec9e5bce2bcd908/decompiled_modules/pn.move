module 0xdb2fc7a15bac2d0f8573000ee820d221728650676a8414776ec9e5bce2bcd908::pn {
    struct PN has drop {
        dummy_field: bool,
    }

    fun init(arg0: PN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PN>(arg0, 9, b"PN", b"PnutX", b"Meme, dex and gamefi", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/1674e0f5-8889-4f47-aa77-ef773c33ec0b.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PN>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<PN>>(v1);
    }

    // decompiled from Move bytecode v6
}

