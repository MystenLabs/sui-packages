module 0xfdc6a9743dabb6e6699ce44d256c23a3d87d504e07ebbf8b1a2148446da238b2::pgt {
    struct PGT has drop {
        dummy_field: bool,
    }

    fun init(arg0: PGT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PGT>(arg0, 6, b"PGT", b"Pixel Goat Maximus", b"Pixel Goatseus Maximus", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Qm_Qe_DDZ_Kx_Xkko_DH_4i_FE_3s85qf_G14_RQK_7hj2z4jtyf_Ld5_ED_29b0b74a28.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PGT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<PGT>>(v1);
    }

    // decompiled from Move bytecode v6
}

