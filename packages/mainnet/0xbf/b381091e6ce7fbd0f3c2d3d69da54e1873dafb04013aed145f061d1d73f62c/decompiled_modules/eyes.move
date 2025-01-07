module 0xbfb381091e6ce7fbd0f3c2d3d69da54e1873dafb04013aed145f061d1d73f62c::eyes {
    struct EYES has drop {
        dummy_field: bool,
    }

    fun init(arg0: EYES, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<EYES>(arg0, 6, b"EYES", b"EYES SUI", b" Just Look Up", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Thia_t_ka_ch_AE_a_c_A_t_A_n_14_4d77ab6836.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<EYES>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<EYES>>(v1);
    }

    // decompiled from Move bytecode v6
}

