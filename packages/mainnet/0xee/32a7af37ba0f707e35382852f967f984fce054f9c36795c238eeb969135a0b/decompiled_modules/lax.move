module 0xee32a7af37ba0f707e35382852f967f984fce054f9c36795c238eeb969135a0b::lax {
    struct LAX has drop {
        dummy_field: bool,
    }

    fun init(arg0: LAX, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<LAX>(arg0, 6, b"LAX", b"Lax", x"53616c6d6f6e20284c6178546f656e29204e6f7277656769616e202073616c6d6f6e20697320746865206265737420696e2074686520776f726c642e205a696e7a696e6f2047726f757020686173206f7665722061206d696c6c696f6e206d656d626572732061726f756e642074686520776f726c6420747279696e672069742e2054686520626573742065636f6c6f676963616c20656e7669726f6e6d656e7420696e204e6f72746865726e204575726f7065206272656564732074686520626573742073616c6d6f6e20696e2074686520776f726c642e0a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Qm_T_Navaa6_P2d_ZVDBR_1f_R6x_Jxw5_Jpn_Stc_N1r_U87z_Bdz_KVEL_81190dc839.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<LAX>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<LAX>>(v1);
    }

    // decompiled from Move bytecode v6
}

