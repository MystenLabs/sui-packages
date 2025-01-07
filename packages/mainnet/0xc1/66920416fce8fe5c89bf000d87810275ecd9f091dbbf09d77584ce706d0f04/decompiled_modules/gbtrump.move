module 0xc166920416fce8fe5c89bf000d87810275ecd9f091dbbf09d77584ce706d0f04::gbtrump {
    struct GBTRUMP has drop {
        dummy_field: bool,
    }

    fun init(arg0: GBTRUMP, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<GBTRUMP>(arg0, 6, b"GBTRUMP", b"GoldenBoyTrump", x"54686520626f7920697320676f6c64656e212046726f6d20776869746520686f75736520746f20666564207261696473206261636b20746f2074686520776869746520686f7573652e20546865206361706974616c69737420706f7374657220626f79206f6620416d657269636120616e64206f7572203230323420707265736964656e7469616c2077696e6e65722e20446f6e616c642022676f6c64656e20626f7922205472756d700a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Qm_U_Fsj_Sq9or_Z7_Guw_ZQ_Sve_Nz5_Pp_H_Rc_A_Qr_Gb_Nabfgwig_AH_3_C_94f9041d26.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GBTRUMP>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<GBTRUMP>>(v1);
    }

    // decompiled from Move bytecode v6
}

