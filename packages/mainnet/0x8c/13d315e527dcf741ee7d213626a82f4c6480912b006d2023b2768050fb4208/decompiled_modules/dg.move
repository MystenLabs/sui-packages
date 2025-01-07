module 0x8c13d315e527dcf741ee7d213626a82f4c6480912b006d2023b2768050fb4208::dg {
    struct DG has drop {
        dummy_field: bool,
    }

    fun init(arg0: DG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DG>(arg0, 6, b"DG", b"DogFish", x"466972737420546f6b656e2077697468206e6f20736f6369616c206f6e2053554920436861696e0a446f67204669736820566972616c206f6e2054696b546f6b20776974682036374d207669657773", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Qmbk3_Ge_XATH_6t_Vu_Xst_H_Tv6aamg_JC_2_V_Rr6_BHK_5ur_Dp_Nw_Bdj_f0ce03dadd.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DG>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<DG>>(v1);
    }

    // decompiled from Move bytecode v6
}

