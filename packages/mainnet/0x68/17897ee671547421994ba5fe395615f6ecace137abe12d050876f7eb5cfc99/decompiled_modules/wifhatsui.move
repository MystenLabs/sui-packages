module 0x6817897ee671547421994ba5fe395615f6ecace137abe12d050876f7eb5cfc99::wifhatsui {
    struct WIFHATSUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: WIFHATSUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<WIFHATSUI>(arg0, 9, b"WIFHATSUI", b"Wif", b"Wif Hat on SUI", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/a1bcdd0b-efc6-4a59-b16e-e4e79ebac5c6.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<WIFHATSUI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<WIFHATSUI>>(v1);
    }

    // decompiled from Move bytecode v6
}

