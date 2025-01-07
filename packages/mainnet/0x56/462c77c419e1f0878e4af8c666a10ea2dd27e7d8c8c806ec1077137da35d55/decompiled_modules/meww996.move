module 0x56462c77c419e1f0878e4af8c666a10ea2dd27e7d8c8c806ec1077137da35d55::meww996 {
    struct MEWW996 has drop {
        dummy_field: bool,
    }

    fun init(arg0: MEWW996, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MEWW996>(arg0, 9, b"MEWW996", b"meww", b"mewwwwwwwwwwwww", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/54046418-a567-44ed-a09e-ea48894eab01.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MEWW996>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<MEWW996>>(v1);
    }

    // decompiled from Move bytecode v6
}

