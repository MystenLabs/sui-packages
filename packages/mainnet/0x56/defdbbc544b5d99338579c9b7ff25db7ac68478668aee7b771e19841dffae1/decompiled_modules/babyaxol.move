module 0x56defdbbc544b5d99338579c9b7ff25db7ac68478668aee7b771e19841dffae1::babyaxol {
    struct BABYAXOL has drop {
        dummy_field: bool,
    }

    fun init(arg0: BABYAXOL, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BABYAXOL>(arg0, 6, b"BabyAXOL", b"BabyAxol", x"437574652c2067696c6c65642c20616e6420726561647920746f206368696c6c21202441584f4c206272696e67732061786f6c6f746c206d6167696320746f2074686520626c6f636b636861696e20616e64206a6f696e73207468652063757465737420746f6b656e207265766f6c7574696f6e2065766572210a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Qm_Uotgv6k_D_Kmv2_DQTWD_3_Z_Karvdon_YVYYXP_Rgbxba_Uv1_F_Re_1_1_1_3841334cf2_5ed416f4f2.gif")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BABYAXOL>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BABYAXOL>>(v1);
    }

    // decompiled from Move bytecode v6
}

