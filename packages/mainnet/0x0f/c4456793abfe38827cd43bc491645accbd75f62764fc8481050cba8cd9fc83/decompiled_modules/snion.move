module 0xfc4456793abfe38827cd43bc491645accbd75f62764fc8481050cba8cd9fc83::snion {
    struct SNION has drop {
        dummy_field: bool,
    }

    fun init(arg0: SNION, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SNION>(arg0, 6, b"SNION", b"SUINION", b"IM SUINION ON SUI CHAIN LFG PUMP IT UP", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Thia_t_ka_ch_AE_a_c_A_t_A_n_20_3c8c2e45ea.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SNION>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SNION>>(v1);
    }

    // decompiled from Move bytecode v6
}

