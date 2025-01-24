module 0xf0ec9e4159cce29e63de7cfebdd29966145ce007d2c104bce3b5050e2c36a2ab::elon {
    struct ELON has drop {
        dummy_field: bool,
    }

    fun init(arg0: ELON, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ELON>(arg0, 6, b"Elon", b"Official Elon Token", b"Elon comes on SUI", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Qm_Xgt6_TE_Gac8_Mx8_EKKYR_9mjj_J_Lmvd9_BB_Vdy_RY_Jzw3kk3mu_97bf3841be.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ELON>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<ELON>>(v1);
    }

    // decompiled from Move bytecode v6
}

