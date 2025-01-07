module 0x9b5d8af895a65b316b5eedae1512d429308cd7b3776b229a4692fe9152f85ffc::hal {
    struct HAL has drop {
        dummy_field: bool,
    }

    fun init(arg0: HAL, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<HAL>(arg0, 9, b"HAL", b"Halima", b"Haltoken", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/2ab5883b-939d-450d-9b1d-09d7feff9ace.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<HAL>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<HAL>>(v1);
    }

    // decompiled from Move bytecode v6
}

