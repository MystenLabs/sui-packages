module 0x12d5a609c6f1b61dcea92c25d0a9009050d77ca2d5698e3394635c9746511972::sjohn {
    struct SJOHN has drop {
        dummy_field: bool,
    }

    fun init(arg0: SJOHN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SJOHN>(arg0, 6, b"SJOHN", b"SUIJOHN", x"4a757374204a6f686e2e0a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Thia_t_ka_ch_AE_a_c_A_t_A_n_75_d60dc341be.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SJOHN>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SJOHN>>(v1);
    }

    // decompiled from Move bytecode v6
}

