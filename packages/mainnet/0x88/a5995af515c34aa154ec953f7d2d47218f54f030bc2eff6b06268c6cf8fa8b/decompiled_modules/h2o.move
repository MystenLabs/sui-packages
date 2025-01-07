module 0x88a5995af515c34aa154ec953f7d2d47218f54f030bc2eff6b06268c6cf8fa8b::h2o {
    struct H2O has drop {
        dummy_field: bool,
    }

    fun init(arg0: H2O, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<H2O>(arg0, 9, b"H2O", b"AQUA", b"Sui / Water", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/8bba0e71-31b4-47e6-84ac-ecadacf857e0.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<H2O>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<H2O>>(v1);
    }

    // decompiled from Move bytecode v6
}

