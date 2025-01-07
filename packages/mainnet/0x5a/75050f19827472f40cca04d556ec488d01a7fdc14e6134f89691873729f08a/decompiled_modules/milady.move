module 0x5a75050f19827472f40cca04d556ec488d01a7fdc14e6134f89691873729f08a::milady {
    struct MILADY has drop {
        dummy_field: bool,
    }

    fun init(arg0: MILADY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MILADY>(arg0, 6, b"Milady", b"Mascot of Autistic Psycho", b"Mascot of Autistic Psycho.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Qm_Uj_ZF_Yzk6_PU_54_Qmw_N6tw6_P_Kbj_Yv41t_Uat_Lxfd_Wj6c_K5pa_1_30407ca62b.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MILADY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<MILADY>>(v1);
    }

    // decompiled from Move bytecode v6
}

