module 0x9c80233911ae6db56d41b3d4f49b86c555ff9e9828a4b50b6392db600f59654f::dkl {
    struct DKL has drop {
        dummy_field: bool,
    }

    fun init(arg0: DKL, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DKL>(arg0, 9, b"DKL", b"Dankolo", b"Dkl token", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/050a5626-f120-4a5e-82c6-4ed4a3d9f960.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DKL>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<DKL>>(v1);
    }

    // decompiled from Move bytecode v6
}

