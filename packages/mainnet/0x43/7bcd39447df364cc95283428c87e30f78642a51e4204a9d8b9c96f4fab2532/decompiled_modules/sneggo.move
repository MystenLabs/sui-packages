module 0x437bcd39447df364cc95283428c87e30f78642a51e4204a9d8b9c96f4fab2532::sneggo {
    struct SNEGGO has drop {
        dummy_field: bool,
    }

    fun init(arg0: SNEGGO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SNEGGO>(arg0, 6, b"SNEGGO", b"SUI NEGGO", b"WELCOME TO NEGGO ON SUI CHAIN", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/4x7xoqc6ogy_Bp_Q9j_KAW_Rs_N_Jn_Uk_Bz_Am_Xs_E7n_Ta3a4pump_527b8cb071.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SNEGGO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SNEGGO>>(v1);
    }

    // decompiled from Move bytecode v6
}

