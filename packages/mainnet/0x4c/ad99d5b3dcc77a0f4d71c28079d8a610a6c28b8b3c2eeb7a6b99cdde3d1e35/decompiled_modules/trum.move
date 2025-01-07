module 0x4cad99d5b3dcc77a0f4d71c28079d8a610a6c28b8b3c2eeb7a6b99cdde3d1e35::trum {
    struct TRUM has drop {
        dummy_field: bool,
    }

    fun init(arg0: TRUM, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TRUM>(arg0, 9, b"TRUM", b"Trump coin", b"Trump meme coin", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/9cef0433-cd28-4289-96f6-1d7ad4157d72.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TRUM>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<TRUM>>(v1);
    }

    // decompiled from Move bytecode v6
}

