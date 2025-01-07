module 0xf0aeafcb1206d332ffe895450af6a9ec09d24487b0800ee663ade4ae8f8fefbc::keke {
    struct KEKE has drop {
        dummy_field: bool,
    }

    fun init(arg0: KEKE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<KEKE>(arg0, 6, b"KEKE", b"KEKE SUI", b"KEKE ON SUI NETWORK", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Thia_t_ka_ch_AE_a_c_A_t_A_n_9_a963e0b7a9.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<KEKE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<KEKE>>(v1);
    }

    // decompiled from Move bytecode v6
}

