module 0x10328e53690216ddc4576ed9a4c687f851a742a52195b6c3778f6424b2abff9e::rino {
    struct RINO has drop {
        dummy_field: bool,
    }

    fun init(arg0: RINO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<RINO>(arg0, 6, b"RINO", b"Rino", b"For those seeking a hero in the meme coin space, $RINO stands ready with courage to lead towards a brighter future for meme coin investors.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Qm_Qwygmki_Z_Hwvph4_V9qt3_Bn_G_Gd_Zi_Xi_L_Xf_J_Lw8wc_Ejm_SVGX_ca9f2dbc65.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<RINO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<RINO>>(v1);
    }

    // decompiled from Move bytecode v6
}

