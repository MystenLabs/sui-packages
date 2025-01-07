module 0x17bd9b7b3db5bd038fbae5727cd78f41253a729a9a3ffaeca4eb689d99f4a637::xgift {
    struct XGIFT has drop {
        dummy_field: bool,
    }

    fun init(arg0: XGIFT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<XGIFT>(arg0, 6, b"XGIFT", b"X change Gift", x"58474946543a20456c756e204d75736b6b20676976205472656d70206120626f78207361792022726f636b657420706172742c222062757420697473206a75732062616e616e61207065656c2e205472616d702067697620456c756e206120676f6c64656e204d41474120636f696e206275742069742063686f636c617465207772617020696e20666f696c2e20426f7468206c617567682c20736179202262657374206769667420747261642065766572210a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Qmbs_R99d_WGQ_Qn_U_Wk3hq_CXW_Wbj_SR_Px_LXAP_4e_C8dy_Lg5_Dfy_D_6266e947af.gif")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<XGIFT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<XGIFT>>(v1);
    }

    // decompiled from Move bytecode v6
}

