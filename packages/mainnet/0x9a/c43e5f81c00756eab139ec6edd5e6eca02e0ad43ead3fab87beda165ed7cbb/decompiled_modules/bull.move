module 0x9ac43e5f81c00756eab139ec6edd5e6eca02e0ad43ead3fab87beda165ed7cbb::bull {
    struct BULL has drop {
        dummy_field: bool,
    }

    fun init(arg0: BULL, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BULL>(arg0, 9, b"BULL", b"Bullist", b"We are need bullist market", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/3a598a0e-8609-4ff0-97b6-4d4bbe242ee2-a1975-512.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BULL>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<BULL>>(v1);
    }

    // decompiled from Move bytecode v6
}

