module 0x6181e9f8c1037aef491a805528e794c8298ec2413bb9499f90c30a31c792e28b::babyshark {
    struct BABYSHARK has drop {
        dummy_field: bool,
    }

    fun init(arg0: BABYSHARK, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BABYSHARK>(arg0, 6, b"BabyShark", b"BabyShark on sui", b"Doo Doo Doo Doo Doo Doo", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Qmefr_Azs_JGV_5c_ZZ_Ksa_BES_Nt_Kw_YL_Kb_BE_5a_NT_Ep99w6i_Ffy3_5d141880d4.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BABYSHARK>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BABYSHARK>>(v1);
    }

    // decompiled from Move bytecode v6
}

