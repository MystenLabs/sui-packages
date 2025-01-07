module 0x6d6ea191bac63280dbce4eba7f5cad140d6bdb05fbb3cbb1071ffa86a208c1a9::god {
    struct GOD has drop {
        dummy_field: bool,
    }

    fun init(arg0: GOD, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<GOD>(arg0, 6, b"GOD", b"God", b"One to rule them all. The most GODLY token", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Qmaqe_Ssnx_V6_J_Sn_G5t_F5_Fa_T_Soku_Khx_BN_Xn_Bks_U_Zz_Ef1_LY_Lg_3e9b31988d.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GOD>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<GOD>>(v1);
    }

    // decompiled from Move bytecode v6
}

