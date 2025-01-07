module 0x24d5020e09579c15078408346aa212f589f3007cd99b1ef1a5bb61a93695b6d2::venko {
    struct VENKO has drop {
        dummy_field: bool,
    }

    fun init(arg0: VENKO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<VENKO>(arg0, 6, b"VENKO", b"VENKOonSUI", b"The era of doges is up, it is now the era of aliens, friend!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/3m_Ekk_L_Lr_400x400_a536b5070b.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<VENKO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<VENKO>>(v1);
    }

    // decompiled from Move bytecode v6
}

