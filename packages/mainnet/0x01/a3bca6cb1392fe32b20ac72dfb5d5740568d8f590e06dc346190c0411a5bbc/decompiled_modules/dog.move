module 0x1a3bca6cb1392fe32b20ac72dfb5d5740568d8f590e06dc346190c0411a5bbc::dog {
    struct DOG has drop {
        dummy_field: bool,
    }

    fun init(arg0: DOG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DOG>(arg0, 6, b"DOG", b"+_+ dog", b"+_+", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Qmcw_E_Cx_Kg_AB_Aj_Cqv_C9ukdn1_Lhn_Sy_BL_8_Tvc_NM_Ws7_E4u2a_M4_d90f2f4ff2.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DOG>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<DOG>>(v1);
    }

    // decompiled from Move bytecode v6
}

