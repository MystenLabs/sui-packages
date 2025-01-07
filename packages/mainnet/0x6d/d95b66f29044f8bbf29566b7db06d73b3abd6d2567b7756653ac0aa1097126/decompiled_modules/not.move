module 0x6dd95b66f29044f8bbf29566b7db06d73b3abd6d2567b7756653ac0aa1097126::not {
    struct NOT has drop {
        dummy_field: bool,
    }

    fun init(arg0: NOT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<NOT>(arg0, 6, b"NOT", b"Not On Sui", b"The one and only penguin on sui", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/8_V4_Rt_PR_Hd_Aju_SE_5c_Pij_Yo_An_TE_Uk3_NH_Jp3_Rox_C_Cqppump_5_13af352030.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<NOT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<NOT>>(v1);
    }

    // decompiled from Move bytecode v6
}

