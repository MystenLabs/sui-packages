module 0x1eaabd3da73e4883552c3ce07e416d2bee4e9309c64f36692469ff5538226702::tpm {
    struct TPM has drop {
        dummy_field: bool,
    }

    fun init(arg0: TPM, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TPM>(arg0, 6, b"TPM", b"Tasty Puff the Marshmallow", b"Tasty Puff is a sweet loving marshmallow, but his intentions are a little darker than they appear. Tasty Puff has a history, and he does't want it to be known...", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Qmce_LGE_1re_A_Nvi_Re_Gmwj_JCE_Ys_Uid7tri_Kg_M_Cw_Hn_Ntn9_Mpi_dff67a6e94.jfif")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TPM>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<TPM>>(v1);
    }

    // decompiled from Move bytecode v6
}

