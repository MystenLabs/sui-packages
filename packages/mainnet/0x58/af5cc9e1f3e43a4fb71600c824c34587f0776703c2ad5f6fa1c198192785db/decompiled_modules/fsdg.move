module 0x58af5cc9e1f3e43a4fb71600c824c34587f0776703c2ad5f6fa1c198192785db::fsdg {
    struct FSDG has drop {
        dummy_field: bool,
    }

    fun init(arg0: FSDG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FSDG>(arg0, 9, b"FSDG", b"FD", b"DGSH", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/35798120-7243-49c9-9867-70150e2d5e32.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FSDG>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<FSDG>>(v1);
    }

    // decompiled from Move bytecode v6
}

