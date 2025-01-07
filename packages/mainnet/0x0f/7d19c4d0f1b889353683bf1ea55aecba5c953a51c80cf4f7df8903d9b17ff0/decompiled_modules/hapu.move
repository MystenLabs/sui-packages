module 0xf7d19c4d0f1b889353683bf1ea55aecba5c953a51c80cf4f7df8903d9b17ff0::hapu {
    struct HAPU has drop {
        dummy_field: bool,
    }

    fun init(arg0: HAPU, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<HAPU>(arg0, 9, b"HAPU", b"voiu", b"Hapu is my live", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/75e1085c-53a9-43ad-9e75-7f751b29a356.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<HAPU>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<HAPU>>(v1);
    }

    // decompiled from Move bytecode v6
}

