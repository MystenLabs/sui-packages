module 0x89700dfe43564887095026aad243223b61727655aaa8dc2bc35f9b581e7b0a7::john {
    struct JOHN has drop {
        dummy_field: bool,
    }

    fun init(arg0: JOHN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<JOHN>(arg0, 6, b"JOHN", b"JOHN ON SUI", x"4a6f686e2069732061206e6f726d69652c206a75737420616e206f7264696e6172792064756465206e616d656420244a4f484e2e0a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Thia_t_ka_ch_AE_a_c_A_t_A_n_75_d66aed5d75.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<JOHN>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<JOHN>>(v1);
    }

    // decompiled from Move bytecode v6
}

