module 0x85ac9891f33e51508f2b13956705af01aa845c100438b013fda02e5f02d7741a::nokia {
    struct NOKIA has drop {
        dummy_field: bool,
    }

    fun init(arg0: NOKIA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<NOKIA>(arg0, 6, b"NOKIA", b"NOKIA SUI", b"3310 ROCK", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/360_F_308271562_h7b_E_Di_NW_Mz75n_C0puq5b_G_Hq_Pfp5_Qjxh_G_d64d5dacfc.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<NOKIA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<NOKIA>>(v1);
    }

    // decompiled from Move bytecode v6
}

