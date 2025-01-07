module 0x6fa7ff8d95d18b44419567ac1cd6cc7a5959dd69078213cbddb145a0243a0a8c::dose {
    struct DOSE has drop {
        dummy_field: bool,
    }

    fun init(arg0: DOSE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DOSE>(arg0, 6, b"DOSE", b"DOG BUT BLUE SUI", b"JUST DOG BUT BLUE", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/group_3_5_Y4_LJM_2vrg_Pf_Gq_P2_V_7bdb35b2ca.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DOSE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<DOSE>>(v1);
    }

    // decompiled from Move bytecode v6
}

