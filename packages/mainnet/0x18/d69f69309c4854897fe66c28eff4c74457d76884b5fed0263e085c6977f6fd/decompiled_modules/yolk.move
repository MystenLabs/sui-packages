module 0x18d69f69309c4854897fe66c28eff4c74457d76884b5fed0263e085c6977f6fd::yolk {
    struct YOLK has drop {
        dummy_field: bool,
    }

    fun init(arg0: YOLK, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<YOLK>(arg0, 6, b"YOLK", b"Sui Yolk", b"SuiYolk - Where everyone belongs", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Thia_t_ka_ch_AE_a_c_A_t_A_n_4_e866c93066.gif")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<YOLK>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<YOLK>>(v1);
    }

    // decompiled from Move bytecode v6
}

