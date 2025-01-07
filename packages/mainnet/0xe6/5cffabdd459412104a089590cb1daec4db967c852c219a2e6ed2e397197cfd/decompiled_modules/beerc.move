module 0xe65cffabdd459412104a089590cb1daec4db967c852c219a2e6ed2e397197cfd::beerc {
    struct BEERC has drop {
        dummy_field: bool,
    }

    fun init(arg0: BEERC, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BEERC>(arg0, 9, b"BEERC", b"BeerCoin", b"Nice nice beer", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/76ee163c-4469-4c03-90bc-a2001b374d2f.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BEERC>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<BEERC>>(v1);
    }

    // decompiled from Move bytecode v6
}

