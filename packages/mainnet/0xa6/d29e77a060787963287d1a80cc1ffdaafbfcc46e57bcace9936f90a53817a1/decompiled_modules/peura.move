module 0xa6d29e77a060787963287d1a80cc1ffdaafbfcc46e57bcace9936f90a53817a1::peura {
    struct PEURA has drop {
        dummy_field: bool,
    }

    fun init(arg0: PEURA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PEURA>(arg0, 6, b"PEURA", b"Peura", b"This Xmas, Santa is out, and I am in. Gotta save Xmas and drop gifts straight to the $PEURA fam. 1000Xmas PEURA rich, a full-blown billionaire after stacking Santa wealth. TO THE AURORA LIGHTS IS THE TARGET", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Qm_Qrrug_Qh_KC_Fz_Tv_TX_Kjj_X_Wy_P_Vu92d_Q4o_C_Tt_V5ftt_Lr_Vp48_75670cb145.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PEURA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<PEURA>>(v1);
    }

    // decompiled from Move bytecode v6
}

