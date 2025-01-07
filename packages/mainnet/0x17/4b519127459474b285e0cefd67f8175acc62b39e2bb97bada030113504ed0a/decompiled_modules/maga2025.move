module 0x174b519127459474b285e0cefd67f8175acc62b39e2bb97bada030113504ed0a::maga2025 {
    struct MAGA2025 has drop {
        dummy_field: bool,
    }

    fun init(arg0: MAGA2025, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MAGA2025>(arg0, 6, b"MAGA2025", b"MAKE AMERICA GREAT AGAIN 2025", b"DONALD TRUMP - MAKE AMERICA GREAT AGAIN 2025 ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Ah_BB_Wz_Kfg_Sg_Xc4_NT_Xxqvczi_Xc_MQ_Pv6_Tcf_Fn_Tu4yr_Ba_JH_b0d5c569f5.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MAGA2025>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<MAGA2025>>(v1);
    }

    // decompiled from Move bytecode v6
}

