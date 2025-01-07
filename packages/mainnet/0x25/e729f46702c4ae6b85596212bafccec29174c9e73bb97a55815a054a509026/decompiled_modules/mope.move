module 0x25e729f46702c4ae6b85596212bafccec29174c9e73bb97a55815a054a509026::mope {
    struct MOPE has drop {
        dummy_field: bool,
    }

    fun init(arg0: MOPE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MOPE>(arg0, 6, b"MOPE", b"Mope SUI", b"Have hope in Mope", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/7_CA_Egfbz_J_Xj9_Mo6_D9k_R_Yxi_JR_Xa_SV_Pyh_UQW_9_BJ_6cbpump_148d8c42d4.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MOPE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<MOPE>>(v1);
    }

    // decompiled from Move bytecode v6
}

