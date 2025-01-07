module 0xc861740582e71d0d6667ad8b05b4c8c7aedd43e28dec925e0c0719c76fdcad5b::WavecrestFin {
    struct WAVECRESTFIN has drop {
        dummy_field: bool,
    }

    fun init(arg0: WAVECRESTFIN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<WAVECRESTFIN>(arg0, 0, b"COS", b"Wavecrest Fin", b"For those who are gone too long.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://aurahma-canvas-test-bucket.s3.eu-west-3.amazonaws.com/cosmetic/Head_Wavecrest_Fin.png")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<WAVECRESTFIN>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<WAVECRESTFIN>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

