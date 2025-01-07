module 0x834a5fc9bafa72794b8c240c1775f432057806114c82741474169f5a81ffcc27::kpepe {
    struct KPEPE has drop {
        dummy_field: bool,
    }

    fun init(arg0: KPEPE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<KPEPE>(arg0, 6, b"KPEPE", b"Kpepe", b"Hey  And Welcome to Krazy Pepe it's a community Driven coin now dev is out team wanting to push this lock in let's make dev Regret his actions FOMO krazy Pepe", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Qmb_T5av_Kys3hn_Lqeihm_Snaf_Fr_Jz_MZ_Kq_BPP_Vdz95x83b_Jgp_132a20afed.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<KPEPE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<KPEPE>>(v1);
    }

    // decompiled from Move bytecode v6
}

