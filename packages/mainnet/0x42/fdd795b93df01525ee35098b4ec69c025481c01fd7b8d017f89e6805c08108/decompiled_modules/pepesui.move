module 0x42fdd795b93df01525ee35098b4ec69c025481c01fd7b8d017f89e6805c08108::pepesui {
    struct PEPESUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: PEPESUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PEPESUI>(arg0, 9, b"PEPESUI", b"Pepe", b"Pepe on sui", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/a3b93a35-fb62-4dde-96b9-eac7e540e7a5.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PEPESUI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<PEPESUI>>(v1);
    }

    // decompiled from Move bytecode v6
}

