module 0x7c21f451d69969224f5004e78f73a135398fbb17a8f1bfaf1a3720ba36a8bc7b::muma {
    struct MUMA has drop {
        dummy_field: bool,
    }

    fun init(arg0: MUMA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MUMA>(arg0, 6, b"MUMA", b"MUMA ON SUI", b"got MUMA?", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Qm_SYU_Wr_Ezg7xkk_Lw9_N5u_Nfhg_Tg_M6_Qa5_BT_5dz3_Xif_Nt_W16_E_050654710e.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MUMA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<MUMA>>(v1);
    }

    // decompiled from Move bytecode v6
}

