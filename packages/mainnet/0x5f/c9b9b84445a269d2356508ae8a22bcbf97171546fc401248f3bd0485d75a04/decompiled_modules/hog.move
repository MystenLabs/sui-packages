module 0x5fc9b9b84445a269d2356508ae8a22bcbf97171546fc401248f3bd0485d75a04::hog {
    struct HOG has drop {
        dummy_field: bool,
    }

    fun init(arg0: HOG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<HOG>(arg0, 6, b"HOG", b"Heart of Gold", b"The Book influenced him so much that the first Starship to go to Mars will be called \"Heart of Gold\"!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Qmc_Tp12j_Rb_Eg_Hy_HPD_5rwx_L_Sy_LVR_1p8o_KU_43_S5aro_Hc_SLKV_9fc3f51a5c.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<HOG>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<HOG>>(v1);
    }

    // decompiled from Move bytecode v6
}

