module 0x2d88bcb81639fc3c00285bf2cfd6d1b0031d888a4066a8096144b31fb5825730::aras {
    struct ARAS has drop {
        dummy_field: bool,
    }

    fun init(arg0: ARAS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ARAS>(arg0, 9, b"ARAS", b"Arastoo", b"IRAN", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/45171697-4bc7-4c33-b476-167dec6fe66f.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ARAS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<ARAS>>(v1);
    }

    // decompiled from Move bytecode v6
}

