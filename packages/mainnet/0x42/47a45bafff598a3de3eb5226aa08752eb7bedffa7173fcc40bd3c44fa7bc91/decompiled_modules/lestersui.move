module 0x4247a45bafff598a3de3eb5226aa08752eb7bedffa7173fcc40bd3c44fa7bc91::lestersui {
    struct LESTERSUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: LESTERSUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<LESTERSUI>(arg0, 9, b"LESTERSUI", b"LESTER", b"Lester token on SUI chain", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/131c8e4c-ce1e-4f52-baca-979785c1abff.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<LESTERSUI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<LESTERSUI>>(v1);
    }

    // decompiled from Move bytecode v6
}

