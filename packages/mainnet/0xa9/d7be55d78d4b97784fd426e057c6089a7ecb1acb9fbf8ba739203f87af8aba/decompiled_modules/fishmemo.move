module 0xa9d7be55d78d4b97784fd426e057c6089a7ecb1acb9fbf8ba739203f87af8aba::fishmemo {
    struct FISHMEMO has drop {
        dummy_field: bool,
    }

    fun init(arg0: FISHMEMO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FISHMEMO>(arg0, 9, b"FISHMEMO", b"MEMO", b"meme coin adaption from fish memo", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/aafe2bf2-f058-4caf-8d53-492e51c4a1fc.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FISHMEMO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<FISHMEMO>>(v1);
    }

    // decompiled from Move bytecode v6
}

