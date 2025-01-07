module 0xa1e7e83a7a5d6f32a287361fd157501b0133b56076952154e7d5a8ae08bbb331::hhippo {
    struct HHIPPO has drop {
        dummy_field: bool,
    }

    fun init(arg0: HHIPPO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<HHIPPO>(arg0, 6, b"Hhippo", b"Horror Hippo", b"Horror Hippos", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/G_Zjn_Z8_U_Wc_Ag23n_P_0844bae335_0e3367977e.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<HHIPPO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<HHIPPO>>(v1);
    }

    // decompiled from Move bytecode v6
}

