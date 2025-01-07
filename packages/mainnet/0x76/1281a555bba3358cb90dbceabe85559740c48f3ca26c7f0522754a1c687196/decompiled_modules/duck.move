module 0x761281a555bba3358cb90dbceabe85559740c48f3ca26c7f0522754a1c687196::duck {
    struct DUCK has drop {
        dummy_field: bool,
    }

    fun init(arg0: DUCK, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DUCK>(arg0, 6, b"DUCK", b"duck", b"If it looks like a duck , swims like a duck , and quacks like a duck , then it probably is a duck.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Qmcfze_CJ_Pv_Xo_WR_1_Caj_Uq_P_Fey_H1cj_Xn96osh3q_AM_Nfv7_QH_3_475c5ab823.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DUCK>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<DUCK>>(v1);
    }

    // decompiled from Move bytecode v6
}

