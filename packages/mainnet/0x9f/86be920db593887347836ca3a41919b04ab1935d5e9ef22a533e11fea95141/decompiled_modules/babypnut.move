module 0x9f86be920db593887347836ca3a41919b04ab1935d5e9ef22a533e11fea95141::babypnut {
    struct BABYPNUT has drop {
        dummy_field: bool,
    }

    fun init(arg0: BABYPNUT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BABYPNUT>(arg0, 6, b"BABYPNUT", b"Baby Pnut", b"Baby Pnut, the baby version of $PNUT.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/z9ys_Nw_XC_Yrh4x_X_Ry_QG_9uj_Wqx_Nrdc_Choico_JA_9ebd7i_F_42afa5bd41.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BABYPNUT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BABYPNUT>>(v1);
    }

    // decompiled from Move bytecode v6
}

