module 0xc99ff26d6930787d136ae9570507159501eae3c4f64ec8179347f21639e0f99c::stepangigo {
    struct STEPANGIGO has drop {
        dummy_field: bool,
    }

    fun init(arg0: STEPANGIGO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<STEPANGIGO>(arg0, 9, b"STEPANGIGO", b"Gigo", b"The first real CryptoStepanGigo", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/4595a93e-50d2-4f18-a767-0f19caa0ccf7.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<STEPANGIGO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<STEPANGIGO>>(v1);
    }

    // decompiled from Move bytecode v6
}

