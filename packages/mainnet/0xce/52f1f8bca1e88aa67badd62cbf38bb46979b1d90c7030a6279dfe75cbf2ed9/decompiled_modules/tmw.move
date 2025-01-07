module 0xce52f1f8bca1e88aa67badd62cbf38bb46979b1d90c7030a6279dfe75cbf2ed9::tmw {
    struct TMW has drop {
        dummy_field: bool,
    }

    fun init(arg0: TMW, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TMW>(arg0, 6, b"TMW", b"Trump Must Win", x"446f6e616c64205472756d7020697320696e20686973203730732c20627574206865206973207374696c6c206669676874696e6720666f72206f75722066726565646f6d20616e64206120626574746572206c6966652e204c6574277320737570706f72742068696d2e5765206d7573742074727573742068696d2e0a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Qm_QAU_6_Yhh9_Nd_Tfi_SML_4_Hfw_Rd279_K_Qy_Tiuqem_G9qi2b_Js_RV_51bf473d13.jfif")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TMW>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<TMW>>(v1);
    }

    // decompiled from Move bytecode v6
}

