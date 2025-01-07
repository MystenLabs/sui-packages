module 0x2823f245862e6a16565fbea3f843a61477f2dc2bc31cecd4efde680daaf1a474::bode {
    struct BODE has drop {
        dummy_field: bool,
    }

    fun init(arg0: BODE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BODE>(arg0, 6, b"BODE", b"Book Of Degenerates", x"54686520486f6c7920426f6f6b20466f722054686520446567656e6572617465732e204d6179207765206c6179207468696e6520666f756e646174696f6e20666f7220746865206e6f726d69657320746f20636f6d6574682e0a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Qmbg_Xf_Zf3myg1_Wj4_Z_Ra5_Uy_RZN_2_X_Ltn_Gbc_Ckuc9_Nefvu_AE_7_add4b5b9b6.jfif")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BODE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BODE>>(v1);
    }

    // decompiled from Move bytecode v6
}

