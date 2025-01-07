module 0x680f7fb9e3fbf72ee24e4df0eec211c02e0d48cf643872b5bc6a283ebb7ea563::sdgfdg {
    struct SDGFDG has drop {
        dummy_field: bool,
    }

    fun init(arg0: SDGFDG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SDGFDG>(arg0, 9, b"SDGFDG", b"FDHFDH", b"SDFGH", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/e31c111a-3aab-42cf-9d3c-d48adce8d688.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SDGFDG>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SDGFDG>>(v1);
    }

    // decompiled from Move bytecode v6
}

