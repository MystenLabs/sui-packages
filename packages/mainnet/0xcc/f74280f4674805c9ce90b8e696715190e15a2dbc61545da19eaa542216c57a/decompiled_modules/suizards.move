module 0xccf74280f4674805c9ce90b8e696715190e15a2dbc61545da19eaa542216c57a::suizards {
    struct SUIZARDS has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIZARDS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIZARDS>(arg0, 6, b"SUIZARDS", b"Suizards Bros", b"The wizards bros on sui", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/s_T_Ba_B_Co_Rjy_Yj3_Bm_I2_N5k0_Fz_BN_1_Y_1_c8eb9b4c17.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIZARDS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUIZARDS>>(v1);
    }

    // decompiled from Move bytecode v6
}

