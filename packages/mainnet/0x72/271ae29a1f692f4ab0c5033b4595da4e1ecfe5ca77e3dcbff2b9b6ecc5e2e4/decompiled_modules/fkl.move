module 0x72271ae29a1f692f4ab0c5033b4595da4e1ecfe5ca77e3dcbff2b9b6ecc5e2e4::fkl {
    struct FKL has drop {
        dummy_field: bool,
    }

    fun init(arg0: FKL, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FKL>(arg0, 9, b"FKL", b"GHI", b"Good morning I hope you ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/4837ff28-15d6-4ddb-8641-f58e814e8bc0.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FKL>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<FKL>>(v1);
    }

    // decompiled from Move bytecode v6
}

