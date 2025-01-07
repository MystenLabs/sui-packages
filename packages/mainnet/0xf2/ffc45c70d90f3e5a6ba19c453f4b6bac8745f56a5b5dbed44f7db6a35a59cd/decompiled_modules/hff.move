module 0xf2ffc45c70d90f3e5a6ba19c453f4b6bac8745f56a5b5dbed44f7db6a35a59cd::hff {
    struct HFF has drop {
        dummy_field: bool,
    }

    fun init(arg0: HFF, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<HFF>(arg0, 9, b"HFF", b"FEW", b"Goku is a good ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/afabd25e-cb2e-4c63-b8ea-36600ca67dba.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<HFF>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<HFF>>(v1);
    }

    // decompiled from Move bytecode v6
}

