module 0x7844a476a6f88bf76de8b60d1d70e5ce6872f7fd4ada177f0e6b3e1c847f3a9c::melo {
    struct MELO has drop {
        dummy_field: bool,
    }

    fun init(arg0: MELO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MELO>(arg0, 6, b"MELO", b"MELO FISH", b"In partnership with Sui we will witness the rise of $MELO.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Thia_t_ka_ch_AE_a_c_A_t_A_n_22_72a70e2e42.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MELO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<MELO>>(v1);
    }

    // decompiled from Move bytecode v6
}

