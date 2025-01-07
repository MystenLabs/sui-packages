module 0x6c1238bbd199222d9ad8652c603332427979fcb053d43bf6d1dedc1720972b0e::naker {
    struct NAKER has drop {
        dummy_field: bool,
    }

    fun init(arg0: NAKER, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<NAKER>(arg0, 6, b"NAKER", b"NAKER SUI", x"416e206f726967696e616c206d656d65636f696e2062656172696e6720697420616c6c206f6e2073756928616e64206265796f6e64292e0a0a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/jim_Bqij_Np9y_Zwg_Mmx_Fa_LE_Cr5r_Fyp_PGZQN_Eq_L9_YU_4_Uj_T_7616587c18.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<NAKER>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<NAKER>>(v1);
    }

    // decompiled from Move bytecode v6
}

