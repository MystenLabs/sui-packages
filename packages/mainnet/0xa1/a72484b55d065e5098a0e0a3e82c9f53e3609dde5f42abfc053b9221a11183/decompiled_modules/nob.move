module 0xa1a72484b55d065e5098a0e0a3e82c9f53e3609dde5f42abfc053b9221a11183::nob {
    struct NOB has drop {
        dummy_field: bool,
    }

    fun init(arg0: NOB, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<NOB>(arg0, 9, b"NOB", b"Noob", b"for blastroyale community", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/5c1e6072-370e-43c2-8629-150166621030.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<NOB>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<NOB>>(v1);
    }

    // decompiled from Move bytecode v6
}

