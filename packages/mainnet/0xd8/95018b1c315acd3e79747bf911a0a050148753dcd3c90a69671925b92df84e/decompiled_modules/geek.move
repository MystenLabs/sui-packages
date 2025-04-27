module 0xd895018b1c315acd3e79747bf911a0a050148753dcd3c90a69671925b92df84e::geek {
    struct GEEK has drop {
        dummy_field: bool,
    }

    fun init(arg0: GEEK, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<GEEK>(arg0, 6, b"GEEK", b"Geek of Sui", x"4a757374206765656b696e672074686520537569204e6574776f726b203a290a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/5a_WN_3_FF_Dz_D_Uk_Y9k_F_Ds_UQ_Qp_Wa67v2uhzrk_Xr_Q9_Qvfpump_472a6aa89d.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GEEK>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<GEEK>>(v1);
    }

    // decompiled from Move bytecode v6
}

