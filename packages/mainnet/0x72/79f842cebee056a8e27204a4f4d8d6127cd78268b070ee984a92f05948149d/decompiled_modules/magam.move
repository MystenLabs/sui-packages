module 0x7279f842cebee056a8e27204a4f4d8d6127cd78268b070ee984a92f05948149d::magam {
    struct MAGAM has drop {
        dummy_field: bool,
    }

    fun init(arg0: MAGAM, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MAGAM>(arg0, 6, b"MAGAM", b"MAGA Magnet", b"Even magnet knows who's the right one. MAKE AMERICA GREAT AGAIN!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Qm_Uqq_Pdhes_GJ_Vj_Kd_V9_Et_T371_Aru3_MW_8o_C6_Xu7f_Hw_J43p5c_2c86949099.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MAGAM>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<MAGAM>>(v1);
    }

    // decompiled from Move bytecode v6
}

