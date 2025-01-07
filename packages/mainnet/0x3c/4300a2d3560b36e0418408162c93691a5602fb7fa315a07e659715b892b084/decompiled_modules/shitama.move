module 0x3c4300a2d3560b36e0418408162c93691a5602fb7fa315a07e659715b892b084::shitama {
    struct SHITAMA has drop {
        dummy_field: bool,
    }

    fun init(arg0: SHITAMA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SHITAMA>(arg0, 6, b"SHITAMA", b"Sui Punch Man", b"Meet Sui Punch Man. $SHITAMA. That one Punch.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/GEJB_Dpevef_DW_Vzy_H_Uzmebpiqr_Hw_Fehy5hq_T_Db_VGCL_7b_E_656980c9d3.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SHITAMA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SHITAMA>>(v1);
    }

    // decompiled from Move bytecode v6
}

