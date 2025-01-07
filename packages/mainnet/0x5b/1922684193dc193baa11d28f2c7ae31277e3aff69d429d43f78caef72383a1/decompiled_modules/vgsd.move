module 0x5b1922684193dc193baa11d28f2c7ae31277e3aff69d429d43f78caef72383a1::vgsd {
    struct VGSD has drop {
        dummy_field: bool,
    }

    fun init(arg0: VGSD, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<VGSD>(arg0, 9, b"VGSD", b"SD", b"B", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/85e7eaf2-830e-42c6-93b2-ba7c7051fc76.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<VGSD>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<VGSD>>(v1);
    }

    // decompiled from Move bytecode v6
}

