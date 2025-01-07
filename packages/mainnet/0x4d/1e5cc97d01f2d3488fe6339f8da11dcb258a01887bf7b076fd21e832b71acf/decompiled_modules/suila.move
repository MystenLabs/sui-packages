module 0x4d1e5cc97d01f2d3488fe6339f8da11dcb258a01887bf7b076fd21e832b71acf::suila {
    struct SUILA has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUILA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUILA>(arg0, 6, b"SUILA", b"Suila", b"Suila Whale, the graceful and elegant token mascot of the SUI network, embodies wisdom, prosperity, and oceanic charm. ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/DALLA_E_2024_12_29_15_34_57_A_3_D_animated_style_cartoon_depiction_of_a_lady_whale_The_whale_has_a_soft_and_elegant_design_with_a_gentle_smile_long_eyelashes_and_a_small_decor_b8a778eb54.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUILA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUILA>>(v1);
    }

    // decompiled from Move bytecode v6
}

