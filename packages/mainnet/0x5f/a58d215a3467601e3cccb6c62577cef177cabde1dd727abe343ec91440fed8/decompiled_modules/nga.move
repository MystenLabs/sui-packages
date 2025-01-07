module 0x5fa58d215a3467601e3cccb6c62577cef177cabde1dd727abe343ec91440fed8::nga {
    struct NGA has drop {
        dummy_field: bool,
    }

    fun init(arg0: NGA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<NGA>(arg0, 9, b"NGA", b"ngami", b"NGAMI", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/50ec1f13-6ea2-479e-8ab2-53e925d91dac.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<NGA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<NGA>>(v1);
    }

    // decompiled from Move bytecode v6
}

