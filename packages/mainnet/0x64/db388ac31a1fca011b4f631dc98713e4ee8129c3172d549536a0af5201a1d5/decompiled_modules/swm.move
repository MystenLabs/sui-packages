module 0x64db388ac31a1fca011b4f631dc98713e4ee8129c3172d549536a0af5201a1d5::swm {
    struct SWM has drop {
        dummy_field: bool,
    }

    fun init(arg0: SWM, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SWM>(arg0, 9, b"SWM", b"Swim", b"who says cats can't swim? lets prove them wrong", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/4d90c3cb-4f72-4f50-be71-d2306fef5e24.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SWM>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SWM>>(v1);
    }

    // decompiled from Move bytecode v6
}

