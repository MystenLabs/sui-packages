module 0xdb975ed9e2ad558c0478ac374571770a7cf902af2d480e91549f20917a9aeb58::leon {
    struct LEON has drop {
        dummy_field: bool,
    }

    fun init(arg0: LEON, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<LEON>(arg0, 6, b"Leon", b"Leon the sea lion", x"416e20656e64616e6765726564204175737472616c69616e20536561206c696f6e204c656f6e0a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Qm_XV_Es_Djfp_Mn_Ls_QD_Ra_WS_Yfg_Eoat_Hse_Vs5_Hd_JN_9q_U_Bz_G_Caf_76693d6385.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<LEON>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<LEON>>(v1);
    }

    // decompiled from Move bytecode v6
}

