module 0x5c28a957a035757ccbe41d9c9094ee7dd3aabe7b2287419a60ef7b8b72bb5c2b::jennie {
    struct JENNIE has drop {
        dummy_field: bool,
    }

    fun init(arg0: JENNIE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<JENNIE>(arg0, 6, b"JENNIE", b"First Realistic AI Dog", b"Jennie is the world's most realistic robotic emotional support animal", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Qmci_G2c4_K4r4n4n_Z8b_B_Gh_Vb_W4_T_Bb8_Yk_Gg_Zwh_Czg_Usg_G_Pr_H_8a4334850b.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<JENNIE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<JENNIE>>(v1);
    }

    // decompiled from Move bytecode v6
}

