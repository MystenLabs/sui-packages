module 0x528dffbb140c9e5e133e6611f6f9b7e92efa3df8c78724d34bcc686a6e39947f::gm {
    struct GM has drop {
        dummy_field: bool,
    }

    fun init(arg0: GM, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<GM>(arg0, 6, b"GM", b"GROKIUS MAXIMUS", b"https://x.com/alx/status/1891680734932267517", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Qm_W7gk_Zec_Cvwg_U_Xv_R1_W_Cvz_Du_U_Ktx7_TQ_7w_N_Maf_Ho9_Md_X3_WH_4aff04ae22.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GM>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<GM>>(v1);
    }

    // decompiled from Move bytecode v6
}

