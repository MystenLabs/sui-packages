module 0xba3300eb5a7123e7336dec14dd438b7a123f659f928091f9ca6e90c30ffb43aa::armani {
    struct ARMANI has drop {
        dummy_field: bool,
    }

    fun init(arg0: ARMANI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ARMANI>(arg0, 6, b"ARMANI", b"Armani Dog", b"Armani Dog lives for luxury and commands respect wherever it goes on Sui.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/4_Ka7_Rcmh_K7_M_Xz_N17mt_H68_Rt_Br17_YB_Zm_Ec_WX_4m7_Lrpump_1fc4ac9e0f.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ARMANI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<ARMANI>>(v1);
    }

    // decompiled from Move bytecode v6
}

