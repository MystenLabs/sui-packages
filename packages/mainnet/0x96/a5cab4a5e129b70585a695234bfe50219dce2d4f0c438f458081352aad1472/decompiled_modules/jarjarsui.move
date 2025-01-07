module 0x96a5cab4a5e129b70585a695234bfe50219dce2d4f0c438f458081352aad1472::jarjarsui {
    struct JARJARSUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: JARJARSUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<JARJARSUI>(arg0, 6, b"JARJARSUI", b"JARJAR ET", b"JARJAR ARRIVED AT MOVEPUMP NOW", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/imagem_2024_10_12_035421221_c09a28dddc.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<JARJARSUI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<JARJARSUI>>(v1);
    }

    // decompiled from Move bytecode v6
}

