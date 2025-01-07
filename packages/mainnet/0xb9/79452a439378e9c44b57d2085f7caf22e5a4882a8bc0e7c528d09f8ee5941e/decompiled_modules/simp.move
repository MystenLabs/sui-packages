module 0xb979452a439378e9c44b57d2085f7caf22e5a4882a8bc0e7c528d09f8ee5941e::simp {
    struct SIMP has drop {
        dummy_field: bool,
    }

    fun init(arg0: SIMP, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SIMP>(arg0, 6, b"SIMP", b"Simpers", b"simps unite", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Bcj_QVMV_Xw_Ujs_KU_9mccvqi_Vog1g_W5rh3g_Wh_Qnxxc_Npump_140b64bfb8.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SIMP>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SIMP>>(v1);
    }

    // decompiled from Move bytecode v6
}

