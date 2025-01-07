module 0x6b262646b9e145a50d1a8c1d3ed3bb199cef44ae33a230407508ba6f9ab9f1a6::irs {
    struct IRS has drop {
        dummy_field: bool,
    }

    fun init(arg0: IRS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<IRS>(arg0, 6, b"IRS", b"iridescent rabbit shark", x"4f4d204e4f4d204e4f4d200a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Qmd_M3_By_L8t_Jr_Wpk_Gx_A_Fsqyo_Fy_W_Ay4_S3_Tue_Uo_Zr_C3_SV_Steq_ef14ffdf15.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<IRS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<IRS>>(v1);
    }

    // decompiled from Move bytecode v6
}

