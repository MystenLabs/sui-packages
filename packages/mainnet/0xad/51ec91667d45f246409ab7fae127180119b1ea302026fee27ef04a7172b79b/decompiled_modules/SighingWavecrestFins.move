module 0xad51ec91667d45f246409ab7fae127180119b1ea302026fee27ef04a7172b79b::SighingWavecrestFins {
    struct SIGHINGWAVECRESTFINS has drop {
        dummy_field: bool,
    }

    fun init(arg0: SIGHINGWAVECRESTFINS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SIGHINGWAVECRESTFINS>(arg0, 0, b"COS", b"Sighing Wavecrest Fins", b"Ridged with dust from the clouds.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://aurahma-canvas-test-bucket.s3.eu-west-3.amazonaws.com/cosmetic/Head_Sighing_Wavecrest_Fins.png")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SIGHINGWAVECRESTFINS>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SIGHINGWAVECRESTFINS>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

