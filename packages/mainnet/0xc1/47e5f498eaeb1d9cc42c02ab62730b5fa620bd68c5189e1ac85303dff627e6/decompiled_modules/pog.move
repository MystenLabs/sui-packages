module 0xc147e5f498eaeb1d9cc42c02ab62730b5fa620bd68c5189e1ac85303dff627e6::pog {
    struct POG has drop {
        dummy_field: bool,
    }

    fun init(arg0: POG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<POG>(arg0, 6, b"POG", b"Pog", b"Pog the frog ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Qmb_Wdk8zhi_Ssu73_Rhxc_R_Lx_MCWGNB_8y_RKRU_8ik_GM_Ei_Wji_BA_d63d7f235b.gif")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<POG>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<POG>>(v1);
    }

    // decompiled from Move bytecode v6
}

