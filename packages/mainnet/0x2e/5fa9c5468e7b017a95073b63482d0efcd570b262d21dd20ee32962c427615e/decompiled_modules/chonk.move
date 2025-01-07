module 0x2e5fa9c5468e7b017a95073b63482d0efcd570b262d21dd20ee32962c427615e::chonk {
    struct CHONK has drop {
        dummy_field: bool,
    }

    fun init(arg0: CHONK, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CHONK>(arg0, 6, b"CHONK", b"CHAD CHONK", x"43484f4e4b20495320544845204348414420544841542057454e54204d41442024484f4e4b204f4e204554482057494c4c20474f20544f2042494c4c494f4e532121210a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Qmc_GV_Un_M_Kj9_D_Rpw_N_Nq_Brbrejf4s_Kh62_Cm4v_Uy_B_Lj_Cr5t_Na_232bf883f0.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CHONK>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<CHONK>>(v1);
    }

    // decompiled from Move bytecode v6
}

