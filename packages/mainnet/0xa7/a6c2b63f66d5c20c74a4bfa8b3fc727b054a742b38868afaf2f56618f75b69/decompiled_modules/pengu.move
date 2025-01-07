module 0xa7a6c2b63f66d5c20c74a4bfa8b3fc727b054a742b38868afaf2f56618f75b69::pengu {
    struct PENGU has drop {
        dummy_field: bool,
    }

    fun init(arg0: PENGU, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PENGU>(arg0, 6, b"PENGU", b"Pengu Penguins", b"A Quirky Fusion of Pixels and Penguinity. $Pengu", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Qm_W6222z_Ktk_DZ_Lfy1p_S_Yf_Br_F9_No5y2ra_L3wx4id6_Sk_PX_Ls_637b078ddd.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PENGU>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<PENGU>>(v1);
    }

    // decompiled from Move bytecode v6
}

