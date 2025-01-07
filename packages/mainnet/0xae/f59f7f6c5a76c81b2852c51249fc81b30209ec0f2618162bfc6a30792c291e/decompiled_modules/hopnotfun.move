module 0xaef59f7f6c5a76c81b2852c51249fc81b30209ec0f2618162bfc6a30792c291e::hopnotfun {
    struct HOPNOTFUN has drop {
        dummy_field: bool,
    }

    fun init(arg0: HOPNOTFUN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<HOPNOTFUN>(arg0, 6, b"HOPNOTFUN", b"Hop.Fun CTO", x"4c6f736520796f75722074696d652049524c2026206f6e200a405375694e6574776f726b", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Dise_A_o_sin_t_A_tulo_33_00505d1291.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<HOPNOTFUN>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<HOPNOTFUN>>(v1);
    }

    // decompiled from Move bytecode v6
}

