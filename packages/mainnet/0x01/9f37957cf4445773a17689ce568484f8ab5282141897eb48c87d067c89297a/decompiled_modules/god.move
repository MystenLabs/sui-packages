module 0x19f37957cf4445773a17689ce568484f8ab5282141897eb48c87d067c89297a::god {
    struct GOD has drop {
        dummy_field: bool,
    }

    fun init(arg0: GOD, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<GOD>(arg0, 6, b"GOD", b"God", x"4f6e6520746f2072756c65207468656d20616c6c2e20546865206d6f737420474f444c5920746f6b656e0a0a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Qmaqe_Ssnx_V6_J_Sn_G5t_F5_Fa_T_Soku_Khx_BN_Xn_Bks_U_Zz_Ef1_LY_Lg_9681f11d2b.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GOD>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<GOD>>(v1);
    }

    // decompiled from Move bytecode v6
}

