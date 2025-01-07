module 0xc8d752d3664409e1b92b45795ecad34841de8bedbd9ed86256b9a169eb23d4cb::pty {
    struct PTY has drop {
        dummy_field: bool,
    }

    fun init(arg0: PTY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PTY>(arg0, 9, b"PTY", b"PATTY", b"It's a community project created for meme token awareness", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/6b8553a9-3d45-4d89-97b7-8e7b7fd76c60.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PTY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<PTY>>(v1);
    }

    // decompiled from Move bytecode v6
}

