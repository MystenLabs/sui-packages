module 0x3267351b9d3443a7921dcf29bff4f90f7769cb5c96bc0ac237c08bb8e7be423c::babymiggles {
    struct BABYMIGGLES has drop {
        dummy_field: bool,
    }

    fun init(arg0: BABYMIGGLES, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BABYMIGGLES>(arg0, 6, b"BABYMIGGLES", b"Baby Miggles", b"The Baby of Mister Miggles has been corner and will follow the same step. ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Qm_Xs_Qp_Nc7_M_Ny_Snpt_N_Qrns_Nv_KNASCD_3_QR_Vfs61svz_BQMM_Uz_9181cca9f5.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BABYMIGGLES>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BABYMIGGLES>>(v1);
    }

    // decompiled from Move bytecode v6
}

