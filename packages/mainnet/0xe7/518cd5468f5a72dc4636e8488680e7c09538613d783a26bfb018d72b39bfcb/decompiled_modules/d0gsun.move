module 0xe7518cd5468f5a72dc4636e8488680e7c09538613d783a26bfb018d72b39bfcb::d0gsun {
    struct D0GSUN has drop {
        dummy_field: bool,
    }

    fun init(arg0: D0GSUN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<D0GSUN>(arg0, 6, b"D0GSUN", b"Dogsun", b"DOGSUN ON MOVEPUMP", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Qm_Pvug9f4v_W_Yd5_Ap8zs_Nnt_D1z_B_Xh_V57bwy_X_Qz_Pguhbjksn_4d56fbdeef.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<D0GSUN>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<D0GSUN>>(v1);
    }

    // decompiled from Move bytecode v6
}

