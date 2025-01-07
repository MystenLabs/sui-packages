module 0xb028b555793021043b99899d159528ac0497b297d294ef1e3990237b615ab1da::subrett {
    struct SUBRETT has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUBRETT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUBRETT>(arg0, 6, b"SuBrett", b"brett but he in sui", b"brett but he came to sui because base is ass cheeks", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/B8_D52974_4_C1_F_46_CE_A179_E6_A2234_DCCB_2_835f3ae67b.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUBRETT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUBRETT>>(v1);
    }

    // decompiled from Move bytecode v6
}

