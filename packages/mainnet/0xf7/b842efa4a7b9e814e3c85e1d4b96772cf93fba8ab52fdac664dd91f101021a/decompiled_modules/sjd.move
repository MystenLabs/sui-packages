module 0xf7b842efa4a7b9e814e3c85e1d4b96772cf93fba8ab52fdac664dd91f101021a::sjd {
    struct SJD has drop {
        dummy_field: bool,
    }

    fun init(arg0: SJD, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SJD>(arg0, 9, b"SJD", b"Sonic ", b"Wow that looks so ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/8a3fcba1-56b7-4a73-b930-9729ef4ad91a.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SJD>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SJD>>(v1);
    }

    // decompiled from Move bytecode v6
}

