module 0x80ebdc68a27a4e1b9307241c969ea7d5ad898066697e4296e5359e6975b841cc::coby {
    struct COBY has drop {
        dummy_field: bool,
    }

    fun init(arg0: COBY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<COBY>(arg0, 6, b"COBY", b"COBY ON SUI", b"Once you're in the cult - $COBY becomes your best friend forever", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/8_Wn_QQ_Rbu_EZ_3_CC_Db_H5_MC_Vio_Bbw6o75_NKA_Nq9_Wd_Ph_B_Ds_Wo_58714c95de.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<COBY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<COBY>>(v1);
    }

    // decompiled from Move bytecode v6
}

