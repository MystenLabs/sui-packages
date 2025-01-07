module 0xd236e15b24518f39de390eb7a2f9c6911208a809f3f8c5c6c4de707094f64c2b::catie {
    struct CATIE has drop {
        dummy_field: bool,
    }

    fun init(arg0: CATIE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CATIE>(arg0, 9, b"CATIE", b"Catbull", b"Seasonal cat", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/870e1f5d-5d9e-4371-b942-f9047d0b7cb1.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CATIE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<CATIE>>(v1);
    }

    // decompiled from Move bytecode v6
}

