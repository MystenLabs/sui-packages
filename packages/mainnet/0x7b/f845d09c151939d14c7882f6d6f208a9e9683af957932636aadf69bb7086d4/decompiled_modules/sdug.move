module 0x7bf845d09c151939d14c7882f6d6f208a9e9683af957932636aadf69bb7086d4::sdug {
    struct SDUG has drop {
        dummy_field: bool,
    }

    fun init(arg0: SDUG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SDUG>(arg0, 6, b"SDUG", b"DUG INU SUI", x"5468652070656f706c657320636f696e21204a6f696e20746865207265766f6c7574696f6e210a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Thia_t_ka_ch_AE_a_c_A_t_A_n_67_4f06ca01bb.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SDUG>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SDUG>>(v1);
    }

    // decompiled from Move bytecode v6
}

