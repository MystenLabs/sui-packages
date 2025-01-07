module 0xd510710b4564d2d3886cc0282106c3e48f7fe2fe1cd2c6dd1df067100394054a::noot {
    struct NOOT has drop {
        dummy_field: bool,
    }

    fun init(arg0: NOOT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<NOOT>(arg0, 6, b"NOOT", b"NOOT ON SUI", b"THE REAL NOOT ON SUI", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/8_V4_Rt_PR_Hd_Aju_SE_5c_Pij_Yo_An_TE_Uk3_NH_Jp3_Rox_C_Cqppump_7_a91504c226_56500121dc.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<NOOT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<NOOT>>(v1);
    }

    // decompiled from Move bytecode v6
}

