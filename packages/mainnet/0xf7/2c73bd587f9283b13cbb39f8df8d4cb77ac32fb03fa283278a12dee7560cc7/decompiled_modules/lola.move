module 0xf72c73bd587f9283b13cbb39f8df8d4cb77ac32fb03fa283278a12dee7560cc7::lola {
    struct LOLA has drop {
        dummy_field: bool,
    }

    fun init(arg0: LOLA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<LOLA>(arg0, 9, b"LOLA", b"lomen", b"adsff", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/f2a54f67-a63f-47eb-985e-507fe3e49234.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<LOLA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<LOLA>>(v1);
    }

    // decompiled from Move bytecode v6
}

