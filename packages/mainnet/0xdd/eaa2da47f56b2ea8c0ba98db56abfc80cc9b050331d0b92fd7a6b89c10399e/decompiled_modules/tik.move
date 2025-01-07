module 0xddeaa2da47f56b2ea8c0ba98db56abfc80cc9b050331d0b92fd7a6b89c10399e::tik {
    struct TIK has drop {
        dummy_field: bool,
    }

    fun init(arg0: TIK, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TIK>(arg0, 9, b"TIK", b"TIKITAKA", b"Join now and earn passive income ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/6aa62e3a-f997-47b6-a97d-345e97038919.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TIK>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<TIK>>(v1);
    }

    // decompiled from Move bytecode v6
}

