module 0x13bc1b2b005bbf650988d60f05f8f3192d8adc5bac15d719caf5527972547392::r {
    struct R has drop {
        dummy_field: bool,
    }

    fun init(arg0: R, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<R>(arg0, 9, b"R", b"RenGo ", b"For fun ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/7bee7840-1fe9-4d23-b5f2-d34dea322b1d.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<R>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<R>>(v1);
    }

    // decompiled from Move bytecode v6
}

