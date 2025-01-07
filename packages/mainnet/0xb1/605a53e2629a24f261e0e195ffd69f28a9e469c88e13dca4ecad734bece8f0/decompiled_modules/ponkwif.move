module 0xb1605a53e2629a24f261e0e195ffd69f28a9e469c88e13dca4ecad734bece8f0::ponkwif {
    struct PONKWIF has drop {
        dummy_field: bool,
    }

    fun init(arg0: PONKWIF, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PONKWIF>(arg0, 6, b"PONKWIF", b"PONKWIF SUI", b"First PONKWIF on sui", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Thia_t_ka_ch_AE_a_c_A_t_A_n_2024_10_21_T020902_742_846e430231.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PONKWIF>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<PONKWIF>>(v1);
    }

    // decompiled from Move bytecode v6
}

