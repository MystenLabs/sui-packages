module 0x85db8613ec0b925b2f12246e80de7d39dd1c4a9bb599ec722d32c34e1666e294::adfgdfggd {
    struct ADFGDFGGD has drop {
        dummy_field: bool,
    }

    fun init(arg0: ADFGDFGGD, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ADFGDFGGD>(arg0, 9, b"ADFGDFGGD", b"fhfgh", b"fgdgf", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/0f34d810-a70e-4a25-9953-07ddd12406c2.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ADFGDFGGD>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<ADFGDFGGD>>(v1);
    }

    // decompiled from Move bytecode v6
}

