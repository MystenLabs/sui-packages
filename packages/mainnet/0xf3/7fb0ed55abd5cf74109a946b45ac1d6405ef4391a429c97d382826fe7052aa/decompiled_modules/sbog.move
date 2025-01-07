module 0xf37fb0ed55abd5cf74109a946b45ac1d6405ef4391a429c97d382826fe7052aa::sbog {
    struct SBOG has drop {
        dummy_field: bool,
    }

    fun init(arg0: SBOG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SBOG>(arg0, 6, b"SBOG", b"SUI BOG", b"Meet $SBOG, Matt Furies first frog", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Thia_t_ka_ch_AE_a_c_A_t_A_n_72_0fab52a09b.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SBOG>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SBOG>>(v1);
    }

    // decompiled from Move bytecode v6
}

