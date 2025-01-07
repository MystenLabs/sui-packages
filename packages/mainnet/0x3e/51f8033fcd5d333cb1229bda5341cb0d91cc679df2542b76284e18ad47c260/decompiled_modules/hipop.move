module 0x3e51f8033fcd5d333cb1229bda5341cb0d91cc679df2542b76284e18ad47c260::hipop {
    struct HIPOP has drop {
        dummy_field: bool,
    }

    fun init(arg0: HIPOP, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<HIPOP>(arg0, 6, b"HIPOP", b"HIPPOPOP", b"IT'S A BIRD , IT'S A PLANE , IT'S HIPPOPOP !", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/N_C_create_a_hippopotam_as_a_lollypop_realistic_mak_0d8c97bd_676a_45cc_bd76_9fdd47ea4669_04e4f5e5aa.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<HIPOP>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<HIPOP>>(v1);
    }

    // decompiled from Move bytecode v6
}

