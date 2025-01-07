module 0x8630f43ba7f2769c706fa6c30416bfee36f0cc051093508b4703aac85e2de482::shiddy {
    struct SHIDDY has drop {
        dummy_field: bool,
    }

    fun init(arg0: SHIDDY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SHIDDY>(arg0, 6, b"SHIDDY", b"sLiM ShIdDy", x"20245348494444592069732068657265210a0a4e6f7420746865207265616c20536c696d2053686164792062757420646566696e6974656c7920746865207368696464696573742e202050756d70696e6720626164207268796d65732026206761696e73207374726169676874206f757474612074686520746f696c657421200a0a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Qm_Uvcz_S_Qm_Fw_Htb_K_Gd_G_Sagm_D_Tqz_Pr_T76b_FXC_6vp_T_Sk_D_Euqu_8827dc73b3.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SHIDDY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SHIDDY>>(v1);
    }

    // decompiled from Move bytecode v6
}

