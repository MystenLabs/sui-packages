module 0x27b7bf42333237ae95282751f2e7c3cd372735af5628068916734c1962c04f33::hodl {
    struct HODL has drop {
        dummy_field: bool,
    }

    fun init(arg0: HODL, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<HODL>(arg0, 6, b"Hodl", b"Hodl 6900", b"Half orange drinking lemonade ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/DCDAB_70_F_201_B_44_EE_AE_48_ECF_9691_AB_24_F_03a1c818ef.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<HODL>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<HODL>>(v1);
    }

    // decompiled from Move bytecode v6
}

