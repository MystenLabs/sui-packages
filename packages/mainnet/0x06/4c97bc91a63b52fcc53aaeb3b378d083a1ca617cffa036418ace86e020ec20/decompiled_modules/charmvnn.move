module 0x64c97bc91a63b52fcc53aaeb3b378d083a1ca617cffa036418ace86e020ec20::charmvnn {
    struct CHARMVNN has drop {
        dummy_field: bool,
    }

    fun init(arg0: CHARMVNN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CHARMVNN>(arg0, 9, b"CHARMVNN", b"CHARMVN", b"For fun token", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/3efd5654-391e-4377-a7be-21b19f414be2.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CHARMVNN>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<CHARMVNN>>(v1);
    }

    // decompiled from Move bytecode v6
}

