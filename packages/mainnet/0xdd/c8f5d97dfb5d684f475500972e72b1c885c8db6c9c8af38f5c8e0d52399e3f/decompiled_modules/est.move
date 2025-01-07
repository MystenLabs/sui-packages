module 0xddc8f5d97dfb5d684f475500972e72b1c885c8db6c9c8af38f5c8e0d52399e3f::est {
    struct EST has drop {
        dummy_field: bool,
    }

    fun init(arg0: EST, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<EST>(arg0, 9, b"EST", b"Estrella", x"5468697320746f6b656e206973206275696c7420746f206372656174652067656e65726174696f6e616c207765616c746820f09f988e2c7472616465206e6f7720", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/74ddd4f4-1e20-43a7-a4c0-f77f12b1a16d.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<EST>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<EST>>(v1);
    }

    // decompiled from Move bytecode v6
}

